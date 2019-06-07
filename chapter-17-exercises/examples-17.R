# Interactive Visualizations in R
# Based on example code in Programming Skills for Data Science by Freeman & Ross
# Modified by RG Willhoft, 2019

library( "ggplot2" )

# 17.1 The plotly Package

library( "plotly" )

flower_plot <- ggplot( data = iris ) +
  geom_point( mapping = aes( x = Sepal.Width, y = Petal.Width, color = Species ) )

ggplotly( flower_plot)

plot_ly(
  data = iris,
  x = ~Sepal.Width,
  y = ~Petal.Width,
  color = ~Species,
  type = "scatter",
  mode = "markers"
) %>%
  layout(
    title = "Iris Data Set Visualization",
    xaxis = list( title = "Sepal Width", ticksuffix = "cm" ),
    yaxis = list( title = "Petal Width", ticksuffix = "cm" )
  )

# 17.2 - The rbokeh Package

library( "rbokeh" )

figure(
  data = iris,
  title = "Iris Data Set Visualization"
) %>%
  ly_points(
    Sepal.Width,
    Petal.Width,
    color = Species
  ) %>%
  x_axis(
    label = "Sepal Width",
    number_formatter = "printf",
    format = "%s cm"
  ) %>%
  y_axis(
    label = "Petal Width",
    number_formatter = "printf",
    format = "%s cm"
  )

# 17.3 - The leaflet Package

library( "leaflet" )

leaflet() %>%
  addProviderTiles( "CartoDB.Positron" ) %>%
  setView( lng = -122.3321, lat = 47.6062, zoom = 10 )

locations <- data.frame(
  label = c("University of Washington", "Seattle Central Collger"),
  latitude = c(47.6553, 47.6163),
  longitude = c(-122.3035, -122.3216 )
)

leaflet( data = locations) %>%
  addProviderTiles( "CartoDB.Positron" ) %>%
  setView( lng = -122.3321, lat = 47.6062, zoom = 11 ) %>%
  addCircles(
    lat = ~latitude,
    lng = ~longitude,
    popup = ~label,
    radius = 500,
    stroke = FALSE
  )

# 17.4 - Interactive Visualization in Action: Exploring Change to the City of Seattle

library( "dplyr" )

all_permits <- read.csv( "data/Building_Permits.csv", stringsAsFactors = FALSE )

new_buildings <- all_permits %>%
  filter(
    PermitTypeDesc == "New",
    PermitClass != "N/A",
    as.Date( all_permits$IssuedDate) >= as.Date("2010-01-01")
  )

new_buildings <- new_buildings %>%
  mutate( year = substr(IssuedDate, 1, 4) )

by_year <- new_buildings %>%
  group_by( year ) %>%
  count()

plot_ly(
  data = by_year,
  x = ~year,
  y = ~n,
  type = "bar",
  alpha = 0.7,
  hovertext = "y"
) %>%
  layout(
    title = "Number of new building permist per year in Seattle",
    xaxis = list( title = "Year" ),
    yaxis = list( title = "Number of Permits" )
  )

leaflet( data = new_buildings ) %>%
  addProviderTiles( "CartoDB.Positron" ) %>%
  setView( lng = -122.3321, lat = 47.6062, zoom = 10 ) %>%
  addCircles(
    lat = ~Latitude,
    lng = ~Longitude,
    popup = ~Description,
    stroke = FALSE
  )

palette_fn <- colorFactor( palette = "Set3", domain = new_buildings$PermitClass )

plot_ly(
  data = by_year,
  x = ~year,
  y = ~n,
  type = "bar",
  alpha = 0.7,
  hovertext = "y"
) %>%
  layout(
    title = "Number of new building permist per year in Seattle",
    xaxis = list( title = "Year" ),
    yaxis = list( title = "Number of Permits" )
  )

leaflet( data = new_buildings ) %>%
  addProviderTiles( "CartoDB.Positron" ) %>%
  setView( lng = -122.3321, lat = 47.6062, zoom = 10 ) %>%
  addCircles(
    lat = ~Latitude,
    lng = ~Longitude,
    popup = ~Description,
    stroke = FALSE,
    color = ~palette_fn( PermitClass )
  ) %>%
  addLegend(
    position = "bottomright",
    title = "New Buildings in Seattle",
    pal = palette_fn,
    values = ~PermitClass,
    opacity = 1
  )
