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
## @deftypefn {Function File} {@var{retval} =} gradient_calculate (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: Veronica Sharma <veronica@Veronicas-Air>
## Created: 2017-03-16

%function to calculate the gradient that minimises the cost function 
function [J_history, theta] = gradient_calculate (X, y, theta, alpha, iterations)
  
  %define the parameters
  J_history = zeros(iterations, 1);
  m = length(X); 
  
  %iterate the loop 'iterations' times to get the minimised cost and appropriate parameters
  for iter = 1 : iterations
    
    %calculate the hypothesis
    htheta = X*theta;
    
    %calculate the theta vector
    theta1 = theta(1) - (alpha/m)*sum((htheta - y).*X(:,1));
    theta2 = theta(2) -  (alpha/m)*sum((htheta - y).*X(:,2));
    
    %assign changed values to theta vectors
    theta(1) = theta1;
    theta(2) = theta2;
    
    %calculate the cost by calling costFunction_LinearReg
    J_history(iter) = costFunction_LinearReg(X, y, theta);
    
  end
  
end
