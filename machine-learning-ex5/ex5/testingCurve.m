function [error_train, error_cv, error_test] = testingCurve(X,y, Xval, yval, Xtest, ytest, lambda)

%calculate the theta term
theta = trainLinearReg(X, y, lambda);

%calculate the errors for training, cross validation and testing data sets
error_train = linearRegCostFunction(X, y, theta, 0);
error_cv = linearRegCostFunction(Xval, yval, theta, 0);
error_test = linearRegCostFunction(Xtest, ytest, theta, 0);

end %end of function