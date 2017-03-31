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
## @deftypefn {Function File} {@var{retval} =} ex1_multiVero (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: Veronica Sharma <veronica@Veronicas-Air>
## Created: 2017-03-17

%file to implement the algorithm of Linear Regression with Multiple Variables
close all; clc; clear;

data = load('ex1data2.txt');

%set the variables
X = [data(:, 1), data(:, 2)];
y = data(:, 3);
m = length(y); %number of training examples

fprintf('Plotting the data... \n');

%plot the values of X on plane
plot(X(:, 1), X(:, 2), 'rx', 'MarkerSize', 10);
xlabel('Size of house'); ylabel('Number of bedrooms');

fprintf('Normalizing the features... \n');

%for feature scaling do not consider X0 and theta0
[X, mu, sigma] = featureNormalize_vero(X);

%add bias term to X
X = [ones(m, 1) X];

%define parameters
theta = zeros(size(X, 2), 1);

alpha = 1;
iterations = 400;

%apply gradient descent to find the best values of parameter theta
fprintf('Running gradient descent on multiple variables...\n');
[J_history, theta] = gradientDescent_multiVero(X, y, theta, alpha, iterations);
theta


%hold on;
%plot(y, htheta)
%hold off;

%plot cost with respect to number of iterations
figure;
plot(1:numel(J_history), J_history, '-b', 'LineWidth', 2);
xlabel('Number of iterations'); ylabel('Cost Value');

fprintf('Press enter to continue...\n');
pause;

predict1 = [1, 1650, 3]*theta; %calculated the htheta
fprintf('Predicted price for 1650 sq foot house and 3 bedrooms: %f \n', predict1);

%Data prediction using Normal Equation
fprintf('Solving for Normal Equation...\n');

data = csvread('ex1data2.txt');
X = data(:, 1:2);
y = data(:, 3);

X = [ones(length(y), 1), X];

theta_norm = NormalEquation_vero(X, y);
theta_norm

htheta_norm = X*theta_norm;

predict2 = [1, 1650, 3]*theta_norm;
predict2


