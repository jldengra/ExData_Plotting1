###########################################
# Project 1 for Exploratory Data Analysis #
###########################################

# Plot1.R
# This script performs the following actions for the first plot: 
# 
# 1. Download and unzip the data file (only when necessary). 
# 2. Load the data from the dates 2007-02-01 and 2007-02-02.
# 3. Construct the plot and save it to a PNG file with a width of 480 pixels 
#    and a height of 480 pixels.
# 4. Save and name the resulting plot file as plot1.png


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

# 2. Load the data from the dates 2007-02-01 and 2007-02-02.

data <- read.csv("./data/household_power_consumption.txt", header = TRUE, 
                 sep = ';', na.strings = "?", stringsAsFactors = FALSE)

# Let's check the structure of the data frame
str(data)
'data.frame':        2075259 obs. of  9 variables:
# $ Date                 : chr  "16/12/2006" "16/12/2006" "16/12/2006" "16/12/2006" ...
# $ Time                 : chr  "17:24:00" "17:25:00" "17:26:00" "17:27:00" ...
# $ Global_active_power  : num  4.22 5.36 5.37 5.39 3.67 ...
# $ Global_reactive_power: num  0.418 0.436 0.498 0.502 0.528 0.522 0.52 0.52 0.51 0.51 ...
# $ Voltage              : num  235 234 233 234 236 ...
# $ Global_intensity     : num  18.4 23 23 23 15.8 15 15.8 15.8 15.8 15.8 ...
# $ Sub_metering_1       : num  0 0 0 0 0 0 0 0 0 0 ...
# $ Sub_metering_2       : num  1 1 2 1 1 2 1 1 1 2 ...
# $ Sub_metering_3       : num  17 16 17 17 17 17 17 17 17 16 ...

# The sampled values of Date are strings with the format "DD/MM/YYYY", 
# with a fixed length of 10. Let's check if this applies to the rest of
# observations.
table(nchar(data$Date))
# 8       9      10 
# 466560 1249920  358779 

# So the strings value for date are not equally sized and formatted. It 
# seems that sometimes they appear with only a number D or M for month.
# The dates 2007-02-01 and 2007-02-02 must be then denoted as "1/2/2007"
# and "2/2/2007". Let's check this and subset by them. 

table(data$Date[data$Date == "1/2/2007" | data$Date == "2/2/2007"])
# 1/2/2007 2/2/2007 
#     1440     1440 

# As expected, the dates of interest are formatred as as "1/2/2007"
# and "2/2/2007" in our data set, so we can subset by these values.
data <- subset(data, Date == "1/2/2007" | Date == "2/2/2007")

# Looking at the plots that we need to reconstruct, three of them
# will need to estimate the day of week of Date, so Date should be 
# a date instead of a string. As there are different time zones, Time 
# should also be included when computing the day of week. Let's combine
# Date and Time to add a date variable called "fulldate".

library(lubridate)
data$fulldate <- dmy_hms(paste(data$Date, data$Time))

# Let's remove the variables Date and Time from our data frame
# since they are no longer needed
data <- data[ , !(names(data) %in% c("Date", "Time"))]


# 3. Construct the plot and save it to a PNG file with a width of 480 pixels 
#    and a height of 480 pixels.

hist(data$Global_active_power, col = "red", main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)", ylab = "Frequency")


# 4. Save and name the resulting plot file as plot1.png

# We can do it just copying the plot to a PNG device and closing it
dev.copy(png, file = "plot1.png", height = 480, width = 480)
dev.off()
