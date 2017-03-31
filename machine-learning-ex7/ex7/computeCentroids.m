function centroids = computeCentroids(X, idx, K)
%COMPUTECENTROIDS returns the new centroids by computing the means of the 
%data points assigned to each centroid.
%   centroids = COMPUTECENTROIDS(X, idx, K) returns the new centroids by 
%   computing the means of the data points assigned to each centroid. It is
%   given a dataset X where each row is a single data point, a vector
%   idx of centroid assignments (i.e. each entry in range [1..K]) for each
%   example, and K, the number of centroids. You should return a matrix
%   centroids, where each row of centroids is the mean of the data points
%   assigned to it.
%

% Useful variables
[m n] = size(X);

% You need to return the following variables correctly.
centroids = zeros(K, n);
meanPoint = zeros(1,size(X,2));


% ====================== YOUR CODE HERE ======================
% Instructions: Go over every centroid and compute mean of all points that
%               belong to it. Concretely, the row vector centroids(i, :)
%               should contain the mean of the data points assigned to
%               centroid i.
%
% Note: You can use a for-loop over the centroids to compute this.
%

%using loop version
%loop for all the cluster centroids
for i=1:K
  %get the indexes of the idx containing the cluster value 'i'
  indexI = find(idx == i);
  
  %calculate the mean of the points in 'X' indexed by 'indexI'
  for j=1:length(indexI)
    meanPoint = meanPoint + X(indexI(j), :);  
  end
  
  %calculate the average of all the points assigned to the cluster centroid 'i'
  meanPoint = (meanPoint)/length(indexI);
  
  centroids(i, :) = meanPoint;
  meanPoint = 0;
  
end

% =============================================================


end

