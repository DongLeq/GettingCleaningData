## Reading X_test, y_test, subject_test in test folder
X_test <- read.table ("~/GIT_REPO/gettingcleaningdata/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table ("~/GIT_REPO/gettingcleaningdata/UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table ("~/GIT_REPO/gettingcleaningdata/UCI HAR Dataset/test/subject_test.txt")
## Merge into test file
test <- cbind(y_test, subject_test, X_test)

## Reading X_train, y_train, subject_train in train folder
X_train <- read.table ("~/GIT_REPO/gettingcleaningdata/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table ("~/GIT_REPO/gettingcleaningdata/UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table ("~/GIT_REPO/gettingcleaningdata/UCI HAR Dataset/train/subject_train.txt")
## Merge into train file
train <- cbind(y_train, subject_train, X_train)

## Merges the training and the test sets to create one data set
mdata <- rbind(train, test)

## Reading features.txt
features <- read.table ("~/GIT_REPO/gettingcleaningdata/UCI HAR Dataset/features.txt")

## Appropriately labels the data set with descriptive variable names
 colnames (mdata) <- c("activity_no", "subject", as.character(features$V2))

## use library dplyr
 library(dplyr)
## chose columns with name containing mean, std (standard deviation), activity_no, subject
  chosecol <- grep("activity|subject|mean|std", colnames(mdata), value=TRUE)
## Extracts only the measurements on the mean and standard deviation for each measurement
 cdata <- mdata [,chosecol]

## Uses descriptive activity names to name the activities in the data set
 activity <- read.table ("~/GIT_REPO/gettingcleaningdata/UCI HAR Dataset/activity_labels.txt")
 colnames (activity) = c("activity_no", "activity")
 fdata <- merge(cdata, activity, by = "activity_no" )
## remove column "activity_no"
 fdata <- select (fdata, -activity_no)

## name "tidy.txt" for  tidy data set with the average of each variable for each activity and each subject
 tidy<- aggregate(fdata, by = list(fdata$activity, fdata$subject), FUN = "mean")
 tidy <- select (tidy, -activity)
 write.table (tidy, file = "tidy.txt", row.names = FALSE)

