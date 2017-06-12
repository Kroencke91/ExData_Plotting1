
#download & unzip data file ############################
data_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

temp <- tempfile()

download.file(data_url, temp)

unzip(temp, "household_power_consumption.txt")

alldat <- read.csv("household_power_consumption.txt", header=TRUE, sep=";")

unlink(temp)

rm(temp)
#######################################################

#filter dataset
pwr <- subset(alldat, Date=="1/2/2007" | Date=="2/2/2007")

#prep data
pwr$Date <- as.Date(pwr$Date,"%d/%m/%Y")

pwr$Time <- as.character(pwr$Time)

pwr$Global_active_power <- as.numeric(as.character(pwr$Global_active_power))

pwr$Global_reactive_power <- as.numeric(as.character(pwr$Global_reactive_power))

pwr$Voltage <- as.numeric(as.character(pwr$Voltage))

pwr$Global_intensity <- as.numeric(as.character(pwr$Global_intensity))

pwr$Sub_metering_1 <- as.numeric(as.character(pwr$Sub_metering_1))

pwr$Sub_metering_2 <- as.numeric(as.character(pwr$Sub_metering_2))

pwr$Sub_metering_3 <- as.integer(as.character(pwr$Sub_metering_3))

gap <- pwr$Global_active_power

dt <- strptime(paste(pwr$Date,pwr$Time), format="%Y-%m-%d %H:%M:%S")

png(filename="plot2.png", width=480, height=480, units="px")

plot(dt,gap,type="l",xlab="",ylab="Global Active Power (kilowatts)")

dev.off()

