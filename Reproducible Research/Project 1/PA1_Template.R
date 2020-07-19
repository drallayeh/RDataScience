## RR-project 1 - Abdou Allayeh
## Data loading

setwd("~/RDataScience/Reproducible Research/Project 1")
download.file("https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2Factivity.zip", destfile = "activity.zip", mode="wb")

## unzip data and read 

unzip("activity.zip")
Rawdata <- read.csv("activity.csv", header = TRUE)
head(Rawdata)

## Calculate total number of steps per day

main_data <- na.omit(Rawdata)
steps_per_day <- aggregate(main_data$steps, by = list(Steps.Date = main_data$date), FUN = "sum")

hist(steps_per_day$x, col = "gold", 
     breaks = 20,
     main = "Histogram for Total steps per day",
     xlab = "Total steps per day")

## Calculate the mean and median of all steps per day

main_mean <- mean(steps_per_day[,2])
print(main_mean)

main_median <- median(steps_per_day[,2])
print (main_median)

## average activity pattern per day
## Time Plotting for all steps per averaged of all days, along all 5-min intervals

avaraged_day <- aggregate(main_data$steps, 
                          by = list(Interval = main_data$interval), 
                          FUN = "mean")
plot(avaraged_day$Interval, avaraged_day$x, type = "l", 
     main = "Average activity pattern per day", 
     ylab = "Avarage number of steps ", 
     xlab = "5-min intervals")

## define the interval with the maximum number of steps

interval_row <- which.max(avaraged_day$x)
max_interval <- avaraged_day[interval_row,1]
print (max_interval)

## calculate the total number of NA values

NA_number <- length(which(is.na(Rawdata$steps)))
print (NA_number)

## Histogram for new frequencies of all steps

missingVals <- sum(is.na(data))
library(magrittr)
library(dplyr)

replacewithmean <- function(x) replace(x, is.na(x), mean(x, na.rm = TRUE))
meandata <- Rawdata %>% group_by(interval) %>% mutate(steps = replacewithmean(steps))
head(meandata)

## Histogram of all steps per day 
## Calculate and report the mean and median all steps per day

FullSummedDataByDay <- aggregate(meandata$steps, by=list(meandata$date), sum)

names(FullSummedDataByDay)[1] ="date"
names(FullSummedDataByDay)[2] ="totalsteps"
head(FullSummedDataByDay,15)

## Summary of newest data and making histogram

summary(FullSummedDataByDay)
hist(FullSummedDataByDay$totalsteps, xlab = "Steps", ylab = "Frequency", main = "Total Daily Steps", breaks = 20)

## Compare between the mean and median of Old and New data

oldmean <- main_mean
newmean <- mean(FullSummedDataByDay$totalsteps)
oldmedian <- main_median
newmedian <- median(FullSummedDataByDay$totalsteps)

## differences in activity patterns between weekdays and weekends
## Plotting for Comparison of average all steps per each interval

meandata$date <- as.Date(meandata$date)
meandata$weekday <- weekdays(meandata$date)
meandata$weekend <- ifelse(meandata$weekday=="Saturday" | meandata$weekday=="Sunday", "Weekend", "Weekday" )

library(ggplot2)
meandataweekendweekday <- aggregate(meandata$steps , by= list(meandata$weekend, meandata$interval), na.omit(mean))
names(meandataweekendweekday) <- c("weekend", "interval", "steps")

ggplot(meandataweekendweekday, aes(x=interval, y=steps, color=weekend)) + geom_line()+
  facet_grid(weekend ~.) + xlab("Interval") + ylab("Mean Steps") +
  ggtitle("Comparison of Average All Steps per each Interval")





