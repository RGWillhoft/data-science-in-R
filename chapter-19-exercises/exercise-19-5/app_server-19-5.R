### Exercise 5 ###

library(shiny)
library(ggplot2)

# Create a shiny server that creates a scatterplot.
app_server <- function(input, output) {

# It should use an `input` with features: `x_var`, `y_var`, `color`, and `size`
# Save the result of `renderPlot` to output$scatter
  output$scatter <- renderPlot({
    plt <- ggplot( data = mpg ) +
      geom_point(
        mapping = aes_string( x = input$x_var, y = input$y_var ),
        color = input$color,
        size = input$size
      ) +
      labs(
        title = paste( "MPG Dataset:", input$y_var, "vs", input$x_var ) 
      ) +
      theme(
        plot.title = element_text(
          face = "bold",
          size = 16,
          hjust = 0.5
        )
      )
    plt
  })
}
