rm(list = ls())  # clears environment
cat("\014") # clears the console in RStudio

### Description ###

# First I cleared the environment and RStudio console as noted above. This makes sure
# my environment is clear and I have a clear console to work with. Then I set the
# working directory, then I opened the file and I made sure it did not exist before
# opening it, if it exists, then it does not reopen.  Since there is only one file in
# the zip, I uncompressed it with "unz" as shown below in the code.  I opened the file
# as read.table, which is essentially a data frame and it makes it easier to analyze.
# Looking at the data I noticed there are many na's when I analyzed it with
# "summary()", too many to use the na.omit command.  So instead of using the na.omit,
# I used "data" > 0 in most places to filter out the na's and negative numbers.  I
# also reformatted my code by 'Reformat Code' option under the Code menu in RStudio.

### Code ###

# Set working directory
setwd("C:/R/DA5020/Week_02")


# Task 1 & 2: Open the file and it is open, do not reopen.
if (!exists("my.dat")) {
  my.dat <-
    read.table(
      unz("AirlineDelays.zip", "AirlineDelays.txt"),
      header = TRUE,
      sep = ","
    )
}


# Task 3: Write a function called TotalNumDelays.
TotalNumDelays = function(x) {
  # This function finds and returns the total number of delays of a carrier. This
  # uses a subset named, data, to filter by carrier.  It uses "data$column" formate
  # to extract data from each of the "delay" columns and collects the amount of times
  # not the total amount of minutes. It uses length to find how many delays for each
  # "delay" column.  It uses "data$column > 0" to remove the negative and NA values.
  # The calculation takes the sum of each delay to get the total number of delays
  # then returns the answer with a print function.
  
  # This is the subset
  data <- subset(my.dat, CARRIER == x)
  
  # This section calculates the number of delays for each column and removes
  # negative and NA values.
  dep.delay <- length(which(data$DEP_DEL > 0))
  arr.delay <- length(which(data$ARR_DELAY > 0))
  carrier.delay <- length(which(data$CARRIER_DELAY > 0))
  weather.delay <- length(which(data$WEATHER_DELAY > 0))
  nas.delay <- length(which(data$NAS_DELAY > 0))
  security.delay <- length(which(data$SECURITY_DELAY > 0))
  late.aircraft.delay <-
    length(which(data$LATE_AIRCRAFT_DELAY > 0))
  
  # This section adds the total number of delays and returns a value.
  total.delays <-
    dep.delay + arr.delay + carrier.delay + weather.delay + nas.delay + security.delay + late.aircraft.delay
  print(paste("The total number of delays of the carrier", x, "is", total.delays))
}

# Enter a carrier in quotes to find the total number of delays, i.e. "AA".
TotalNumDelays("AA")


# Task 4: Write a function called TotalDelaysByOrigin.
TotalDelaysByOrigin = function(x) {
  # This function finds and returns the total number of delays for an airport.
  # It is the same code as TotalNumDelays but CARRIER is changed to ORIGIN
  # in the subset data.  I also modified the print statement.
  
  # This is the subset
  data <- subset(my.dat, ORIGIN == x)
  
  # This section calculates the number of delays for each column and removes
  # negative and NA values.
  dep.delay <- length(which(data$DEP_DEL > 0))
  arr.delay <- length(which(data$ARR_DELAY > 0))
  carrier.delay <- length(which(data$CARRIER_DELAY > 0))
  weather.delay <- length(which(data$WEATHER_DELAY > 0))
  nas.delay <- length(which(data$NAS_DELAY > 0))
  security.delay <- length(which(data$SECURITY_DELAY > 0))
  late.aircraft.delay <-
    length(which(data$LATE_AIRCRAFT_DELAY > 0))
  
  # This section adds the total number of delays and returns a value.
  total.delays <-
    dep.delay + arr.delay + carrier.delay + weather.delay + nas.delay + security.delay + late.aircraft.delay
  print (paste(
    "The total number of delays for the airport",
    x,
    "is",
    total.delays
  ))
}

# Enter an airport origin in quotes to find the total number of delays, i.e. "BOS".
TotalDelaysByOrigin("BOS")


# Task 5: Write a function called AvgDelay.
AvgDelay = function(x, y) {
  # This function calculates and returns the average arrival
  # delay for a carrier flying into the specified destination airport.
  # This code uses 2 subsets to filter by carrier and destination.
  # It filters out all na and negative data then calculates the mean
  # from the arrival delay column then prints the mean.
  
  # Theses are the subsets
  data.carrier <- subset(my.dat, CARRIER == x)
  data.dest <- subset(data.carrier, DEST == y)
  
  # This section calculates the average and returns a value.
  # I start by removing the na and negative values then I take the mean.
  # I rounded the answer to 2 decimal places to make it more presentable.
  arr.delay <- data.dest[(which(data.dest$ARR_DELAY > 0)),]
  arr.delay.mean <- mean(arr.delay$ARR_DELAY)
  print(
    paste(
      "The average arrival delay for the carrier",
      x,
      "flying into the airport",
      y,
      "is",
      round(arr.delay.mean, digits = 2),
      "minutes."
    )
  )
}

# Enter a carrier in quotes followed by a comma and the destination airport
# in quotes to find the average arrival delay, i.e. "AA", "BOS".
AvgDelay("AA", "BOS")
