# download and unzip the file
fileUrl="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

if (!file.exists("household_power_consumption.txt")) {
  download.file(fileUrl, destfile="exdata_data_household_power_consumption.zip")
  file<-unzip(zipfile="exdata_data_household_power_consumption.zip")
}


library(dplyr)

# read txt file as data table
originalTxt=read.table("household_power_consumption.txt",sep=";",
                       header = TRUE,stringsAsFactors = FALSE)


# using data from the dates 2007-02-01 and 2007-02-02
date_filter=grep("^(2/2/2007)|^(1/2/2007)",originalTxt$Date)
graphDf=originalTxt[date_filter,]


# combine date and time and transform into date class 
dateTime=strptime(paste(graphDf$Date,graphDf$Time),format = "%Y-%m-%d %H:%M:%S")
graphDf$dateTime=dateTime

# make the plot
png('plot2.png',width=480,height=480,units="px",bg = "transparent")
plot(graphDf$dateTime,graphDf$Global_active_power,
     type = "l",
     xlab = "",
     ylab="Global Active Power (kilowatts)",
     bg="transparent")
dev.off()