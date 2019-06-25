# RG Willhoft, 2019

library(shiny)
library(dplyr)
library(leaflet)

shootings <- read.csv( "data/police-shootings.csv", stringsAsFactors = FALSE )

ui <- fluidPage(
    titlePanel("Fatal Police Shootings"),
    sidebarLayout(
        sidebarPanel(
            selectInput(
                inputId = "analysis_var",
                label = "Level of Analysis",
                choices = c( "gender", "race", "body_camera", "threat_level" )
            )
        ),
        mainPanel(
            leafletOutput( "shooting_map" ),
            tableOutput( "grouped_table" )
        )
    )
)


# Define server logic required to draw a histogram
server <- function(input, output) {
    
    output$shooting_map <- renderLeaflet({
        palette_fn <- colorFactor(
            palette = "Dark2",
            domain = shootings[[input$analysis_var]]
        )
        leaflet( data = shootings ) %>%
            addProviderTiles( "Stamen.TonerLite" ) %>%
            addCircleMarkers(
                lat = ~lat,
                lng = ~long,
                label = ~paste0( name, ", ", age ),
                color = ~palette_fn( shootings[[input$analysis_var]] ),
                fillOpacity = 0.7,
                radius = 4,
                stroke = FALSE
            ) %>%
            addLegend(
                position = "bottomright",
                title = input$analysis_var,
                pal = palette_fn,
                values = shootings[[input$analysis_var]],
                opacity = 1
            )
    })
    
    output$grouped_table <- renderTable({
        table <- shootings %>%
            group_by( shootings[[input$analysis_var]] ) %>%
            count() %>%
            arrange( -n )
        colnames( table ) = c( input$analysis_var, "Number of Victims")
        table
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
