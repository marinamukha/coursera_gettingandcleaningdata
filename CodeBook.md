# Human Activity Recognition Using Smartphones
## Peer-reviewed assignment for "Getting and Cleaning Data" course

## Data Source
The data was obtained from the UC Irvine Machine Learning Repository. It includes information on 30 volunteers who performed various kinds of activities wearing a smartphone. The data was recorded by using the embedded accelerometer and gyroscope. The obtained dataset was split in two subsamples - training set (70%) and test set (30%). More technical information as well as the dataset can be found [here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

## Study goal
The goal of the study is to prepare the tidy dataset for further descriptive analysis. In particular, to calculate average statistics of the variables for each activity and each subject.

## Short description of analysis 
In order to create a tidy dataset, the analysis undergoes the following steps:
* Appropriately label the data fields;
* Merge the training and test sets;
* Assign activity names to the data;
* Select the needed variables;
* Calculate average statistics.

More detailed information on these steps can be found in [README.md](https://github.com/marinamukha/coursera_gettingandcleaningdata/blob/master/README.md).

## Variables description
Each record in the raw dataset represents a 561-feature vector with time and frequency domain variables. The signals from smartphones were used to estimate variables of the feature vector for each pattern. '-XYZ' is used to denote 3-axial signals in the X, Y and Z directions (set 1):

Time domain | Frequency domain
------------|-----------------
tBodyAcc-XYZ |  fBodyAcc-XYZ
tGravityAcc-XYZ | fBodyAccJerk-XYZ
tBodyAccJerk-XYZ | fBodyGyro-XYZ
tBodyGyro-XYZ | fBodyAccMag
tBodyGyroJerk-XYZ | fBodyAccJerkMag
tBodyAccMag | fBodyGyroMag
tGravityAccMag | fBodyGyroJerkMag
tBodyAccJerkMag | 
tBodyGyroMag | 
tBodyGyroJerkMag |

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable (set 2):

* gravityMean-XYZ
* tBodyAccMean
* tBodyAccJerkMean
* tBodyGyroMean
* tBodyGyroJerkMean 

We are interested only in those variables that capture the mean and standard deviation of the described characteristics. Variables from set 1 have both mean and standard deviation observations, whereas in set 2 only the mean values are provided. Therefore, in the final dataset only 73 out of 561 characteristics are used, along with three identifying variables. There are 10299 observations in the final dataset and no missing observations.

### Variable 1: id
This variable identifies the subject (person) in the sample.

Integer, 1...30

### Variable 2: activity
This variable identifies the type of activity. Different subjects can be involved in different activities.

Factor with 6 levels:

Identifier | Activity
-----------|----------
1 |"LAYING"
2 | "SITTING"
3 | "STANDING"
4 | "WALKING"
5 | "WALKING_DOWNSTAIRS"
6 | "WALKING_UPSTAIRS"

### Variable 3: type
This variable identifies whether the person is in train or test dataset. Each subject belongs o one group only.

Factor with two levels:

Identifier | Group
-----------|----------
1 | "train"
2 | "test"

### Variables 4-76: time-varying mean and standard deviation values of various characteristics.
Continuous variables in range [-1, 1]. The names of these variables are constructed in the following manner: 
* prefix t/f - to denote time/frequency domain signals
* variable name
* suffix X/Y/Z - to denote 3-axial signals in the X, Y and Z directions
* mean/std - to denote which statistic is applied
