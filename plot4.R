
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

#open PNG device
png(filename="plot4.png", width=480, height=480, units="px")

#plot set up
par(mfrow = c(2, 2), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0))

#top left plot
plot(dt,gap,type="l",xlab="",ylab="Global Active Power")

#top right plot
plot(dt,pwr$Voltage,type="l",xlab="datetime",ylab="Voltage")

#bottom left plot
plot(dt,pwr$Sub_metering_1,type="l",col="black",xlab="",ylim=range(pwr$Sub_metering_1),ylab="Energy sub metering")

par(new = TRUE)

plot(dt,pwr$Sub_metering_2,type="l",col="red",xlab="",ylim=range(pwr$Sub_metering_1),ylab="",axes=FALSE)

par(new = TRUE)

plot(dt,pwr$Sub_metering_3,type="l",col="blue",xlab="",ylim=range(pwr$Sub_metering_1),ylab="",axes=FALSE)

legend("topright",bty="n",lty=c(1,1,1),col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

#bottom right plot
plot(dt,pwr$Global_reactive_power,type="l",xlab="datetime",ylab="Global_reactive_power")

#close PNG device
dev.off()
