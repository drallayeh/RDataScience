## R code for Plot 3
setwd("~/RDataScience/Plotsdata")
dataFile <- "~/RDataScience/Plotsdata/household_power_consumption.txt"
data <- read.table(dataFile, header=TRUE, sep=";", stringsAsFactors=FALSE, dec=".")
subData <- data[data$Date %in% c("1/2/2007","2/2/2007"),]
data <- read.table(dataFile, header=TRUE, sep=";", stringsAsFactors=FALSE, dec=".")
subData <- data[data$Date %in% c("1/2/2007","2/2/2007") ,]

## png and PLOT 3
datetime <- strptime(paste(subData$Date, subData$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 
globalActivePower <- as.numeric(subData$Global_active_power)
subMeteringI <- as.numeric(subData$Sub_metering_1)
subMeteringII <- as.numeric(subData$Sub_metering_2)
subMeteringIII <- as.numeric(subData$Sub_metering_3)

png("plot3.png", width=480, height=480)
plot(datetime, subMeteringI, type="l", ylab="Energy Submetering", xlab="")
lines(datetime, subMeteringII, type="l", col="red")
lines(datetime, subMeteringIII, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2.5, col=c("black", "red", "blue"))
dev.off()

