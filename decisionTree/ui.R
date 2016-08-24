library(shiny)

ui <- fluidPage( 
  
  fluidRow(
    column(12, h2('Decision Tree'), align = "center")
  ),
  
  sidebarLayout(
    sidebarPanel(
      numericInput("seed", "Seed", value = 1, min = 0, max = 1000),
      checkboxInput("predict", 
                    "Show prediction mechanism", value = FALSE),
      uiOutput("inputRange")
    ),
    
    mainPanel(
      fluidRow(column(10, h4('Data Set'), align = "left")),
      tableOutput("table"),
      fluidRow(column(10, h4('Corresponding Tree Model'), align = "left")),
      plotOutput("plot")
    )
  )   
)