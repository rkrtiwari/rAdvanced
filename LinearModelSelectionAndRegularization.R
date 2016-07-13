#install.packages("leaps")

## Forward selection model
library(leaps)
fwdSelection <- regsubsets(mpg ~ ., data = mtcars, method = "forward")
sumFwdSel <- summary(fwdSelection)
names(sumFwdSel)

sumFwdSel$outmat 
sumFwdSel$which[ind,]

ind <- which.max(sumFwdSel$adjr2)
ind
coef(fwdSelection, ind)

## Lasso model
library(glmnet)
x <- model.matrix(mpg ~ ., mtcars)[,-1] 
y <- mtcars$mpg

grid <- 10^seq(10,-2, length = 100)  # lambda values

lassoMod <- glmnet(x, y, alpha = 1,lambda = grid) # alpha = 0 (ridge)
dim(coef(lassoMod)) 


set.seed(1) 
train <- sample(1: nrow(x), nrow(x)/2) 
test <- (-train) 
yTest <- y[test]

cv.out <- cv.glmnet(x[train,],y[train], alpha=1, nfolds = 5) 
plot(cv.out) 
bestlam  <- cv.out$lambda.min 
lasso.pred <- predict(cv.out ,s=bestlam ,newx=x[test,]) 
mean((lasso.pred -yTest)^2) 








