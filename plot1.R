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

#convert the Date column to date and Global active power column to numeric 
myPlotData$Global_active_power <- as.numeric(myPlotData$Global_active_power)

#call PNG driver to save chart
png("plot1.png", width = 480, height = 480, units="px")

#create histogram chart
hist(myPlotData$Global_active_power,main="Global Active Power", col="red", xlab="Global Active Power (kilowatts)")

#close the device
dev.off()
