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

library(glmnet)
x <- model.matrix(mpg ~ ., mtcars)[,-1] 
y <- mtcars$mpg

set.seed(1) 
train <- sample(1: nrow(x), nrow(x)/2) 
test <- (-train) 
yTest <- y[test]

cv.out <- cv.glmnet(x[train,],y[train], alpha=1, nfolds = 5)   # alpha = 0 (lasso)
bestlam  <- cv.out$lambda.min 
lasso.pred <- predict(cv.out ,s=bestlam ,newx=x[test,]) 
mean((lasso.pred - yTest)^2) 

bestlam

lasso.pred <- predict(cv.out ,s=5 ,newx=x[test,]) 
mean((lasso.pred - yTest)^2)

lasso.pred <- predict(cv.out ,s=0.1 ,newx=x[test,]) 
mean((lasso.pred - yTest)^2)




