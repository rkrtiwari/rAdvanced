##############################################################################
# We will make a decision tree model to predict the Species of a flower based
# on its sepal and petal measurement
##############################################################################

# 1. Load the required libraries
## install.packages("rpart")
## install.packages("rpart.plot")
library(rpart)  # library for decision tree
library(rpart.plot)  # For decision tree visualization


# 2. Understanding the data set
head(iris)
summary(iris)
str(iris)

col <- ifelse(iris$Species == "setosa", "red", 
              ifelse(iris$Species== "virginica", "green", "blue"))
plot(iris$Petal.Length, iris$Petal.Width, col = col, 
     xlab = "Petal Length", ylab = "Petal Width") 
legend(x=0.9,y=2.5, legend=c("Setosa", "Versicolor", "Virginica"),
       col = c("red", "blue", "green"), pch = 1, bty = "n")

# 3. Building the decision tree model
## 3.a Splitting the data set into training and testing data set
nr <- nrow(iris)
inTrain <- sample(1:nr, 0.6*nr)
train <- iris[inTrain,]
test <- iris[-inTrain, 1:4]
testClass <- iris[-inTrain, 5]

## 3.b Training the tree model
treeModel <- rpart(Species ~ ., data = train)
#treeModel <- rpart(Species ~ Petal.Width + Petal.Length, data = iris)
rpart.plot(treeModel)

## 3.c Making prediction with the tree model
test[1,]
predict(treeModel, test[1,], type = "class")
testClass[1]

predClass <-  predict(treeModel, test, type = "class")
predClass

## 4. Checking the accuracy of the model
mean(predClass == testClass) # % accuracy
table(predClass, testClass)  # Confusion Matrix
table(predClass)

## 5. Challenge
# Build a decision tree model to predict the House Price in Boston

#5.1 Download the data set 
url <- "https://archive.ics.uci.edu/ml/machine-learning-databases/housing/housing.data"
boston <- read.table(url, header = FALSE, nrows = -1)
names(boston) <- c("CRIM", "ZN", "INDUS", "CHAS", "NOX", "RM", "AGE", "DIS", "RAD",
                   "TAX", "PTRATIO", "B", "LSTAT", "MEDV")

head(boston)

# 5.2 Split the data into train (60%) and test (40%) set
nr <- nrow(boston)
set.seed(1)



# 5.3 Make the decision tree model (we want to predict MEDV using all other 
# variables)

tModel <-  # save the model as tModel 
rpart.plot(tModel)

# 5.4 Make the prediction


# 5.5 Access the model performance. Use root mean square value     


#########################################################################################################
# Random Forest
############################################################################################################
##install.packages("randomForest")

library(randomForest)
set.seed(1)
rfModel <- randomForest(Species ~ ., data=train, mtry=4, ntree=20)
predClass <- predict(rfModel, newdata = test)
table(predClass, testClass)
rfModel$importance 

