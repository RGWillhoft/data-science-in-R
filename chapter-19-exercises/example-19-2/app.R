#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)




page_default <- tabPanel( 
    "Default",
    titlePanel("Old Faithful Geyser Data"),
    sidebarLayout(
        sidebarPanel(
            sliderInput("bins",
                        "Number of bins:",
                        min = 1,
                        max = 50,
                        value = 30)
        ),
        mainPanel(
           plotOutput("distPlot")
        )
    )
)

page_example1 <- tabPanel(
    "Example #1",
    h2("Greetings from Shiny"),
    textInput( inputId = "username", label = "What is your name?"),
    textOutput( outputId = "message" )
)

page_example2 <- tabPanel(
    "Example #2",
    h2("Random numbers and statistics"),
    p("This is based somewhat on some of the items in the book."),
    sliderInput(
        "numberOfValues",
        "Mean of Values",
        min = 2,
        max = 100,
        value = 50,
        step = 1
    ),
    numericInput( 
        "meanOfValues", 
        "Mean of values", 
        min = -10,
        max = 10,
        value = 0
    ),
    radioButtons( 
        "sdOfValues",
        "Standard Devitation",
        c( 0.5, 1, 2 )
    ),

    textOutput( outputId = "statsMessage" ),
    plotOutput( "statsPlot" ),
    tableOutput( "statsTable" )
)

ui <- navbarPage(
    "Examples from Chapter 19",
    page_default,
    page_example1,
    page_example2
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$distPlot <- renderPlot({
        # generate bins based on input$bins from ui.R
        x    <- faithful[, 2]
        bins <- seq(min(x), max(x), length.out = input$bins + 1)

        # draw the histogram with the specified number of bins
        hist(x, breaks = bins, col = 'darkgray', border = 'white')
    })
    
    output$message <- renderText( {
        # This block is like a function that will automatically rerun
        # when a referened "input" value changes
        
        # Use th "Username" key from "input" to create a value
        message_str <- paste0( "Hello ", input$username, "!" )
        
        # Return the value to be rendered by the UI
        message_str
    })
    
    randomValues <- reactive({
        rnorm(
            input$numberOfValues,
            input$meanOfValues,
            as.numeric( input$sdOfValues )
        )
    })

    output$statsMessage <- renderText( {
        message_str <- paste( 
            "Actual mean:", mean( randomValues() ),
            "and standard deviation of Values:",  sd( randomValues() ) 
        )
        message_str
    })
    
    output$statsPlot <- renderPlot( {
        plot( randomValues() )
    })
    
    # output$distPlot <- renderPlot({
    #     # generate bins based on input$bins from ui.R
    #     x    <- faithful[, 2]
    #     bins <- seq(min(x), max(x), length.out = input$bins + 1)
    #     
    #     # draw the histogram with the specified number of bins
    #     hist(x, breaks = bins, col = 'darkgray', border = 'white')
    # })
    
    output$statsTable <- renderTable({
        tibble( index = 1:length(randomValues()), value = randomValues())
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
