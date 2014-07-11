# Plot3.R


# Getting and transforming data
# -----------------------------

# Read file
# (note the data file must be in the directory from which the one containing 
#  the script hangs)
data <- read.csv2("./../household_power_consumption.txt",
                  na.strings="?",
                  header=TRUE,
                  stringsAsFactors=FALSE)

# We are interested only in data from Feb 1, 2007 and Feb 2, 2007
k <- data$Date %in% c("1/2/2007","2/2/2007")
data <- data[k,]

# We add a new column called Datetime that is data$Date and data$Time put toguether
# data$Datetime will be the last column
data <- within(data, Datetime <- as.POSIXlt(paste(Date,Time),format="%d/%m/%Y %H:%M:%S"))

# We drop some columns
rownames(data) <- NULL
data$Date <- NULL
data$Time <- NULL

# Data type conversion and Datatime relocation (now the first column)
data <- cbind(data$Datetime, as.data.frame(mapply(function(x) as.numeric(x), data[,1:7])))
colnames(data)[1] <- "Datetime"


# Plot 3 - The three submeterings
# -------------------------------

# The plot has three lines: black submetering 1, blue submetering 2, red submetering 3
# (Note: The week day language depends on the local configuration)
plot(data$Datetime, data$Sub_metering_1, col="black", type="l",
     xlab="", ylab="Energy sub metering")
lines(data$Datetime, data$Sub_metering_2, col="red", type="l") # line adds lines
lines(data$Datetime, data$Sub_metering_3, col="blue", type="l")
legend("topright", lty=c(1,1,1), col=c("black","red","blue"), 
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))


# This stores the plot in a file called plot3.png
# (alternatively the precedent plot could be copied to a device, but it is not
#  an exact operation)
# The size is the default one, but included for the shake of clarity
# The folder ./figure/ must exist
png(file = "./figure/plot3.png", width = 480, height = 480, units = "px") # opens the png devive
plot(data$Datetime, data$Sub_metering_1, col="black", type="l",
     xlab="", ylab="Energy sub metering")
lines(data$Datetime, data$Sub_metering_2, col="red", type="l") # line adds lines
lines(data$Datetime, data$Sub_metering_3, col="blue", type="l")
legend("topright", lty=c(1,1,1), col=c("black","red","blue"), 
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.off() # closes the png device
