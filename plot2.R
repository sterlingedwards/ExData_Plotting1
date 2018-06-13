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

##Plot 2
plot.new()
png("plot2.png")
plot(df3$Date, df3$Globalactivepower, type = "l", xlab = " ", ylab = "Global 
     Active Power (kilowatts)")
dev.off()