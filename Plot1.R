## Step 1: We download the archive

zipUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zipFile <- "household_power_consumption.txt"

if (!file.exists(zipFile)) {
  download.file(zipUrl, destfile = "archive.zip")
}

if (!file.exists(zipFile)) {
  unzip("./archive.zip")
}

## Step 2: We read the table, subset it and covert time and dates into POSIXlt

x <- read.table("./household_power_consumption.txt", header = T, sep = ";", na.strings = "?", stringsAsFactors = F)
task <- subset(x, Date %in% c("1/2/2007", "2/2/2007"))
task$Time <- paste(as.vector(task$Date), as.vector(task$Time))
task$Time <- strptime (task$Time, format = "%d/%m/%Y %H:%M:%S")
task$Date <- as.Date(task$Date, format = "%d/%m/%Y")
rm(x)

## Step 3: We draw the plot!
png(filename = "Plot1.png", width = 480, height = 480) 
hist(task$Global_active_power, xlab = "Global Active Power (kilowatts)", ylab = "Frequency", main = "Global Active Power", col = "red")
dev.off()