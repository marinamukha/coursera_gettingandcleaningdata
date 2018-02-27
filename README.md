# Human Activity Recognition Using Smartphones
## Peer-reviewed assignment for "Getting and Cleaning Data" course

This file explains step-by-step the analysis conducted in order to obtain the clean dataset and construct the average statistics.

1. Import data
	1. The names of the variables are in the separate file, so in order to obtain the names for the major datasets, we need to construct the *names* vector first.
	In order to ease the use of the names, delete the characters such as brackets and make the names lower case.
	1. Import the following data for both train and test groups: 561 characteristics (use the *names* vector to assign the column names); data on subjects; data on activity labels.
	1. For each subsample (train and test) merge the three datasets (subjects, activity labels and characteristics).
	1. Append the two tables (train data and test data) and create a variable *type* which indicates the subset (1 "train", 2 "test").
	1. Check for the missing data in the final dataset. There are no missing values. 
1. Select needed data
	1. Search for the variables that are related to mean and standard deviation (and exclude the *meanFrequency* variables).
1. Aggregate data
	1. Using the *id* and *activity* as identifier, collapse the dataset to the mean values for each variable (in total 40 observations) using the *aggregate* function.
  
  As a result of this analysis, there are two data frames: *trackData* which is a tidy dataset of cariables of means and standard deviations of characteristics with identifiers (10299 observations of 77 variables); and *avgtrackData* which represents the mean values per subject per activity (180 osbervations of  77 variables).
