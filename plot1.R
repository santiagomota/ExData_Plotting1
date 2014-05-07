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

par(mfrow = c(1, 1))

hist(selection$Global_active_power, col="red", 
     xlab="Global Active Power (kilowatts)", main="Global Active Power")

# Change to main directory
setwd("./")
# Create figure directory
if(!file.exists("./figure")){dir.create("./figure")}
# Print to png file 
dev.copy(png, file="./figure/plot1.png", width=480, height=480)  ## Copy my plot to a PNG file
dev.off()
