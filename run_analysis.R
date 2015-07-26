##########   Coursera, Getting & Cleaning Data    ##########
##########            Course Project              ##########
 
## Set up & read in data
    rm(list=ls())
    setwd(getwd())
    library(dplyr)
    library(reshape2)

    ### Download data file
    ZipData <- paste("https://d396qusza40orc.cloudfront.net/",
                     "getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", sep="")
    temp <- tempfile()
    download.file(ZipData, temp)
    unzip(temp, exdir = getwd())
    
    ### Read in test & train sets
        dsets <- c("test", "train")         ### two datasets
        dpath <- "UCI HAR Dataset"          ### path to data folder
        files <- c("subject_", "X_", "y_")  ### 3 types of files
        for (s in dsets) {
            assign(s, lapply(paste(dpath,"/",s,"/",files,s,".txt",sep=""),read.table))
        }
        names(test) <- c("subj", "set", "lab") 
        names(train) <- c("subj", "set", "lab")
        
    ### Read in activity labels & features
        files <- c("activity_labels", "features")
        dsets <- paste(dpath,"/",files,".txt",sep="")
        af <- lapply(dsets,read.table)
        names(af) <- files
        names(af$activity_labels) <- c("actnum", "activity")
        names(af$features) <- c("featnum", "feature")
        
    ### Clean up
        rm(list=c("dpath", "dsets", "files"))

## Step 1: Merges the training & test sets to create one dataset
    all <- rbind(test$set, train$set)
    
## Step 2: Extracts only the measurements on the mean and std dev for each measurement
    ### Identify columns that are mean() and std()
        af$features <- af$features[(grepl("mean()",af$features$feature, fixed=T) |
                                    grepl("std()",af$features$feature, fixed=T)),]
    ### Keep those columns only
        all <- all[,af$features$featnum]
    
## Step 3: Uses descriptive activity names to name the activities in the dataset
    all <- cbind(rbind(test$subj, train$subj), rbind(test$lab, train$lab), all)
    colnames(all)[1:2] <- c("subj", "act")
    all <- merge(all, af$activity_labels, by.x="act", by.y="actnum", all.x=T)
    all$act <- NULL       

## Step 4: Appropriately labels the data set with descriptive variable names
    af$features$feature <- as.character(af$features$feature)
    colnames(all)[2:67] <- af$features$feature
    
## Step 5: From dataset in step 4, create a 2nd, independent tidy dataset with the 
##          average of each variable for each acivity and each subject
    molten <- melt(all, id=c("subj", "activity"))
    tidy <- dcast(molten, subj + activity ~ variable, mean)
    tidy <- melt(tidy, id=c("subj", "activity"), 
            variable.name="measurement", value.name="mean")

## Write tidy data into text file
    write.table(tidy, file="ProjectTidyData.txt", row.names=FALSE)
    
## Read tidy data    
    #TidyData <- read.table("ProjectTidyData.txt", header=T)
    #View(TidyData)
    