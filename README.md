RUN_ANALYSIS.R 
version 1 20/05/2014

1.BACKGROUND

The run_analyis.R, referred here as "the script", is the main deliverable for the Getting and Cleaning Data Course Project, which represents 40% of the final grade. This course project will be evaluated and graded through peer assessment.

The scrip does the following:

a.Merges the training files to create one training data set.

b.Merges the test files to create one test data set.

c.Merges the training and test data sets to create one complete data set.

d.Extracts only the measurements on the mean and standard deviation for each measureme.

e.Uses descriptive activity names to name the activities in the data set

f.Appropriately labels the data set with descriptive activity names.†

g.Creates a second, independent tidy data set with the average of each variable for each activity and each subject.†


2.GENERAL NOTES

- The "CodeBook.md" file describes the variables, the data, and any transformations and work performed to clean up the data;

- The "runanalysis diagram.png" is a high-level visual representation of the CodeBook mentioned above. 


3.RUNNING THE SCRIPT

- The complete dataset will have  10,299 rows and 83 columns. First calculate a rough estimate of how much memory the dataset will require in memory before reading into R.

- The run_analyis.R script assumes that user has already obtained the source data from here:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

- The script will require the source data to be saved in the user's R working directory. Please refer to "Working Directories and Workspaces" in the RStudio help for changing working directory if necessary.

- This script does not require the installation if any special package.

4.CONTACT US:
BorgCube Inc.
unshar@borgcollective.nea.ru


