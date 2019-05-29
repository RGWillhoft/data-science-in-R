# Exercise 2: working with data APIs
# RG Willhoft, 2019

# load relevant libraries
library("httr")
library("jsonlite")

# Be sure and check the README.md for complete instructions!
# https://developer.nytimes.com/accounts/create


# Use `source()` to load your API key variable from the `apikey.R` file you made.
# Make sure you've set your working directory!
source( "appkeys.R" )

# Create a variable `movie_name` that is the name of a movie of your choice.
movie_name <- "The Hunt for Red October"

# Construct an HTTP request to search for reviews for the given movie.
# The base URI is `https://api.nytimes.com/svc/movies/v2/`
# The resource is `reviews/search.json`
# See the interactive console for parameter details:
#   https://developer.nytimes.com/movie_reviews_v2.json
#
# You should use YOUR api key (as the `api-key` parameter)
# and your `movie_name` variable as the search query!

base_uri <- "https://api.nytimes.com/svc/movies/v2/"
resource <- "reviews/search.json"
query_params <- list(query = "the hunt for red october", "api-key" = nytimes_key )
# https://api.nytimes.com/svc/movies/v2/reviews/search.json?query=godfather&api-key=yourkey

# Send the HTTP Request to download the data
# Extract the content and convert it from JSON
response_data <- fromJSON( content( GET( paste0(base_uri,resource),query=query_params), "text" ) )

# What kind of data structure did this produce? A data frame? A list?


# Manually inspect the returned data and identify the content of interest 
# (which are the movie reviews).
# Use functions such as `names()`, `str()`, etc.
results <- response_data$results

# Flatten the movie reviews content into a data structure called `reviews`
reviews <- flatten( results )

# From the most recent review, store the headline, short summary, and link to
# the full article, each in their own variables
headline <- reviews$headline[1]
short_summary <- reviews$summary_short[1]
link <- reviews$link.url[1]

# Create a list of the three pieces of information from above. 
# Print out the list.
movie_info <- list( headline = headline, summary = short_summary, link = link )
print( movie_info )
