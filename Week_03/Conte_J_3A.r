rm(list = ls())  # clears environment
cat("\014") # clears the console in RStudio

### Comments ###

# First I cleared the environment and RStudio console as noted above. This makes sure
# my environment is clear and I have a clear console to work with. Then I set the
# working directory, then I opened the file and I made sure it did not exist before
# opening it, if it exists, then it does not reopen.  I Opened the file as a CSV file
# which the mode is 'list' and class is 'data.frame'.  Then I wrote the function
# leastInvInterval and executed it. I also reformatted my code by 'Reformat Code'
# option under the Code menu in RStudio.

### Code ###

# Set working directory
setwd("C:/R/DA5020/Week_03")

# Task 1:
# This imports a csv file that contains both numeric and character variable.
# By default, the data is loaded as a list and data.frame.  This can be confirmed by
# running mode(acqu.data) and class(acqu.data).  This is good for my analysis, so no
# changes are required. The file will not "reopen" if it is already opened. 
if (!exists("acqu.data")) {
  acqu.data <- read.csv(
    "Acquisitions.csv",
    header = TRUE,
    sep = ","
  )
}


# I ran this to show the mode and class.
mode(acqu.data) # returns list
class(acqu.data) # returns data.frame

# Task 2:
# Write a function called leastInvInterval():
leastInvInterval <- function(x) {
  # This function finds the smallest interval between successive investments.
  # I define my varibles then use a for loop to find the dates and then I sort them.
  # Once the dates are sorted I find the difference between the dates and extract
  # the smallest interval. Then I return the answer in a print statement.
  
  # I define the variable date with an arbritrary date
  date <- as.Date("1970-01-01")

  # This is a for loop to get the dates
  for (i in 1:length(x$Date)) {
    date[i] <- as.Date(x$Date[i], format = "%m/%d/%Y")
  }
  
  # I sort the dates to make sure they are oldest to newest.
  new.date <- date[order(as.Date(date, format = "%m/%d/%Y"))]
  
  # This finds the intervals between the dates and gets the smallest
  small.int <- min(diff(new.date))
  
  # This returns the answer
  print(paste(
    "The smallest interval between successive investments is",
    small.int,
    "days."
  ))
}

# This calls the function with argument acqu.data
leastInvInterval(acqu.data)
