# Getting and Cleaning Data - Course Project README

This document describes and outlines the steps and methodology used to create a tidy data set with 
the average of each variable for each activity and each subject using the gyroscopic data.

This code was written using a Windows 8 platform and R version 3.0.1 (2014-04-10) -- "Spring Dance"

The 'dplyr' library was imported for ease of extracting an independent 'tidy' data table.
This package makes use of functions "group_by", "summarise_each" and "arrange"

A summary of the steps taken to produce the code is as follows:

Step 1a: Read in the raw training and test data ("X_train.txt" and "X_test.txt" respectively), applying the condition 
colclasses="numeric" to coerce the values to numeric. 
Step 1b: Merge the datasets using the rbind() function - this is done by simply adding the rows of the testing data to the
rows of the training data to create a new, larger dataset. This is a safe way to merge the data because the columns of both 
the training and test data are identical.

Step 2a: Read in the "features.txt" file, which contains headings for 561 variables associated with the gyroscopic data.
Step 2b: Use the "grepl" function to determine which headings contain the terms "mean()" or "std()", setting a logical vector
equal to "TRUE" if a column name does contain either term or equal to "FALSE" otherwise.
Step 2c: Re-cast the original dataset to contain only those columns associated with variables that contain "mean()" or "std()".
This should greatly diminish the number of columns from 561 to 79 variables.

Step 3a: Read in the Activity data for the Training and Test data sets ("y_train.txt" and "y_test.txt" respectively) as factors.
Rename the factor levels to correspond to the name of the activity using the "activity_labels.txt" table.
Step 3b: Merge the training and test Activity data using rbind(), similar to Step 1b above.
Step 3c: Read in the Subject data for the Training and Test data sets ("subject_train.txt" and "subject_test.txt" respectively).
Step 3d: Merge the Training and Test Subject data using rbind(), similar to Steps 1b and 3b above.
Step 3e: Merge the Activity and Subject columns with the previously merged raw Training and Test data from Step 1b above. 
This is accomplished using the cbind() function.

Step 4: Using the variables determined in Step 2b above (from the 'grepl' function), apply the corresponding variable headings
to the new dataset along with "Activity" and "Subject" columns for the respective headings.

Step 5a: Using the functionality of the 'dplyr' library, apply the "group_by" function to group the large data table by Activity
and Subject.
Step 5b: Apply the "summarise_each" function to calculate the mean of each variable for the corresponding Activity/Subject combination.
Step 5c: For ease of display, apply the "arrange" function to sort the data by Activity and Subject in an ascending manner.

Step 6: Output a text file "tidy_data.txt" to be analyzed separately.
