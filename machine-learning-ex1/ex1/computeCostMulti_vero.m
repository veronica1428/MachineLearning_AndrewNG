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
## @deftypefn {Function File} {@var{retval} =} computeCostMulti_vero (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: Veronica Sharma <veronica@Veronicas-Air>
## Created: 2017-03-17

%function to calculate the cost of the data having multiple variables
function [J] = computeCostMulti_vero(X, y, theta)
  
  %initialize the cost value
  J = 0;
  m = length(y);
  
  %calculate the hypothesis
  htheta = X*theta;
  
  %calculate the squared error
  sq_error = (htheta - y).^2;
  
  %calculate the cost involved
  J = J + (1/(2*m))*sum(sq_error);

end