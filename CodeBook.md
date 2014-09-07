#Getting and Cleaning Data Course Project CodeBook

This file describes the variables, the data, and any transformations or work that I have performed to clean up the data.  

* The site where the data was obtained:  
<http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones>      
The data for the project:  
<https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>  

## Variables and descriptions

Variable       | Description
---------------|-------------
SubjectID      | identifier of the subject who performed the activity for each window sample. Its range is from 1 to 30.
Activity       | Activity name
\*\_Mean(\_\*) | Mean of correspondent feature variable
\*\_Std(\_\*)  | Standard Deviation of correspondent feature variable

Feature variables used in project

```
[1] "tBodyAcc_Mean_X"           "tBodyAcc_Mean_Y"           "tBodyAcc_Mean_Z"           "tBodyAcc_Std_X"           
 [5] "tBodyAcc_Std_Y"            "tBodyAcc_Std_Z"            "tGravityAcc_Mean_X"        "tGravityAcc_Mean_Y"       
 [9] "tGravityAcc_Mean_Z"        "tGravityAcc_Std_X"         "tGravityAcc_Std_Y"         "tGravityAcc_Std_Z"        
[13] "tBodyAccJerk_Mean_X"       "tBodyAccJerk_Mean_Y"       "tBodyAccJerk_Mean_Z"       "tBodyAccJerk_Std_X"       
[17] "tBodyAccJerk_Std_Y"        "tBodyAccJerk_Std_Z"        "tBodyGyro_Mean_X"          "tBodyGyro_Mean_Y"         
[21] "tBodyGyro_Mean_Z"          "tBodyGyro_Std_X"           "tBodyGyro_Std_Y"           "tBodyGyro_Std_Z"          
[25] "tBodyGyroJerk_Mean_X"      "tBodyGyroJerk_Mean_Y"      "tBodyGyroJerk_Mean_Z"      "tBodyGyroJerk_Std_X"      
[29] "tBodyGyroJerk_Std_Y"       "tBodyGyroJerk_Std_Z"       "tBodyAccMag_Mean"          "tBodyAccMag_Std"          
[33] "tGravityAccMag_Mean"       "tGravityAccMag_Std"        "tBodyAccJerkMag_Mean"      "tBodyAccJerkMag_Std"      
[37] "tBodyGyroMag_Mean"         "tBodyGyroMag_Std"          "tBodyGyroJerkMag_Mean"     "tBodyGyroJerkMag_Std"     
[41] "fBodyAcc_Mean_X"           "fBodyAcc_Mean_Y"           "fBodyAcc_Mean_Z"           "fBodyAcc_Std_X"           
[45] "fBodyAcc_Std_Y"            "fBodyAcc_Std_Z"            "fBodyAccJerk_Mean_X"       "fBodyAccJerk_Mean_Y"      
[49] "fBodyAccJerk_Mean_Z"       "fBodyAccJerk_Std_X"        "fBodyAccJerk_Std_Y"        "fBodyAccJerk_Std_Z"       
[53] "fBodyGyro_Mean_X"          "fBodyGyro_Mean_Y"          "fBodyGyro_Mean_Z"          "fBodyGyro_Std_X"          
[57] "fBodyGyro_Std_Y"           "fBodyGyro_Std_Z"           "fBodyAccMag_Mean"          "fBodyAccMag_Std"          
[61] "fBodyBodyAccJerkMag_Mean"  "fBodyBodyAccJerkMag_Std"   "fBodyBodyGyroMag_Mean"     "fBodyBodyGyroMag_Std"     
[65] "fBodyBodyGyroJerkMag_Mean" "fBodyBodyGyroJerkMag_Std" 

```
## Data Source

Data                     |    Detail
-------------------------|---------------------
train/X_train.txt        | data collected from training set
train/y_train.txt        | label for identifying which activity the training set took
train/subject_train.txt  | identifier of subject of training set
test/X_train.txt         | data collected from testing set
test/y_train.txt         | label for identifying which activity the testing set took
test/subject_train.txt   | identifier of subject of testing set
activity_labels.txt      | links the activity labels with their activity name
features.txt             | all feature variables

##Main Data Frame in project

Data Frame Name        | Description
-----------------------|------------------------
DataSet                | Combination of all the training and the testing sets (Step 1)
SelectDataSet          | Select only the measurements on the mean and sd for each feature variable (Step 2)
ModifiedDataSet        | First independent tidy data with substitution of activity label and descriptive variable names (Step 4)
TidyDataSet            | Second independent tidy data with the average of each variable for each activity and each subject (Step 5)
 
##Transformation to clean up data
The run_analysis.R script performs the following steps to clean the data: 
  
 1. Read X_train.txt, y_train.txt and subject_train.txt from the "./data/train" folder and store them in *TrainingSet*, *TrainingLabel* and *TrainingSubject* variables respectively.       
 2. Read X_test.txt, y_test.txt and subject_test.txt from the "./data/test" folder and store them in *TestingSet*, *TestingLabel* and *TestingSubject* variables respectively.  
 3. Concatenate *TestingSet* to *TrainingSet* to generate a 10299x561 data frame - *DataSet*; concatenate *TestingLabel* to *TrainingLabel* to generate a 10299x1 data frame, *Label*; concatenate *TestingSubject* to *TrainingSubject* to generate a 10299x1 data frame, *Subject*.  
 4. Combine *Subject*, *Label* , *DataSet* in order to generate a 10299x563 data frame, save in *DataSet*. Rename first two column as SubjectID and ActivityID
 5. Read the features.txt file from the "/data" folder and store the data in a variable called *Features*. In order to extract the measurements on the mean and standard deviation, first extract index of feature variable. This results in a 66 index list. Then generate a 10299x68 subset of *DataSet* with the 66 corresponding columns, storing in *SelectDataSet* as well as a 66x2 subset of *Features* with the 66 corresponding columns, storing in *SelectFeature*.
 6. Clean the column names of *SelectDataSet*. Remove the "()" symbols in the names, substitute "-" with "_" as well as make the first letter of "mean" and "std" a capital letter "M" and "S" respectively.   
 7. Read the activity_labels.txt file from the "./data"" folder and store the data in a variable called *Activity*.  
 8. Clean the activity names in the second column of *Activity*. First make all names to lower cases. If the name has an underscore between letters, remove the underscore and capitalize first letter of each word.  
 8. Transform the values of ActivityID column of *SelectDataSet* according to the *Activity* data frame. Rename second column of *SelectDataSet* as Activity.
 9. So far get a cleaned 10299x68 data frame *SelectDataSet*, of which first column is SubjectID ranging from 1 to 30 and second column is Activity containing 6 kinds of activity names and the last 66 columns containing selected feature variables that range from -1 to 1 exclusive.
 10. Write the *SelectDataSet* out to "Step4DataSet.txt" file in current working directory.  
 11. Finally, generate a second independent tidy data set with the average of each feature variable for each Subject and each Activity. since having 30 unique subjects and 6 unique activities, which means 180 possible combinations of the two. Then, for each combination, we calculate the mean of each feature variable with the corresponding combination. So, after initializing the *TidyDataSet* data frame and performing the two for-loops, get a 180x68 data frame, restoring in *TidyDataSet*.
 12. Write the *TidyDataSet* out to "Step5DataSet.txt" file in current working directory. 
 
*© All Rights reserved by **Liu Li** 07/09/2014 .*