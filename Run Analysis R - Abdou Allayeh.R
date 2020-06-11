##Run_Analysis_R - Abdou Allayeh

## Libraries_Preparation
library(data.table)
library(plyr)
library(knitr)
library(reshape2)
library(codebook)
library(remotes)

## Get/download Data
rawDataDir <- "./rawData"
rawDataUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
rawDataFilename <- "rawData.zip"
rawDataDFn <- paste(rawDataDir, "/", "rawData.zip", sep = "")
dataDir <- "./data"

if (!file.exists(rawDataDir)) {
  dir.create(rawDataDir)
  download.file(url = rawDataUrl, destfile = rawDataDFn)
}
if (!file.exists(dataDir)) {
  dir.create(dataDir)
  unzip(zipfile = rawDataDFn, exdir = dataDir)
}
  
path_rf <- file.path("./data" , "UCI HAR Dataset")
files<-list.files(path_rf, recursive=TRUE)
files
  
## Read Training data sets
F_train <- read.table(file.path(path_rf, "train", "X_train.txt"),header = FALSE)
A_train <- read.table(file.path(path_rf, "train", "Y_train.txt"),header = FALSE)
S_train <- read.table(file.path(path_rf, "train", "subject_train.txt"),header = FALSE)

## Read Testing data sets
F_test <- read.table(file.path(path_rf, "test" , "X_test.txt" ),header = FALSE)
A_test <- read.table(file.path(path_rf, "test" , "y_test.txt" ),header = FALSE)
S_test <- read.table(file.path(path_rf, "test" , "subject_test.txt"),header = FALSE)

## Merge Training & testing data sets
F_data <- rbind(F_train, F_test)
A_data <- rbind(A_train, A_test)
S_data <- rbind(S_train, S_test)

## Set Names to data
names(S_data)<-c("subject")
names(A_data)<- c("activity")
F_dataNames <- read.table(file.path(path_rf, "features.txt"),head=FALSE)
names(F_data)<- F_dataNames$V2

## Get the data frame for all data sets
dataCombine <- cbind(S_data, A_data)
Data <- cbind(F_data, dataCombine)

## Extract Feature
feature <- read.table(paste(sep = "", dataDir, "/UCI HAR Dataset/features.txt"))
a_label <- read.table(paste(sep = "", dataDir, "/UCI HAR Dataset/activity_labels.txt"))
a_label[,2] <- as.character(a_label[,2])
selectedCols <- grep("-(mean|std).*", as.character(feature[,2]))
selectedColNames <- feature[selectedCols, 2]
selectedColNames <- gsub("-mean", "Mean", selectedColNames)
selectedColNames <- gsub("-std", "Std", selectedColNames)
selectedColNames <- gsub("[-()]", "", selectedColNames)

## Extract Data 
F_data <- F_data[selectedCols]
allData <- cbind(S_data, A_data, F_data)
colnames(allData) <- c("Subject", "Activity", selectedColNames)
allData$Activity <- factor(allData$Activity, levels = a_label[,1], labels = a_label[,2])
allData$Subject <- as.factor(allData$Subject)

## Produce tidy data set
library(reshape2)
meltedData <- melt(allData, id = c("Subject", "Activity"))
tidyData <- dcast(meltedData, Subject + Activity ~ variable, mean)
write.table(tidyData, "./tidy_dataset.txt", row.names = FALSE, quote = FALSE)

## Codebook
library(codebook)
new_codebook_rmd()














