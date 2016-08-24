library(shiny)

ui <- fluidPage(
  
  sidebarLayout(
    sidebarPanel(
      checkboxInput("sc", "Indicate Coefficient", value = FALSE),
      numericInput("ls", "Log lambda", -1, min = -6, max = 1, step = 0.1),
      numericInput("vn", "Variable Number", 4, min = 1, max = 10, step = 1)
    ),
    mainPanel(
      plotOutput("plot1"),
      h4(textOutput("text1"))
    )
  ))