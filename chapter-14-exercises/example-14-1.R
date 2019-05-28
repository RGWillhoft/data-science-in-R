# Yelp API: Where is the best Cuban food in Seattle?
library("httr")
library("jsonlite")
library("dplyr")
#library("ggrepel")
#library("ggmap")

url <- "https://api.github.com/search/repositories?q=dplyr&sort=forks"
response <- GET(url)

base_url <- "https://api.github.com"
endpoint <- '/search/repositories'
resource_url <- paste0(base_url,endpoint)
query_parms <- list(q="dplyr", sort="forks")
response <- GET( resource_url, query=query_parms)
response_text <- content( response, type="text" )
response_data <- fromJSON(response_text)
View(response_data)

