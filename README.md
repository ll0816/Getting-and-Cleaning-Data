#Getting and Cleaning Data Course Project
Author: ***Liu Li***   
Github: <https://github.com/ll0816/Project>
##Instruction for the project
The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.  
One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:
<http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones>  
Here are the data for the project:
<https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>  
You should create one R script called run_analysis.R that does the following.
Merges the training and the test sets to create one data set.
Extracts only the measurements on the mean and standard deviation for each measurement.  
Uses descriptive activity names to name the activities in the data set.
Appropriately labels the data set with descriptive activity names.
Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

##Two ways to reproduce this project on your machine.

#### 1. Clone repo to your local machine from Github (containing Dataset, so take more time)   
1. Run following command in your `Terminal`
		
		git clone https://github.com/ll0816/Project.git
2. Change working directory of RStudio correctly  
      
		setwd("path to downloaded repo")
3. Run following command in `RStudio` to run Rstript
		
		source("run_analysis.R")
4. Code above will create two txt-format files under working directory of Rstudio
    * `Step4DataSet.txt` (8.3 Mb): it contains a *10299 x 68* data frame, which reaches the requirement of instruction from **Step 1** to **Step 4**
    * `Step5TidyDataSet.txt` (225 Kb): it cantains a *180 x 68* data frame,  which reaches the requirement of **Step 5**.

####2. Faster way to reproduce project

1. Dowload this file, `run_analysis.R` and `Cookbook.md` seperately and put them into directory contains `UCI HAR DataSet`
2. Change working directory of RStudio correctly
    		
    	setwd("path to directory contains above downloaded file and Dataset")
3. Run following command in `RStudio` to run Rstript
		
		source("run_analysis.R")
4. Code above will create two txt-format files under working directory of Rstudio
    * `Step4DataSet.txt` (8.3 Mb): it contains a *10299 x 68* data frame, which reaches the requirement of instruction from **Step 1** to **Step 4**
    * `Step5TidyDataSet.txt` (225 Kb): it cantains a *180 x 68* data frame,  which reaches the requirement of **Step 5**.
  
  
*© All Rights reserved by **Liu Li** 07/09/2014 .*