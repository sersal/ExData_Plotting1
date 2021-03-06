# Plot1.R


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
# d <- as.POSIXlt(data$Date,format="%d/%m/%Y")
# k <- d==as.POSIXlt("2007-02-01",format="%Y-%m-%d") | 
#      d==as.POSIXlt("2007-02-02",format="%Y-%m-%d")
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


# Plot 1 - Global active power
# ----------------------------

# The plot is a red histogram with a title and a label in the X axis
# This shows it in the screen
hist(data$Global_active_power, col="red", 
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)")

# This stores the plot in a file called plot1.png
# The size is the default one, but included for the shake of clarity
png(file = "./figure/plot1.png", width=480, height=480, units="px") # opens the png devive
hist(data$Global_active_power, col="red", 
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)")
dev.off() # closes the png device
