rm(list = ls())  # clears environment
cat("\014") # clears the console in RStudio

### Comments ###

# First I cleared the environment and RStudio console as noted above. This makes sure
# my environment is clear and I have a clear console to work with. Then I set the
# working directory, I set the required libraries, XML.  Then I opened the
# file and I made sure it did not exist before opening it.  Then I analyzed the data.

### Code ###

# Set working directory
setwd("C:/R/DA5020/Week_04")

# Set required libraries:
# XML is required for analyzing XML data and RCurl is required to open https
require(XML)

# Task 1:
# If the data exists, no need to reopen.
url1 <-
  "http://www.cs.washington.edu/research/xmldatasets/data/auctions/ebay.xml"
if (!exists("xml.eBay")) {
  xml.eBay <- xmlTreeParse(url1)
}

# write a function named moreFiveBids
moreFiveBids <- function(x) {
  # This function finds how many auctions had more than 5 bids.  I put the top-level
  # XML node in variable r.  Then I collect all bid information for all r quantities
  # in a for loop and collect the xmlValue.  Then I change the data into numeric and
  # use length to find the number of bids greater than 5.
  
  # Put data into top-level XML node
  r <- xmlRoot(x)
  
  # Declare variable
  bid <- NULL
  
  # This is a for loop to get the number of bids. The bid info is in r[[i]][[5]][[5]]
  for (i in 1:length(r)) {
    bid[i] <- xmlValue(r[[i]][[5]][[5]])
  }
  
  # Need to change from character to numeric for analysis
  bid.num <- as.numeric(bid)
  
  # This takes the total bid amount greater than 5 and returns the answer in print.
  bid.number <- 5
  auction.count <- length(which(bid.num > bid.number))
  print (paste(
    "There are",
    auction.count,
    "auctions that had more than",
    bid.number,
    "bids."
  ))
}

# This calls the function with argument xml.eBay
moreFiveBids(xml.eBay)

# Task 2:
# If the data exists, no need to reopen.
url2 <-
  "http://www.barchartmarketdata.com/data-samples/getHistory15.xml"
if (!exists("xml.trades")) {
  xml.trades <- xmlTreeParse(url2)
}

if (!exists("df.trades")) {
  df.trades <- xmlToDataFrame(url2)
}

# write and use the following functions highestClosingPrice, totalVolume,
# averageVolume.

highestClosingPrice <- function(x) {
  # This function findsthe highest closing pricefor the security.  I put the
  # top-level XML node in variable r.  Then I collect all price information for all
  # r quantities in a for loop and collect the xmlValue.  Then I change the data
  # into numeric remove NA and then take the max.
  
  # Put data into top-level XML node
  r <- xmlRoot(x)
  
  # Declare variable
  price <- NULL
  
  # This is a for loop to get the number of bids. The bid info is in r[[i]][[5]]
  # I started the loop at 2 because r[[1]] does not have any usefull data.
  for (i in 2:length(r)) {
    price[i] <- xmlValue(r[[i]][[5]])
  }
  
  # Need to change from character to numeric for analysis
  price.num <- as.numeric(price)
  
  # Since I started at 2, there is a NA in the data that I need to remove
  price.complete <- na.omit(price.num)
  
  # security symbol
  sec.sym <- xmlValue(r[[2]][[1]])
  
  print (paste(
    "The highest closing price for the security",
    sec.sym,
    "was",
    max(price.complete)
  ))
}

# This calls the function with argument xml.trades
highestClosingPrice(xml.trades)


totalVolume <- function(x) {
  # This function findsthe highest closing pricefor the security.  I put the
  # top-level XML node in variable r.  Then I collect all volume information for all
  # r quantities in a for loop and collect the xmlValue.  Then I change the data
  # into numeric remove NA and then take the sum.
  
  # Put data into top-level XML node
  r <- xmlRoot(x)
  
  # Declare variable
  volume <- NULL
  
  # This is a for loop to get the number of bids. The bid info is in r[[i]][[8]]
  # I started the loop at 2 because r[[1]] does not have any usefull data.
  for (i in 2:length(r)) {
    volume[i] <- xmlValue(r[[i]][[8]])
  }
  
  # Need to change from character to numeric for analysis
  volume.num <- as.numeric(volume)
  
  # Since I started at 2, there is a NA in the data that I need to remove
  volume.complete <- na.omit(volume.num)
  
  # security symbol
  sec.sym <- xmlValue(r[[2]][[1]])
  
  print (paste(
    "The total volume traded for the security",
    sec.sym,
    "was",
    sum(volume.complete)
  ))
}

# This calls the function with argument xml.trades
totalVolume(xml.trades)


averageVolume <- function(df) {
  # This function finds the average trading volume during each HOUR of the trading
  # day.  I used a data frame as the input and edited the timestamp so I could
  # analyze it with POSIXct and aggregate to get the hourly average.
  
  # This removes the T in the timestamp
  df$timestamp <- gsub(pattern = "T",
                       replacement = " ",
                       df$timestamp)
  
  # This removes the -05:00" at the end of the timestamp
  df$timestamp <- gsub(pattern = "-05:00",
                       replacement = "",
                       df$timestamp)
  
  # This puts the info into a data frame. I use as.numeric for volume to make it
  # numeric data to analyze with aggregate.
  df.volume <- data.frame(df$timestamp, as.numeric(df$volume))
  names(df.volume) <- c("timestamp", "volume")
  
  # This removes the NA's
  df.volume <- na.omit(df.volume)
  
  # This gets the hourly average using aggregate and POSIXct
  mean.data <-
    aggregate(df.volume$volume, list(hour = cut(
      as.POSIXct(df.volume$timestamp), "hour"
    )), mean)
  
  # I remove the date from the hour column because the instructions ask for a data
  # frame containing hour.
  mean.data$hour <- gsub(pattern = "2013-10-29 ",
                         replacement = "",
                         mean.data$hour)
  
  # This returns the dataframe
  return(mean.data)
}

# This calls the function with argument df.trades
averageVolume(df.trades)
