############################################################################################################
# lapply and sapply
############################################################################################################
# returns a value for every member of the list after application of the supplied function
# remember the columns of a data frame are equivalent to a 

lapply(mtcars, mean)   # the function is applied to each individual column
unlist(lapply(mtcars, mean))  # simplify the result (convert to a vector)
sapply(mtcars, mean)

n <- ncol(mtcars)
for (i in 1:n){
  text <- sprintf( "%6s %4.2f",  colnames(mtcars)[i], mean(mtcars[[i]]))
  print(text, quote=FALSE)
}


lapply(mtcars, max)    # the function is applied to each individual column
unlist(lapply(mtcars, max)) # simplify the result (convert to a vector)
sapply(mtcars, max)


lapply(mtcars, range)
unlist(lapply(mtcars, range))
sapply(mtcars, range)

## Challenge: Find the mean of Sepal.Length, Sepal.Width, Petal.Length and Petal.Width in the 
## iris data set
head(iris)


##################################################################################################
# tapply and aggregate
##################################################################################################
# applies a function to each individual group of the data 

tapply(mtcars$mpg, mtcars$cyl, mean, simplify = TRUE)
tapply(mtcars$mpg, mtcars$am, mean, simplify = TRUE)

tapply(mtcars$mpg, list(mtcars$cyl, mtcars$am), mean)
tapply(mtcars$mpg, mtcars[,c(2,9)], mean)

aggregate(mtcars$mpg, list(mtcars$cyl), FUN=mean)
aggregate(mtcars$mpg, by=list(mtcars$cyl,mtcars$am), FUN=mean)

## Challenge: Find the mean of Petal.Length for each species in iris data set
## Find the mean of all four lengths for each species in the iris data set
head(iris)

######################################################################################################
# split
######################################################################################################
mpgCyl <- split(mtcars$mpg, mtcars$cyl)
mpgCyl

myFun <- function(x){
  sprintf("n = %3d, mean = %2.2f, sd = %2.2f",  length(x), mean(x), sd(x))
}

lapply(mpgCyl, myFun)




