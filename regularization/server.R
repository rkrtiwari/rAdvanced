library(shiny)
library(glmnet)

server <- function(input, output){
  
  x <- model.matrix(mpg ~ ., mtcars)[,-1] 
  y <- mtcars$mpg
  
  set.seed(1) 
  train <- sample(1: nrow(x), nrow(x)/2) 
  test <- (-train) 
  yTest <- y[test]
  
  lModel <- glmnet(x[train,],y[train], alpha=1)
  
  output$plot1 <- renderPlot({
    plot(lModel, xvar = "lambda", label = TRUE, lwd =2, 
         cex.axis = 1.5, cex.lab = 1.5)
    
    if(input$sc){
      wc <- coef(lModel, s = exp(input$ls))[input$vn+1]
      s <- exp(input$ls)
      points(input$ls,wc, pch = 8, col = "black", cex = 2)
      segments(input$ls,-10,input$ls,wc)
      segments(-10,wc,input$ls,wc)
      
      output$text1 <- renderText({
        wc <- coef(lModel, s = exp(input$ls))[input$vn+1]
        vname <- names(mtcars)[input$vn+1]
        sprintf("Coefficient of %s: %3.2f", vname, wc)
      })
    }
    
  })
  
  
  
}