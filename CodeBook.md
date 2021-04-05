## Code book for *run_analysis.R*

### Data provided by the assignment

#### Training Set


`x_train`:  
Data frame of measured data for the training set. Ecah row is a 561-element vector of measured corresponding to a study subject and an activity that that subject performed

`y_train`:  
Data frame of activities performed by training set subjects corresponding to data values in `x_train`. Values 1-6 corresponding to factor levels of activities that were performed:  
1            WALKING  
2   WALKING_UPSTAIRS  
3 WALKING_DOWNSTAIRS  
4            SITTING  
5           STANDING  
6             LAYING  

`subject_train`:  
Data frame of training set subject identification numbers that performed activities in `y_train` corresponding to measured values in `x_train`, values 1-30.  

#### Test set

`x_test`:
Data frame of measured data for the test set. Ecah row is a 561-element vector of measured corresponding to a study subject and an activity that that subject performed  

`y_test`:  
Data frame of activities performed by test set subjects corresponding to data values in `x_test`. Values 1-6 corresponding to factor levels of activities that were performed:  
1            WALKING  
2   WALKING_UPSTAIRS  
3 WALKING_DOWNSTAIRS  
4            SITTING  
5           STANDING  
6             LAYING  

`subject_test`:  
Data frame of test set subject identification numbers that performed activities in `y_test` corresponding to measured values in `x_test`, values 1-30.  

#### Data common to both, test and train set  

`activities`:  
A list of names of activities that subjects performed. Six activities were included  
"WALKING"            "WALKING_UPSTAIRS"   "WALKING_DOWNSTAIRS" "SITTING"            "STANDING"           "LAYING"   

`features`:  
A list of 561 features describing measured variables in `x_train` and `x_test` data frames.  
Variables were derived from a list of signals that were measured. Variables are as follows:  
mean(): Mean value  
std(): Standard deviation  
mad(): Median absolute deviation  
max(): Largest value in array  
min(): Smallest value in array  
sma(): Signal magnitude area  
energy(): Energy measure. Sum of the squares divided by the number of values   
iqr(): Interquartile range   
entropy(): Signal entropy  
arCoeff(): Autorregresion coefficients with Burg order equal to 4  
correlation(): correlation coefficient between two signals  
maxInds(): index of the frequency component with largest magnitude  
meanFreq(): Weighted average of the frequency components to obtain a mean frequency  
skewness(): skewness of the frequency domain signal   
kurtosis(): kurtosis of the frequency domain signal   
bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window  
angle(): Angle between to vectors  

The list of signals they were derived from are as follows:    
tBodyAcc-XYZ  
tGravityAcc-XYZ  
tBodyAccJerk-XYZ  
tBodyGyro-XYZ  
tBodyGyroJerk-XYZ  
tBodyAccMag  
tGravityAccMag  
tBodyAccJerkMag  
tBodyGyroMag  
tBodyGyroJerkMag  
fBodyAcc-XYZ  
fBodyAccJerk-XYZ  
fBodyGyro-XYZ  
fBodyAccMag  
fBodyAccJerkMag  
fBodyGyroMag  
fBodyGyroJerkMag  

The *angle()* variable was further vectorized by averaging following signals:  
gravityMean  
tBodyAccMean  
tBodyAccJerkMean  
tBodyGyroMean  
tBodyGyroJerkMean  


### Data calculated by the assignment script

`train`:  
Merged data frame of training data set with the subject and activity data.  

`test`:  
Merged data frame of test data set with the subject and activity data.  

`full_df`:  
Merged data frame contaiing both `train` and `test` data.  

`df_mean_std`:  
Data frame containing extracted measurements on only the mean and standard deviation for each measurement.  
The data frame contains  
*subject*: Subject ID of the individual that performed the activity  
*activity*: Descriptive activity name of the activity performed by the subject  
a 66-element vector of variables that contain *mean()* or *std()* on each measurement  

`df_tidy`:  
The final, tidy-format, data frame containing averages of variables from `df_mean_std` grouped by the subject and the activity type.  
The data frame contains  
*subject*: Subject ID of the individual that performed the activity  
*activity*: Descriptive activity name of the activity performed by the subject  
a 66-element vector of averages of variables that contain *mean()* or *std()* on each measurement


