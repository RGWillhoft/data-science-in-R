# 14.3 - Accessing Web APIs from R
# 14.4 - Processing JSON Data
# Based on example code in Programming Skills for Data Science by Freeman & Ross
# Modified by RG Willhoft, 2019

library("httr")
library("jsonlite")
library("dplyr")

# A very simple http request
url <- "https://api.github.com/search/repositories?q=dplyr&sort=forks"
response <- GET(url)

# A better way to create the above request
base_url <- "https://api.github.com"
endpoint <- '/search/repositories'
resource_url <- paste0(base_url,endpoint)
query_parms <- list(q="dplyr", sort="forks")
response <- GET( resource_url, query=query_parms)

# Get the (raw) text from the response
response_text <- content( response, type="text" )

# Using JSON to parse and flatten the data
response_data <- fromJSON(response_text)
View(response_data)

# Get the actual items from the response
response_items <- response_data$items
View(response_items)

# Some JSON examples
# Note that the strings are in single quotes to preserve the double quotes

text = 
  '{
    "first_name": "Ada",
    "job": "Programmer",
    "salary": 78000,
    "in_union": true,
    "favorites": {
      "music": "jazz",
      "food": "pizza",
      "colors": ["green", "blue" ]
    }
  }'

person <- fromJSON( text )
View( person )

# This is the JSON equivalent of a data frame

text =
  '[
    { 
      "country": "Brazil", 
      "titles": 5, 
      "total_wins": 70, 
      "total_losses": 17 
    },
    { 
      "country": "Italy", 
      "titles": 4, 
      "total_wins": 66, 
      "total_losses": 20 
    },
    { 
      "country": "Germany", 
      "titles": 4, 
      "total_wins": 45, 
      "total_losses": 17 
    },
    { 
      "country": "Argentina", 
      "titles": 2, 
      "total_wins": 42, 
      "total_losses": 21
    },
    { 
      "country": "Uruguay", 
      "titles": 2, 
      "total_wins": 20, 
      "total_losses": 19 
    }
  ]'
  
world_cup_data <- fromJSON( text )
world_cup_data$percent <- world_cup_data$total_wins / ( world_cup_data$total_wins + world_cup_data$total_losses )
View( world_cup_data )
