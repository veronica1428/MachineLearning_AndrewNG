#quick and dirty implementation

#SIMPLE LINEAR REGRESSION (slr)

#house price prediction -- using linear regression

setwd("/Users/veronica/Documents/Octave/machine-learning-ex1/ex1")

#define libraries to be used
library("ggplot2")


#load the train csv file -- with univariate variable
data1 <- read.csv("ex1data1.txt", check.names = TRUE)
#set the names of the columns of input matrix
names(data1) <- c("Population", "Profit")
#check for classes
classData <- sapply(data1, class)

#retrieve predictor and target variable values
X <- as.matrix(data1[, 1])
y <- as.matrix(data1[, 2])

#plot the data of input and output variables
plot(X[,1], y[,1], 'p', xlab="Population", ylab="Profit")

#add bias to input vector X
X <- cbind(1, X)

#set col names of X and y
colnames(X) <- c("theta0", "Population")
colnames(y) <- c("Profit")

#set row names of X and y
rownames(X) <- as.integer(1:nrow(X))
rownames(y) <- as.integer(1:nrow(y))

#define parameters
alpha = 0.1
iterations = 1500
m <- nrow(X)
theta = matrix(data= 0, nrow = ncol(X), ncol = 1)

#calculate the initiall cost without gradient descent
#costvalue <- costfunction_slr(X, y , theta)

#calculate the gradients
J_iterations <- calculateGradients_slr(X, y, theta, alpha, iterations)

#plot htheta(decision boundary) over input points to 
#check for error graphically

#function to calculate gradients 
calculateGradients_slr <- function(X, y, theta, alpha, iterations){
       
        #initialize the gradient matrix
        J_val <- matrix(nrow=iterations, ncol=1, data=0)
        
        for (iter in iterations){
                
                htheta <- X %*% theta
                error <- (htheta - y)
                grad_temp <- matrix(data=0, nrow=nrow(theta), ncol=1)
                
                for (j in ncol(theta)){
                        grad_temp[j, ] <- theta[j,] - (alpha/m) %*% sum(t(error) %*% X[, j])
                }
                
                #after calculating current gradient descent for all the parameters
                theta <- grad_temp
                
                #get the cost using current theta parameter
                J_val[iter,] <- costfunction_slr(X, y, theta)
        }
        
        return (J_val)
}

#function to get the actual cost of the slr initially
costfunction_slr <- function(X, y, theta){
        
        #require("ggplot2")
        
        #initialise cost to zero value
        J = 0
        #find the hypothesis
        htheta <- X %*% theta
        #calculate squared error
        sq_error <- (htheta - y)^2
        J = J + (1/(2*m))*sum(sq_error)
        
        par(new=TRUE)
        plot(y[,1], htheta, 'l', xlab="Population", ylab="Profit")
        
        print(J)
        
        return (J)
}









#set the names of the columns of input matrix
names(data1) <- c("HouseSize", "NumberBedrooms", "Price")

#retrieve predictor and target variable values
X <- data1[, c(1,2)]
y <- data1[, 3]

#retrieve basic information of the data to analyse it easily
str(data1)
summary(data1)
sapply(data1, class)

#plot the data to see association between variables
#depicting linear positively associated relationship -- HouseSize and price
#depicting polynomial relationship -- NumberBedrooms and price
plot(data1)

#do univariate analysis
par(mfrow=c(2,2))
hist(X$HouseSize, breaks = 20) 
hist(X$NumberBedrooms, breaks = 20) 
boxplot(X$HouseSize)
boxplot(X$NumberBedrooms)

model <- lm(y ~ X)
summary(model)




