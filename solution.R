## Challenge: download the boston housing dataset and save it under the name house

url <- "https://archive.ics.uci.edu/ml/machine-learning-databases/housing/housing.data"
house <- read.table(url, header = FALSE, sep = "", nrows = -1)
colnames(house) <-  c("CRIM", "ZN", "INDUS", "CHAS", "NOX", "RM", "AGE", "DIS", "RAD", "TAX", "PTRATIO", "B", "LSTAT",
  "MEDV") 
tail(house)

## Challenge: Find the mean value of mpg for each type of gears (3, 4, and 5) in
## mtcars dataset

head(mtcars)
mmc <- melt(mtcars, id = 'gear', measure.vars = 'mpg')
dcast(mmc, gear ~ variable, mean)

## Challenge: 
### 1. Plot Day vs Ozone data for airquality dataset
### 2. Use different colors for different months
### 3. Use different panels for different months

ggplot(airquality) + aes(x=Day, y = Ozone) + geom_point()
ggplot(airquality) + aes(x=Day, y = Ozone, col=factor(Month)) + geom_point()
ggplot(airquality) + aes(x=Day, y = Ozone) + geom_point() +
  facet_wrap (~ Month)

## Challenge: Find the mean of Sepal.Length, Sepal.Width, Petal.Length and Petal.Width in the 
## iris data set
### One line solution
lapply(iris[,1:4], mean)
sapply(iris[,1:4], mean)


### Calculating mean for each individual observation
mean(iris[,1])
mean(iris[,2])
mean(iris[,3])
mean(iris[,4])

## Challenge: Find the mean of Petal.Length for each species in iris data set
head(iris)

### using tapply
tapply(iris$Petal.Length, iris$Species, mean)

### using aggregate
aggregate(iris$Petal.Length, by = list(iris$Species), mean)

### using lapply and split
lapply(split(iris[,3], iris$Species), mean)


## Find the mean of all four lengths for each species in the iris data set

### Using aggregate
aggregate(iris[,1:4], by = list(iris$Species), mean)

### Using tapply
for (i in 1:4){
  print(colnames(iris)[i])
  print(tapply(iris[[i]], iris[[5]], mean))
}


# Build a linear model to predict the House Price in Boston

# Download the data set 
url <- "https://archive.ics.uci.edu/ml/machine-learning-databases/housing/housing.data"
boston <- read.table(url, header = FALSE, nrows = -1)
names(boston) <- c("CRIM", "ZN", "INDUS", "CHAS", "NOX", "RM", "AGE", "DIS", "RAD",
                   "TAX", "PTRATIO", "B", "LSTAT", "MEDV")

head(boston)

# Build the linear model (we want to predict MEDV using all other 
# variables)

m1 <- lm(MEDV ~ ., data = boston)

# Look at the parameters associated with the model. coefficients, r-squared value
names(m1)
names(summary(m1))
m1$coefficients
summary(m1)$r.squared

# Predict the model performace on the data that was used to build the model
pred <- predict(m1, newdata = boston)
data.frame(pred, boston$MEDV)

