library(ggplot2)

# 1. Line plot
ggplot(mtcars) + aes(x=wt, y = mpg) + geom_point()

# 2. Bar Plot
ggplot( mtcars, aes(x = factor( cyl))) + geom_bar(width = 0.5, color = "black", fill = "red")

# mean.mpg <- tapply(mtcars$mpg, mtcars$cyl, mean)
# mean.mpg
# names(mean.mpg)
# ggplot( mean.mpg, aes(x = factor( cyl), y = mean(mpg))) + 
#   geom_bar(stat = "identity", width = 0.5, color = "black", fill = "red")

# 3. Histogram
ggplot(mtcars, aes(x = mpg)) + geom_histogram(binwidth = 3, color = "black", fill = "red")

# 4. Boxplot
ggplot( mtcars, aes(x = factor( cyl), y = mpg)) + 
  geom_boxplot(width = 0.6, color = "black", fill = "red")

ggplot( mtcars, aes(x = cyl, y = mpg)) + 
  geom_boxplot(width = 0.9, color = "black", fill = "red")  

# 1. scatter plot
ggplot(mtcars) + aes(x=wt, y=mpg) + geom_point()

## Setting the size of the points in the scatter plot
ggplot(mtcars) + aes(x=wt, y=mpg) + geom_point(size=3)

## Setting the color of the points in the scatter plot
ggplot(mtcars) + aes(x=wt, y=mpg) + geom_point(size=3, color = "blue")

## Setting the shape of the points in the scatter plot
ggplot(mtcars) + aes(x=wt, y=mpg) + 
  geom_point(size=3, color = "blue", shape = 17)

# 2. Changing labels
ggplot(mtcars) + aes(x=wt, y=mpg) + geom_point() +
  labs(x = "Weight", y = "Miles per Gallon", title = "My Plot") +
  theme(axis.text = element_text(colour = "blue"),
        axis.title = element_text(size = rel(1.5), angle = 0),
        plot.title = element_text(size = rel(2.5), colour = "green"))
  
# 3. Changing x and y scale
ggplot(mtcars) + aes(x=wt, y=mpg) + geom_point() +
  scale_x_continuous(limits = c(1.5,6.5)) +
  scale_y_continuous(limits = c(5,35))


## 3. Grouping data points by variable
ggplot(mtcars) + aes(x=wt, y=mpg, color = cyl ) + 
  geom_point(size=3, shape = 17)

ggplot(mtcars) + aes(x=wt, y=mpg, color = factor(cyl) ) + 
  geom_point(size=3, shape = 17)

ggplot(mtcars) + aes(x=wt, y=mpg, color = factor(cyl), shape = factor(am)) + 
  geom_point(size=5)

ggplot(mtcars) + aes(x=wt, y=mpg, color = factor(cyl), shape = factor(am)) + 
  geom_point(size=5) + scale_shape_manual(values = c(4,5))

ggplot(mtcars) + aes(x=wt, y=mpg, color = factor(cyl), shape = factor(am)) + 
  geom_point(size=5) + scale_shape_manual(values = c(17,18)) +
  scale_color_brewer(palette = "Set1")

## 4. Adding trend line
ggplot(mtcars) + aes(x=wt, y=mpg) + 
  geom_point(size=3, color = "blue", shape = 17) +
  stat_smooth(method = "lm")

ggplot(mtcars) + aes(x=wt, y=mpg) + 
  geom_point(size=3, color = "blue", shape = 17) +
  stat_smooth(method = "lm", se = FALSE)


## Faceting 1
ggplot(mtcars) + aes(x=wt, y=mpg) + 
  geom_point(size=3, color = "blue", shape = 17) +
  facet_grid(. ~ cyl)

ggplot(mtcars) + aes(x=wt, y=mpg) + 
  geom_point(size=3, color = "blue", shape = 17) +
  facet_grid( cyl ~ .)

ggplot(mtcars) + aes(x=wt, y=mpg) + 
  geom_point(size=3, color = "blue", shape = 17) +
  facet_grid( cyl ~ am)

# Faceting 2
library(reshape2)
mmtcars <- melt(mtcars2, id = c("names", "wt", "hp"), measure.vars = "mpg")
mmtcars <- melt(mtcars, id = "mpg", measure.vars = c("wt", "hp", "qsec", "drat"))
head(mmtcars)
ggplot(mmtcars) + aes(x=value, y = mpg, color = variable) + geom_point(size = 3) +
  facet_wrap( ~ variable, scales = "free", ncol = 2)

## Faceting 3
aqm <- melt(airquality, id=c("month", "day"), measure.vars = c("ozone", "temp"), 
            na.rm=TRUE)
meanVal <- dcast(aqm, month ~ variable, mean)
meanValm <- melt(meanVal, id = "month")
ggplot(meanValm) + aes(x=factor(month), y= value, fill = factor(month)) + 
  geom_bar(stat="identity") +
  facet_grid( . ~ variable) +
  theme(axis.title = element_text(size = rel(1.5)),
        axis.text = element_text(size   = rel(1.5)),
        strip.text.x = element_text(size = rel(1.5)))


