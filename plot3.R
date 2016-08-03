#Downloand and unzip the data files
# 
# if(!file.exists("exdata-data-household_power_consumption.zip")) {
#   temp <- tempfile()
#   download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
#   file <- unzip(temp)
#   unlink(temp)
# }

if(!file.exists("./consumptiondata")){
dir.create("./consumptiondata")
fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip" 
download.file(fileurl, "./consumptiondata/powerconsumption.zip") 
alldata<-unzip(zipfile="./consumptiondata/powerconsumption.zip")
}

#Read data from downloaded file
hpc <- read.table(alldata, header=T, sep=";")

#reformat date and time
hpc$Date <- as.Date(hpc$Date, format="%d/%m/%Y")


#Filter data for only 2 days and tranform to get date time
hpc2days <- hpc[(hpc$Date=="2007-02-01") | (hpc$Date=="2007-02-02"),]
hpc2days<-transform(hpc2days, datetime=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")

#defactorize
hpc2days$Global_active_power <- as.numeric(as.character(hpc2days$Global_active_power))

hpc2days$Sub_metering_1 <- as.numeric(as.character(hpc2days$Sub_metering_1))
hpc2days$Sub_metering_2 <- as.numeric(as.character(hpc2days$Sub_metering_2))
hpc2days$Sub_metering_3 <- as.numeric(as.character(hpc2days$Sub_metering_3))


#plot
plot(hpc2days$datetime,hpc2days$Sub_metering_1,type="l",ylab="Energy sub metering",xlab="")
lines(hpc2days$datetime,hpc2days$Sub_metering_2,col="red")
lines(hpc2days$datetime,hpc2days$Sub_metering_3,col="blue")

#build legend
legend("topright",col=c("black","red","blue"),c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=c(1,1),lwd=c(1,1))


#save to png
dev.copy(png,file="plot3.png",height=480,width=480)
dev.off()
