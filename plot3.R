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
png("plot3.png")
with(hpc, {
        
        ##Setting up the bare graph.
        plot(DateTime, Sub_metering_1, type = "n", xlab = "", 
             ylab = "Energy sub metering");
        
        ##Plotting the different lines one at a time.
        lines(DateTime, Sub_metering_1)
        
        lines(DateTime, Sub_metering_2, col = "tomato")
        
        lines(DateTime, Sub_metering_3, col = "blue")
        
        ##Adding in the legend, with "lwd = 1" to get the symbol to be a line.
        legend("topright",col = c("black","tomato","blue"), 
               legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
               lwd = 1)
})
dev.off()