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
## @deftypefn {Function File} {@var{retval} =} mailsClassify (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: Veronica Sharma <veronica@Veronicas-MacBook-Air.local>
## Created: 2017-02-11

%%function [retval] = mailsClassify (input1, input2)
%%endfunction

%length of vocabulary
vocab_length = 1899;

%load the ham dataset
ham_path = fullfile(pwd, 'my_data', 'ham');
ham_files = dir(ham_path);
ham_vector = zeros(length(dir(ham_path)), vocab_length);

%loop through all the ham mails in ham folder
%pre process all the mails in the ham folder
count = 1;
for file = 1:length(ham_files)
  if (isdir(ham_files(file).name))
    continue;  
  end
  ham_files(file).name
  file_data = myReadFile(ham_files(file).name)
  word_indices = processEmail(file_data);
  ham_vector(count,:) = emailFeatures(word_indices);
  count = count + 1;
end

%load the spam dataset
spam_path = fullfile(pwd, 'my_data', 'spam');
spam_files = dir(spam_path);
spam_vector = zeros(length(dir(spam_path)), vocab_length);

%loop through all the spam mails in the spam folder
%pre process all the mails in the spam folder
count = 1;
for file = 1:length(spam_files)
  file_data = myReadFile(file);
  word_indices = processEmail(file_data);
  spam_vector(count, :) = emailFeatures(word_indices);
  count = count + 1;
end