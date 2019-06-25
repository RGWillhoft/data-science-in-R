#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# The UI is the result of calling the "fluidPage()" layout function
ui <- fluidPage(
    # A static content element: a 2nd level header that displays text
    h2("Greetings from Shiny"),
    
    # A widget: a text input box (same input in the "username" key)
    textInput( inputId = "username", label = "What is your name?"),
    
    # An output element: a text output (for the "message" key)
    textOutput( outputId = "message" )
)


# The server is a function that takes "input" and "output" arguments
server <- function(input, output) {
    # Assign a value to the "message" key in the "output" list using
    # the renderText() method, creating a value the UI can display
    output$message <- renderText( {
        # This block is like a function that will automatically rerun
        # when a referened "input" value changes
        
        # Use th "Username" key from "input" to create a value
        message_str <- paste0( "Hello ", input$username, "!" )
        
        # Return the value to be rendered by the UI
        message_str
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
