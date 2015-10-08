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
plot(hh_subset$Sub_metering_1 ~ hh_subset$DateTime, type="l",
     ylab="Global Active Power (kilowatts)", xlab="")
lines(hh_subset$Sub_metering_2 ~ hh_subset$DateTime, col='Red')
lines(hh_subset$Sub_metering_3 ~ hh_subset$DateTime, col='Blue')
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=1, 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.copy(png, file="plot3.png", width=480, height=480, res=65)
dev.off()
