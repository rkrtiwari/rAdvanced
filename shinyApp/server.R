library(shiny)
library(ggplot2)
library(scales)
shinyServer(function(input, output) {
  output$text <- renderText({
    input$title
  })
  
  output$plot <- renderPlot({
    
    x <- mtcars[, input$x]
    y <- mtcars[, input$y]
    plot(x,y, pch=16, col = "red")
    
  })
  
  
}
)