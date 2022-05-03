function [A] = specialMatrix(n,m)
%This function creates a n by m matrix A with the following properties: 
% the value of each element in the first row is the number of the row, 
% the value of each element in the first column is the number of the row, 
% the rest of the elements each has a value equal to the sum of the element above it and the element to the left, 
% the function returns an error if the user does not input exactly two arguments.
%
% INPUTS:
%	- n: The number of rows in the matrix
%	- m: The number of columns in the matrix
% OUTPUTS:
%	- A: The matrix with the above properties

% Test if the user input exactly two arguments
test = nargin;
if test ~= 2
    error('This function requires two input arguments, n and m')
end

A = zeros(n,m); % create n x m array of zeros

% Create the special matrix
c = m;
while c >= 1 % while loop to create first row
    A(1,c) = c;
    c = c-1;
end

r = n; 
while r >= 1 % loop for first column
    A(r,1) = r;
    r = r-1;
end

row = 2;
for row = 2:n % nested loops to fill out remaining values
    col = 2;
    for col = 2:m
        A(row,col) = A(row-1,col)+A(row,col-1);
    end
end
       

end
% Things beyond here are outside of your function
