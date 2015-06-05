plot2 <- function() {
  
  # this function requires the sqldf package to be installed
  require(sqldf) 
  
  # if file doesn't exist, download and unzip file into working directory
  if(!file.exists("household_power_consumption.txt")) {
    download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "household_power_consumption.zip") 
    unzip("household_power_consumption.zip")
  }
  
  # define hpc as a semicolon-delimited file
  hpc <- file("household_power_consumption.txt") 
  attr(hpc, "file.format") <- list(sep = ";", header = TRUE)
  
  # use sqldf to read it in, keeping only the columns needed and rows where the date is either 2/1/2007 or 2/2/2007
  hpc.df <- sqldf("select Date, Time, Global_active_power from hpc where Date in ('1/2/2007', '2/2/2007')")
  
  # create datetime field from Date and Time fields  
  hpc.df$datetime <- as.POSIXct(paste(hpc.df$Date, hpc.df$Time), format="%d/%m/%Y %H:%M:%S")
  
  # create plot, saving to plot2.png file in working directory
  png(filename = "plot2.png", width = 480, height = 480)
  with(hpc.df, plot(datetime, Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = ""))
  dev.off()
  
}