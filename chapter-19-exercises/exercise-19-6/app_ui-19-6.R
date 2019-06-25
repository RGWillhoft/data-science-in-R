# Libraries
library(plotly)
library(shiny)

# ui.R

# Create a variable `color_input` as a `selectInput()` that allows users to
# select a color from a list of choices
variable_input <- selectInput(
  "variable",
  "Variable",
  c( Population = "population", 
     "Electoral Votes" = "votes", 
     "Votes / Population" = "ratio"
     )
)


app_ui <- fluidPage(
  mainPanel(
    # Add a selectInput that allows you to select a variable to map
    variable_input,
    
    # Use `plotlyOutput()` to show your map
    plotlyOutput( "map" )
  )
)