##Make sure the file "household_power_consumption.txt" is in your working directory
library(dplyr)

colnames = c("Date", "Time", "Globalactivepower", "Globalreactivepower", 
             "Voltage", "Globalintensity", "Submetering1", "Submetering2", 
             "Submetering3")
df <- read.table("household_power_consumption.txt", 
                 sep = ";", col.names = colnames, na.strings = "?", skip = 1, 
                 stringsAsFactors = FALSE)
df1 <- filter(df, Date == "1/2/2007" | Date == "2/2/2007")
df2 <- mutate(df1, Date = as.POSIXct(paste(Date, Time, sep = " "), 
                                     format = "%d/%m/%Y %H:%M:%S"))
df3 <- select(df2, -Time)

##Plot 4
plot.new()
png("plot4.png")
par(mfcol = c(2,2))
##Top left
plot(df3$Date, df3$Globalactivepower, type = "l", xlab = " ", ylab = "Global 
     Active Power (kilowatts)")
##Bottom left
plot(df3$Date, df3$Submetering1, type = "n", xlab = " ", 
     ylab = "Energy sub metering")
        points(df3$Date, df3$Submetering1, col = "black", type = "l")
        points(df3$Date, df3$Submetering2, col = "red", type = "l")
        points(df3$Date, df3$Submetering3, col = "blue", type = "l")
        legend("topright", col = c("black", "red", "blue"), 
         legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
         lwd = 1)
##Top right
plot(df3$Date, df3$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")
##Bottom right
plot(df3$Date, df3$Globalreactivepower, type = "l", xlab = "datetime", 
     ylab = "Global_reactive_power")
dev.off()