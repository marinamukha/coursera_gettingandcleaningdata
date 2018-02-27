################################################################################
## Specialization:   Data Science
## Course:           III. Getting and Cleaning Data
################################################################################
## Peer-graded Assignment: Getting and Cleaning Data Course Project
################################################################################
rm(list = ls())
setwd("./III/rdir")
library(plyr)
library(dplyr)
library(stringr)
library(reshape2)
library(foreign)
################################################################################

## assign column names & remove all additional signes
## however, keep the . before and after statistics, in this way it's easier to 
## differentiate between mean and meanfreq
features <- read.table("./data/UCI HAR Dataset/features.txt")
names <- as.character(features$V2)
head(names)
names <- gsub("\\(|\\)|\\.", "", names)
names <- tolower(names)
head(names)

## import data
train <- read.table("./data/UCI HAR Dataset/train/X_train.txt", col.names = names)
test  <- read.table("./data/UCI HAR Dataset/test/X_test.txt", col.names = names)

trainSubjects <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")
testSubjects  <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")

trainLabels <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
testLabels  <- read.table("./data/UCI HAR Dataset/test/y_test.txt")

activity <- read.table("./data/UCI HAR Dataset/activity_labels.txt")

## rename data frames with labels & subjects
trainSubjects <- rename(trainSubjects, id = V1)
testSubjects <- rename(testSubjects, id = V1)

## make two big tables - combine data with subjects and activities
trainData <- cbind(trainSubjects, trainLabels, type = "train", train)
testData  <- cbind(testSubjects, testLabels, type = "test", test)

## merge activity with labels
trainData1 <- merge(activity, trainData, by.x = "V1", by.y = "V1",
                      all = TRUE)
testData1  <- merge(activity, testData, by.x = "V1", by.y = "V1",
                      all = TRUE)
trainData1 <- rename(trainData1, activityid = V1, activity = V2)
testData1 <- rename(testData1, activityid = V1, activity = V2)

## make final table - append, not merge
trackData <- rbind(trainData1, testData1)

## check for the NA's - althought in the description it's written 
all(colSums(is.na(trackData))==0) 

## subset - only mean and stdev vars
trackData <- trackData[ , grepl("(mean\\.|mean$|std|id|activity|type)", 
                                names(trackData))]

## average and sort
avgtrackData <- aggregate(. ~ id + activity, data = trackData, mean)
avgtrackData <- arrange(avgtrackData, id, activity)
avgtrackData$type <- factor(avgtrackData$type, levels = c(1, 2), 
                            labels = c("train", "test"))

## remove unnecessary data
rm(activity, features, test, testData, testLabels, testSubjects, train,
   trainData, trainLabels, trainSubjects, names, testLabel, trainLabel,
   testData1, trainData1)

## export data
write.table(trackData, "./trackData.txt", sep="\t", row.names = FALSE)
write.table(avgtrackData, "./avgtrackData.txt", sep="\t", row.names = FALSE)
