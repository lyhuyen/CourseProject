---
output: html_document
---
# README

***
Coursera, Getting and Cleaning Data  
Ly Tran  
July 6th - August 3rd, 2015  

***


## Project's Information
This is a project for the Coursera course, Getting and Cleaning Data, aiming to demonstrate the student's ability to collect, work with, and clean a dataset. 

### Products
There are 4 files as end products:   
    - The R script is saved in **run_analysis.R**.  
    - The output tidy dataset is saved in __ProjectTidyData.txt__.  
    - The codebook for the tidy dataset is in __Codebook.md__.  
    - This README file, __README.md__.  

To read the tidy dataset, you can run the following code after copying the tidy data file (__ProjectTidyData.txt__) into the working directory:
```
    TidyData <- read.table("ProjectTidyData.txt", header=T)  
    View(TidyData)
```

### Data
The data for this project is obtained from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip. The R script __run_analysis.R__ includes a section that downloads & unzips the data into the working directory. If the internet is not available, or the data is already in the working directory, the section _Download data file_ from line 10 to line 15 should be commented out. 

The script assumes that the dataset is unzipped into the working directory and its structure is preserved. That is, all data should be saved into the folder __UCI HAR Dataset__. The folder __UCI HAR Dataset__ should contain:  

* File __activity_labels.txt__ and __features.txt__.  
* Folder __test__, which contains  
    + File __subject_test.txt__  
    + File __X_test.txt__  
    + File __y_test.txt__  
        
* Folder __train__, which contains  
    + File __subject_train.txt__  
    + File __X_train.txt__  
    + File __y_train.txt__  

Explanation for the original dataset can be found at http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones and the file __features_info.txt__ in the unzipped data folder. Part of the file is included in this README file under the Features section. 

### Procedure
This project consists of 5 steps, all documented in the R script file __run_analysis.R__. The script requires to packages: __dplyr__ and __reshape2__.

1. Merge the training and test sets to arrive at one data file.    
2. Extracts only the measurements on the mean and std dev for each measurement. This is done by keeping variables that contain characters "mean()" or "std()". The parentheses are required, as the original dataset contains variables such as mean of frequency (containing "meanFreq") or pre-calculated average of measurement across 3 axial directions X, Y, and Z (tBodyAccMean, tBodyGyroMean, ...).  
3. Attach descriptive names to activities in the dataset. So, instead of numbers 1, 2, 3, ..., the activity column now specifies LAYING, STANDING, WALKING, etc...
4. Attach descriptive names to the dataset. So, each measurement has a name label instead of only a number. For example, tBodyAcc-mean()-X refers to the average signal in the X direction received by the accelerometer worn by the volunteer. 
5. Take the average of each measurement for each subject and each activity. The product of this step is a tidy dataset that is saved in __ProjectTidyDataset.txt__. 

## Features
_Note: This section is obtained from the file __features_info.txt__ that is included with the original dataset._  

The features selected for the original database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

- tBodyAcc-XYZ  
- tGravityAcc-XYZ  
- tBodyAccJerk-XYZ  
- tBodyGyro-XYZ  
- tBodyGyroJerk-XYZ  
- tBodyAccMag  
- tGravityAccMag  
- tBodyAccJerkMag  
- tBodyGyroMag  
- tBodyGyroJerkMag  
- fBodyAcc-XYZ  
- fBodyAccJerk-XYZ  
- fBodyGyro-XYZ  
- fBodyAccMag  
- fBodyAccJerkMag  
- fBodyGyroMag  
- fBodyGyroJerkMag  

The set of variables that were estimated from these signals are: 

- mean(): Mean value  
- std(): Standard deviation  
- mad(): Median absolute deviation  
- max(): Largest value in array  
- min(): Smallest value in array  
- sma(): Signal magnitude area  
- energy(): Energy measure. Sum of the squares divided by the number of values.  
- iqr(): Interquartile range  
- entropy(): Signal entropy  
- arCoeff(): Autorregresion coefficients with Burg order equal to 4  
- correlation(): correlation coefficient between two signals  
- maxInds(): index of the frequency component with largest magnitude  
- meanFreq(): Weighted average of the frequency components to obtain a mean frequency  
- skewness(): skewness of the frequency domain signal  
- kurtosis(): kurtosis of the frequency domain signal  
- bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.  
- angle(): Angle between to vectors.  

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

- gravityMean  
- tBodyAccMean  
- tBodyAccJerkMean  
- tBodyGyroMean  
- tBodyGyroJerkMean  

The complete list of variables of each feature vector is available in 'features.txt'