##########################################
### Principal Component Analysis (PCA) ###
##########################################


library(ggfortify)
library(e1071)
library(class)
library(psych)
library(ggplot2)


names(wine) <- c("Type","Alcohol","Malic acid","Ash","Alcalinity of ash","Magnesium","Total phenols","Flavanoids","Nonflavanoid Phenols","Proanthocyanins","Color Intensity","Hue","Od280/od315 of diluted wines","Proline")
head(wine)

wine$Type <- as.factor(wine$Type)

wine <- wine[,-c(4,5,10)]

pairs.panels(wine[,-1],gap = 0,bg = c("red", "yellow", "blue")[wine$Type],pch=21)

wine.pc <- prcomp(wine[,-1], center = TRUE, scale. = TRUE)

attributes(wine.pc)
summary(wine.pc)
wine.pc$rotation

plot(wine.pc)

## using autoplot() function to plot the components
autoplot(wine.pc, data = wine, colour = 'Type',
         loadings = TRUE, loadings.colour = 'blue',
         loadings.label = TRUE, loadings.label.size = 3)

####The variables that most contribute to PC1 is Nonflavanoid Phenols, Malic Acid, and Color Intensity

#KNN model run on original dataset
#k as square root of total data points
k=13
knn.pred <- knn(train = wine[,-1], test = wine[,-1], cl = wine$Type, k = k)

## evaluate
cm <- table(Predicted=knn.pred, Actual = wine$Type, dnn=list('predicted','actual'))

cm

n = sum(cm) # number of instances
nc = nrow(cm) # number of classes
diag = diag(cm) # number of correctly classified instances per class 
rowsums = apply(cm, 1, sum) # number of instances per class
colsums = apply(cm, 2, sum) # number of predictions per class
p = rowsums / n # distribution of instances over the actual classes
q = colsums / n # distribution of instances over the predicted 

precision = diag / colsums 
recall = diag / rowsums 
f1 = 2 * precision * recall / (precision + recall) 

data.frame(recall, precision, f1)


#KNN model run on pca analysis
k=13
knn.pred <- knn(train = wine.pc$x[,c(1,2,3)], test = wine.pc$x[,c(1,2,3)], cl = wine$Type, k = k)

## evaluate
cm <- table(Predicted=knn.pred, Actual = wine$Type, dnn=list('predicted','actual'))

cm

n = sum(cm) # number of instances
nc = nrow(cm) # number of classes
diag = diag(cm) # number of correctly classified instances per class 
rowsums = apply(cm, 1, sum) # number of instances per class
colsums = apply(cm, 2, sum) # number of predictions per class
p = rowsums / n # distribution of instances over the actual classes
q = colsums / n # distribution of instances over the predicted 

precision = diag / colsums 
recall = diag / rowsums 
f1 = 2 * precision * recall / (precision + recall) 

data.frame(recall, precision, f1)

##identify the variable that least influences PC1, remove it, and rerun PCA

## using autoplot() function to plot the components
autoplot(wine.pc, data = wine, colour = 'Type',
         loadings = TRUE, loadings.colour = 'blue',
         loadings.label = TRUE, loadings.label.size = 3)

#variables that least affect PC1 are Flavanoids, Total phenols, and /od315 of diluted wines
View(wine)

# Remove least influential columns
wine <- wine[ , -c(5, 6, 10)]

pairs.panels(wine[,-1],gap = 0,bg = c("red", "yellow", "blue")[wine$Type],pch=21)

wine.pc <- prcomp(wine[,-1], center = TRUE, scale. = TRUE)

attributes(wine.pc)
summary(wine.pc)
wine.pc$rotation

plot(wine.pc)

## using autoplot() function to plot the components
autoplot(wine.pc, data = wine, colour = 'Type',
         loadings = TRUE, loadings.colour = 'blue',
         loadings.label = TRUE, loadings.label.size = 3)

#KNN model run on pca analysis
k=13
knn.pred <- knn(train = wine.pc$x[,c(1,2,3)], test = wine.pc$x[,c(1,2,3)], cl = wine$Type, k = k)

## evaluate
cm <- table(Predicted=knn.pred, Actual = wine$Type, dnn=list('predicted','actual'))

cm

n = sum(cm) # number of instances
nc = nrow(cm) # number of classes
diag = diag(cm) # number of correctly classified instances per class 
rowsums = apply(cm, 1, sum) # number of instances per class
colsums = apply(cm, 2, sum) # number of predictions per class
p = rowsums / n # distribution of instances over the actual classes
q = colsums / n # distribution of instances over the predicted 

precision = diag / colsums 
recall = diag / rowsums 
f1 = 2 * precision * recall / (precision + recall) 

data.frame(recall, precision, f1)
