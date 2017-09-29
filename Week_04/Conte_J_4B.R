rm(list = ls())  # clears environment
cat("\014") # clears the console in RStudio

### Comments ###

# First I cleared the environment and RStudio console as noted above. This makes sure
# my environment is clear and I have a clear console to work with. Then I set the
# working directory, I set the required libraries, XML and RCurl.  RCurl is required
# to open https sites since XML does not support https.  Then I opened the
# file and I made sure it did not exist before opening it.  Then I analyzed the data.
# I made sure to use local variables for the functions...I am usually lazy and use 
# global vairables :)

### Code ###

# Set working directory
setwd("C:/R/DA5020/Week_04")

# Set required libraries:
# XML is required for analyzing XML data and RCurl is required to open https
require(XML)
require(RCurl)

# Task 1:
# Set URL, then use RCurl to get the URL because XML does not support https.
# Then put it into a dataframe.  If the data exists, no need to reopen.
url <-
  "https://www.senate.gov/general/contact_information/senators_cfm.xml"
xurl <- getURL(url)
if (!exists("my.df")) {
  my.df <- xmlToDataFrame(xurl)
}

# Task 2: Write a function senatorName() that returns the names of the senators for a
# given state.
senatorName <- function(x, df) {
  # This function finds and returns the names of the senators for a given state. This
  # uses a subset named, data, to filter by state.  It uses "data$column" formate
  # to extract the first and last names of the senators then returns the answer
  # with a print function.
  
  # This is the subset
  data <- subset(df, state == x)
  
  # This section adds the total number of delays and returns a value.
  print(
    paste(
      "The senators for the state of",
      x,
      "are",
      data$first_name[1],
      data$last_name[1],
      "and",
      data$first_name[2],
      data$last_name[2]
    )
  )
}

# Enter a state in quotes followed by a comma and the data frame to find the senator 
# names, i.e. ("MA", my.df)
senatorName("MA", my.df)

# Task 3: Write a function senatorPhone() that returns the phone number for a given
# senator. The function should take the first and last name of the senator.
senatorPhone <- function(x, y, df) {
  # This function returns the phone number of the senator requested.
  # This code uses 2 subsets to filter by first_name and last_name.
  # Then returns the phone number.

  # Theses are the subsets.  There will only be one value in data.ln.
  data.fn <- subset(df, first_name == y)
  data.ln <- subset(data.fn, last_name == x)
  
  # This section returns the phone number.
  print(paste("The phone number for senetor",
              y,
              x,
              "is",
              data.ln$phone))
}

# Enter the last name of the senator in quotes followed by a comma and the first name
# in quotes followed by a comma and the data frame to find the phone number, i.e. 
# ("Warren", "Elizabeth", my.df).
senatorPhone("Warren", "Elizabeth", my.df)
