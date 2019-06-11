# RG Willhoft, 2019

library(dplyr)
library(rworldmap)
library(rworldxtra)
library(RColorBrewer)

setwd("D:/Dropbox/Data Science/Data Science in R")
life_exp <- read.csv( 
  "data/API_SP.DYN.LE00.IN_DS2_en_csv_v2.csv", 
  skip = 4, 
  stringsAsFactors = FALSE 
)

longest_le <- life_exp %>%
  filter( X2015 == max(X2015, na.rm = TRUE) ) %>%
  select( Country.Name, X2015 ) %>%
  mutate( expectancy = round(X2015,1))

shortest_le <- life_exp %>%
  filter( X2015 == min(X2015, na.rm = TRUE) ) %>%
  select( Country.Name, X2015 ) %>%
  mutate( expectancy = round(X2015,1))

le_difference <- longest_le$expectancy - shortest_le$expectancy

top_10_gain <- life_exp %>%
  mutate( gain = X2015 - X1960 ) %>%
  top_n( 10, wt = gain ) %>%
  arrange( - gain ) %>%
  mutate( gain_str = paste( format( round(gain,1), nsmall = 1),"years" ) ) %>%
  select( Country.Name, gain_str )

# Join this data fram to a shapefile that describes how to draw each country
# The 'rworldmap package provides a helful function for doing this
mapped_data <- joinCountryData2Map(
  life_exp,
  joinCode = "ISO3",
  nameJoinColumn = "Country.Code",
  mapResolution = "high"
)
