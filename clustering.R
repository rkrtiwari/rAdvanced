#########################################################################################  
## Hierarchichal clustering
#########################################################################################

### Generate figure for hierarchichal clustering
set.seed(4)
index <- sample(c(TRUE, FALSE), nrow(iris), p = c(0.05, 0.95), replace = TRUE)
myIris <- iris[index,3:4]
species <- iris[index,5]
disM <- dist(myIris)
irisClust <- hclust(disM)

clusters <- cutree(irisClust, k = 3)
clusters <- ifelse(clusters==1, "setosa", ifelse(clusters==2, 
                                                 "versicolor", "virginica"))
clusters <- factor(clusters)
col <- ifelse(clusters == "setosa", "green", 
              ifelse(clusters=="versicolor", "red", "blue"))


par(mfrow = c(2,2), mar = c(5.1, 4.1, 4.1, 2.1))
#install.packages("sparcl")
library(sparcl)
ColorDendrogram(irisClust, y = col, labels = names(clusters), main = "Dendogram",   branchlength = 5, xlab = " ")
abline(h=1.5)

plot(myIris$Petal.Length, myIris$Petal.Width, pch = " ",
     xlab = "Petal.Length", ylab = "Petal.Width", cex.axis=1.3, cex.lab = 1.3)
text(myIris$Petal.Length, myIris$Petal.Width, labels = which(index==TRUE), 
     cex = 0.8, col = col)


plot(myIris$Petal.Length, myIris$Petal.Width, pch = 19, col = col,
     xlab = "Petal.Length", ylab = "Petal.Width", 
     cex.lab = 1.3, cex.axis=1.3, cex = 1.3, main = "Identified Groups")
#legend(x=1,y=2.7, legend = c("group1", "group2", "group3"), 
#       col = c("green", "red", "blue"), pch = 19, y.intersp=0.1, 
#       cex = 1.3, bty = "n")

col <- ifelse(species == "setosa", "green", 
              ifelse(species=="versicolor", "red", "blue"))
plot(myIris$Petal.Length, myIris$Petal.Width, pch = 17, col = col,
     xlab = "Petal.Length", ylab = "Petal.Width", cex.lab = 1.3, 
     cex.axis=1.3, cex = 1.3, main = "Actual Species")
legend(x=1,y=2.7, legend = c("setosa", "versicolor", "virginica"), 
       col = c("green", "red", "blue"), pch = 17, y.intersp=0.1, 
       cex = 1.3, bty = "n")

### data preprocessing for hierarchichal clustering. 
### Only 5% of the data have been used  for clustering. More data is not a problem for
### clustering algorithm but the visualization becomes extremely dense.
set.seed(4)
index <- sample(c(TRUE, FALSE), nrow(iris), p = c(0.05, 0.95), replace = TRUE)
myIris <- iris[index,3:4]
myIris

### Clustering done on a subset of iris data which is  named myIris
disM <- dist(myIris)
irisClust <- hclust(disM)
clusters <- cutree(irisClust, k = 3)
clusters
iris[index,5]


##########################################################################################
## kmeans clustering
##########################################################################################

### Generate the corresponding figure
set.seed(100)
index <- sample(c(TRUE, FALSE), nrow(iris), p = c(0.2, 0.8), replace = TRUE)
myIris <- iris[index,3:4]
group <- iris$Species[index]
set.seed(100)
predGroup <- kmeans(myIris, centers = 3, nstart = 10)
predGroupC <- ifelse(predGroup$cluster==1, "setosa", ifelse(predGroup$cluster==2, 
                                                            "versicolor", "virginnica"))
predGroupC <- factor(predGroupC)
table(predGroupC, group)

par(mfrow = c(1,2))
col <- ifelse(predGroupC == "setosa", "green", 
              ifelse(predGroupC=="versicolor", "red", "blue"))
plot(myIris$Petal.Length, myIris$Petal.Width, pch = 19, col = col, 
     xlab = "Petal.Length", ylab = "Petal.Width",
     main = "Identified Groups")
points(predGroup$centers, pch = 8, col = c("magenta"), cex = 1.2)
legend(x=1,y=2.5, legend = c("group1", "group2", "group3", "group centroid"), 
       col = c("green", "red", "blue", "magenta"), pch = c(19,19,19,8), 
       y.intersp=0.75, cex = 0.75,
       bty = "n")



col <- ifelse(group == "setosa", "green", ifelse(group=="versicolor", "red", "blue"))
plot(myIris$Petal.Length, myIris$Petal.Width, pch = 17, col = col,
     xlab = "Petal.Length", ylab = "Petal.Width",
     main = "Actual Species")
legend(x=1,y=2.5, legend = c("setosa", "versicolor", "virginica"), 
       col = c("green", "red", "blue"), pch = 17, y.intersp=0.75, cex = 0.75,
       bty = "n")
par(mfrow = c(1,1))

### Carry out kmeans clustering
set.seed(100)
index <- sample(c(TRUE, FALSE), nrow(iris), p = c(0.2, 0.8), replace = TRUE)
myIris <- iris[index,3:4]
group <- iris$Species[index]
set.seed(100)
predGroup <- kmeans(myIris, centers = 3, nstart = 10)
predGroupC <- ifelse(predGroup$cluster==2, "setosa", ifelse(predGroup$cluster==1, 
                                                            "versicolor", "virginnica"))
predGroupC <- factor(predGroupC)
table(predGroupC, group)


