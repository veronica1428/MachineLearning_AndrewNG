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
## @deftypefn {Function File} {@var{retval} =} myReadFile (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: Veronica Sharma <veronica@Veronicas-MacBook-Air.local>
## Created: 2017-02-11

%% user customised function to read file contents
%% function for practising matlab programming

function file_data = myReadFile (file_path)
  
  fprintf('Inside myReadFile function \n');
  file_path
  %open file connection
  fid = fopen(file_path);
  
  file_data = "";
  
  if(fid)
    file_data = textScan(fid, "%c", inf);
    fclose(fid);  
  else
    file_data = "";
    fprintf('Unable to open the file: %s\n', file_path);
  end

end
