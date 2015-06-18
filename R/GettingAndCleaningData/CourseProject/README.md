Analysis of Samsung Data
====================
The included R script, "run_analysis.R," does the following:
- 1. Merges the training and the test sets to create one data set.
- 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
- 3. Uses descriptive activity names to name the activities in the data set
- 4. Appropriately labels the data set with descriptive variable names. 
- 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


Procedure
====================

Read the raw data into R
--------------------
- Read "activity_labels.txt" - the labels data
- Read "features.txt" - the features data
- Read "subject_test.txt" - the list of test subjects
- Read "X_test.txt" - the test data
- Read "y_test.txt" - the list of test activities
- Read "subject_train.txt" - the list of training subjects
- Read "X_train.txt" - the training data
- Read "y_train.txt" - the list of training activities


Examine of the dimensions of the imported data
--------------------

**We learn from dim() that:**
- The test and training datasets have different numbers of rows, but the same number of columns (561). This is also the same number of feature names.
- The subject_test, the X_test, and y_test datasets all have the same number of rows (2946).
- The subject_train, X_train, and y_train datasets all have the same number of rows (7351).

**So logically, we should do the following:**
- Apply the 561 feature names as column names for the test and training datasets.
- Attach the subject_test and y_test datasets as columns onto the sides of the X_test dataset.
- Attach the subject_train and y_train datasets as columns onto the sides of the X_train dataset.
- Apply the activity labels to their corresponding numbers.


Quiz Step 1: Merge all the data sets
--------------------

- Apply the 561 feature names from the "features" file as a list of column names for the training and test data.frames.
- Merge all the training lists and test lists into single respective data.frames - then label the last two columns of each data.frame "Subject" and "Activity," respectively.
- Bind the merged test and training data.frames together, with "test" on top of "train."


Quiz Step 2: Extract the mean and standard deviation for each measurement
--------------------
- Make a list of all columns whose names contain the words "mean" or "std" (plus "Subject" and Activity").
- Create a data.frame with only mean and std measurements, along with subject numbers and activities.
- Create a narrower data frame with means for each measurement's means and standard deviations for each subject, grouped by activity.


Quiz Step 3: Apply descriptive names to the activities
--------------------
- Replace the one-word all-caps activity descriptions in "activity_labels.txt" with more descriptive activity names.
- Replace all activity label numbers in our data.frame with their new and improved activity labels.



Quiz Step 4: Label the data columns with descriptive variable names
--------------------
- Read out the list of columns names from our data.frame as a character vector, so we can search-and-replace strings inside of it.
- Replace each component of each name with a more descriptive one.
- Write the new and improved descriptive names back to the data.frame as column names.


Quiz Step 5: From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.
--------------------
- Create a "by activity" data.frame, with overall means for each measurement for each activity, for all subjects
- Create a "by subject" data.frame, with overall means for each measurement for each subject, for all activities






