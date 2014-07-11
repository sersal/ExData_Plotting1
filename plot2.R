# Plot2.R


# Getting and transforming data
# -----------------------------

# Read file
data <- read.csv2("household_power_consumption.txt",
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


# Plot 2 - Global active power per day as a time series
# -----------------------------------------------------

# The plot is a thin black line; x-axis: day of the week; y-asix: active power
# (Note: The annotation language depends on the local configuration)
plot(data$Datetime, data$Global_active_power,
     type = "l",      
     xlab = "",
     ylab = "Global Active Power (kilowatts)")

# This stores the plot in a file called plot2.png
# (alternatively the precedent plot could be copied to a device, but it is not
#  an exact operation)
<<<<<<< HEAD
# The size is the default one, but included for the shake of clarity
=======
>>>>>>> 88389f6a567a2eba5c44b65e8c963285def9b213
png(file = "plot2.png") # opens the png devive
plot(data$Datetime,data$Global_active_power,
     type = "l", 
     xlab = "",
<<<<<<< HEAD
     ylab = "Global Active Power (kilowatts)",
     width = 480,
     height = 480,
     units = "px")
dev.off() # closes the png device





=======
     ylab = "Global Active Power (kilowatts)")
dev.off() # closes the png device
>>>>>>> 88389f6a567a2eba5c44b65e8c963285def9b213
