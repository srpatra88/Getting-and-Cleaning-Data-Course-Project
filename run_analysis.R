# Load dplyr library
library(dplyr)

# Download and extract the data sets
destination <- "smartphone.zip"

if(!file.exists(destination)){
  download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip","smartphone.zip")
  unzip(destination, overwrite=TRUE)
}

# read subject train and test data
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")

# row bind train and test subject data and assign a header
subject_complete <- rbind(subject_train,subject_test)
names(subject_complete) <- c("subject_id")

# Load feature data and add headers
features <- read.table("UCI HAR Dataset/features.txt")
names(features) <- c("feature_id","feature_name")
feature_names <- features$feature_name


# load X train and test data
x_train <- read.table("UCI HAR Dataset/train/X_train.txt")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt")

# row bind train and test X data to generate complete dataset for X. Assign feature names as headers.
x_complete <- rbind(x_train,x_test)
names(x_complete) <- feature_names

# Extract all mean and standard deviation measures
mean_and_std_features <- grep("(mean|std)\\(\\)",feature_names)

# select all columns in x related only to mean and standard deviations
x_new <- x_complete[,mean_and_std_features]

# To use as header for the x_complete data frame, process feature names (replace paranthesis and minus signs)
feature_name_clean <- gsub("(\\(|\\))", "", feature_names[mean_and_std_features])
feature_name_clean <- gsub("-", "_", feature_name_clean)

# Assign clean headers to the x_new
names(x_new) <- feature_name_clean

# load Y train and test data
y_train <- read.table("UCI HAR Dataset/train/Y_train.txt")
y_test <- read.table("UCI HAR Dataset/test/Y_test.txt")

# row bind train and test Y data to generate complete dataset for X
y_complete <- rbind(y_train,y_test)
names(y_complete) <- c("activity_id")


# Load activity labels mapping
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
names(activity_labels) <- c("activity_id","activity_name")

# Transform all the given datasets into a single big frame using cbind.
complete_activity <- cbind(subject_complete, y_complete, x_new)

# Convert subject_id as factor. Convert activity_ids as factor using activity names instead of their ids.
complete_activity$subject_id <- as.factor(complete_activity$subject_id)
complete_activity$activity_id <- factor(complete_activity$activity_id, levels = activity_labels$activity_id, labels = activity_labels$activity_name)

# Create tidy dataset by grouping on (subject_id, activity_id) and calculating mean per group
tidy <- complete_activity %>% group_by(subject_id, activity_id) %>% summarise_each(funs(mean))
write.table(tidy,"tidy.txt", row.names = FALSE)