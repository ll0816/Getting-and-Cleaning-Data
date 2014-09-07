######################################################################################
#Step1 -- Merges the Training and the test sets to create one data set.
#check whether UCI HAR Dataset exists
if (!("UCI HAR Dataset" %in% list.files())) {
    stop("Master! I can't UCI HAR Dataset Directory under current working directory.\n 
       Please use 'setwd()' to change working directory to right place or put\n 
       UCI HAR Dataset under working directory.")
}
#load package, if not installed, the code below will install package automatically
packagelist <- c("data.table")
newpackage <- packagelist[!(packagelist %in% installed.packages()[,"Package"])]
if(length(newpackage)>0) install.packages(newpackage)
sapply(packagelist, require, character.only=TRUE, quietly=TRUE)

#load Training set, trainging lables and Subject identifier of who in Training 
#set performed Activity from correspodant txt file.
TrainingSet <- read.table("./UCI HAR DataSet/train/X_train.txt")
TrainingLabel <- read.table("./UCI HAR DataSet/train/y_train.txt")
TrainingSubject <- read.table("./UCI HAR DataSet/train/subject_train.txt")

#go through each DataSet
head(TrainingSet)
dim(TrainingSet)  # 7352*561
head(TrainingLabel)
dim(TrainingLabel)  #7352*1
head(TrainingSubject)
dim(TrainingSubject)  #7352*1

#load testing set, testing lables and Subject identifier of who in testing set 
#performed Activity from correspodant txt file.
TestingSet <- read.table("./UCI HAR DataSet/test/X_test.txt")
TestingLabel <- read.table("./UCI HAR DataSet/test/y_test.txt")
TestingSubject <- read.table("./UCI HAR DataSet/test/subject_test.txt")

#go through each DataSet
dim(TestingSet)   #2947*561
dim(TestingLabel)   #2947*1
dim(TestingSubject)  #2947*1
head(TestingSet)
head(TestingLabel)
head(TestingSubject)

#merge Training set and testing sets
DataSet <- rbind(TrainingSet, TestingSet)
Label <- rbind(TrainingLabel, TestingLabel)
Subject <- rbind(TrainingSubject, TestingSubject)

# go through merged DataSet
tail(DataSet)
dim(DataSet)   #10299*561
tail(Label)
dim(Label)   #10299*1
tail(Subject)
dim(Subject)   #10299*1

#Change names for DataSet
names(Label) <- "ActivityID"
names(Label)
names(Subject) <- "SubjectID"
names(Subject)

#Merges the Training and the test sets into one data set.
temp <- cbind(Subject, Label)
DataSet <- cbind(temp, DataSet)
head(DataSet)
rm(temp)

#################################################################################################

#Step2 -- Extracts only the measurements on the mean and standard deviation for each measurement. 

#load all feature variables and go through it
Features <- read.table("./UCI HAR Dataset/features.txt")
head(Features)
dim(Features)  #561*2

# change name for feature variable column
names(Features) <- c("Number", "Feature")

# extract only the measurements on the mean and standard deviation for each measurement.
SelectIndex <- grepl("mean\\(\\)|std\\(\\)", Features[,2])
sum(SelectIndex)  #66
SelectFeatures <- Features[SelectIndex,]
SelectDataSet <- DataSet[,c(T,T,SelectIndex)]  #first two column are Label and Subject DataSet
names(SelectDataSet)
length(SelectDataSet)  #66+2

# make feature variables' name readable
SelectFeatures[,2] <- gsub("\\(\\)", "", SelectFeatures[,2])
SelectFeatures[,2] <- gsub("-", "_", SelectFeatures[,2])
SelectFeatures[,2] <- gsub("mean", "Mean", SelectFeatures[,2])
SelectFeatures[,2] <- gsub("std", "Std", SelectFeatures[,2])
SelectFeatures[,2]

#########################################################################################################

#Step3 -- Uses descriptive Activity names to name the activities in the data set
#load data set of names of activities
Activity <- read.table("./UCI HAR DataSet/activity_labels.txt")
head(Activity)

#make this data set more readable
names(Activity) <- c("ActivityID", "ActivityName")
names(Activity)
Activity[,2] <- tolower(gsub("_","",Activity[,2]))
substr(Activity[,2], 1, 1) <- toupper(substr(Activity[,2], 1, 1))
substr(Activity[2:3,2], 8, 8) <- toupper(substr(Activity[2:3,2], 8, 8))
Activity

#substitue ActivityId with ActivityName and change column name
SelectDataSet[,"ActivityID"] <- Activity[SelectDataSet[,"ActivityID"], 2]
setnames(SelectDataSet, "ActivityID", "Activity")
head(SelectDataSet$Activity, 50)
#####################################################################################################

#Step4 -- Appropriately Labels the data set with descriptive variable names. 
length(names(SelectDataSet)[-(1:2)])
setnames(SelectDataSet, names(SelectDataSet)[-(1:2)], SelectFeatures$Feature)
head(SelectDataSet)

# write out the first processed Dataset
write.table(SelectDataSet, "Step4DataSet.txt",row.name = F)

# check whether txt file was saved correctly
ModifiedDataSet <- read.table("Step4DataSet.txt", header = T)
head(ModifiedDataSet)
##############################################################################################################

#Step5 -- From the data set in step 4, creates a second, independent tidy data set with the average 
#         of each variable for each Activity and each Subject.

# Count the number of subjects
TotalSubject <- length(table(Subject))
TotalSubject  #30

# Count the number of Activity
TotalActivity <- length(Activity[,2])
TotalActivity   #6

#the number of selected feature variable
TotalCol <- dim(SelectDataSet)[2]
TotalCol

# define the dimension of Tidy Data Set which we are required to create
TidyDataSet <- matrix(NA, nrow = TotalSubject*TotalActivity , ncol = TotalCol) 
dim(TidyDataSet)  #180*68
# transfer matrix to dataframe and calculate the mean of each feature variable of each activity of each subject
TidyDataSet <- as.data.frame(TidyDataSet)
colnames(TidyDataSet) <- colnames(ModifiedDataSet) 
head(TidyDataSet)
row <- 1 
for(i in 1:TotalSubject) {
    for(j in 1:TotalActivity) {
        TidyDataSet[row, 1] <- sort(unique(Subject)[, 1])[i]
        TidyDataSet[row, 2] <- Activity[j, 2]
        bool1 <- i == ModifiedDataSet$SubjectID
        bool2 <- Activity[j, 2] == ModifiedDataSet$Activity
        TidyDataSet[row, 3:TotalCol] <- colMeans(ModifiedDataSet[bool1&bool2, 3:TotalCol])
        row <- row + 1
    }
}
head(TidyDataSet)

#write out 2nd Data Set
write.table(TidyDataSet, "Step5TidyDataSet.txt", row.names = F)

# © All Rights reserved by Liu Li 07/09/2014.
