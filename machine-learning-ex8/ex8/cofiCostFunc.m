function [J, grad] = cofiCostFunc(params, Y, R, num_users, num_movies, ...
                                  num_features, lambda)
%COFICOSTFUNC Collaborative filtering cost function
%   [J, grad] = COFICOSTFUNC(params, Y, R, num_users, num_movies, ...
%   num_features, lambda) returns the cost and gradient for the
%   collaborative filtering problem.
%

% Unfold the U and W matrices from params
X = reshape(params(1:num_movies*num_features), num_movies, num_features);
Theta = reshape(params(num_movies*num_features+1:end), ...
                num_users, num_features);

            
% You need to return the following values correctly
J = 0;
X_grad = zeros(size(X));
Theta_grad = zeros(size(Theta));

% ====================== YOUR CODE HERE ======================
% Instructions: Compute the cost function and gradient for collaborative
%               filtering. Concretely, you should first implement the cost
%               function (without regularization) and make sure it is
%               matches our costs. After that, you should implement the 
%               gradient and use the checkCostFunction routine to check
%               that the gradient is correct. Finally, you should implement
%               regularization.
%
% Notes: X - num_movies  x num_features matrix of movie features
%        Theta - num_users  x num_features matrix of user features
%        Y - num_movies x num_users matrix of user ratings of movies
%        R - num_movies x num_users matrix, where R(i, j) = 1 if the 
%            i-th movie was rated by the j-th user
%
% You should set the following variables correctly:
%
%        X_grad - num_movies x num_features matrix, containing the 
%                 partial derivatives w.r.t. to each element of X
%        Theta_grad - num_users x num_features matrix, containing the 
%                     partial derivatives w.r.t. to each element of Theta
%

%calculate the cost function(vectorised)
sq_error = ((X*Theta' - Y).^2);
J = (sum(sum(R.*sq_error)));

regularise_users = sum(sum(Theta.^2,2));
regularise_movies = sum(sum(X.^2, 2));

J = (1/2)*(J + lambda*regularise_users + lambda*regularise_movies);

%calculate the cost function(non-vectorised) -- commented
%{
J_matrix = zeros(num_movies, num_users);
prediction = X*Theta';

for i=1:num_movies
  for j=1:num_users
    sq_error = (prediction(i,j) - Y(i,j))^2;  
    J_matrix(i,j) = R(i,j)*sq_error;
  end
end
%}

%J = (1/2)*sum(sum(J_matrix));

% =============================================================

%calculate the derivatives(non-vectorised) -- commented
%loop over all the movies 
%{
for i=1:num_movies
  %loop over all the features
  for k=1:num_features
    %loop over all the users rating for a single movie
    for j=1:num_users
      %if user rated the movie, then proceed else skip the user
      if R(i, j) == 1
        pred = X(i,:)*Theta(j,:)';
        X_grad(i,k) = X_grad(i,k) + (pred - Y(i, j))*Theta(j,k);
      end
    end
    
    X_grad(i, k) = X_grad(i,k) + lambda*X(i,k);
  end
end

%loop over all the users 
for j=1:num_users
  %loop over all the features
  for k=1:num_features
    %loop over all the movies rated by a single user
    for i=1:num_movies
      %if user rated the movie, then proceed else skip the movie
      if R(i, j) == 1
        pred = X(i,:)*Theta(j,:)';
        Theta_grad(j,k) = Theta_grad(j,k) + (pred - Y(i, j))*X(i,k);
      end
    end
    
    Theta_grad(j,k) = Theta_grad(j,k) + lambda*Theta(j,k);
  end
end
%}

%calculate the derivatives(vectorised)
%loop over all the movies
for i=1:num_movies
  %to find all users who rated for a single movie
  idx = find(R(i,:)==1);
  %if there is rating by at least a user
  if idx
    %create a Theta_temp matrix containing users who rated for that movie
    Theta_temp = Theta(idx,:);  
    %create a Y_temp matrix containing users for current movie only
    Y_temp = Y(i, idx);
    
    %find difference between prediction and actual rating given by user 
    diff = X(i,:)*Theta_temp' - Y_temp;
    X_grad(i,:) = diff*Theta_temp;
  end
end

X_grad = X_grad + lambda*X;

%loop over all the users
for j=1:num_users
  %to find all the movies rated by a single user
  idx = find(R(:,j) == 1);
  %if the idx is not empty or at least a movie has been rated by the user
  if idx
    %create a X_temp matrix containing all the movies rated by the user
    X_temp = X(idx, :);
    %create a Y_temp matrix containing all the moving rating by a single user
    Y_temp = Y(idx, j);
    
    %find the difference between prediction and actual rating by user
    diff = X_temp*Theta(j,:)' - Y_temp;
    Theta_grad(j,:) = diff'*X_temp;
  end
end

Theta_grad = Theta_grad + lambda*Theta;

grad = [X_grad(:); Theta_grad(:)];

end
