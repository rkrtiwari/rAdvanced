library(shiny)
library(rpart)
library(rpart.plot)

server <- function(input, output){
  
  output$table <- renderTable({(iris[c(1,60,110,150),])})
  
  output$plot <- renderPlot({  
    set.seed(input$seed)
    inTrain <- sample(c(TRUE, FALSE), size = nrow(iris), replace = TRUE, prob = c(0.6,0.4))
    trainData <- iris[inTrain,]
    testData <- iris[!inTrain,1:4]
    testClass <- iris[!inTrain,5]
    treeModel <- rpart(Species ~ ., data = trainData)
    result <- unlist(path.rpart(treeModel, nodes = 7))
    split1 <- strsplit(result, split = " ")[[2]]
    rule1 <- unlist(strsplit(split1, split = ">="))
    split2 <- strsplit(result, split = " ")[[3]]
    rule2 <- unlist(strsplit(split2, split = ">="))
    
    par(mfrow=c(1,2))
    rpart.plot(treeModel, type = 0)
    
    col <- ifelse(trainData$Species == "setosa", "red", 
                  ifelse(trainData$Species== "virginica", "green", "blue"))
    pty <- ifelse(trainData$Species == "setosa", 8, 
                  ifelse(trainData$Species== "virginica", 3, 4))
    xmax <- max(iris$Petal.Length)
    xmin <- min(iris$Petal.Length)
    
    ymax <- max(iris$Petal.Width)
    ymin <- min(iris$Petal.Width)
    
    plot(trainData$Petal.Length, trainData$Petal.Width, col = col, 
         pch = pty, xlab = "Petal Length", ylab = "Petal Width",
         cex=0.5, xlim = c(xmin, xmax), ylim = c(ymin, ymax))
    
    if(rule1[1]=="Petal.Length"){
      abline(v = as.numeric(rule1[2]))
    }
    
    if(rule1[1]=="Petal.Width"){
      abline(h = as.numeric(rule1[2]))
    }
    
    if(rule2[1]=="Petal.Length"){
      abline(v = as.numeric(rule2[2]))
    }
    
    if(rule2[1]=="Petal.Width"){
      segments(as.numeric(rule1[2]), as.numeric(rule2[2]), 
               7.2, as.numeric(rule2[2]))
    }
    
    legend(x=5.0,y=0.75, legend = c("setosa", "versicolor" , "virginica"), 
           col = c("red", "blue", "green"), 
           pch = c(8,4,3), cex = 0.75, bty = "n")
    
    if(input$predict) {
      testData <- iris[as.numeric(input$obsN),]
      testClass <- predict(treeModel, testData)
      col <- ifelse(testData[,5] == "setosa", "red", 
                    ifelse(testData[,5]== "virginica", "green", "blue"))
      points(testData$Petal.Length, testData$Petal.Width, col = col,
             pch = 11, cex = 1.5)
    }
    })
  
  output$inputRange <- renderUI({
    set.seed(input$seed)
    inTrain <- sample(c(TRUE, FALSE), size = nrow(iris), replace = TRUE, prob = c(0.6,0.4))
    testO <- which(inTrain == FALSE)
    selectInput("obsN", "Predict", choices = testO, selected = testO[1])
  })
  
}