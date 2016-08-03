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


#defactorize 
hpc2days$Global_active_power <- as.numeric(as.character(hpc2days$Global_active_power))

#plot
hist(hpc2days$Global_active_power,main="Global Active Power",col="red",xlab="Global Active Power(kilowatts)")

#save to png
dev.copy(png,file="plot1.png",height=480,width=480)
dev.off()


