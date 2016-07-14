#generalized linear model
## Polynomial Regression

head(mtcars)

lm1 <- lm(mpg ~ wt, data = mtcars)
lm2 <- lm(mpg ~ poly(wt,2), data = mtcars)
lm3 <- lm(mpg ~ poly(wt,3), data = mtcars)
lm4 <- lm(mpg ~ poly(wt,4), data = mtcars)

anova(lm1,lm2,lm3,lm4)
# p value comparing the linear model 1 to quadratic model 2 is close to zero
# indicating that a linear fit is not sufficient. Model 3 and 4 are unnecessary
# as the p-values are very high

coef(summary(lm2))
max(mtcars$wt)
min(mtcars$wt)
wtGrid <- seq(1.5, 5.5, length.out = 50)
prediction <- predict(lm2, newdata = list(wt = wtGrid))
plot(x=mtcars$wt, y = mtcars$mpg, pch = 19, col= "blue", xlab = "wt", ylab = "mpg") 
points(x= wtGrid, y = prediction, type="l", col="green")

## Generalized additive model

drange <- range(mtcars$disp)
dispGrid <- seq(drange[1], drange[2], length.out = 50)
wtGrid <- seq(1.5, 5.5, length.out = 50)

library(gam) 
gam1 <- gam(mpg ~ s(wt,2) + disp, data = mtcars)
gam2 <- gam(mpg ~ s(wt,2) + s(disp,2), data = mtcars)
anova(gam1, gam2)
prediction1 <- predict(gam1, newdata = list(wt = wtGrid, disp = dispGrid))
prediction2 <- predict(gam2, newdata = list(wt = wtGrid, disp = dispGrid))
plot(x=mtcars$wt, y = mtcars$mpg, pch = 19, col= "blue", xlab = "wt", ylab = "mpg") 
points(x= wtGrid, y = prediction1, type="l", col="green")
points(x= wtGrid, y = prediction2, type="l", col="red")
