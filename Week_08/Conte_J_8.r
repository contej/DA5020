rm(list = ls())  # clears environment
cat("\014") # clears the console in RStudio

#########################################################################################
# Assignment:
# Follow the steps of the Web API in R Tutorial and redo them on your own.
# Submit your source code and the tweets_sample.json file generated from the script.
#########################################################################################

# Registering your Application on Twitter
# Step 1: Register it here: https://dev.twitter.com/apps. Go to Create New App.

# Step 2: Enter a name for your application. e.g "Data Science NEU"
# Enter a description for the app e.g. "Getting tweet data using streaming API in R"
# For the website enter a placeholder e.g. "http://www.google.com"
# The callback URL field is optional
# Scroll down the page. Check the license agreement. And click on "Create your Twitter
# Application".
# Your application has been successfully created.

# Step 3: Under the Keys and Access Tokens Tab you will see API Key and API Secret.
# For the access token and access token secret scroll down the page and click on the
# button "Create my access token". Refresh the page if necessary and you will now see
# the the access token and the access token secret.

# Environment Setup
# Step 1: Set working directory
setwd("C:/R/DA5020/Week_08")

# Step 2: Set libraries
library(ROAuth)
library(streamR)
library(twitteR)
library(ROAuth)

# Step 3: Download the certificate needed for authentication. This creates a
# certificate file on the desktop.
download.file(url = "http://curl.haxx.se/ca/cacert.pem", destfile = "cacert.pem")

# Step 4: Create a file to collect all the Twitter JSON data received from the
# API call.
outFile <- "tweets_sample.json"

# Step 5: Set the configuration details to authorize your application to access
# Twitter data.
requestURL       <- "https://api.twitter.com/oauth/request_token"
accessURL        <- "https://api.twitter.com/oauth/access_token"
authURL          <- "https://api.twitter.com/oauth/authorize"
consumerKey      <-
  "9I7HXkhlUFEIBTyAraCAP7eP2"
consumerSecret   <-
  "FlsSx15ec2vomDtV06XfJ9ve8xadfx70eYSwmPA2e9TTMI9u8h"
accessToken      <-
  "876824407985070081-27y6hxybSk9K8041vyRmjwpjp6gSO8A"
accessTokenSecret <- "x5Ou1oMrmQJdWhJKiswkDDGrRu9mV79DjHoGTRvnUCuUg"
# The requestURL, accessURL and authURL remain the same. For the consumerKey,
# consumerSecret, accessToken, acessTokenSecret, fill in the information that was
# provided when you created a developer's account on Twitter (Registering Your
# Application on Twitter, Step 3).


# Step 6: Authenticate user via OAuth handshake and save the OAuth certificate to
# the local disk for future connections. OAuth is an authentication protocol that
# enables a third-party application to obtain limited access to an HTTP service
# without sharing passwords.
my_oauth <- OAuthFactory$new(
  consumerKey = consumerKey,
  consumerSecret = consumerSecret,
  requestURL = requestURL,
  accessURL = accessURL,
  authURL = authURL
)
my_oauth$handshake(cainfo = "cacert.pem")
#########################################################################################
## PAUSE HERE !!!!!
# Once the above code is executed, you will be given a link to authorize your
# application to get Twitter feeds. Copy the link in your browser. Click on
# "Authorize MyApplication." You will receive a pin number. Copy the pin number and
# paste it in the console. Your browser may have automatically opened if you are
# using OS X.

# Step 7:  After your application has been authorized, you will need to register
# your credentials by setting up the OAuth credentials for a Twitter session.

setup_twitter_oauth(consumerKey, consumerSecret, accessToken, accessTokenSecret)

# Then press 1 in the console to allow the file to access the credentials.
#########################################################################################

# Getting Tweet Data
# Step 1: You can now start getting tweet data. The sampleStream() function in the
# streamR package opens a connection to Twitter's Streaming API that returns a
# random sample of public statuses and outputs a JSON file.
sampleStream(file = outFile,
             oauth = my_oauth,
             tweets = 100)

# Step 2: The filterStream() function allows for more specific filtering, for
# example, search for "Boston" or "RedSox" at a certain geolocation, and time
# out after 5 seconds.
follow   <- ""
track    <- "Boston,RedSoxs"
location <- c(23.786699, 60.878590, 37.097000, 77.840813)
filterStream(
  file.name = outFile,
  follow = follow,
  track = track,
  locations = location,
  oauth = my_oauth,
  timeout = 5
)

# Step 3: Confirm filterStream() with additional information
follow   <- ""
track    <- "SenWarren"
filterStream(
  file.name = outFile,
  follow = follow,
  track = track,
  oauth = my_oauth,
  timeout = 10
)
