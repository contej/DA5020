rm(list = ls())  # clears environment
cat("\014") # clears the console in RStudio

### Comments ###

# First I cleared the environment and RStudio console as noted above. This makes sure
# my environment is clear and I have a clear console to work with. Then I set the
# working directory, then I opened the file and I made sure it did not exist before
# opening it, if it exists, then it does not reopen.  I had a tough time getting xlsx
# to load.  First I had to set JAVA_HOME to the jre file and to get an Excel file to
# load I needed to set ptions(java.parameters = "-Xmx8000m") to use more memory to
# open large data files.

### Code ###

# Set working directory
setwd("C:/R/DA5020/Week_04")

# Set required parameters for xlsx
# The first sets JAVA_HOME and the second expands the memory so I can open large files
Sys.setenv(JAVA_HOME = 'C:\\Program Files\\Java\\jdk1.8.0_91\\jre')
options(java.parameters = "-Xmx8000m")

# Set required libraries
require(xlsx)

# Task 1:
# Open file, if it exists, do not open. This opens the file starting with the header
# on row 3 and I setstringsAsFactors=FALSE  to avoid having R automatically convert
# string values to factor
if (!exists("my.df")) {
  my.df <-
    read.xlsx2(
      "2013 Geographric Coordinate Spreadsheet for U S  Farmers Markets 8'3'1013.xlsx",
      sheetIndex = 1,
      startRow = 3,
      stringsAsFactors = FALSE,
      header = TRUE
    )
}

# Task 2:
# To standardize the Season1Date, I used regex to find and change values.  I am not
# sure if this is the best way, but it's the only way I know how with non-standard
# and chaotic data.  I have the the code split up into the seven catagories below,
# Summer, Fall, Winter, Spring, Year-Round, Half-Year, and Ignore:

# Year-Round
my.df$Season1Date <- gsub(pattern = "^(01)(.*)to (10|11|12)(.*)",
                         replacement = "Year-Round",
                         my.df$Season1Date)
my.df$Season1Date <- gsub(pattern = "^(03)(.*)to (12)(.*)",
                         replacement = "Year-Round",
                         my.df$Season1Date)
my.df$Season1Date <- gsub(pattern = "^(04)(.*)(.13) to (03)(.*)(.14)",
                         replacement = "Year-Round",
                         my.df$Season1Date)
my.df$Season1Date <- gsub(pattern = "^(05)(.*)(.13) to (05)(.*)(.14)",
                         replacement = "Year-Round",
                         my.df$Season1Date)
my.df$Season1Date <- gsub(pattern = "^(09)(.*)(.13) to (06)(.*)(.14)",
                         replacement = "Year-Round",
                         my.df$Season1Date)
my.df$Season1Date <- gsub(pattern = "^(Jan.)(.*)to (Dec.)(.*)",
                         replacement = "Year-Round",
                         my.df$Season1Date)
my.df$Season1Date <- gsub(pattern = "^(Feb.)(.*)to (Nov.)(.*)",
                         replacement = "Year-Round",
                         my.df$Season1Date)
my.df$Season1Date <- gsub(pattern = "^December to December",
                         replacement = "Year-Round",
                         my.df$Season1Date)
my.df$Season1Date <- gsub(pattern = "^June to June",
                         replacement = "Year-Round",
                         my.df$Season1Date)
my.df$Season1Date <- gsub(pattern = "^May to May",
                         replacement = "Year-Round",
                         my.df$Season1Date)
my.df$Season1Date <- gsub(pattern = "^April to April",
                         replacement = "Year-Round",
                         my.df$Season1Date)
my.df$Season1Date <- gsub(pattern = "^September to September",
                         replacement = "Year-Round",
                         my.df$Season1Date)

# for Half-Year
my.df$Season1Date <- gsub(pattern = "^(06|05|04)(.*)to (11|12)(.*)",
                         replacement = "Half-Year",
                         my.df$Season1Date)
my.df$Season1Date <- gsub(pattern = "^(10|11|12|01)(.*)to (05|06)(.*)",
                         replacement = "Half-Year",
                         my.df$Season1Date)
my.df$Season1Date <- gsub(pattern = "^(03|04)(.*)to (09|10|11)(.*)",
                         replacement = "Half-Year",
                         my.df$Season1Date)
my.df$Season1Date <- gsub(pattern = "^(05)(.*)to (10)(.*)",
                         replacement = "Half-Year",
                         my.df$Season1Date)
my.df$Season1Date <- gsub(pattern = "^(10)(.*)to (04)(.*)",
                         replacement = "Half-Year",
                         my.df$Season1Date)
my.df$Season1Date <- gsub(pattern = "^(09)(.*)(.13) to (05)(.*)(.14)",
                         replacement = "Half-Year",
                         my.df$Season1Date)
my.df$Season1Date <- gsub(pattern = "7/12/13 to 11/29/13",
                         replacement = "Half-Year",
                         my.df$Season1Date)
my.df$Season1Date <- gsub(pattern = "^(May.|Jun.)(.*)to (Nov.|Dec.)(.*)",
                         replacement = "Half-Year",
                         my.df$Season1Date)
my.df$Season1Date <- gsub(pattern = "^(Apr.)(.*)to (Nov.|Dec.)(.*)",
                         replacement = "Half-Year",
                         my.df$Season1Date)
my.df$Season1Date <- gsub(pattern = "^(Nov.)(.*)to (Apr.|May|Jul.)(.*)",
                         replacement = "Half-Year",
                         my.df$Season1Date)
my.df$Season1Date <- gsub(pattern = "^(Mar.)(.*)to (Sep.|Oct.|Nov.|Dec.)(.*)",
                         replacement = "Half-Year",
                         my.df$Season1Date)
my.df$Season1Date <- gsub(pattern = "^(Jul.)(.*)to (Dec.)(.*)",
                         replacement = "Half-Year",
                         my.df$Season1Date)
my.df$Season1Date <- gsub(pattern = "^(Oct.)(.*)to (Mar.)(.*)",
                         replacement = "Half-Year",
                         my.df$Season1Date)
my.df$Season1Date <- gsub(pattern = "^(Dec.|Jan.)(.*)to (May)(.*)",
                         replacement = "Half-Year",
                         my.df$Season1Date)
my.df$Season1Date <- gsub(pattern = "^(Oct.)(.*)to (Apr.|Jun.|May)(.*)",
                         replacement = "Half-Year",
                         my.df$Season1Date)
my.df$Season1Date <- gsub(pattern = "^(Feb.)(.*)to (Sep.|Oct.)(.*)",
                         replacement = "Half-Year",
                         my.df$Season1Date)
my.df$Season1Date <- gsub(pattern = "^(Sep.)(.*)to (Apr.|May)(.*)",
                         replacement = "Half-Year",
                         my.df$Season1Date)

# Spring
my.df$Season1Date <- gsub(pattern = "^(03|04)(.*)(.13) to (05|06)(.*)(.13)",
                         replacement = "Spring",
                         my.df$Season1Date)

# Summer
my.df$Season1Date <- gsub(pattern = "^(05|06)(.*)(.13) to (05|06|07|08|09)(.*)(.13)",
                         replacement = "Summer",
                         my.df$Season1Date)
my.df$Season1Date <- gsub(pattern = "^(06|07)(.*)(.13) to (06|07|08|09|10)(.*)(.13)",
                         replacement = "Summer",
                         my.df$Season1Date)
my.df$Season1Date <- gsub(pattern = "^(04|05)(.*)(.13) to (04|05|06|07|08|09|10)(.*)(.13)",
                         replacement = "Summer",
                         my.df$Season1Date)
my.df$Season1Date <- gsub(pattern = "^(08|09)(.*)(.13) to (08|09)(.*)(.13)",
                         replacement = "Summer",
                         my.df$Season1Date)
my.df$Season1Date <- gsub(pattern = "^(May.|Jun.)(.*)to (Sep.|Oct.)(.*)",
                         replacement = "Summer",
                         my.df$Season1Date)
my.df$Season1Date <- gsub(pattern = "^(Apr.|May|Jul.|Jun.|Aug)(.*)to (Jul.|Aug.|Sep.|Oct.)(.*)",
                         replacement = "Summer",
                         my.df$Season1Date)
my.df$Season1Date <- gsub(pattern = "^(June 17)(.*)to (June 17)(.*)",
                         replacement = "Summer",
                         my.df$Season1Date)
my.df$Season1Date <- gsub(pattern = "^(September 20)(.*)to (September 20)(.*)",
                         replacement = "Summer",
                         my.df$Season1Date)
my.df$Season1Date <- gsub(pattern = "^(Start Date)(.*)",
                         replacement = "Summer",
                         my.df$Season1Date)

#Fall
my.df$Season1Date <- gsub(pattern = "^(08|09|10)(.*)to (10|11|12)(.*)",
                         replacement = "Fall",
                         my.df$Season1Date)
my.df$Season1Date <- gsub(pattern = "^(07)(.*)to (11|12)(.*)",
                         replacement = "Fall",
                         my.df$Season1Date)
my.df$Season1Date <- gsub(pattern = "^(Jul.|Aug)(.*)to (Nov.)(.*)",
                         replacement = "Fall",
                         my.df$Season1Date)
my.df$Season1Date <- gsub(pattern = "^(Aug.|Sep.|Oct.|Nov.)(.*)to (Nov.|Dec.)(.*)",
                         replacement = "Fall",
                         my.df$Season1Date)

#Winter
my.df$Season1Date <- gsub(pattern = "^(11|12|01|02)(.*)(.12|.13) to (11|12|01|02|03|04)(.*)(.13)",
                         replacement = "Winter",
                         my.df$Season1Date)
my.df$Season1Date <- gsub(pattern = "^(11|12|01|02)(.*)(.13|.14) to (11|12|01|02|03|04)(.*)(.14)",
                         replacement = "Winter",
                         my.df$Season1Date)
my.df$Season1Date <- gsub(pattern = "^(Dec.|Jan.)(.*)to (Mar.|Apr.)(.*)",
                         replacement = "Winter",
                         my.df$Season1Date)
my.df$Season1Date <- gsub(pattern = "^(Oct.|Nov.)(.*)to (Feb.|Mar.)(.*)",
                         replacement = "Winter",
                         my.df$Season1Date)

# Ignore
my.df$Season1Date <- gsub(pattern = ".*to$",
                         replacement = "",
                         my.df$Season1Date)
my.df$Season1Date <- gsub(pattern = "^\\d+$",
                         replacement = "",
                         my.df$Season1Date)

# This puts the data into a data frame and gives the columns proper names
df.seasons <-
  as.data.frame(table(my.df$Season1Date))
names(df.seasons) <- c("Season1Date", "Freq")

# This sorts and displays the Season1Date.
sort.df.seasons <-
  df.seasons[order(df.seasons$Freq, decreasing = TRUE), ]
sort.df.seasons

# If I wanted to save this to a file:
# write.xlsx(
#   my.df,
#   file = "2013 Geographric Coordinate Spreadsheet for U S  Farmers Markets 8'3'1013_R1.xlsx",
#   sheetName = "Season1data",
#   col.names = TRUE,
#   row.names = FALSE,
#   append = FALSE,
#   showNA = TRUE
# )

# Task 3:  # Write a retrieval function acceptsWIC() that allows a data scientist
# to find which markets accept WIC.

acceptsWIC <- function(x) {
  # This function finds and returns the names of markets that accept WIC. This
  # uses a subset named, df.sub, to filter by WIC == Y then returns the results.
  
  # This collects all WIC == Y data and prints it
  return(df.sub <- subset(x, WIC == "Y"))
}

# This calls the function with argument my.df
df.acceptsWIC <- acceptsWIC(my.df)
head(df.acceptsWIC)

# This will save the function as a CSV file to analyze the data
#write.csv(df.acceptsWIC, file = "wic_data.csv", row.names = FALSE)
