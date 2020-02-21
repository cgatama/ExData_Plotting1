## set global options that apply to every chunk in your file, call knitr::opts_chunk$set

knitr::opts_chunk$set(echo = TRUE, results = "asis")



## Loading the data
getwd()
setwd("E:/CourseraMOOCs/Rstudio/ExData_Plotting1")

## #Reads in data from file.
pwData <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))

## convert the Date and Time variables to Date/Time classes in R using the
## as.Date() functions
pwData$Date <- as.Date(pwData$Date, "%d/%m/%Y")

## Read data the data only from dates 2007-02-01 and 2007-02-02.
pwData <- subset(pwData,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))

## Remove incomplete observation
pwData <- pwData[complete.cases(pwData),]

## Combine Date and Time column
dateTime <- paste(pwData$Date, pwData$Time)

## Name the vector
# dateTime <- setNames(dateTime, "DateTime")


## Remove Date and Time column
pwData <- pwData[ ,!(names(pwData) %in% c("Date","Time"))]

## Add DateTime column
pwData <- cbind(dateTime, pwData)

## Format dateTime Column
pwData$dateTime <- as.POSIXct(dateTime)


### Plot 3

with(pwData, {
  plot(Sub_metering_1~dateTime, type="l",
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~dateTime,col='Red')
  lines(Sub_metering_3~dateTime,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lwd=c(1,1,1), 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))


## Save plot3 as PNG file with a width of 480 pixels and a height of           ##480pixels
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()



