# Creating Visualizations with ggplot2
# Based on example code in Programming Skills for Data Science by Freeman & Ross
# Modified by RG Willhoft, 2019

# 16.2 - Basic Plotting with ggplot2

library("ggplot2")
library("hexbin")

ggplot( data = midwest ) +
  geom_point( mapping = aes( x = percollege, y = percadultpoverty ) )

ggplot( data = midwest ) +
  geom_col( mapping = aes( x = state, y = poptotal ) )

ggplot( data = midwest ) +
  geom_hex( mapping = aes( x = percollege, y = percadultpoverty ) )

ggplot( data = midwest ) +
  geom_point( mapping = aes( x = percollege, y = percadultpoverty ) ) +
  geom_smooth( mapping = aes( x = percollege, y = percadultpoverty ) )

ggplot( data = midwest, mapping = aes( x = percollege, y = percadultpoverty ) ) +
  geom_point() +
  geom_smooth() +
  geom_point( mapping = aes( y = percchildbelowpovert ) )

ggplot( data = midwest ) +
  geom_point( mapping = aes( x = percollege, y = percadultpoverty, color = state ) )

ggplot( data = midwest ) +
  geom_point( 
    mapping = aes( x = percollege, y = percadultpoverty ),
    color = "red",
    alpha = 0.3 
  )

# 16.3 - Complete Layouts and Customization

library("dplyr")
library("tidyr")

# 16.3.1 - Position Adjustments

state_race_long <- midwest %>%
  select( state, popwhite, popblack, popamerindian, popasian, popother ) %>%
  gather( key = race, value = population, -state )

ggplot( state_race_long ) + 
  geom_col( mapping = aes( x = state, y = population, fill = race ) )

ggplot( state_race_long ) + 
  geom_col( 
    mapping = aes( x = state, y = population, fill = race ),
    position = "fill" 
  )

ggplot( state_race_long ) + 
  geom_col( 
    mapping = aes( x = state, y = population, fill = race ),
    position = "dodge" 
  )

# 16.3.2 - Styling with Scales

ggplot( data = midwest ) +
  geom_point( mapping = aes( x = percollege, y = percadultpoverty, color = state ) )

ggplot( data = midwest ) +
  geom_point( mapping = aes( x = percollege, y = percadultpoverty, color = state ) ) +
  scale_x_continuous() +
  scale_y_continuous() +
  scale_color_discrete()

labeled <- midwest %>%
  mutate( location = if_else( inmetro == 0, "Rural", "Urban" ) )

wisconsin_data = labeled %>% filter( state == "WI" )
michigan_data = labeled %>% filter( state == "MI" )

x_scale <- scale_x_continuous( limits = range( labeled$percollege ) )
y_scale <- scale_y_continuous( limits = range( labeled$percadultpoverty ) )

color_scale <- scale_color_discrete( limits = unique( labeled$location ) )

ggplot( data = wisconsin_data ) +
  geom_point(
    mapping = aes( x = percollege, y = percadultpoverty, color = location )
  ) +
  x_scale +
  y_scale +
  color_scale

ggplot( data = michigan_data ) +
  geom_point(
    mapping = aes( x = percollege, y = percadultpoverty, color = location )
  ) +
  x_scale +
  y_scale +
  color_scale

ggplot( data = midwest ) +
  geom_point( mapping = aes( x = percollege, y = percadultpoverty, color = state ) ) +
  scale_color_brewer( palette = "Set3")

# 16.3.3 - Coordinate Systems

top_10 <- midwest %>%
  top_n( 10, wt = poptotal ) %>%
  unite( county_state, county, state, sep = ", " ) %>%
  arrange( poptotal ) %>%
  mutate( location = factor( county_state, county_state ) )

ggplot( top_10 ) +
  geom_col( mapping = aes( x = location, y = poptotal ) ) +
  coord_flip()

# 16.3.4 - Facets (Subplots)

labeled <- midwest %>%
  mutate( location = if_else( inmetro == 0, "Rural", "Urban" ) )

ggplot( data = labeled ) +
  geom_point(
    mapping = aes( x = percollege, y = percadultpoverty, color = location ),
    alpha = 0.6
  ) +
  facet_wrap( ~state )

# 16.3.5 - Labels and Annotations

ggplot( data = labeled ) +
  geom_point(
    mapping = aes( x = percollege, y = percadultpoverty, color = location ),
    alpha = 0.6
  ) +
  labs(
    title = "Percent College Educated versus Poverty Rates",
    x = "Percentage of College Educated Adults",
    y = "Percentage of Adults Living in Poeverty",
    color = "Urbanity"
  )

library( ggrepel )

most_poverty <- midwest %>%
  group_by( state ) %>%
  top_n( 1, wt = percadultpoverty ) %>%
  unite( county_state, county, state, sep = ". " )

subtitle <- "(the county with the highest level of poverty in each state is labeled)"

ggplot( data = labeled,
        mapping = aes( x = percollege, y = percadultpoverty ) ) +
  geom_point( mapping = aes( color = location), alpha = 0.6 ) +
  geom_label_repel(
    data = most_poverty,
    mapping = aes( label = county_state ),
    alpha = 0.6
  ) +
  
  scale_x_continuous( limits = c(0,55) ) +
  
  labs(
    title = "Percent College Educated versus Poverty Rates",
    subtitle = subtitle,
    x = "Percentage of College Educated Adults",
    y = "Percentage of Adults Living in Poeverty",
    color = "Urbanity"
  )

# 16.4 - Building Maps

# 16.4.1 - Choropleth Maps

library("maps")
library("mapproj")

state_shape <- map_data( 'state' )

ggplot( state_shape ) +
  geom_polygon(
    mapping = aes( x = long, y = lat, group = group ),
    color = "white",
    size = 0.1 # this is the stoke line between states
  ) +
  coord_map()

# the book has this later, but needs to be before we create the graph

blank_theme <- theme_bw() +
  theme(
    axis.line = element_blank(),
    axis.text = element_blank(),
    axis.ticks = element_blank(),
    axis.title = element_blank(),
    plot.background = element_blank(),
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    panel.border = element_blank(),
  )

evictions <- read.csv( "data/states.csv", stringsAsFactors = FALSE ) %>%
  filter( year == 2016 ) %>%
  mutate( state = tolower(state) ) 

state_shape <- map_data( "state" ) %>%
  rename( state = region ) %>%
  left_join( evictions, by="state" )

ggplot( state_shape ) +
  geom_polygon(
    mapping = aes( x = long, y = lat, group = group, fill = eviction.rate ),
    color = "white",
    size = 0.1 # this is the stoke line between states
  ) +
  coord_map() +
  scale_fill_continuous( low = "#132B43", high = "Red" ) +
  labs( fill = "Eviction Rate" ) +
  blank_theme

# 16.4.2 - Dot Distribution Maps

cities <- data.frame(
  city = c("Seattle","Denver","Rochester"),
  lat = c(47.6062, 39.7392, 43.1566),
  long = c(-122.3321, -104.9903, -77.6088)
)

ggplot( state_shape ) +
  geom_polygon(
    mapping = aes( x = long, y = lat, group = group ),
    color = "white",
    size = 0.1 # this is the stoke line between states
  ) +
  geom_point(
    data = cities,
    mapping = aes( x=long, y = lat ),
    color = "red"
  ) +
  coord_map()

# 16.5 - Mapping Evictions in San Francisco