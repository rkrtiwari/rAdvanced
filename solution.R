## Challenge: download the boston housing dataset and save it under the name house

url <- "https://archive.ics.uci.edu/ml/machine-learning-databases/housing/housing.data"
house <- read.table(url, header = FALSE, sep = "", nrows = -1)
colnames(house) <-  c("CRIM", "ZN", "INDUS", "CHAS", "NOX", "RM", "AGE", "DIS", "RAD", "TAX", "PTRATIO", "B", "LSTAT",
  "MEDV") 
tail(house)

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


