## R Code for Plot 1 - Abdou Allayeh
Library(data.table)

## Get/download Data
rawDataDir <- "./raw_P_Data"
rawDataUrl <- "https://archive.ics.uci.edu/ml/machine-learning-databases/00235/household_power_consumption.zip"
rawDataFilename <- "household_power_consumption.zip"
rawDataDFn <- paste(rawDataDir, "/", "household_power_consumption.zip", sep = "")
dataDir <- "./Plotsdata"
if (!file.exists(rawDataDir)) {
  dir.create(rawDataDir)
  download.file(url = rawDataUrl, destfile = rawDataDFn)
}
if (!file.exists(dataDir)) {
  dir.create(dataDir)
  unzip(zipfile = rawDataDFn, exdir = dataDir)
}

##Read data and filter it for specific dates
setwd("~/RDataScience/Plotsdata")
dataFile <- "~/RDataScience/Plotsdata/household_power_consumption.txt"
data <- read.table(dataFile, header=TRUE, sep=";", stringsAsFactors=FALSE, dec=".")
subData <- data[data$Date %in% c("1/2/2007","2/2/2007"),]
data <- read.table(dataFile, header=TRUE, sep=";", stringsAsFactors=FALSE, dec=".")
subData <- data[data$Date %in% c("1/2/2007","2/2/2007") ,]

## png and PLOT 1
globalActivePower <- as.numeric(subData$Global_active_power)
png("plot1.png", width=480, height=480)
hist(globalActivePower, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.off()

