#####################################################################################################
# Data Mutation
########################################################################################################
## Is used to add a new column to a data frame
## install.packages("dplyr")
library(dplyr)
head(mtcars)

mutate(mtcars, displ_l = disp / 61.0237)  # change of units
range(mtcars$wt)
mutate(mtcars, heavy = ifelse(wt > 3, "yes", "no"))
mutate(mtcars, hpPerWt = hp/wt)


###########################################################################################################
# Data Merging
###########################################################################################################
authors <- data.frame(
  surname = I(c("Tukey", "Venables", "Tierney", "Ripley", "McNeil")),
  nationality = c("US", "Australia", "US", "UK", "Australia"),
  deceased = c("yes", rep("no", 4)))

books <- data.frame(
  name = I(c("Tukey", "Venables", "Tierney",
             "Ripley", "Ripley", "McNeil", "R Core")),
  title = c("Exploratory Data Analysis",
            "Modern Applied Statistics ...",
            "LISP-STAT",
            "Spatial Statistics", "Stochastic Simulation",
            "Interactive Data Analysis",
            "An Introduction to R"),
  other.author = c(NA, "Ripley", NA, NA, NA, NA,
                   "Venables & Smith"))

authors
books

merge(authors, books, by.x = "surname", by.y = "name")
merge(authors, books, by.x = "surname", by.y = "name")


##########################################################################################################
#Data Reshaping
###########################################################################################################

## Data reshaping is just a rearrangement of the form of the data - it does not
## change the content of the dataset

## identifier variable: These help to identify the subject for which we took
## information on different characteristics

## Measured variable: These are those characteristics whose values we measured 
## for our subject of interest

## install.packages("reshape2")
library(reshape2)
names(airquality) <- tolower(names(airquality))
head(airquality)
nrow(airquality)

aqm <- melt(airquality, id=c("month", "day"), measure.vars = c("ozone", "temp"), 
            na.rm=TRUE)
head(aqm)

dcast(aqm, month + day ~ variable)
dcast(aqm, day + month ~ variable)
meanVal <- dcast(aqm, month ~ variable, mean) # monthly average

ggplot(meanVal) + aes(x=month, y= ozone, fill = factor(month)) + geom_bar(stat="identity")

## Advantage of melting. We can plot 2 histograms in 1 command
meanValm <- melt(meanVal, id = "month")
ggplot(meanValm) + aes(x=factor(month), y= value, fill = factor(month)) + 
  geom_bar(stat="identity") +
  facet_grid( . ~ variable)

########################################################################################################
# Missing Data
#######################################################################################################
#install.packages("mice")
#install.packages("VIM")
library(mice)
library(VIM) 

## Create data set with missing values
set.seed(2) 
miss_mtcars <- mtcars 

some_rows <- sample(1:nrow(miss_mtcars), 7) 
miss_mtcars$drat[some_rows] <- NA

some_rows <- sample(1:nrow(miss_mtcars), 5) 
miss_mtcars$mpg[some_rows] <- NA

some_rows <- sample(1:nrow(miss_mtcars), 5)
miss_mtcars$cyl[some_rows] <- NA

some_rows <- sample(1:nrow(miss_mtcars), 3) 
miss_mtcars$wt[some_rows] <- NA

some_rows <- sample(1:nrow(miss_mtcars), 3) 
miss_mtcars$vs[some_rows] <- NA 

only_automatic <- which(miss_mtcars$am==0) 
some_rows <- sample(only_automatic, 4) 
miss_mtcars$qsec[some_rows] <- NA

nrow(miss_mtcars)

## Visualization of the missing pattern
md.pattern(miss_mtcars) #  Cells with a 1 represent nonmissing data; 0s represent missing data.
mpattern <- md.pattern(miss_mtcars)
sum(as.numeric(row.names(mpattern)), na.rm = TRUE)

aggr(miss_mtcars, numbers=TRUE) # visualize the missing data pattern graphically 

## missing data imputation
## convert categorical variables into factors 

miss_mtcars$vs <- factor(miss_mtcars$vs) 
miss_mtcars$cyl <- factor(miss_mtcars$cyl)
imp <- mice(miss_mtcars, m=20, seed=3, printFlag=FALSE) 
imp$method 
imp$imp
imp$imp$mpg

## Creating lm model on the missing data
imp_models <- with(imp, lm(mpg ~ am + wt + qsec)) 
lapply(imp_models$analyses, coef)
pooled_model <- pool(imp_models)
summary(pooled_model) 
pooled_model

lm1 <- lm(mpg ~ am + wt + qsec, data = mtcars)
coef(lm1)



