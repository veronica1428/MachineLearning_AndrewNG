function [J,grad] = nnCostFunction(nn_params, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, ...
                                   X, y, lambda)
%NNCOSTFUNCTION Implements the neural network cost function for a two layer
%neural network which performs classification
%   [J grad] = NNCOSTFUNCTON(nn_params, hidden_layer_size, num_labels, ...
%   X, y, lambda) computes the cost and gradient of the neural network. The
%   parameters for the neural network are "unrolled" into the vector
%   nn_params and need to be converted back into the weight matrices. 
% 
%   The returned parameter grad should be a "unrolled" vector of the
%   partial derivatives of the neural network.
%

% Reshape nn_params back into the parameters Theta1 and Theta2, the weight matrices
% for our 2 layer neural network
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));
                 
% Setup some useful variables
m = size(X, 1);
         
% You need to return the following variables correctly 
J = 0;
Theta1_grad = zeros(size(Theta1));
Theta2_grad = zeros(size(Theta2));
Col = zeros(size(y,1),num_labels); % of size "m*k"

% ====================== YOUR CODE HERE ======================
% Instructions: You should complete the code by working through the
%               following parts.
%
% Part 1: Feedforward the neural network and return the cost in the
%         variable J. After implementing Part 1, you can verify that your
%         cost function computation is correct by verifying the cost
%         computed in ex4.m

%declare variables
p = zeros(size(X, 1), 1); %indicates the index of maximum value for every example in hthetax
a2 = zeros(size(X,1), size(Theta1,1));
h = zeros(size(X,1), size(Theta2,1));
maxVal = zeros(size(X,1), 1); %gives the maximum index across a row in hthetax

%fill Col matrix with values of y for each example row
for i=1:m
  index = y(i,1);
  Col(i, index) = 1;
end

%add the bias unit values for every example = 1
X = [ones(m,1), X];

%calculate activations for hidden layer 
z = X*Theta1';
a2 = sigmoid(z);

%add the bias unit values for every example = 1
a2 = [ones(m,1),a2];

%calculate activations for output layer or hthetax
z = a2*Theta2';
h = sigmoid(z);

%hthetax for every row and index of maximum value
[maxVal, p] = max(h, [], 2);

%calculate the cost without regularization
%J = -((1/m)*sum(((Col.*log(h)) + (1-Col).*log(1-h))(:)))

%calculate the regularization parameters
Theta1_sq = sum((Theta1(:,2:size(Theta1,2)).^2)(:));
Theta2_sq = sum((Theta2(:,2:size(Theta2,2)).^2)(:));

%calculate the cost with regularization
J = -((1/m)*sum(((Col.*log(h)) + (1-Col).*log(1-h))(:)) ) + ...
                    (lambda/(2*m))*sum((Theta1_sq + Theta2_sq));

%cost without regularization
%J = -((1/m)*sum(((Col.*log(h)) + (1-Col).*log(1-h))(:)) ); 

 
%
% Part 2: Implement the backpropagation algorithm to compute the gradients
%         Theta1_grad and Theta2_grad. You should return the partial derivatives of
%         the cost function with respect to Theta1 and Theta2 in Theta1_grad and
%         Theta2_grad, respectively. After implementing Part 2, you can check
%         that your implementation is correct by running checkNNGradients
%
%         Note: The vector y passed into the function is a vector of labels
%               containing values from 1..K. You need to map this vector into a 
%               binary vector of 1's and 0's to be used with the neural network
%               cost function.
%
%         Hint: We recommend implementing backpropagation using a for-loop
%               over the training examples if you are implementing it for the 
%               first time.
%

%declare the variables
%delta3 = zeros(m,num_labels);
%delta2 = zeros(m,size(Theta1,1));

%implement forward propogation using loop 
%for every input example

for i=1:m
  %calculate 'z' and 'a' for second layer  
  z2i = X(i,:)*Theta1'; %vector of dimension -- 1*h
  a2i = sigmoid(z2i); %vector of dimension -- 1*h
  
  %calculate 'z' and 'hthetax' for third layer
  a2i = [1,a2i]; %add a bias term (dimension -- 1*(h+1))
  hthetaxi = sigmoid(a2i*Theta2'); %vector of dimension -- 1*k (k=number of classes)
  
  %find the value of hthetaxi
  [maxi, pi] = max(hthetaxi, [], 2);
  
  delta3 = hthetaxi - Col(i,:);
  
  delta2 = (delta3*Theta2).*sigmoidGradient([1,z2i]);
  delta2 = delta2(2:end); %removing the bias column
  
  Theta2_grad = Theta2_grad + (delta3)'*a2i;
  Theta1_grad = Theta1_grad + (delta2)'*X(i,:);  
  
end

%calculate the average gradient 
Theta1_grad = (1/m)*(Theta1_grad);
Theta2_grad = (1/m)*(Theta2_grad);


% Part 3: Implement regularization with the cost function and gradients.
%
%         Hint: You can implement this around the code for
%               backpropagation. That is, you can compute the gradients for
%               the regularization separately and then add them to Theta1_grad
%               and Theta2_grad from Part 2.
%

Theta1_grad(:,2:end) = Theta1_grad(:,2:end) + (lambda/m)*Theta1(:,2:end);
Theta2_grad(:,2:end) = Theta2_grad(:,2:end) + (lambda/m)*Theta2(:,2:end);

%randomly initialize

% -------------------------------------------------------------

% =========================================================================

% Unroll gradients
grad = [Theta1_grad(:) ; Theta2_grad(:)];

end
