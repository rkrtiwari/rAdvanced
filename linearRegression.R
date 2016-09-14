### Look at the  data set
head(mtcars)

### Build the linear model 
lmModel <- lm(mpg ~ wt, data = mtcars)

### Use the linear model to make prediction
predValue <- predict(lmModel, data.frame(wt = 3))
predValue
predValue <- predict(lmModel, data.frame(wt = c(3,4)))
predValue
predValue <- predict(lmModel, data.frame(wt = mtcars$wt))
predValue

### Access the model parameters
coef(lmModel)

### Model Performance assessment
sumModel <- summary(lmModel)
sumModel$r.squared
r <- cor(mtcars$mpg, mtcars$wt)
r^2      # r.squared is literally the r (correlation coefficient) squared

### Build models with  more than one predictors
lmModel2 <- lm(mpg ~ wt + hp + disp, data = mtcars) # wt, hp, and disp will be used as predictor
lmModel3  <- lm(mpg ~ ., data = mtcars)   # All the variables will be used

sumModel <- summary(lmModel2)
sumModel$r.squared

sumModel <- summary(lmModel3)
sumModel$r.squared

# Build a linear model to predict the House Price in Boston

# Download the data set 
url <- "https://archive.ics.uci.edu/ml/machine-learning-databases/housing/housing.data"
boston <- read.table(url, header = FALSE, nrows = -1)
names(boston) <- c("CRIM", "ZN", "INDUS", "CHAS", "NOX", "RM", "AGE", "DIS", "RAD",
                   "TAX", "PTRATIO", "B", "LSTAT", "MEDV")

head(boston)

# Build the linear model (we want to predict MEDV using all other 
# variables)

# Look at the parameters associated with the model. coefficients, r-squared value

# Predict the model performace on the data that was used to build the model


