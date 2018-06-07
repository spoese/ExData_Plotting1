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

##Plotting the histogram into a .png.
png("plot1.png")

hist(hpc$Global_active_power, col = "red", main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)")

dev.off()