# CodeBook

## Getting and Cleaning Data Course Project

Since this is a course project, the data was made available here:

> The data linked to from the course website represent data collected from the 
> accelerometers from the Samsung Galaxy S smartphone. 
> A full description is available at the site where the data was obtained: 
> [http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones]
> 
> Here are the data for the project: 
> [https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip] 

## Input File Descriptions

### Folder UCI HAR Dataset
activity_labels.txt: decodes the activity Id in the files /test/y_test.txt and /train/y_train.txt
features.txt: decodes the column names for test/X_test.txt and train/X_train.txt

### Folder train
	subject_train.txt: contains subject id for the observations
	Y_train.txt: contains activity id for the observations
	X_train.txt: contains the observations 

### Folder test
	subject_test.txt: contains subject id for the observations
	Y_test.txt: contains activity id for the observations
	X_test.txt: contains the observations 

## Output File ('tidyDataSet.txt') Description

	The data is grouped by Subject and Activitiy.  Each row is a grouping
	All values are the mean of the mean and standard deviation for the group (subject, activity)
	
	The Columns are as follows:
	
	SubjectId: An identifier of the subject who carried out the experiment.               
	Activity: One of six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING)
	
	The remaining columns are the observation:  
		Each axis (X, Y, Z) has its own column
		Columns with mean() denote the mean of the mean linear accelerations
		Columns with std() denote the mean of standard deviation of the linear accelerations
	
	The units used for the accelerations are 'g's (gravity of earth -> 9.80665 m/seg2)
	The gyroscope units are rad/seg    
	
	
 