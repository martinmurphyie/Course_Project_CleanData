Course_Project_CleanData
========================
The purpose of this project is to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. 
The data used represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
The original data for the Project was found here: 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

The R Script run_analysis.R does the following:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, This creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

This script was created and tested on a system running windows 8.1, using Rstudio Version 0.98.1028 and R 3.1.1. The "reshape" package was installed also in order to use the melt() and cast() functions.

The script uses download.file() to download the original dataset which is a Zip file to the working directory. The script uses unzip() to extract all the files into a "UCI HAR Dataset" folder in the working directory.  All of the test files ( subject_test.txt, X_test.txt, Y_test.txt )  and train files ( subject_train.txt, X_train.txt, Y_train.txt )are then loaded into data frames using read.table() commands, and all of the data is merged to form 1 dataset. The variables are named using the feature names from features.txt. This dataset comprises 10299 observations of 563 variables. 

The data then has an extra variable added to describe the Activity name. An extract is taken from this data of Subject, Activity Name and 86 other Variables describing Mean or Standard Deviation data.

The dataset is transformed into a long dataset using the melt function with Subject and Activity_Name used as IDs.
The dataset is then cast using mean of the variables to give the final dataset of 180 observations (30 subjects * 6 Activities) for 88 variables.

The clean and tidy dataset is oputput to a file in the "UCI HAR Dataset" folder in the working directory using the write.file() function.
