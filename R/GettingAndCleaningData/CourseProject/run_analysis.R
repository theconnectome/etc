# Load labels and features data -------------------------------

file_path1 = "features.txt"
features <- read.table(file_path1, header = FALSE)

file_path2 = "activity_labels.txt"
activityLabels <- read.table(file_path2, header = FALSE)


# Load test data -----------------------------------------------

file_path3 = "test/subject_test.txt"
subjectTest <- read.table(file_path3, header = FALSE)

file_path4 = "test/X_test.txt"
xTest <- read.table(file_path4, header = FALSE)

file_path5 = "test/y_test.txt"
yTest <- read.table(file_path5, header = FALSE)


# Load training data -------------------------------------------

file_path6 = "train/subject_train.txt"
subjectTrain <- read.table(file_path6, header = FALSE)

file_path7 = "train/X_train.txt"
xTrain <- read.table(file_path7, header = FALSE)

file_path8 = "train/y_train.txt"
yTrain <- read.table(file_path8, header = FALSE)



# Here's what we're gonna do -------------------------------------

# We learn from dim() that:
# 1) The test and training datasets have different numbers
#    of rows, but the same number of columns (561).
#    This is also the same number of feature names.
# 2) The subjectTest, the xTest, and yTest datasets all 
#    have the same number of rows (2946).
# 3) The subjectTrain, xTrain, and yTrain datasets all 
#    have the same number of rows (7351).

# So logically, we should do the following:
# 1) Apply the 561 feature names as column names for the 
#    test and training datasets.
# 2) Attach the subjectTest and yTest datasets as columns 
#    onto the sides of the xTest dataset.
# 3) Attach the subjectTrain and yTrain datasets as columns
#    onto the sides of the xTrain dataset.
# 4) Apply the activity labels to their corresponding numbers.



# 1. Merge the training and test sets -------------------------------

# Apply the 561 feature names from the "features"
# file as a list of column names for the training 
# and test data.frames.
colnames(xTrain) <- features[,2]
colnames(xTest) <- features[,2]

# Merge all the training lists and test lists into 
# single respective data.frames - then label the last 
# two columns of each data.frame.
mergedTrain <- cbind(xTrain,subjectTrain,yTrain)
colnames(mergedTrain)[562:563] <- c("Subject", "Activity")
mergedTest <- cbind(xTest,subjectTest,yTest)
colnames(mergedTest)[562:563] <- c("Subject", "Activity")

# Bind the merged test and training data.frames together,
# with "test" on top of "train."
mergedFull <- rbind(mergedTest, mergedTrain)



# 2. Extract the mean and standard deviation for each measurement -----

# Create a new data.frame, narrowed down to only the columns
# that have something to do with mean or standard deviation,
# according to features_info.txt.

# Make a list of all columns whose names contain the words
# "mean" or "std" (plus "Subject" and Activity").
meanStdList <- c(1:6, 41:46, 81:86, 121:126, 161:166, 201:202, 
                 214:215, 227:228, 240:241, 253:254, 266:271,
                 294:296, 345:350, 373:375, 424:429, 452:454,
                 503:504, 513, 516:517, 526, 529:530, 539, 
                 542:543, 552, 562:563)

# Create a data.frame with only mean and std measurements,
# along with subject numbers and activities.
mergedNarrow <- mergedFull[, meanStdList]

# Load dplyr, which we're going to need for the rest of this.
library(dplyr)

# "BY SUBJECT AND ACTIVITY" DATA.FRAME: means for each measurement's
# of the means and daviations for each subject, grouped by activity
subjectActivityFrame <- mergedNarrow %>% group_by(Subject, 
                Activity) %>% summarise_each(funs(mean))



# 3. Apply descriptive names to the activities ---------------------

# Replace the one-word all-caps activity descriptions
# in "activity_labels.txt" with more descriptive
# activity names.
activityLabels[,2] <- c("Walking on a flat surface", "Walking up the stairs",
                        "Walking down the stairs", "Sitting in a chair", 
                        "Standing up", "Lying down")

# Replace all activity label numbers with their corresponding 
# activity names from the new and improved "activityLabels."
subjectActivityFrame$Activity <- activityLabels[,2]



# 4. Label the data columns with descriptive variable names --------------

# Read out the list of columns names from meansFrame as a 
# character vector, so we can search-and-replace
# strings inside of it.
colNamesList <- as.list(colnames(subjectActivityFrame))

# Replace each component of each name with a more descriptive one.
colNamesList <- gsub("\\-mean\\(\\)", " - mean", colNamesList)
colNamesList <- gsub("\\-meanFreq\\(\\)", " - mean frequency", colNamesList)
colNamesList <- gsub("\\-std\\(\\)", " - standard deviation", colNamesList)

colNamesList <- gsub("\\-X", " for the X axis", colNamesList)
colNamesList <- gsub("\\-Y", " for the Y axis", colNamesList)
colNamesList <- gsub("\\-Z", " for the Z axis", colNamesList)

colNamesList <- gsub("tBody", "Time for body ", colNamesList)
colNamesList <- gsub("tGravity", "Time for gravity ", colNamesList)
colNamesList <- gsub("fBodyBody", "Time for body body ", colNamesList)
colNamesList <- gsub("fBody", "Frequency for body ", colNamesList)

colNamesList <- gsub("Body", " body", colNamesList)
colNamesList <- gsub("Acc", "accelerometer", colNamesList)
colNamesList <- gsub("Jerk", " Jerk signal", colNamesList)
colNamesList <- gsub("Gyro", "gyroscope", colNamesList)
colNamesList <- gsub("Mag", " (magnitude)", colNamesList)

# Replace all column labels with their new and improved 
# descriptive names.
colnames(subjectActivityFrame) <- colNamesList



# 5. From the data set in step 4, create a second, independent 
# tidy data set with the average of each variable for each 
# activity and each subject. ----------------------------------------


# "BY ACTIVITY" DATA.FRAME: overall means for each measurement
# for each activity, for all subjects
# (For this one, we first have to re-group the source data.frame 
# by "Activity," because we can't remove the "Subject"
# column as long as it's the "group_by" column.)
activityFrame <- subjectActivityFrame %>% group_by(Activity) %>% 
                summarise_each(funs(mean))
activityFrame <- select(activityFrame, -Subject) %>% group_by(Activity) %>% 
        summarise_each(funs(mean))

# "BY SUBJECT" DATA.FRAME: overall means for each measurement
# for each subject, for all activities
subjectFrame <- select(subjectActivityFrame, -Activity) %>% 
        group_by(Subject) %>% 
        summarise_each(funs(mean))

# Write out the tidy data set to the txt file.
write.table(subjectActivityFrame, file="TidyDataSet.txt", row.names=FALSE)





