## Getting and Cleaning Data - Course Project

This is the course project for the Getting and Cleaning Data Coursera course.
The included R script, run_analysis.R, conducts the following:
Download the dataset from web if it does not already exist in the working directory.
Read both the train and test datasets and merge them into F(measurements), A(activity) and S(subject), respectively.
Load the data(F'S) feature, activity info and extract columns named 'mean'(-mean) and 'standard'(-std). Also, modify column names to descriptive. (-mean to Mean, -std to Std, and remove symbols like -, (, ))
Extract data by selected columns(from step 3), and merge F, A(activity) and subject data. Also, replace A(activity) column to it's name by refering activity label (loaded step 3).
Generate 'Tidy Dataset' that consists of the average (mean) of each variable for each subject and each activity. The result is shown in the file tidy_dataset.txt.
