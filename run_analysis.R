################################################################################
## Specialization:   Data Science
## Course:           III. Getting and Cleaning Data
################################################################################
## Peer-graded Assignment: Getting and Cleaning Data Course Project
################################################################################
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

## merge activity with labels
trainLabels <- merge(trainLabels, activity, by.x = "V1", by.y = "V1",
                      all = TRUE)
trainLabel  <- as.character(trainLabels[, 2])
testLabels  <- merge(testLabels, activity, by.x = "V1", by.y = "V1",
                      all = TRUE)
testLabel   <- as.character(testLabels[, 2])

## rename data frames with labels & subjects
trainSubjects <- rename(trainSubjects, id = V1)
testSubjects <- rename(testSubjects, id = V1)

## make two big tables - combine data with subjects and activities
trainData <- cbind(trainSubjects, trainLabel, type = "train", train)
trainData <- rename(trainData, activity = trainLabel)
testData  <- cbind(testSubjects, testLabel, type = "test", test)
testData  <- rename(testData, activity = testLabel)

## make final table - append/bind
trackData <- rbind(trainData, testData)

## check for the NA's - althought in the description it's written there are nonne 
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
   trainData, trainLabels, trainSubjects, names, testLabel, trainLabel)

## export data
write.table(trackData, "./trackData.txt", sep="\t")
write.table(avgtrackData, "./avgtrackData.txt", sep="\t")
