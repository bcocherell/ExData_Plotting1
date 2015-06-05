plot1 <- function() {
  
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
  hpc.df <- sqldf("select Global_active_power from hpc where Date in ('1/2/2007', '2/2/2007')")
  
  # create histogram plot, saving to plot1.png file in working directory
  png(filename = "plot1.png", width = 480, height = 480)
  hist(hpc.df$Global_active_power, main = "Global Active Power", col = "red", xlab = "Global Active Power (kilowatts)")
  dev.off()
  
}