rm(list = ls())  # clears environment
cat("\014") # clears the console in RStudio

# Set working directory
setwd("C:/R/DA5020/Week_07")

# Set libraries
require(RCurl)
require(XML)
require(scrapeR)

# I will scrape the information from the table in the URL listed below.
# This table contains useful links related to bioinformatics with descriptions,
# Name of the website and the host information.
# It has 3 columns of data that I will collect and put into a data frame
# I make it 4 columns of data becuase I extract the link information from one
# of the columns and put it into it's own column.
# I will start by getting the url and convert the data line by line
theurl <-
  "http://www.kinexus.ca/kinetica/weblinks/bioinformatics/index.php"
webpage <- getURL(theurl)

# convert the page into a line-by-line format rather than a single string
tc <- textConnection(webpage) # outputs an R character vector
webpage <-
  readLines(tc) # read the web site as a collection of lines
close(tc) # close website

# Make the scraping parameterized, i.e., allow a data scientist to select search
# parameters -- choose a website that uses GET requests
pagetree <- htmlTreeParse(webpage, useInternalNodes = TRUE)

getData <- function(x) {
  # This function scrapes the data and returns the data as a data frame.
  # I extract the column names and then the columns.  I also extract the link
  # information from column titled Site and put it into a 4th column called
  # site links.  Then I put all of the data into a data frame.
  
  # This is where I scrape the information from x (pagetree)
  # I start with the column names
  # This will scrape the name "Site" by finding the matching node and return it's value
  dat1n <-
    unlist(xpathApply(x, "//*/table/tr/th[1]", xmlValue))
  # This will scrape the name "Host"
  dat2n <-
    unlist(xpathApply(x, "//*/table/tr/th[2]", xmlValue))
  # This will scrape the name "Features"
  dat3n <-
    unlist(xpathApply(x, "//*/table/tr/th[3]", xmlValue))
  
  # Then I extract the column information:
  # This will scrape the name information in the column titled 'Site' by finding the
  # matching nodes and returning it's value
  dat1 <-
    unlist(xpathApply(x, "//*/table/tr/td[1]", xmlValue))
  # This will scrape the information in the column titled 'Host'
  dat2 <-
    unlist(xpathApply(x, "//*/table/tr/td[2]", xmlValue))
  # This will scrape the information in the column titled 'Features'
  dat3 <-
    unlist(xpathApply(x, "//*/table/tr/td[3]", xmlValue))
  # This will scrape the link information in the column titled 'Site'
  dat4 <-
    unlist(xpathApply(x, "//*/table/tr/td[1]/a/@href"))
  
  # Now I will put the infomration into a data frame with the column names
  dat.df <-
    data.frame(dat1,
               dat2,
               dat3,
               dat4,
               stringsAsFactors = FALSE,
               row.names = NULL)
  colnames(dat.df) <- c(dat1n, dat2n, dat3n, "Site Link")
  # This returns the data frame
  return(dat.df)
}

# This calls the function with argument my.df
getData.df <- getData(pagetree)

# I check to make sure that there is the expected data and the first six rows here
# match the first six rows on the website
head(getData.df)

# I decided to make sure all of the data is present but it is difficult to calculate
# how many rows there are on the website.  So I manually counted 67 rows and the
# compared it to the cvs file I made below...it matches the website with 67 rows.
# cvs file
write.csv(getData.df, file = "dat_list.csv", row.names = FALSE)
