function [C, sigma] = dataset3Params(X, y, Xval, yval)
%DATASET3PARAMS returns your choice of C and sigma for Part 3 of the exercise
%where you select the optimal (C, sigma) learning parameters to use for SVM
%with RBF kernel
%   [C, sigma] = DATASET3PARAMS(X, y, Xval, yval) returns your choice of C and 
%   sigma. You should complete this function to return the optimal C and 
%   sigma based on a cross-validation set.
%

% You need to return the following variables correctly.
%C = 1;
%sigma = 0.3;
val = [0.01, 0.03, 0.1, 0.3, 1, 3, 10, 30];
CMat = val(:);
sigmaMat = val(:);
x1 = [1;2;1]; x2 = [0;4;-1];
errorCV = zeros(length(val), length(val)); %matrix of size C*sigma -- 8*8, where 
%every row represent a particular "C" value and every column represents the sigma for that "C" 

% ====================== YOUR CODE HERE ======================
% Instructions: Fill in this function to return the optimal C and sigma
%               learning parameters found using the cross validation set.
%               You can use svmPredict to predict the labels on the cross
%               validation set. For example, 
%                   predictions = svmPredict(model, Xval);
%               will return the predictions on the cross validation set.
%
%  Note: You can compute the prediction error using 
%        mean(double(predictions ~= yval))
%

for i=1:length(val)
  for j=1:length(val)
  %form the model using the X and y training set
  model = svmTrain(X, y, CMat(i,1), @(x1, x2) gaussianKernel(x1, x2, sigmaMat(j,1)));
  %predict the labels for cross validation set
  predictions = svmPredict(model, Xval);

  %find the error in cross validation set -- misclassified examples
  errorCV(i,j) = mean(double(predictions ~= yval));
  
  end %end of loop j
end %end of loop i

% =========================================================================

errorCV
minMatrix = min(errorCV(:))
[CVal, sigmaVal] = find(errorCV == minMatrix)

C = CMat(CVal,1)
sigma = sigmaMat(sigmaVal, 1)

end
