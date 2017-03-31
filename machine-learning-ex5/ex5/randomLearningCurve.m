function [error_train, error_val] = ...
    randomLearningCurve(X, y, Xval, yval, lambda)
%LEARNINGCURVE Generates the train and cross validation set errors needed 
%to plot a learning curve
%   [error_train, error_val] = ...
%       LEARNINGCURVE(X, y, Xval, yval, lambda) returns the train and
%       cross validation set errors for a learning curve. In particular, 
%       it returns two vectors of the same length - error_train and 
%       error_val. Then, error_train(i) contains the training error for
%       i examples (and similarly for error_val(i)).
%
%   In this function, you will compute the train and test errors for
%   dataset sizes from 1 up to m. In practice, when working with larger
%   datasets, you might want to do this in larger intervals.
%

% Number of training examples
m = size(X, 1);

% You need to return these values correctly
error_train = zeros(m, 1);
error_val   = zeros(m, 1);

epoch_size = 50;
error_train_epoch = zeros(1, epoch_size);
error_cv_epoch = zeros(1, epoch_size);


% ====================== YOUR CODE HERE ======================
% Instructions: Fill in this function to return training errors in 
%               error_train and the cross validation errors in error_val. 
%               i.e., error_train(i) and 
%               error_val(i) should give you the errors
%               obtained after training on i examples.
%
% Note: You should evaluate the training error on the first i training
%       examples (i.e., X(1:i, :) and y(1:i)).
%
%       For the cross-validation error, you should instead evaluate on
%       the _entire_ cross validation set (Xval and yval).
%
% Note: If you are using your cost function (linearRegCostFunction)
%       to compute the training and cross validation error, you should 
%       call the function with the lambda argument set to 0. 
%       Do note that you will still need to use lambda when running
%       the training to obtain the theta parameters.
%
% Hint: You can loop over the examples with the following:
%
%       for i = 1:m
%           % Compute train/cross validation errors using training examples 
%           % X(1:i, :) and y(1:i), storing the result in 
%           % error_train(i) and error_val(i)
%           ....
%           
%       end
%

% ---------------------- Sample Solution ----------------------

%declare the variables
trainError = zeros(size(m),1);
valSizeVector = zeros(size(m),1);
%thetaD = zeros(size(m),size(X,2));

%set a loop to find the theta, train error and cross validation error for different
%training set sizes
for i=1:m
  
  for j=1:epoch_size
    theta = trainLinearReg(X(1:i,:),y(1:i,1),lambda);
  
    randIndexTrain = randperm(size(X, 1));
    randIndexCV = randperm(size(Xval, 1));
    
    %calculate the theta value for different training set sizes
    %thetaD(i,:) = theta';
    error_train_epoch(1, j) = linearRegCostFunction(X(randIndex(1:i),:), y(randIndex(1:i),1), theta, 0);
  
    error_cv_epoch(1, j) = linearRegCostFunction(Xval, yval, theta, 0);
  
  end
  
  %calculate the training set error for different training set sizes
  %put lambda = 0  for error_train and error_val
  error_train(i,1) = mean(error_train_epoch);
  
  %calculate the cross validation error for different training set sizes
  error_val(i,1) = mean(error_cv_epoch);
end

% -------------------------------------------------------------

% =========================================================================

end