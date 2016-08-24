#install.packages("leaps")

## Forward selection model
##install.packages("leaps")

library(leaps)
fwdSelection <- regsubsets(mpg ~ ., data = mtcars, method = "forward")
sumFwdSel <- summary(fwdSelection)
names(sumFwdSel)

sumFwdSel$outmat 
ind <- which.max(sumFwdSel$adjr2)
ind
sumFwdSel$which[ind,]
coef(fwdSelection, ind)

## Lasso model
## install.packages("glmnet")

## Lasso model
## install.packages("glmnet")

library(glmnet)

## 1. Creating training and the test data set
x <- model.matrix(mpg ~ ., mtcars)[,-1] 
y <- mtcars$mpg

set.seed(1) 
inTrain <- sample(1: nrow(x), 0.6*nrow(x)) 
yTest <- y[-inTrain]

## 2. Model training
lModel <- glmnet(x[inTrain,],y[inTrain], alpha=1) # alpha = 0 (ridge)

## 3. Model Prediction
predV <- predict(lModel, newx = x[-inTrain,], s = 2)

## 4. Model visualization
plot(lModel, xvar = "lambda", label = TRUE, lwd =2, 
     cex.axis = 1.5, cex.lab = 1.5)
coef(lModel, s = exp(-1))
coef(lModel, s = exp(-1))[5]

## 5. Model Assesment
mean((predV - yTest)^2)

## 6. Finding the optimal value of lambda using cross-validation
cvModel <- cv.glmnet(x[train,],y[train], alpha=1, nfolds = 5) 
bestlam  <- cvModel$lambda.min 
cvpredV <- predict(cvModel, s=bestlam, newx=x[-inTrain,]) 
mean((cvpredV - yTest)^2) 

## 7. Variation of mean-squared error with the penalty parameter
plot(cvModel)




