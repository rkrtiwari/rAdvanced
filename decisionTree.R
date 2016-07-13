## Look at the data set
iris[c(1,100,150),]

## Load the required libraries
library(rpart)
library(rpart.plot)

## create the tree model
## create data partition
set.seed(1)
inTrain <- sample(c(TRUE, FALSE), size = nrow(iris), replace = TRUE, prob = c(0.6,0.4))
trainData <- iris[inTrain,]
testData <- iris[!inTrain,1:4]
testClass <- iris[!inTrain,5]

## create the tree model and make prediction using the tree model
treeModel <- rpart(Species ~ ., data = trainData)
predClass <- predict(treeModel, newdata = testData, type = "class")

# Plot the tree
par(mfrow=c(1,1))
rpart.plot(treeModel, type = 0)

## Use the tree model to predict the class of the test data
predTrainClass <- predict(treeModel, newdata = trainData, type = "class")
predTrainClass
predTestClass <- predict(treeModel, newdata = testData, type = "class")
predTestClass

## Find out the performance of the decision tree
table(predTrainClass, trainData$Species)  # Confusion Matrix
mean(predTrainClass == trainData$Species) # Prediction Accuracy

table(predTestClass, testClass)           # Confusion Matrix
mean(predTestClass == testClass)          # Prediction accuracy      
