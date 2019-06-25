# UI for scatterplot
library(shiny)
library(ggplot2)

# Get a vector of column names (from `mpg`) to use as select inputs
cNames <- colnames( mpg )

# Create a variable `x_input` that stores a `selectInput()` for your
# variable to appear on the x axis of your chart.
# Use the vector of column names as possible values, and make sure
# to assign an inputId, label, and selected value
x_input <- selectInput(
  "x_var",
  "X Variable",
  choices = cNames,
  selected = "manufacturer"
)

# Using a similar approach, create a variable `y_input` that stores a
# `selectInput()` for your variable to appear on the y axis of your chart.
# Add a `selectInput` for the `y` variable
y_input <- selectInput(
  "y_var",
  "Y Variable",
  choices = cNames,
  selected = "cty"
)

# Create a variable `color_input` as a `selectInput()` that allows users to
# select a color from a list of choices
color_input <- selectInput(
  "color",
  "Color",
  c( Blue = "blue", Red = "red", Green = "dark green", Black = "black")
)

# Create a variable `size_input` as a `sliderInput()` that allows users to
# select a point size to use in your `geom_point()`
size_input <- sliderInput(
  "size",
  "Size of point",
  min = 1,
  max = 10,
  value = 2
)

# Create a variable `ui` that is a `fluidPage()` ui element. 
# It should contain:
app_ui <- fluidPage(

  # A page header with a descriptive title
  h2( "MPG Dataset Exploration"),

  # Your x input
  x_input,
  
  # Your y input
  y_input,
  
  # Your color input
  color_input,
  
  # Your size input
  size_input,
  
  # Plot the output with the name "scatter" (defined in `app_server.R`)
  plotOutput( "scatter" )

)

