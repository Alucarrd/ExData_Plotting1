#set the new working directory
setwd("/home/pete/DataScience/ExploratoryAnalysis/CourseProject1/ExData_Plotting1")

#load data into dataframe
myData <- read.table(file="../data/household_power_consumption.txt", header=TRUE, sep=";", stringsAsFactors = FALSE)

#subset data to grab date from 2/1/2007 and 2/2/2007
myPlotData <- myData[myData$Date == '1/2/2007' | myData$Date == '2/2/2007',]

#build a new column to setup Datetime
myPlotData <-cbind(DateTime = paste(myPlotData$Date, myPlotData$Time), myPlotData)

#Convert DateTime column into true date time type
myPlotData$DateTime <- as.POSIXct(myPlotData$DateTime, format="%d/%m/%Y %H:%M:%S")

#Dropt he original Date and Time columns
myPlotData <- subset(myPlotData, select = -c(2,3) )

#convert the Global active power column to numeric 
myPlotData$Global_active_power <- as.numeric(myPlotData$Global_active_power)

#convert Sub_metering_1, Sub_metering_2, Sub_metering_3 to numeric 
myPlotData$Sub_metering_1 <- as.numeric(myPlotData$Sub_metering_1)
myPlotData$Sub_metering_2 <- as.numeric(myPlotData$Sub_metering_2)
myPlotData$Sub_metering_3 <- as.numeric(myPlotData$Sub_metering_3)

#call PNG driver to save chart
png("plot3.png", width = 480, height = 480, units="px")

#plog first line of sub_metering_1
plot(myPlotData$DateTime, myPlotData$Sub_metering_1, type="l", ylab="Energy sub metering", xlab="")

#add Sub_metering_2 as second line
lines(myPlotData$DateTime, myPlotData$Sub_metering_2, col="red")

#add Sub_metering_3 as third line
lines(myPlotData$DateTime, myPlotData$Sub_metering_3, col="blue")

#add legend
legend('topright', c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), col=c('black', 'red', 'blue'), lty=1)

#close the device
dev.off()
