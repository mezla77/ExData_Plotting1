'Read in the data'
HouseElecFull <- read.csv("household_power_consumption.txt",sep=";",colClasses=c("character","character", rep("numeric",7)), na.strings = "?")

'Reduce the dataset to what we are studying'
startRow <- which(HouseElecFull$Date == "1/2/2007")[1]
endRow <- which(HouseElecFull$Date == "3/2/2007")[1] - 1
HouseElecStudy <- HouseElecFull[startRow:endRow,]

rm(HouseElecFull)

'Combine the Date & Time, convert them to POSIX, and add them to the data'
DateTimes <- strptime(paste(HouseElecStudy$Date, " ", HouseElecStudy$Time),"%d/%m/%Y %H:%M:%S")
HouseElecStudy <- cbind(DateTimes,HouseElecStudy)

'Cleanup'
HouseElecStudy$Date <- NULL
HouseElecStudy$Time <- NULL
rm(DateTimes)

'Replace any "?" values with NA for easy processing'
HouseElecStudy[,2:8][HouseElecStudy[,2:8] == "?"] <- NA

'Save the histogram for Plot1 to plot1.png'
png(file = "plot3.png")
plot(HouseElecStudy$DateTimes, HouseElecStudy$Sub_metering_1, type = "l", ylab="Energy sub metering", xlab="")
lines(HouseElecStudy$DateTimes, HouseElecStudy$Sub_metering_2, col="red")
lines(HouseElecStudy$DateTimes, HouseElecStudy$Sub_metering_3, col="blue")
legend("topright", lty = 1,col=c("black", "blue","red"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.off()
