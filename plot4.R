##Initializing the required packages.
if (!require(lubridate))
        install.packages("lubridate")
library(lubridate)
library(plyr)

##Downloading/unzipping file if it doesn't already exist
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if (!file.exists("./HPC.zip")) {
        download.file(fileUrl, destfile = "./HPC.zip")
        unzip("./HPC.zip")
}

##Reading in only the two days worth of data from the table by specifying
##exactly which rows to read in. All of the data are in rows 66638-69517.
hpc <- read.table("household_power_consumption.txt", sep = ";", 
                  na.strings = "?", skip = 66637, nrows = (69517-66637))

##Extracting the column names from the first row of the .txt file.
colnames(hpc) <- read.table("household_power_consumption.txt", sep = ";", 
                            as.is = TRUE, nrows = 1)

##Adding a new column that combines the Date and Time, then converting that
##new column into the Date class.
hpc <- mutate(hpc, DateTime = paste(Date,Time))
hpc$DateTime <- dmy_hms(hpc$DateTime)

##Plotting into a .png
png("plot4.png")

##Setting up the 2x2 grid for the plots.
par(mfrow = c(2,2))

with(hpc, {
        
        ##For each plot, I set up the bare graph, and then add the required data
        plot(DateTime, Global_active_power, type = "n", xlab = "", 
             ylab = "Global Active Power")
        lines(DateTime, Global_active_power)
        
        plot(DateTime, Voltage, type = "n", xlab = "datetime", ylab = "Voltage")
        lines(DateTime,Voltage)
        
        plot(DateTime, Sub_metering_1, type = "n", xlab = "", 
             ylab = "Energy sub metering");
        lines(DateTime, Sub_metering_1)
        lines(DateTime, Sub_metering_2, col = "tomato")
        lines(DateTime, Sub_metering_3, col = "blue")
        legend("topright",col = c("black","tomato","blue"), bty = "n", 
               legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
               lwd = 1)
        
        plot(DateTime, Global_reactive_power, type = "n", xlab = "datetime", ylab = "Global_reactive_power")
        lines(DateTime,Global_reactive_power)
})
dev.off()