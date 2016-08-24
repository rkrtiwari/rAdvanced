library(shiny)

ui <- fluidPage( 
  
  fluidRow(
    column(12, h2('Linear Regression'), align = "center")
  ),
  
  sidebarLayout(
    sidebarPanel(
      selectInput("var2", "y", names(mtcars), selected = "mpg"),
      selectInput("var1", "x", names(mtcars), selected = "wt"),
      checkboxInput("model", 
                    "Show the model", value = FALSE),
      checkboxInput("residual", 
                    "Show the residuals", value = FALSE),
     checkboxInput("predict", 
                   "Show prediction mechanism", value = FALSE),
      uiOutput("inputRange")
    ),
    
    mainPanel(
      plotOutput("plot"),
      
      fluidRow(
        column(8, h3("Model Parameters"))
      ),
      
      fluidRow(
        column(2, p("Intercept")),
        column(2, p("Slope")),
        column(4, p("R-squared"))
      ),
      
      fluidRow(
        column(2, textOutput("coeff1")),
        column(2, textOutput("coeff2")),
        column(4, textOutput("rsqrd"))
      ),
      
      fluidRow(
        column(8, h3("Model Prediction"))
      ),
      
      fluidRow(
        column(4, p("x")), 
        column(4, p("Predicted Value"))
      ),
      
     fluidRow(
       column(4, textOutput("xVal")),
       column(4, textOutput("yVal"))
     )
     

  )   ))