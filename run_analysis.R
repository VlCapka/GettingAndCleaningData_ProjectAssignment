# The goal was to create a single R script called run_analysis.R that does the following: 
# 
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


library(tidyverse)

# Reading data
x_train <- read.table("./data/train/X_train.txt")
y_train <- read.table("./data/train/y_train.txt")
subject_train <- read.table("./data/train/subject_train.txt")
x_test <- read.table("./data/test/X_test.txt")
y_test <- read.table("./data/test/y_test.txt")
subject_test <- read.table("./data/test/subject_test.txt")
features <- read.table("./data/features.txt", row.names = 1)    # row.names argument merges index column to row names
activities <- read.table("./data/activity_labels.txt", row.names = 1)

# Merging data 

# x_ is the data
#       rows are the subjects ID's (1-30)
#       columns are the features from features list (1-561)
# y_ is the activity performed (1-6), factor level for activity
# features are column headers for x_
# activity is what is mapped in y_
# subject_ is the subject ID that preformed the activity (1-30)

# Merge activities and subjects to test and train data, then combine datasets
train <- cbind(subject_train, y_train, x_train)
test <- cbind(subject_test, y_test, x_test)
full_df <- rbind(train, test)

# Assign descriptive variable names
colnames(full_df)[1] <- "subject"
colnames(full_df)[2] <- "activity"
colnames(full_df)[3:563] <- features$V2

# Renaming activity codes
full_df$activity <- activities$V2[full_df$activity]

# Extracting only mean() and std() variables
df_mean_std <- select(full_df, subject, activity, grep("mean\\(\\)|std\\(\\)", features$V2, value = TRUE))

# the following also extracts other variables with (M)mean in their names but they do not appear to be "means of each measurement"
# they appear to be variables that contain meanFrequency or gravityMean as arguments or descriptors of other variables so I decided to omit them (see README file for more info)
# to extract them all, use the code line below
#       df_mean_std <- select(full_df, subject, activity, grep("[Mm]ean|std", features$V2, value = TRUE))

# Grouping per subject and activity and calculating means
# Note: using the across() function eliminate need for pivoting data frame to long and then back to wide format, it works column-wise on data frames
# Rename columns to indicate they are now averages.

df_tidy <- group_by(df_mean_std, subject, activity) %>%
        summarize(across(everything(), mean, .names = "Avg_of_{col}"))

# Writing final, tidy data frame:
write.table(df_tidy, file = "df_tidy.txt", row.names = FALSE)
