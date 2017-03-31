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
## @deftypefn {Function File} {@var{retval} =} displayData_vero (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: Veronica Sharma <veronica@Veronicas-MacBook-Air.local>
## Created: 2017-03-08

%to display images from matrix data

function [h, display_array] = displayData_vero(X, example_width)
    
  %compute the row and column    
  [m, n] = size(X);
  
  if ~exist('example_width', 'var') || isempty(example_width)
    example_width = round(sqrt(n));        
  end

  %set gray as the current color map  
  colormap(gray);
  
  %set the example_height value
  example_height = round(n/example_width);
  
  %set the number of rows and columns to display
  display_row = ceil(sqrt(m));
  display_col = round(m/display_row);

  %set padding between images to 1
  pad = 1;
  
  %set the blank display array
  display_array = -ones(pad + display_row * (example_height + pad), ...
                      pad + display_col * (example_width + pad));

  curr = 1;
  for j=1:display_row
    for i=1:display_col
        if curr > m
          break;        
        end
        
        maxval = max(abs(X(curr, :)));
        display_array(pad + (j-1)*(example_height + pad) + (1:example_height), ...
                      pad + (i-1)*(example_width + pad) + (1:example_width)) = ...   
                  reshape(X(curr,:), example_height, example_width)/ maxval;
        
        curr = curr + 1;
    end  
    
    if curr > m
      break;
    end  
  end
  
  %returns the graphic handle 
  h = imagesc(display_array, [-1,1]);
  
  %do not show image axis
  axis image off;
  
  drawnow;
  
end