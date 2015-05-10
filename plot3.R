###################################
# Code for Plot 3 of project 1 of "Exploratory Data Analysis" course
# Date: 10-MAY-2015
# Author: James Stevenson
###################################

## Replace this with appropriate location:
setwd("C:\\Jamie\\Coursera\\Data Science\\Rwd")

## Create a data directory if doesn't already exist:
if (!file.exists("data")) {
  dir.create("data")
}

## download the zipped data:
fileUrl <- "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile = "./data/household_power_consumption.zip")
list.files("./data")

dateDownloaded <- date()

## unzip data
datafile <- unzip("./data/household_power_consumption.zip", overwrite = T, exdir = "./data")

## read ALL data into a table
fulldata <- read.table(datafile, header=T, sep=";", na.strings = "?")

## isolate date values of interest in new table
### convert date to date type
fulldata$Date <- as.Date(fulldata$Date, format="%d/%m/%Y")
### use date type to isolate
sampledata <- fulldata[(fulldata$Date=="2007-02-01") | (fulldata$Date=="2007-02-02"),]

## add a combined datetime column:
sampledata$Datetime <- strptime(paste(sampledata$Date, sampledata$Time), "%Y-%m-%d %H:%M:%S")

## Plot3
png(filename = "plot3.png", width = 480, height = 480)
plot(sampledata$Datetime, sampledata$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
points(sampledata$Datetime, sampledata$Sub_metering_2, type = "l", xlab = "", ylab = "Energy sub metering", col = "red")
points(sampledata$Datetime, sampledata$Sub_metering_3, type = "l", xlab = "", ylab = "Energy sub metering", col = "blue")
legend("topright", lty = 1, col = c("black", "red", "blue"),
       legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3")
)
##dev.copy(png, file="plot3.png", width=480, height=480)
dev.off()
