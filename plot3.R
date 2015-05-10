###########################################
# Project 1 for Exploratory Data Analysis #
###########################################

# Plot3.R
# This script performs the following actions for the second plot: 
# 
# 1. Download and unzip the data file (only when necessary). 
# 2. Load the data from the dates 2007-02-01 and 2007-02-02.
# 3. Construct the plot and save it to a PNG file with a width of 480 pixels 
#    and a height of 480 pixels.
# 4. Save and name the resulting plot file as plot3.png


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
library(lubridate)RU
data$fulldate <- dmy_hms(paste(data$Date, data$Time))
data <- data[ , !(names(data) %in% c("Date", "Time"))]


# 3. Construct the plot and save it to a PNG file with a width of 480 pixels 
#    and a height of 480 pixels.

# Since the locale in my system is not English, I need to set it before
# drawing to make the week days appear in English

Sys.setlocale("LC_TIME", "English")
# [1] "English_United States.1252"

with (data, {plot(Sub_metering_1 ~ fulldate, type = "l",
                 ylab = "Energy sub metering", xlab = "")      
            lines(Sub_metering_2 ~ fulldate, col = "red")
            lines(Sub_metering_3 ~ fulldate, col = "blue")})
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", 
                              "Sub_metering_3"),
       col = c("black", "red", "blue"), lty = 1, lwd = 2, 
       text.width = 57000)

# 4. Save and name the resulting plot file as plot1.png

# We can do it just copying the plot to a PNG device and closing it

dev.copy(png, file = "plot3.png", width = 480, height = 480)
dev.off()
