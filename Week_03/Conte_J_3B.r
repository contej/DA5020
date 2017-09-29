rm(list = ls())  # clears environment
cat("\014") # clears the console in RStudio

### Comments ###

# First I cleared the environment and RStudio console as noted above. This makes sure
# my environment is clear and I have a clear console to work with. Then I set the
# working directory, then I opened the file and I made sure it did not exist before
# opening it, if it exists, then it does not reopen.  I Opened the file as a CSV file
# which the mode is 'list' and class is 'data.frame'.  I added NA to all blank
# cells in the file when opening it and set stringsAsFactors = FALSE to make the 
# varibles charachters instead of factors (it makes it esier to analyze). I used 
# summary(data) to get an idea of what is in the data.
# The answer to task 5 is in the Comment field of the submission.  Regarding Task 6,
# I made a function of tasks 1 - 4, taskOneToFour, with system.time() and I submitted
# the written answeres in the Comment field of the submission.

### Code ###

# Set working directory
setwd("C:/R/DA5020/Week_03")

# Set required libraries/data
require(lubridate) # for task 2
require(stringr) # for task 6

# Task 1: Open the file and it is open, do not reopen.
# I also added NA to all blank cells to make it esaier to analyze and
# stringsAsFactors = FALSE so I can remove levels from the data.
if (!exists("bird.strikes")) {
  bird.strikes <-
    read.csv(
      unz("Bird Strikes.zip", "Bird Strikes.csv"),
      header = TRUE,
      na.strings = c("", "NA"),
      stringsAsFactors = FALSE,
      sep = ","
    )
}

# Now that all the blanks have NA, I can easily find where there is no value for
# "Reported..Date" by using is.na.
no.date.reported <- sum(is.na(bird.strikes$Reported..Date))
print(paste(
  "There are",
  no.date.reported,
  "bird strikes that do not have a reported date."
))


# Task 2: Which year had the most bird strikes? Write a function to calculate.
mostStrikesYear <- function(x) {
  # Each Flight Date is a bird strike, so this function extracts the year from all of
  # the flight dates using lubridate and puts it into the argument "date.year".  Then
  # date.year is put into a data frame and table to get the year and bird strikes.
  # Then I find the year with the most bird strikes and return the value via print.
  
  # This uses lubridate to extract years from the Flight Date
  date.year <- year(as.Date(x$FlightDate, format = "%m/%d/%Y"))
  
  # This puts the data back into a data frame with the year and number of occurences
  # for the year.  I added stringsAsFactors = FALSE to remove levels from the answer.
  df <- as.data.frame(table(date.year))
  
  # This gets the year with the most occurences.
  year.most <- df$date.year[which(df$Freq == max(df$Freq))]
  
  # This returns the answer
  print(paste(year.most, "was the year with the most bird strikes"))
  
}

# This calls the function with argument bird.strikes
mostStrikesYear(bird.strikes)


# Task 3, How many bird strikes were there for each year? Place the result into a
# data frame. This is the same as the function I used to get the year in Task 2.

# This uses lubridate to extract years from the Flight Date.
date.year <-
  year(as.Date(bird.strikes$FlightDate, format = "%m/%d/%Y"))

# This puts the data back into a data frame with the year and number of occurences
# for the year.  I added stringsAsFactors = FALSE to remove levels from the answer.
# I also gave the columns proper names using the function names().
df <- as.data.frame(table(date.year))
names(df) <- c("Year", "Bird Strikes")

# Show data frame
df


# Task 4, Write a function that calculates the number of birds strikes per airline 
# and then put those results into a dataframe called AirlineStrikes. Write another 
# function that AirlineStrikes as an argument, and returns the airline that has the 
# most birdstrikes.

strikesOnAirline <- function(x) {
  # This function calculates the number of birds strikes per airline and then
  # puts those results into a dataframe.  The function begins by removing all
  # NA and UNKnOWN data.  Then puts the intformation into a data frame and
  # gives proper names to the columns (Airline and Bird Strikes) then sorts
  # the data from most bird strikes to least then returns the data.
  
  
  # This removes all UNKNOWN and NA data from the column Aircraft..Airline.Operator
  data.airline <-
    x$Aircraft..Airline.Operator[!(
      is.na(x$Aircraft..Airline.Operator) |
        x$Aircraft..Airline.Operator == "UNKNOWN"
    )]
  
  # This puts the data into a data frame and gives the columns proper names
  df.airline <-
    as.data.frame(table(data.airline))
  names(df.airline) <- c("Airline", "Bird Strikes")
  
  # This sorts the data from most bird strikes to least.  I think it makes the data
  # more presentable.
  sort.df.airline <-
    df.airline[order(df.airline$`Bird Strikes`, decreasing = TRUE),]
  
  # This returns the answer
  return(sort.df.airline)
}

# This calls the function with argument bird.strikes
AirlineStrikes <- strikesOnAirline(bird.strikes)

#This prints the data frame
AirlineStrikes


mostStrikesOnAirline <- function(x) {
  # This function accepts the dataframe AirlineStrikes as an argument, and returns
  # the airline that has the most bird strikes.
  
  # This gets the year with the most occurences.
  airline.most <-
    x$Airline[which(x$`Bird Strikes` == max(x$`Bird Strikes`))]
  
  # This returns the answer
  print(paste("The airline", airline.most, "has the most bird strikes"))
}

# This calls the function with argument (AirlineStrikes
mostStrikesOnAirline(AirlineStrikes)


# Task 6, Create a function for problem 1 to 4.
# I doubled the data in the bird strikes.csv data and saved it as a bird strikes2.csv
# and zipped it, then doubled that and made bird strikes4.csv/zip.
taskOneToFour <- function(x) {
  # This function combines the first 4 tasks.
  
  # This uses stringr to get the file names
  zip.file <- str_c(x, ".zip")
  csv.file <- str_c(x, ".csv")
  # Task 1
  bird.strikes.f <-
    read.csv(
      unz(zip.file, csv.file),
      header = TRUE,
      na.strings = c("", "NA"),
      stringsAsFactors = FALSE,
      sep = ","
    )
  
  no.date.reported <- sum(is.na(bird.strikes.f$Reported..Date))
  print(paste(
    "There are",
    no.date.reported,
    "bird strikes that do not have a reported date."
  ))
  
  #Task 2
  # This uses lubridate to extract years from the Flight Date
  date.year <- year(as.Date(bird.strikes.f$FlightDate, format = "%m/%d/%Y"))
  
  # This puts the data back into a data frame with the year and number of occurences
  # for the year.  I added stringsAsFactors = FALSE to remove levels from the answer.
  df <- as.data.frame(table(date.year))
  
  # This gets the year with the most occurences.
  year.most <- df$date.year[which(df$Freq == max(df$Freq))]
  
  # This returns the answer
  print(paste(year.most, "was the year with the most bird strikes"))
  
  # Task 3
  names(df) <- c("Year", "Bird Strikes")
  print(df)
  
  #Task 4
  # This removes all UNKNOWN and NA data from the column Aircraft..Airline.Operator
  data.airline <-
    bird.strikes.f$Aircraft..Airline.Operator[!(
      is.na(bird.strikes.f$Aircraft..Airline.Operator) |
        bird.strikes.f$Aircraft..Airline.Operator == "UNKNOWN"
    )]
  
  # This puts the data into a data frame and gives the columns proper names
  df.airline <-
    as.data.frame(table(data.airline))
  names(df.airline) <- c("Airline", "Bird Strikes")
  
  # This sorts the data from most bird strikes to least.  I think it makes the data
  # more presentable.
  sort.df.airline <-
    df.airline[order(df.airline$`Bird Strikes`, decreasing = TRUE),]
  
  # This returns the answer
  print(sort.df.airline)
  
  airline.most <-
    sort.df.airline$Airline[which(sort.df.airline$`Bird Strikes` == max(sort.df.airline$`Bird Strikes`))]
  
  # This returns the answer
  print(paste("The airline", airline.most, "has the most bird strikes"))
  
}

# This calculates and presents the amount of time it takes to execute this function
system.time(taskOneToFour("Bird Strikes"))



