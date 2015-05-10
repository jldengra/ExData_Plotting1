###########################################
# Project 1 for Exploratory Data Analysis #
###########################################

# Plot2.R
# This script performs the following actions for the second plot: 
# 
# 1. Download and unzip the data file (only when necessary). 
# 2. Load the data from the dates 2007-02-01 and 2007-02-02.
# 3. Construct and customize the plot.
# 4. Save it to a PNG file with a width of 480 pixels and a height of 480 pixels.


# 1. Download and unzip the data file (only when necessary). 

# Firstly, it is set as working directory the folder where the source file is

setwd("D:/Training/Data Science/JHU Specialization/Exploratory Data Analysis/Project 1/ExData_Plotting1")

# The archive with the project data file is downloaded and extracted to a "data"
# subfolder in this directory, and finally the archive is removed. 

if (!file.exists("./data")) { dir.create("./data") }
if (!file.exists("./data/household_power_consumption.txt")){
        fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        download.file(fileUrl, destfile = "./data/data.zip")
        unzip("./data/data.zip", exdir = "./data")
        unlink("./data/data.zip")
}


# 2. Load the data from the dates 2007-02-01 and 2007-02-02 
#    like in plot1.R (more comments and details in that script)

data <- read.csv("./data/household_power_consumption.txt", header = TRUE, 
                 sep = ';', na.strings = "?", stringsAsFactors = FALSE)
data <- subset(data, Date == "1/2/2007" | Date == "2/2/2007")
library(lubridate)
data$fulldate <- dmy_hms(paste(data$Date, data$Time))
data <- data[ , !(names(data) %in% c("Date", "Time"))]


# 3. Construct and customize the plot.

# Since the locale in my system is not English, I need to set it before
# drawing to make the week days appear in English

Sys.setlocale("LC_TIME", "English")
# [1] "English_United States.1252"

par(mfrow = c(1, 1), mar = c(4, 4, 3, 1.8))
with (data, plot(Global_active_power ~ fulldate, type = "l",
                 xlab = "", ylab = "Global Active Power (kilowatts)",  
                 cex.lab = .75, cex.axis = .75))


# 4. Save it to a PNG file with a width of 480 pixels and a height of 480 pixels.
# We can do it just copying the plot to a PNG device and closing it.

dev.copy(png, file = "plot2.png", width = 480, height = 480)
dev.off()
