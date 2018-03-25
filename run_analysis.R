## Create one R script called run_analysis.R that does the following: 
## 1. Merges the training and the test sets to create one data set. 
## 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
## 3. Uses descriptive activity names to name the activities in the data set 
## 4. Appropriately labels the data set with descriptive activity names. 
## 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

# Load Packages and get the Data
library(data.table)
library(reshape2)
download.file(url="https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",destfile = "dataset.zip")
unzip("dataset.zip")

# Load activity labels and features
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")[,2]
features <- read.table("./UCI HAR Dataset/features.txt")[,2]

# Extract only the data on mean and standard deviation
extract_features <- grepl("mean|std", features)

# Load test datasets
test <- read.table("./UCI HAR Dataset/test/X_test.txt")
testActivities <- read.table("./UCI HAR Dataset/test/y_test.txt")
testSubjects <- read.table("./UCI HAR Dataset/test/subject_test.txt")
names(test) <- features

# Extract only the data on mean and standard deviation
test <- test[,extract_features]

# Load activity labels
testActivities[,2] <- activity_labels[testActivities[,1]] 
names(testActivities) <- c("Activity_ID", "Activity_Label") 
names(testSubjects) <- "subject" 

# Bind test data
test_data <- cbind(as.data.table(testSubjects), testActivities, test)

# Load train datasets
train <- read.table("./UCI HAR Dataset/train/X_train.txt") 
trainActivities <- read.table("./UCI HAR Dataset/train/y_train.txt") 
trainSubjects <- read.table("./UCI HAR Dataset/train/subject_train.txt") 
names(train) <- features 

# Extract only the data on mean and standard deviation
train <- train[,extract_features]

# Load activity labels
trainActivities[,2] <- activity_labels[trainActivities[,1]] 
names(trainActivities) <- c("Activity_ID", "Activity_Label") 
names(trainSubjects) <- "subject" 

# Bind train data
train_data <- cbind(as.data.table(trainSubjects), trainActivities , train)

# Merge datasets and add labels
combined <- rbind(test_data, train_data)
ids <- c("subject",  "Activity_ID", "Activity_Label")
data_labels <- setdiff(colnames(combined), ids)
melt_data <- melt(combined, id = ids, measure.vars = data_labels)

#Creat tidy dataset and write the result on a file
tidy_data <- dcast(melt_data, subject + Activity_Label ~ variable, mean)
write.table(tidy_data, file = "./tidy_data.txt", row.names = FALSE)