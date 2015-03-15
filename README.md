# Readme

## Getting and Cleaning Data Course Project

The script assumes you have downloaded and unzipped the folder '**UCI HAR Dataset**' from
here: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

The script also assumes you have set you working directory in R to the folder with the script

To run the script: **source("run_analysis.R")**

## Steps taken in the script:
	1. Loads all files in memory
	2. Assigns columns names to the training data and test data so we know what's what.
	3. Combines the training and test files in to two complete datasets, and then combined the training and test datasets into one big dataset
	4. Removes all columns which weren't mean() or std() using a Regular Expression.  Had to removed duplicate columns first so 'select' worked
	5. Replaces the ActivityId with the Activity Name 
	6. Creates a summary table with the mean of each observation grouped by Subject and Activity
	7. Saves the summary table as tidyDataSet.txt

