rm(list = ls())  # clears environment
cat("\014") # clears the console in RStudio

### Comments ###

# First I cleared the environment and RStudio console as noted above. This makes sure
# my environment is clear and I have a clear console to work with. Then I set the
# working directory.  I opened the file as a list and I realized that I only need the
# first element of the list.  So I removed everything but the first element and 
# cleaned up the data a little before putting it into a data frame.  Once it was 
# in a data frame I split the title from the date and made a data frame with Movie 
# and Release Year.  I ran system.time on this and it takes 2 minutes to run on my 
# computer.

### Code ###

# Set working directory
setwd("C:/R/DA5020/Week_04")


# Open file, if it exists, do not open. I used scan to open the file as a list and I 
# seperated it by new line (\n) and skipped the first 14 rows to start where the movies
# begin.
if (!exists("movie.list")) {
  movie.list <-
    scan(
      gzfile("movies.list.gz"),
      what = "character",
      sep = "\n",
      skip = 14
    )
}

# Now that I have a list, I can separate elements by tab using strsplit
movie.list.edit <- strsplit(movie.list, '\t')

# I extracted the first vector element and set it as the list element name
names(movie.list.edit) <- sapply(movie.list.edit, `[[`, 1)

# I Kept the first vector element from each list element
movie.list.edit <- lapply(movie.list.edit, `[`, 1)

# I made it a vector to clean the data
movie.list.edit <- unlist(movie.list.edit)

# Now that is is a vector, I can clean it up a little before making it a data frame.
# Remove shows with regex
movie.list.edit <- gsub(pattern = "(.*)(\\})$",
          replacement = "",
          movie.list.edit)

# Remove blanks from the vector
movie.list.edit <- movie.list.edit[movie.list.edit != ""]

# Remove \" from the data with regex
movie.list.edit <- gsub(pattern = "\\\"",
          replacement = "",
          movie.list.edit)

# I cleaned the data as much as I could and noe I can put it into a data frame
movie.df <- data.frame(movie.list.edit, stringsAsFactors = FALSE, row.names = NULL)
names(movie.df) <- c("Movie")

# I removed non-date parentheses from the data with regex...i.e (TV)
movie.df$Movie <- gsub(pattern = "\\s(\\([A-z]+\\))$",
                       replacement = "",
                       movie.df$Movie)

# This makes sure the date has 4 digits, i.e (1970/II) changes to (1970)
movie.df$Movie <- gsub(pattern = "\\/\\w+\\)$",
                       replacement = "\\)",
                       movie.df$Movie)

# I use substring to collect the date and put it into a Year column
movie.df$'Release Year' <- substr(movie.df$Movie, nchar(movie.df$Movie) - 5, nchar(movie.df$Movie))

# Remove the dates from the Movie column with regex
movie.df$Movie <- gsub(pattern = "\\s(\\(\\d+\\))$",
                       replacement = "",
                       movie.df$Movie)

# The next 2 removes parentheses from the Year
movie.df$'Release Year' <- gsub(pattern = "\\(",
                                replacement = "",
                                movie.df$'Release Year')

movie.df$'Release Year' <- gsub(pattern = "\\)",
                                replacement = "",
                                movie.df$'Release Year')

# Removes (????) from the Movie
movie.df$Movie <- gsub(pattern = "\\s(\\(\\?\\?\\?\\?\\))$",
                       replacement = "",
                       movie.df$Movie)

# Replaces ???? in the Year with NA
movie.df$'Release Year' <- gsub(pattern = "(\\?\\?\\?\\?)$",
                                replacement = NA,
                                movie.df$'Release Year')

# The data frame is complete
head(movie.df)


# I used the following for troubleshooting
#grep("(\\?\\?\\?\\?)$", movie.df$'Release Year', value = TRUE)
write.csv(movie.df, file = "movie_list.csv", row.names = FALSE)
