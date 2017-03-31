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
## @deftypefn {Function File} {@var{retval} =} costFunction_LinearReg (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: Veronica Sharma <veronica@Veronicas-Air>
## Created: 2017-03-16

%function to calculate the cost of the whole data
function [J] = costFunction_LinearReg(X, y, theta)
  
  J = 0;
 
  %calculate the hypothesis
  htheta = X*theta;
  %calculate the sq error 
  sq_error = (htheta - y).^2;
  
  %calculate the cost
  J = J + 1/(2*length(X))*sum(sq_error);
  
end