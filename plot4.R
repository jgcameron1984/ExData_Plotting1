# Download and extract project data into working directory

# Set working directory
setwd("~/Coursera/04.Exploratory Data Analysis/Projects/Project1/Data")

# Read in data file
hhpower <- read.table("household_power_consumption.txt", 
                      header=T, sep=";",
                      colClasses = c("character", "character", "numeric",
                                     "numeric", "numeric", "numeric",
                                     "numeric", "numeric", "numeric"),
                      na = "?")
# Convert Date and subset data file
hhpower$Date <- as.Date(hhpower$Date, format="%d/%m/%Y")
hh_subset <- hhpower[(hhpower$Date=="2007-02-01") | (hhpower$Date=="2007-02-02"),]

# Combine Date and Time and convert to Date/Time classes
hh_subset$DateTime <- paste(hh_subset$Date, hh_subset$Time)
hh_subset$DateTime <- as.POSIXct(hh_subset$DateTime)

# Construct plot and save it to a PNG file
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0), cex.axis=.8, cex.lab = .8)
with(hh_subset, {
plot(Global_active_power ~ DateTime, type="l",
     ylab="Global Active Power", xlab="")
plot(Voltage ~ DateTime, type="l",
     ylab="Voltage", xlab="datetime")
plot(Sub_metering_1 ~ DateTime, type="l",
     ylab="Energy sub metering", xlab="")
lines(Sub_metering_2 ~ DateTime, col='Red')
lines(Sub_metering_3 ~ DateTime, col='Blue')
legend("top", col=c("black", "red", "blue"), lty=1, lwd=2, 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       bty="n", cex=.8)
plot(Global_reactive_power ~ DateTime, type="l",
     ylab="Global_reactive_power", xlab="datetime")
})

dev.copy(png, file="plot4.png", width=480, height=480)
dev.off()
