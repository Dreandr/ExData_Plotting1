## Step 1: download and unzip the data

zipUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zipFile <- "household_power_consumption.txt"

if (!file.exists(zipFile)) {
  download.file(zipUrl, destfile = "archive.zip")
}

if (!file.exists(zipFile)) {
  unzip("./archive.zip")
}

## Step 2: Read the table, subset it, convert Time and Date variables into POSIXlt

x <- read.table("./household_power_consumption.txt", header = T, sep = ";", na.strings = "?", stringsAsFactors = F)
task <- subset(x, Date %in% c("1/2/2007", "2/2/2007"))
task$Time <- paste(as.vector(task$Date), as.vector(task$Time))
task$Time <- strptime (task$Time, format = "%d/%m/%Y %H:%M:%S")
task$Date <- as.Date(task$Date, format = "%d/%m/%Y")
rm(x)

## Step 3: Plot 

png(filename = "Plot3.png", width = 480, height = 480) 
plot(task$Time, task$Sub_metering_1, xlab = "", ylab = "Energy sub metering", type = "l") 
lines(x = task$Time, y = task$Sub_metering_2, col = "red")
lines(x = task$Time, y = task$Sub_metering_3, col = "blue")
legend("topright", legend=c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), lty = 1, col=c("black" , "red", "blue"))
dev.off()