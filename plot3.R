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

## Plot 3
## change locale
sessionInfo()
Sys.setlocale("LC_TIME", "English")

png("plot3.png",width = 480, height = 480)
plot(power$Sub_metering_1~power$Datetime, type="l", xlab = "", ylab="Energy sub metering")
lines(power$Sub_metering_2~power$Datetime, col = "coral2")
lines(power$Sub_metering_3~power$Datetime, col = "cornflowerblue")
legend("topright", lty = 1, col = c("black", "coral2", "cornflowerblue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex=1)
dev.off()
