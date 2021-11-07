# Add-ons to TI0077 - L04

######### Basics ###########
# to install packages:
# install.packages("caret")
install.packages(c("caret", "e1071", "AppliedPredictiveModeling","ellipse", "corrplot","ILSR"),
                 dependencies = c("Depends", "Suggests"))
      
rm(list=ls())
getwd() # if required setwd('your path here')
options(digits=5) 

####### Spatial sign ########
library("caret") # Classification And REgression Training
set.seed(1)
n <- 10000
tmp <- data.frame(x=c(rnorm(n, 0, 0.02), -1, 1, 0.5),
                  y=c(rnorm(n, 0, 0.2), -1, 1, -2))

plot(tmp, asp=1, col=c(rep(1,n), 2, 3, 4), pch=19)
grid()
plot(spatialSign(tmp), asp=1, col=c(rep(1,n), 2, 3, 4), pch=19)
grid()
 
H <- c(9,15,25,14,10,18,0,16,5,19,16,20)
M <- c(39,56,93,61,50,75,32,85,42,70,66,80)
 
 plot(H,M)
 
 H.bar <- mean(H)
 M.bar <- mean(M)
 N <- length(H)

Cov <- (sum((H-H.bar)*(M-M.bar)))/(N-1) # cov(H,M)

#############  PCA example data ###########
## Source: A tutorial on Principal Components Analysis
## Get some data:
x <- c(2.5,0.5,2.2,1.9,3.1,2.3,2.0,1.0,1.5,1.1)
y <- c(2.4,0.7,2.9,2.2,3.0,2.7,1.6,1.1,1.6,0.9)

# Plot the data
plot(x,y,xlim=c(-1,4),ylim=c(-1,4)); abline(h=0,v=0,lty=3)

## subtract the mean and compute the covariance matrix (aka dispersion matrix)
xm <- x - mean(x)
ym <- y - mean(y)

# Plot the data
plot(xm,ym); abline(h=0,v=0,lty=3)

m <- matrix(c(xm,ym),ncol=2) # make a matrix of the given data
m

cov.m <- cov(m)
cov.m  # notice that the non-diagonal values are both positive, ie, x & y increase together

## find the eigenvectors and eigenvalues of the covariance matrix
cov.eig <- eigen(cov.m)
cov.eig

cov.eig$vectors[,1] %*% cov.eig$vectors[,2] # should equals zero since they are orthogonal between themselves

## Plot these eigenvectors onto the data to present the new basis
plot(xm,ym); abline(h=0,v=0,lty=3)

abline(a=0,b=(cov.eig$vectors[1,1]/cov.eig$vectors[2,1]),col="green")
abline(a=0,b=(cov.eig$vectors[1,2]/cov.eig$vectors[2,2]),col="blue")

# Note: The first eigenvector (red) seems like a linear fit showing us how it is 
# related to the data but the other eigenvector does not seem that related to the data
# If we look to the eigenvalues, the first is much larger than the second: 
# the highest eigenvalue identifies the dataset’s principle component.

# Once found the eigenvectors, we should order them decreasingly by their eigenvalues. 
# This give us the components by order of significance! 
# We can decide to ignore the components with less significance: 
# we will lose information but not that much if their values are small.

# So we start with a dataset of n dimensions, choose p components and get a new 
# dataset with p dimensions representing the original dataset. 
# This process of removing the less important axes can help reveal hidden, 
# simplified dynamics in high dimensional data. 
# This process is called dimensional reduction.

## Form the feature vector 
# Feature vector with just one component
feature.vector1 <- as.matrix(cov.eig$vectors[,1],ncol=1)  
feature.vector1

# Feature vector with both components
feature.vector2 <- as.matrix(cov.eig$vectors[,c(1,2)],ncol=2) 
feature.vector2

## Derive the new transformed dataset 
# With our feature vector we can derive the new transformed dataset.
# If M is the original dataset and F is the feature vector, 
# then the transpose for the new dataset if given by F_trasp × M_transp

# New dataset for feature vector 1
final1 <- t(feature.vector1) %*% t(m) 
final1

# New dataset for feature vector 2
final2 <- t(feature.vector2) %*% t(m) 
final2

# After the transformation, the data is 'decorrelated': 
# the covariance between the variables is zero:
cov(t(final2))

# final1 has 1 dimension
t(final1)

# final2 has 2 dimensions, we can plot it:
plot(final2[1,],final2[2,],ylim=c(-2,2));abline(h=0,v=0,lty=3)

# if we keep all eigenvectors, we can recover it by 100% (like in final2)
# If we keep 2 components, we can recover it by 100% (like in final2)
adjust.dataset2 <- t(feature.vector2 %*% final2)

adjust.dataset2[,1] <- adjust.dataset2[,1] + mean(x) 
adjust.dataset2[,2] <- adjust.dataset2[,2] + mean(y) 
adjust.dataset2

plot(adjust.dataset2[,1],adjust.dataset2[,2],xlim=c(-1,4),ylim=c(-1,4))
abline(h=0,v=0,lty=3)

# if we keep just some eigenvector (like final1), we do the same but cannot 
# expect the original information, just some degraded version:
adjust.dataset1 <- t(feature.vector1 %*% final1)

adjust.dataset1[,1] <- adjust.dataset1[,1] + mean(x) # re-add means
adjust.dataset1[,2] <- adjust.dataset1[,2] + mean(y)
adjust.dataset1

plot(adjust.dataset1[,1],adjust.dataset1[,2],xlim=c(-1,4),ylim=c(-1,4))
abline(h=0,v=0,lty=3)

########### Built-in functions ###########
# In R the library stats include prcomp() 
## prcomp() performs a principal components analysis on the given data matrix and 
# returns the results as an object of class prcomp.
df = data.frame(x=x, y=y)
# prcomp() does the mean centering (option center=TRUE)
# also it scales the variables so that all have unit variance (scale=TRUE). 
# This is necessary if the data has # different units (it uses correlation matrix). 
# In this case, the units are the same, and we like to have the same results as above (it uses covariance matrix):

pca.eg <- prcomp(df, center=TRUE, scale=FALSE) 
pca.eg # check the rotation attributes are equal to cov.eig above (except for the minus sign which is irrelevant)

plot(xm,ym); abline(h=0,v=0,lty=3)
abline(a=0,b=(pca.eg$rotation[1,1]/pca.eg$rotation[2,1]),col="red")
abline(a=0,b=(pca.eg$rotation[1,2]/pca.eg$rotation[2,2]),col="green")

summary(pca.eg)

par(mfrow=c(1,2))
plot(pca.eg)
# Samples are displayed as point labels, variables are displayed  as vectors
biplot(pca.eg) 

par(mfrow=c(1,1))
prcomp(df, scale=TRUE, tol=.2) 

# argument 'tol' receives a value indicating the magnitude below which 
# components should be omitted. Components are omitted if their standard 
# deviations are less than or equal to tol times the standard deviation of the first component.


######## ISLR example ##########
# Chapter 10 Lab 1: Principal Components Analysis
# Source: G. James et al., An Introduction to Statistical Learning: 
# with Applications in R, 2013
rm(list=ls())

states=row.names(USArrests)
states

names(USArrests)
apply(USArrests, 2, mean)
apply(USArrests, 2, var)
pr.out=prcomp(USArrests, scale=TRUE)
names(pr.out)
pr.out$center
pr.out$scale
pr.out$rotation
dim(pr.out$x)
biplot(pr.out, scale=0)
pr.out$rotation=-pr.out$rotation
pr.out$x=-pr.out$x
biplot(pr.out, scale=0)
pr.out$sdev
pr.var=pr.out$sdev^2
pr.var
pve=pr.var/sum(pr.var)
pve
plot(pve, xlab="Principal Component", 
     ylab="Proportion of Variance Explained", ylim=c(0,1),type='b')
plot(cumsum(pve), xlab="Principal Component", 
     ylab="Cumulative Proportion of Variance Explained", ylim=c(0,1),type='b')
# a=c(1,2,8,-3)
#cumsum(a)
