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
df1 <- data.frame(CustomerId = c(1:6), Product = c(rep("Toaster", 3), 
                                                   rep("Radio", 3)))
df2 <- data.frame(CustomerId = c(2, 4, 6, 7), State = c(rep("Alabama", 2),
                                                        rep("Ohio", 1), "Texas"))
df1
df2
merge(df1, df2, by = "CustomerId")  # inner join
merge(df2, df1, by = "CustomerId")  # inner join

merge(df1, df2, by = "CustomerId", all = TRUE)  # outer join
merge(df1, df2, by = "CustomerId", all.x = TRUE) # Left outer join
merge(df1, df2, by = "CustomerId", all.y = TRUE) # right outer join

df3 <- data.frame(id = c(2, 4, 6, 7), State = c(rep("Alabama", 2),
                                                rep("Ohio", 1), "Texas"))
merge(df1, df3, by.x="CustomerId", by.y = "id")

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
dcast(aqm, variable ~ month + day)
meanVal <- dcast(aqm, month ~ variable, mean) # monthly average
dcast(aqm, variable ~ month, mean)


library(ggplot2)
ggplot(meanVal) + aes(x=month, y= ozone, fill = factor(month)) + 
  geom_bar(stat="identity")

## Challenge: Find the mean value of mpg for each type of gears (3, 4, and 5) in
## mtcars dataset


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

## Dealing with missing data
### Complete case analysis
mean(miss_mtcars$mpg)
mean(miss_mtcars$mpg, na.rm = TRUE)

m1 <- lm(mpg ~ am + wt + qsec, data = miss_mtcars, na.action = na.omit)


### Missing Data Imputation
#### Mean Substitution
mean_sub <- miss_mtcars
mean_sub$qsec[is.na(mean_sub$qsec)] <- mean(mean_sub$qsec, na.rm = TRUE)


#### Multiple Imputation
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



