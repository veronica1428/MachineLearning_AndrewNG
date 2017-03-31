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
## @deftypefn {Function File} {@var{retval} =} predict_vero (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: Veronica Sharma <veronica@Veronicas-MacBook-Air.local>
## Created: 2017-03-09

%function to predict the image data using trained neural network (3 layer network)
function [p] = predict_vero(X, Theta1, Theta2)
  
  %set the number of neurons in each layer of the network
  hidden_layer_neurons = size(Theta1, 1);
  output_layer_neurons = size(Theta2, 1);
  
  %set bias column in input data
  X = [ones(size(X,1), 1), X];
  
  %number of examples in input data
  m = size(X,1);
  
  %set the size of user defined parameters
  a2 = zeros(m, hidden_layer_neurons);
  htheta = zeros(m, output_layer_neurons);
  p = zeros(m, 1);
  
  %find the value of activation function for layer2
  z = X*Theta1';
  a2 = sigmoid_vero(z);
   
  %add bias term in a2
  a2 = [ones(m,1), a2];
   
  %find the value of activation function for layer3
  z= a2*Theta2';
  htheta = sigmoid_vero(z);
   
  [maxval, p] = max(htheta, [], 2);
  
end