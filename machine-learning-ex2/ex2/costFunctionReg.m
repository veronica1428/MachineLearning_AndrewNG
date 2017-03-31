function [J, grad] = costFunctionReg(theta, X, y, lambda)
%COSTFUNCTIONREG Compute cost and gradient for logistic regression with regularization
%   J = COSTFUNCTIONREG(theta, X, y, lambda) computes the cost of using
%   theta as the parameter for regularized logistic regression and the
%   gradient of the cost w.r.t. to the parameters. 

% Initialize some useful values
m = length(y); % number of training examples

% You need to return the following variables correctly 
J = 0;
regularisation = 0;
grad = zeros(size(theta));

% ====================== YOUR CODE HERE ======================
% Instructions: Compute the cost of a particular choice of theta.
%               You should set J to the cost.
%               Compute the partial derivatives and set grad to the partial
%               derivatives of the cost w.r.t. each parameter in theta

%calculate the cost using regularization and without vectorisation
for i=1:m
  %% set the hypothesis
  hypoi = sigmoid(X(i,:)*theta);
  J = J + y(i,1)*log(hypoi) + (1-y(i,1))*log(1-hypoi);
end

J = (-1/m)*J;

for j=2:size(X,2)
  regularisation = regularisation + (lambda/(2*m))*(theta(j,1))^2;
end

J = J + regularisation;
  
%calculate the gradient with regularization and without vectorisation
for i=1:m
  htheta = sigmoid(X(i,:)*theta);
  grad(1,1) = grad(1,1) + (1/m)*(htheta - y(i,1))*X(i,1);
  for j=2:size(X,2)
    grad(j,1) = grad(j,1) + (1/m)*(htheta - y(i,1))*X(i,j);
  end
end    

for j=2:size(X,2)
  grad(j,1) = grad(j,1) + (lambda/m)*(theta(j,1));
end
  
% =============================================================

end
