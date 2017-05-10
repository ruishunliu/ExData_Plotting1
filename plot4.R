# set working directory
if(!file.exists("workfile")) {dir.create("workfile")}
setwd("./workfile")
if(!file.exists("Figures")) {dir.create("Figures")}
webUrl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(webUrl,destfile = "./data.zip")
datazipFile<-grep(".zip$",dir(),value=T)
# unzip dataset
unzip(zipfile=datazipFile)
textFile<-grep(".txt$",dir(),value=T)
dataFile<-file(textFile)
headNames=c("Date","Time","Global_active_power",
           "Global_reactive_power","Voltage","Global_intensity",
           "Sub_metering_1","Sub_metering_2","Sub_metering_3")
figData<-read.table(text=grep("^[1,2]/2/2007",readLines(dataFile),value=TRUE),
                 sep=';',col.names=headNames,
                 na.strings='?')
figData$Date <- as.Date(figData$Date, format = '%d/%m/%Y')
figData$DateTime <- as.POSIXct(paste(figData$Date, figData$Time))
# plot 4
Sys.setlocale(category = "LC_ALL", locale = "english")
png(filename = "./Figures/plot4.png",width = 480,height = 480,units = "px")
par(mfrow = c(2, 2))
# picture 1
with(figData,plot(DateTime,Global_active_power,xlab="",ylab="Global Active Power",type="l"))
# picture 2
with(figData,plot(DateTime,Voltage,xlab="datetime",ylab="Voltage",type="l"))
# picture 3
with(figData,plot(DateTime,Sub_metering_1,xlab="",ylab="Energy sub metering",type="l"))
lines(figData$DateTime,figData$Sub_metering_2,col="red",type="l")
lines(figData$DateTime,figData$Sub_metering_3,col="blue",type="l")
legend("topright", col = c('black', 'red', 'blue'), 
       legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), 
       lwd = 1, bty = "n")
# picture 4
with(figData,plot(DateTime,Global_reactive_power,xlab="datetime",ylab="Global_reactive_power",type="l"))
# close device
dev.off()