library(shiny)

server <- function(input, output){
  
  x <- reactive({as.numeric(mtcars[[input$"var1"]])})
  y <- reactive({as.numeric(mtcars[[input$"var2"]])})

  
 output$inputRange <- renderUI({
   xmin <- min(x())
   xmax <- floor(max(x()))
   xval <- (min(x()) + max(x()))/2
   sliderInput("xVal", "Predict", min = 0, 
               max = xmax, value = xval, step = 0.5)
 })
  
  output$plot <- renderPlot({   
    plot(x(), y(), pch = 19, col = "blue", xlab = input$"var1", 
         ylab =  input$"var2", xlim = c(0, 1.05*max(x())),
         ylim = c(0, 1.2*max(y())),
         cex.lab = 1.5, cex.axis = 1.5)
    mtModel <- lm(y() ~ x())
    
    if (input$model) {
      abline(mtModel, col = "green")
    }
    
    if(input$residual) {
      n <- length(x())
      ypred <- mtModel$coefficients[1] + x()*mtModel$coefficients[2]
      for (i in 1:n)
        lines(c(x()[i], x()[i]), c(y()[i], ypred[i]), col = "black")
    }
    
   if(input$predict) {
     xVal <- input$"xVal"
     yPred <- mtModel$coefficients[1] + xVal*mtModel$coefficients[2]
     points(xVal, yPred, pch = 8, cex = 2.5)
     segments(xVal, -20, xVal, yPred, lty = 2)
     segments(-100, yPred, xVal, yPred, lty = 2)
   }
    
  })
  
  output$xVal <- renderText({
    input$"xVal"
  })
  
  output$yVal <- renderText({
    mtModel <- lm(y() ~ x())
    ypred <- mtModel$coefficients[1] + mtModel$coefficients[2]*input$"xVal"
    round(ypred,2)
  })
  
  output$corVal <- renderPrint({
    cor(x(),y())
  })
  
  output$corSq <- renderPrint({
    cor(x(),y())*cor(x(),y())
  })
  

  output$coeff1 <- renderText({
    mtModel <- lm(y() ~ x())
    round(mtModel$coefficients[1],2)
  })
  
  
  output$coeff2 <- renderText({
    mtModel <- lm(y() ~ x())
    round(mtModel$coefficients[2],2)
  })
  
  output$rsqrd <- renderText({
    mtModel <- lm(y() ~ x())
    mdlSum <- summary(mtModel)
    round(mdlSum$r.squared,2)
  })

}