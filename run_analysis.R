#
# C.f. Readme.md for more infomration
#

#-------------------------------------------------------------------------------
# 1. Loads all files in memory

# Load refences
library(dplyr)

# Load reference files into memory
features <- read.table(file = "UCI HAR Dataset/features.txt")
activity_labels <- read.table(file = "UCI HAR Dataset/activity_labels.txt")

# Load training data files into memory
X_train <- read.table(file = "UCI HAR Dataset/train/X_train.txt")
Y_train <- read.table(file = "UCI HAR Dataset/train/Y_train.txt")
subject_train <- read.table(file = "UCI HAR Dataset/train/subject_train.txt")

# Load test data files into memory
X_test <- read.table(file = "UCI HAR Dataset/test/X_test.txt")
Y_test <- read.table(file = "UCI HAR Dataset/test/Y_test.txt")
subject_test <- read.table(file = "UCI HAR Dataset/test/subject_test.txt")

#-------------------------------------------------------------------------------
# 2. Assigns columns names to the training data and test data so we know what's what.

colnames(activity_labels) <- c("ActivityId", "ActivityName")
colnames(features) <- c("FeatureId", "FeatureName")

colnames(Y_train) <- c("ActivityId")
colnames(subject_train) <- c("SubjectId")
colnames(X_train) <- features$FeatureName

colnames(Y_test) <- c("ActivityId")
colnames(subject_test) <- c("SubjectId")
colnames(X_test) <- features$FeatureName

#-------------------------------------------------------------------------------
# 3. Combines the training and test files in to two complete datasets, and 
#    then combined the training and test datasets into one big dataset

# cbind the two datasets together, then rbind them
dataset <- rbind(cbind(Y_train, subject_train, X_train), cbind(Y_test, subject_test, X_test))

# Clean up
rm(list = setdiff(ls(), c("dataset", "activity_labels")))

#-------------------------------------------------------------------------------
# 4. Removes all columns which weren't mean() or std() using a Regular 
#    Expression.  Had to removed duplicate columns first so 'select' worked

# RegEx test for column names with 'mean()' or 'std()'
regEx_MeanStd = "(mean\\(\\))|(std\\(\\))"

# There are duplicate columns in dataset!
# Test if duplicate columns contain 'mean()' or 'str()' - We don't want to 
# delete them my accident
if(!all(grepl(regEx_MeanStd, colnames(dataset)[duplicated(colnames(dataset))]) == FALSE))
  warning("Duplicate column names with 'mean()' or 'str()'")

# Remove duplicate columns (so we can use 'select')
dataset <- dataset[, !duplicated(colnames(dataset))]

# Select the first two identity columns and any columns with 'mean()' or 'str()' 
dataset <- select(dataset, c(1,2, grep(regEx_MeanStd, colnames(dataset))))

# Clean up
rm(regEx_MeanStd)

#-------------------------------------------------------------------------------
# 5. Replaces the ActivityId with the Activity Name 

# Put the two dataset together
dataset <- merge(dataset, activity_labels)

# Let's be really fancy and move the columns around so we have a nice dataset
dataset = subset(dataset, select = c(2, length(colnames(dataset)), seq(3, length(colnames(dataset)) -1 )))

# Clean up
rm(activity_labels)

#-------------------------------------------------------------------------------
# 6. Creates a summary table with the mean of each observation grouped by Subject and Activity

tidyDataSet <- aggregate(dataset[, seq(3, length(colnames(dataset)))], by=list(dataset$SubjectId, dataset$ActivityName), FUN=mean, na.rm=TRUE)

# Rename the groups so we know what they are
tidyDataSet <- dplyr::rename(tidyDataSet, SubjectId = Group.1, Activity = Group.2)

#-------------------------------------------------------------------------------
# 7. Saves the summary table

write.table(tidyDataSet, "tidyDataSet.txt", row.name=FALSE)

#-------------------------------------------------------------------------------
  
# Clean up
rm(dataset)
rm(tidyDataSet)