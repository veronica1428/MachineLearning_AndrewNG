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
## @deftypefn {Function File} {@var{retval} =} gradientDescent_multiVero (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: Veronica Sharma <veronica@Veronicas-Air>
## Created: 2017-03-17

%function to implement working of gradient descent on multiple variables
function [J_val, theta] = gradientDescent_multiVero(X, y, theta, alpha, iterations)
  
  J_val = zeros(iterations, 1);
  m = length(y);
  
  for iter=1:iterations
    
    %define parameters
    thetaN = zeros(size(X,2),1);
    
    %calculate the hypothesis
    htheta = X*theta;
    
    %for all the features in matrix X    
    for j=1:size(theta,1)
      thetaN(j) = theta(j) - (alpha/m)*(sum((htheta-y).*X(:,j)));
    end
    
    theta = thetaN;
    
    %calculate the cost using calculated current theta parameters value
    J_val(iter) = computeCostMulti_vero(X, y, theta);
    
  end
end
