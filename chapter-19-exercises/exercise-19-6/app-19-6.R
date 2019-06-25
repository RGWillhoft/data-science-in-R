# Exercise 6: interactive mapping

# Load libraries so they are available
library("shiny")

# Use source() to execute the `app_ui.R` and `app_server.R` files. These will
# define the UI value and server function respectively.
source( "app_ui-19-6.R" )
source( "app_server-19-6.R" )

# You will need to fill in the `app_ui.R` file to create the layout.
# Run the app through this file.

# Create a new `shinyApp()` using the loaded `ui` and `server` variables
shinyApp( ui = app_ui, server = app_server )
