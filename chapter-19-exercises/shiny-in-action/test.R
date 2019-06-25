# Create a map of fatal police shootings using leaflet

# Load the leaflet function for mapping
library( "leaflet" )

# Load the prepared data
shootings <- read.csv( "data/police-shootings.csv", stringsAsFactors = FALSE )

# Construct a color palette (scale) based on the `race` column
# Using double-bracket notation will make it easier to adapt for use with Shiny
palette_fn <- colorFactor( palette = "Dark2", domain = shootings[["race"]] )

# Create a map of the shooting using leaflet
# The `addCircleMarkers()` function will make circles with radii based on zoom
leaflet( data = shootings ) %>%
  addProviderTiles( "Stamen.TonerLite" ) %>%
  addCircleMarkers(
    lat = ~lat,
    lng = ~long,
    label = ~paste0( name, ", ", age ),
    color = ~palette_fn( shootings[["race"]] ),
    fillOpacity = 0.7,
    radius = 4,
    stroke = FALSE
  ) %>%
  addLegend(
    position = "bottomright",
    title = "race",
    pal = palette_fn,
    values = shootings[["race"]],
    opacity = 1
  )

table <- shootings %>%
  group_by( shootings[["race"]] ) %>%
  count() %>%
  arrange( -n )

colnames( table ) = c( "race", "Number of Victims")

