#########################################################################################  
## Hierarchichal clustering
#########################################################################################
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

#########################################################################################  
## k-means clustering
#########################################################################################
### data preprocessing for hierarchichal clustering. 
### Only 5% of the data have been used  for clustering. More data is not a problem for
### clustering algorithm but the visualization becomes extremely dense.

set.seed(100)
index <- sample(c(TRUE, FALSE), nrow(iris), p = c(0.2, 0.8), replace = TRUE)
myIris <- iris[index,3:4]
group <- iris$Species[index]
set.seed(100)
predGroup <- kmeans(myIris, centers = 3, nstart = 10)
predGroupC <- ifelse(predGroup$cluster==2, "setosa", 
                     ifelse(predGroup$cluster==1, "versicolor", "virginnica"))
predGroupC <- factor(predGroupC)
table(predGroupC, group)

