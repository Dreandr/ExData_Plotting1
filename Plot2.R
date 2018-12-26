## Step 1: Download and unzip the data

zipUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zipFile <- "household_power_consumption.txt"

if (!file.exists(zipFile)) {
  download.file(zipUrl, destfile = "archive.zip")
}

if (!file.exists(zipFile)) {
  unzip("./archive.zip")
}

## Step 2: read the table, subset it and covert Time and Date variables into POSIXlt

x <- read.table("./household_power_consumption.txt", header = T, sep = ";", na.strings = "?", stringsAsFactors = F)
task <- subset(x, Date %in% c("1/2/2007", "2/2/2007"))
task$Time <- paste(as.vector(task$Date), as.vector(task$Time))
task$Time <- strptime (task$Time, format = "%d/%m/%Y %H:%M:%S")
task$Date <- as.Date(task$Date, format = "%d/%m/%Y")
rm(x)

## Step 3: We plot!
png(filename = "Plot2.png", width = 480, height = 480) 
plot(task$Time, task$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
dev.off()


