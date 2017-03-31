function [J, grad] = linearRegCostFunction(X, y, theta, lambda)
%LINEARREGCOSTFUNCTION Compute cost and gradient for regularized linear 
%regression with multiple variables
%   [J, grad] = LINEARREGCOSTFUNCTION(X, y, theta, lambda) computes the 
%   cost of using theta as the parameter for linear regression to fit the 
%   data points in X and y. Returns the cost in J and the gradient in grad

% Initialize some useful values
m = length(y); % number of training examples

% You need to return the following variables correctly 
J = 0;
grad = zeros(size(theta));

% ====================== YOUR CODE HERE ======================
% Instructions: Compute the cost and gradient of regularized linear 
%               regression for a particular choice of theta.
%
%               You should set J to the cost and grad to the gradient.
%

%find the regularisation penalty
regCostParam = (lambda/(2*m))*(sum(theta(2:end,1).^2));

%calculate the predicted value for every example
hthetax = X*theta;

%calculate the overall cost
J = J + (1/(2*m))*(sum((hthetax-y).^2)) + regCostParam;

% =========================================================================

%calculate the gradient
for i=1:size(X,1)
  for j=1:size(theta,1)
    grad(j,1) =  grad(j,1) + (hthetax(i,1)-y(i,1))*X(i,j);
    
    %if(j > 1)
     % val = val + (lambda/m)*theta(j,1);
    %end
  end
end

grad = (1/m)*grad;

for j=2:size(theta,1)
  grad(j,1) = grad(j,1) + (lambda/m)*(theta(j,1));
end

grad = grad(:);

end
