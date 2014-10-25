## This program completes all steps for the Getting and Cleaning data Course Project.
## The goal is to return a clean and tidy data set from the UCI HAR Dataset.
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive variable names. 
## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

##set location of the zip file to be downloaded and the destination folder
destdir<-paste(getwd(),"/cleandata_project", sep="")
dir.create(destdir)
zip_file<-paste(getwd(),"/cleandata_project/UCIHAR_Dataset.zip", sep="")
zip_url<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

##download the zip file to the destination folder and extract all files
message("downloading the dataset, this could take some time")
if(!file.exists(zip_file)) download.file(zip_url, destfile=zip_file)
message("unzipping the dataset")
unzip(zip_file, overwrite=TRUE, exdir=destdir)

##reading data begins
message("reading test files")
test_subject_test<-read.table(paste(destdir, "/UCI Har Dataset/test/subject_test.txt", sep=""))
test_xtest<-read.table(paste(destdir, "/UCI Har Dataset/test/x_test.txt", sep=""))
test_ytest<-read.table(paste(destdir, "/UCI Har Dataset/test/y_test.txt", sep=""))

message("reading train files")
train_subject_test<-read.table(paste(destdir, "/UCI Har Dataset/train/subject_train.txt", sep=""))
train_xtrain<-read.table(paste(destdir, "/UCI Har Dataset/train/x_train.txt", sep=""))
train_ytrain<-read.table(paste(destdir, "/UCI Har Dataset/train/y_train.txt", sep=""))

message("reading label files")
features<-read.table(paste(destdir, "/UCI Har Dataset/features.txt", sep=""))
activity_labels<-read.table(paste(destdir, "/UCI Har Dataset/activity_labels.txt", sep=""))
colnames(activity_labels)<-c("Activity", "Activity_Name")

##merging data begins
message("binding files")
train<-cbind(train_subject_test,train_ytrain, train_xtrain)
colnames(train)<-c("Subject", "Activity", t(features)[2,])

test<-cbind(test_subject_test,test_ytest, test_xtest)
colnames(test)<-c("Subject", "Activity", t(features)[2,])

##merge the Test and Train Data sets
total <- rbind(train, test)

## Add activity names to the dataset
total<-merge(total, activity_labels, by="Activity")

##extract column names for mean and Standard Deviation measures
short_features<-grep("[Ss]td|[Mm]ean", colnames(total), value=TRUE)

##reduce the dataset to subject, activity_name, Mean and Std columns
message("creating small dataset")
short_data<-total[c("Subject", "Activity_Name", short_features)]

##Install reshape package to enable use of melt and cast
install.packages("reshape")
library(reshape)

## create a long dataset using melt
melt_data<-melt(short_data, id=c(1:2), measure=c(3:88))

##cast the long dataset to output file and find the mean for each measure by Subject and Activity Name
cast_data <- cast(melt_data, Subject + Activity_Name ~ variable, mean)

##output the tidy dataset to cleandata.txt
write.table(cast_data, paste(destdir, "/cleandata.txt", sep="") row.name=FALSE)
