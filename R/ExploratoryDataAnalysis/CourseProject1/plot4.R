#setwd("R/ExploratoryDataAnalysis/CourseProject1")

# Read in the data
data <- read.csv("household_power_consumption.txt", header=TRUE, sep=";")

# Clean up the date and time formats
data$Date <- as.Date(strptime(data$Date, format = "%d/%m/%Y"))
times <- strptime(data$Time, format = "%H:%M:%S")
data$Time <- strftime(times, "%H:%M:%S")

# Subset the dataset into one containing only
# 2007-02-01, 2007-02-02
narrow <- subset(data, Date=="2007-02-01" | Date=="2007-02-02")

# Set up a canvas with 2 rows and 2 columns (for 4 plots)
par(mfrow = c(2,2))

with(narrow, {
        
        # Plot 1 of 4 is "plot2" ---------------------------------
        
        # Plot a histogram of Global Active Power
        plot(as.numeric(paste(Global_active_power)), 
             ylab="Global Active Power (kilowatts)",
             xlab="",
             xaxt="n",
             type="l")
        
        # Add X axis labels for days of the week
        axis(1, at = c(1,1500,2900), labels = c("Thu","Fri","Sat"))
        
        
        # Plot 2 of 4 is a new one -------------------------------
        
        plot(as.numeric(paste(Voltage)), 
             type = "l", ylab = "Voltage", 
             xaxt="n", yaxt="n",
             xlab = "datetime")
        
        # Add X axis labels for days of the week
        axis(1, at = c(1,1500,2900), labels = c("Thu","Fri","Sat"))
        
        # Add Y axis labels in increments of 4
        axis(2, at = seq(234,246,4))
        
        
        # Plot 3 of 4 is "plot3" ---------------------------------
        
        plot(as.numeric(paste(Sub_metering_1)),  
             ylab="Energy sub metering",
             xlab="",
             xaxt="n",
             type="l")
        
        # Add red and blue lines for Sub metering 2 and 3
        lines(as.numeric(paste(Sub_metering_2)), col="red")
        lines(as.numeric(paste(Sub_metering_3)), col="blue")
        
        # Add X axis labels for days of the week
        axis(1, at = c(1,1500,2900), labels = c("Thu","Fri","Sat"))
        
        legend("topright", lty=c(1,1), col = c("black","blue","red"), 
               legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))
        
        
        # Plot 4 of 4 is another new one --------------------------
        
        plot(as.numeric(paste(Global_reactive_power)), 
             type = "l", ylab = "Global_reactive_power", 
             xaxt="n", yaxt="n",
             xlab = "datetime")
        
        # Add X axis labels for days of the week
        axis(1, at = c(1,1500,2900), labels = c("Thu","Fri","Sat"))
        
        # Add Y axis labels in increments of 4
        axis(2, at = seq(0.0,0.5,0.1))
        
})







# Write the histogram to a PNG
png("plot3.png", width = 480, height = 480, units = "px", bg = "white")

# Set up a canvas with 2 rows and 2 columns (for 4 plots)
par(mfrow = c(2,2))

# Set our margins
par(mar= c(4, 4, 2, 1))

with(narrow, {
        
        # Plot 1 of 4 is "plot2" ---------------------------------
        
        # Plot a histogram of Global Active Power
        plot(as.numeric(paste(Global_active_power)), 
             ylab="Global Active Power (kilowatts)",
             xlab="",
             xaxt="n",
             type="l")
        
        # Add X axis labels for days of the week
        axis(1, at = c(1,1500,2900), labels = c("Thu","Fri","Sat"))
        
        
        # Plot 2 of 4 is a new one -------------------------------
        
        plot(as.numeric(paste(Voltage)), 
             type = "l", ylab = "Voltage", 
             xaxt="n", yaxt="n",
             xlab = "datetime")
        
        # Add X axis labels for days of the week
        axis(1, at = c(1,1500,2900), labels = c("Thu","Fri","Sat"))
        
        # Add Y axis labels in increments of 4
        axis(2, at = seq(234,246,4))
        
        
        # Plot 3 of 4 is "plot3" ---------------------------------
        
        plot(as.numeric(paste(Sub_metering_1)),  
             ylab="Energy sub metering",
             xlab="",
             xaxt="n",
             type="l")
        
        # Add red and blue lines for Sub metering 2 and 3
        lines(as.numeric(paste(Sub_metering_2)), col="red")
        lines(as.numeric(paste(Sub_metering_3)), col="blue")
        
        # Add X axis labels for days of the week
        axis(1, at = c(1,1500,2900), labels = c("Thu","Fri","Sat"))
        
        legend("topright", lty=c(1,1), col = c("black","blue","red"), 
               legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))
        
        
        # Plot 4 of 4 is another new one --------------------------
        
        plot(as.numeric(paste(Global_reactive_power)), 
             type = "l", ylab = "Global_reactive_power", 
             xaxt="n", yaxt="n",
             xlab = "datetime")
        
        # Add X axis labels for days of the week
        axis(1, at = c(1,1500,2900), labels = c("Thu","Fri","Sat"))
        
        # Add Y axis labels in increments of 4
        axis(2, at = seq(0.0,0.5,0.1))
        
})
dev.off()
