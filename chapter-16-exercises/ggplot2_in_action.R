# 16.5 - Mapping Evictions in San Francisco
# Based on example code in Programming Skills for Data Science by Freeman & Ross
# Modified by RG Willhoft, 2019

library("dplyr")
library("tidyr")

notices <- read.csv( 'data/Eviction_Notices.csv', stringsAsFactors = FALSE )

# This statement produces some NAs since some of the Location fields are blank
notices <- notices %>%
  mutate( date = as.Date( File.Date, format="%m/%d/%y" ) ) %>%
  filter( format(date, "%Y") == "2017" ) %>%
  separate( Location, c("lat", "long"), ", " ) %>%
  mutate(
    lat = as.numeric( gsub( "\\(", "", lat ) ),
    long = as.numeric( gsub( "\\)", "", long ) )
  )
 
library("ggmap")
library("ggplot2")

base_plot <- qmplot(
  data = notices,
  x = long,
  y = lat,
  geom = "blank",
  maptype = "toner-background",
  darken = 0.7,
  legend = "topleft"
)

base_plot +
  geom_point( mapping = aes( x = long, y = lat ), color = "red", alpha = 0.3 ) +
  labs( title = "Evictions in San Francisco, 2017" ) +
  theme( plot.margin = margin( 0.3, 0, 0, 0, "cm" )) 

base_plot +
  geom_polygon(
    stat = "density2d",
    mapping = aes(
      fill = stat(level)
      ),
    alpha = 0.3
    ) +
  scale_fill_gradient2(
    "# of Evictions",
    low = "white",
    mid = "yellow",
    high = "red" 
    ) +
  labs( 
    title = "Evictions in San Francisco, 2017" 
    ) +
  theme( 
    plot.margin = margin( 0.3, 0, 0, 0, "cm" )
    ) 
