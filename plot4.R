## Santiago Mota
## Exploratory Data Analysis
## Course Project 1
## https://class.coursera.org/exdata-002/human_grading/view/courses/972082/assessments/3/submissions
## https://github.com/santiagomota/ExData_Plotting1

# Fork branch file with data
urls <- ("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip")
# Create data directory
if(!file.exists("./data")){dir.create("./data")}
# Download zip file
download.file(urls, "./data/power_consumption.zip")
# Change to data directory
setwd("./data/")
# Unzip file
unzip("power_consumption.zip")
# Load dataset
energy <- read.csv("household_power_consumption.txt", header=TRUE, sep=";",
                   stringsAsFactors=FALSE)
# Convert Date to date format
energy$Date <- as.Date(strptime(energy$Date, "%d/%m/%Y"))
# Convert Time to POSIXlt format
energy$Time <- strptime(paste(energy$Date, energy$Time), "%Y-%m-%d %H:%M:%S")
# Convert ? to NA
for(i in 3:8) {
      energy[energy[, i]=="?", i] <- "NA"
}
# Convert character to numeric
for(i in 3:8) {
      energy[, i] <- as.double(energy[, i])
}
# Subsetting dates
selection <- energy[(energy$Date=="2007-02-01" | energy$Date=="2007-02-02"), ]

# 4 plots
par(mfrow = c(2, 2))

# Plot 1
plot(selection$Time, selection$Global_active_power, col="black", type="l",
     xlab="Global Active Power (kilowatts)", main="Global Active Power")

# Plot 2
plot(selection$Time, selection$Voltage, col="black", type="l",
     xlab="datatime", ylab="Voltage")

# Plot 3
plot(selection$Time, selection$Sub_metering_1, type="l", 
     col="black", ylab="Energy sub metering", xlab="")
lines(selection$Time, selection$Sub_metering_2, type="l", col="red")
lines(selection$Time, selection$Sub_metering_3, type="l", col="blue")
legend("topright", lty=1, col=c("black", "blue", "red"), cex=1.2,
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       bty="n", y.intersp=1, xjust=1)

# Plot 4
plot(selection$Time, selection$Global_reactive_power, col="black", type="l",
     xlab="datatime", ylab="Global_reactive_power")

# Change to main directory
setwd("../")
# Create figure directory
if(!file.exists("./figure")){dir.create("./figure")}
# Print to png file
dev.copy(png, file="./figure/plot4.png")  ## Copy my plot to a PNG file
dev.off()
