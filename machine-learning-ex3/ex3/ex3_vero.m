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
## @deftypefn {Function File} {@var{retval} =} ex3_vero (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: Veronica Sharma <veronica@Veronicas-MacBook-Air.local>
## Created: 2017-03-08

clc; close all; clear;

#apply logistic regression to calculate cost of n*n greyscale image

#load the file containing image data
load('ex3data1.mat');

%training set size
m = size(X,1);
%number of pixels or parameters of training set
input_layer_size = size(X,2);
%number of output labels
num_label=10;

fprintf('Loading and visualizing the training data\n');

%randomly select 100 rows from training set data to display
randIndex = randperm(m);
disp_data = X(randIndex(1:100), :);

displayData_vero(disp_data);
fprintf('Displayed data, press any key to continue \n');

pause;

%% Loading parameters 

load('ex3weights.mat');

%get the predicted value of each input example
pred = predict_vero(X, Theta1, Theta2);

%get the accuracy of the input data
trainedPred_accuracy = (mean(double(pred == y)))*100;

fprintf('Program paused. Press Enter to continue');
