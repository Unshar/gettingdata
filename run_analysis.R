## ******************************************************************************************
## Coursera> Getting and Cleaning Data - Peer Assessment 2
## ******************************************************************************************
## Objective>> create one R script called run_analysis.R that does the following:
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive activity names. 
## 5. Creates a second, independent tidy data set with the average of each 
## variable for each activity and each subject.
## Here are the data for the project: 
##   https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
## A full description is available at the site where the data was obtained: 
##   http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
## ******************************************************************************************
## Author: Unshar (MissK)
## Date: May 2014
## Source files: activity_labels.txt, features.txt, 
##                subject_train.txt, y_train.txt, x_train.txt,
##                subject_test.txt, y_test.txt, x_test.txt,
##
## Outputs: Tidy_train_and_test_dataset.txt, Summary_train_and_data_by_subject.txt
##
## ******************************************************************************************


# Create variable for local folder
dir<-getwd()
folder<-paste(c(dir,"/UCI HAR Dataset-2"))

# 1. Load Files

  #1.1. Activity Labels
      
    activity<-read.table((paste(c(folder,"/activity_labels.txt"),collapse=''))) 
      colnames(activity)<-c("activityid","activitytype")


  # 1.2. Features
     
    features <- read.table((paste(c(folder,"/features.txt"),collapse='')))
      colnames(features)<-c("featuresid","featurestitle")


  # 1.3. Training dataset
    
    trainsubject<-read.table((paste(c(folder,"/train/subject_train.txt"),collapse='')))
     colnames(trainsubject)<-c("subjectid")

    trainactivity<-read.table((paste(c(folder,"/train/y_train.txt"),collapse='')))
     colnames(trainactivity)<-c("activityid")
                                
    traindata<-read.table((paste(c(folder,"/train/x_train.txt"),collapse='')))
      names(traindata)<- features$featurestitle #add variables labels
      measurements = grep('mean|std', names(traindata)) #create an expression to select only variables containg the word "mean" in their label
        xtraindatareduced = traindata[,measurements] #apply expression (filter) created above on the Training Data

     ## 1.3.1 Combine all 3 Training files into one dataset
        
        xtraindata<-cbind(trainsubject, trainactivity, xtraindatareduced)
        xtraindata$datasetname<-c("Train set") #Create a variable indicating data source for observations
          ## Completness check: 7,352 Observations and 82 variables

  # 1.4. Test dataset
    
    testsubject<-read.table((paste(c(folder,"/test/subject_test.txt"),collapse='')))
      colnames(testsubject)<-c("subjectid")

    testactivity<-read.table((paste(c(folder,"/test/y_test.txt"),collapse='')))
      colnames(testactivity)<-c("activityid")

    testdata<-read.table((paste(c(folder,"/test/x_test.txt"),collapse='')))
      names(testdata)<- features$featurestitle #add variables labels
      measurements = grep('mean|std', names(TestData)) #create an expression to select only variables containg the word "mean" in their label
        xtestdatareduced = testdata[,measurements] #apply expression (filter) created above on the Train Data


    ## 1.4.1 Combine all 3 Test files into one dataset
      
      xtestdata<-cbind(testsubject, testactivity, xtestdatareduced)
      xtestdata$datasetname<-c("Test set")  #Create a variable indicating data source for observations
        ## Completness check: 2,947 Observations and 82 variables

# 2. Merges the training and the test sets to create one data set
  
  x<-rbind(xtraindata, xtestdata)
    # Completness check: 10,299 Observations and 82 variables
        ##export new raw combined sets in case needed in future analysis:
        write.csv(x, "Raw_training_and_test_dataset.txt", row.names = FALSE) 

# 3. Add activity description
  
  xfulldataset<-merge(x, activity,by.x="activityid",by.y="activityid", all.x=TRUE)
    # Completness check: 10,299 Observations and 83 variables

# 4. Re-oder columns and sort by Subject and Activity
  
  fulldataset <- xfulldataset[ , c(2,1,83,82, 3:81)]
  fulldataset<-fulldataset[order(fulldataset$subjectid, fulldataset$activityid),]
  
# 5. Export clean/tidy data set
  
  write.csv(fulldataset, "Tidy_training_and_test_dataset.txt", row.names = FALSE)

# 6. CCreates a second, independent tidy data set with the average of each variable for each activity and each subject. 
#The data set source name was added as investigation trail
  
  fulldataset.avg <- aggregate(fulldataset,
                                list(dataset=fulldataset$datasetname,
                                  activitytype=fulldataset$activitytype,
                                     subjectid=fulldataset$subjectid),
                                mean)

  fulldataset.avg<-fulldataset.avg[order(fulldataset.avg$activityid,fulldataset.avg$subjectid),]
  tmp<-fulldataset.avg[ , c(1:3,8:86)] #Bring just the necessary columns: Data set name, Activity Type, Subject and all 79 measurements

# 7. Export summarized dataset with averages calculated
  
  write.csv(tmp, "Summary_train_and_data_by_subject.txt", row.names = FALSE)
