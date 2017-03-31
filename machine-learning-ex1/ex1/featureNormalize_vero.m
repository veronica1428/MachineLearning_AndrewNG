## Copyright (C) 2017 Veronica Sharma
## 
## This program is free software; you can redistribute it and/or modify it
## under the terms of the GNU General Public License as published by
## the Free Software Foundation; either version 3 of the License, or
## (at your option) any later version.
## 
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
## 
## You should have received a copy of the GNU General Public License
## along with this program.  If not, see <http://www.gnu.org/licenses/>.

## -*- texinfo -*- 
## @deftypefn {Function File} {@var{retval} =} featureNormalize_vero (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: Veronica Sharma <veronica@Veronicas-Air>
## Created: 2017-03-17


%function to normalize all the features in input matrix X
function [meanNorm, mu, sigma] = featureNormalize_vero(X)
  
  meanNorm = X;
  mu = zeros(1, size(X, 2));
  sigma = zeros(1, size(X, 2));
  
  %for every feature, calculate its mean and subtract the value of the feature by its mean
  %divide by the standard deviation or range of the feature
  for j=1:size(X, 2)
    %calculate the mean and standard deviation of the feature
    mu(j) = mean(X(:, j));
    sigma(j) = std(X(:, j));
    
    meanNorm(:, j) = (bsxfun(@minus, X(:, j), mu(j)))./sigma(j);
  end
  
end