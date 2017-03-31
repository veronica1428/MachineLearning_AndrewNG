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
## @deftypefn {Function File} {@var{retval} =} ex1_vero (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: Veronica Sharma <veronica@Veronicas-MacBook-Air.local>
## Created: 2017-03-16

clc; close all; clear;

%file to implement linear regression algorithm from scratch

fprintf('Running Linear Regression Algorithm\n');

%load ex1data1.txt file 
data = load('ex1data1.txt');
%population and profit(or loss) data (column)
X = data(:,1); y = data(:,2);
%number of examples 
m = length(X);

%plot the X y data on a plane
fprintf('Plotting data.....');
plotData_vero(X, y);

pause;

%add additional column of x0 to the matrix X
X = [ones(length(X), 1), X];

%define variables
theta = zeros(2, 1); %theta0 and theta1
%theta(1) = 1; %value of theta0 is always equal to 1 by default
lambda = 0; %regularisation parameter
alpha = 0.01; %gradient descent learning parameter
iterations = 1500;

%calculate the cost of the whole training data
cost = costFunction_LinearReg(X, y, theta)

%calculate the gradient
[cost_history, theta] = gradient_calculate(X, y, theta, alpha, iterations);

fprintf('theta parameters are: ');
fprintf('%f %f \n', theta(1), theta(2));

fprintf('plotting hypothesis line on the plane...\n');
hold on;

plot(X(:,2), X*theta, '-');
hold off;

fprintf('press enter to continue...\n');
pause;

% Predict values for population sizes of 35,000 and 70,000
predict1 = [1 3.5]*theta;
predict2 = [1, 7]*theta;

fprintf('For population of size 35,000, we predict profit of %f \n', predict1*10000);
fprintf('For population of size 70,000, we predict profit of %f \n', predict2*10000);

%find different theta values 
theta1_val = linspace(-10, 10, 100);
theta2_val = linspace(-1, 4, 100);

mat = zeros(length(theta1_val)*length(theta2_val), 3);
count = 1;

%calculate cost for different theta values
J_val = zeros(length(theta1_val), length(theta2_val));

for i=1:length(theta1_val)
  for j=1:length(theta2_val)
    val = [theta1_val(i); theta2_val(j)];
    J_val(i,j) = costFunction_LinearReg(X, y, val);
    mat(count,:) = [theta1_val(i), theta2_val(j), J_val(i,j)];
    
    count = count + 1;
  end
end

%transporse J_val
J_val = J_val';

%plot the J_val against theta0 and theta1 values
figure; %open an empty figure page
surf(theta1_val, theta2_val, J_val);
xlabel('\theta_0'); ylabel('\theta_1');

%plot contour plot
figure;
contour(theta1_val, theta2_val, J_val, logspace(-2,3,20));
xlabel('theta_0'); ylabel('theta_1');
hold on;

plot(theta(1), theta(2), 'rx', 'MarkerSize', 10);


