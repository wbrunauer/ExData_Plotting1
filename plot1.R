##########################################################
## Plot 1: Histogram of Global Active Power (kilowatts) ##
##########################################################
## libraries
.libPaths("C:/tmp/R/libs")
library(data.table)
library(lubridate)
library(dplyr)

## Reading data
setwd("C:/R/work/course_4/data")
list.files(".")
power_tot <- data.frame(fread("household_power_consumption.txt"))
str(power_tot)

## Transforming dates and times
power <- power_tot %>% mutate(Datetime=paste(Date, Time), Date = dmy(Date)) %>% 
                                      mutate(Datetime=dmy_hms(Datetime), day = weekdays(as.Date(Date))) %>% 
                                              filter(Date >= ymd("2007-02-01") & Date <= ymd("2007-02-02"))

## Format as numeric
replace_names <- c("Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")
power[,c(replace_names)] <- sapply(power[,c(replace_names)], as.numeric)
summary(power)

## Plot 1 
png("plot1.png",width = 480, height = 480)
hist(power$Global_active_power, col="coral2", main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.off()
