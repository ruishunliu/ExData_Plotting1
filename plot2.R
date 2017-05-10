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
# plot 2
Sys.setlocale(category = "LC_ALL", locale = "english")
png(filename = "./Figures/plot2.png",width = 480,height = 480,units = "px")
with(figData,plot(DateTime,Global_active_power,xlab="",
                  ylab="Global Active Power (kilowatts)", type ="l"))
dev.off()