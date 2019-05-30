# Create a Google Map with the best sushi locations in Rochester, NY
# Uses Yelp and Google APIs
# Based on example code in Programming Skills for Data Science by Freeman & Ross
# Modified by RG Willhoft, 2019

# Yelp API: Where is the best Sushi food in Rochester?
library("httr")
library("jsonlite")
library("dplyr")
library("ggrepel")
library("ggmap")

# Load API key (stored in another file)
source("../../api_keys.R")

# Construct your search query
base_uri <- "https://api.yelp.com/v3/"
endpoint <- "businesses/search"
uri <- paste0(base_uri,endpoint)

# Store a list of query parameters
query_params <- list(
  term = "restaurants",
  categories = "sushi",
  location = 'Rochester, NY',
  sort_by = "rating",
  radius = 8000
)

# Make a GET request, including your API key as a header
response <- GET(
  uri,
  query = query_params,
  add_headers(Authorization = paste("bearer",yelp_key))
)

# Parse results and isolate data of interest
response_text <- content(response,type="text")
response_data <- fromJSON(response_text)

# Save the data frame of interest
restaurants <- flatten(response_data$businesses)

# Modify the data frame for analysis and presentation
restaurants <- restaurants %>%
  mutate( rank = row_number() ) %>%
  mutate( name_and_rank = paste0( rank, ". ", name ) )

# Create a base layer for the map (Google Maps image of Rochester)
register_google( key = google_maps_key )
base_map <- ggmap(get_map(location = "Rochester, NY", zoom = 11, scale = "auto", maptype = "roadmap", source = "google" ) )

# Add labels to the map based on the coordinates in the data
base_map +
  geom_label_repel(
    data = restaurants,
    aes( x = coordinates.longitude, y = coordinates.latitude, label = name_and_rank )
  )

