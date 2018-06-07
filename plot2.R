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
png("plot2.png")
with(hpc, {
        ##Setting up the bare graph.
        plot(DateTime, Global_active_power, type = "n", xlab = "",
             ylab = "Global Active Power (kilowatts)")
        
        ##Adding the lines to the graph.
        lines(DateTime, Global_active_power)
})
dev.off()