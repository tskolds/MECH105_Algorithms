function [root, fx, ea, iter] = falsePosition(func, xl, xu, es, maxit, varargin)
%falsePosition finds the root of a function using false-position method
% INPUTS:
% - func: The function to be analyzed
% - xl: The first guess at the root or left bracket
% - xu: The second guess at the root or the right bracket
% - es: The stopping criterion
% - maxit: The maximum number of allowed iterations
% OUTPUTS:
% - root: The root as found by the function
% - fx: The function value at the root
% - ea: The approximate relative error at this root
% - iter: The current iteration

% Define initial values
ea = 100;
xr = xl;
iter = 0;

% Test if the root is bracketed
if func(xl)*func(xu) >= 0 | nargin < 3
    error('Root is not bracketed')
end

% Create default es if none is provided
if nargin < 4
    es = 0.0001;
end

% Create default maxit if none is provided
if nargin < 5
    maxit = 200;
end

if nargin < 6
    varargin = 0;
end

% Perform the false-position method
xrold = xl;
while ea > es
    if func(xl) == 0
        xr = xl;
        ea = 0;
        break
    elseif func(xu) == 0
        xr = xu;
        ea = 0;
        break
    end
    xr = xu-((func(xu)*(xl-xu))/(func(xl)-func(xu)));
    ea = abs((xr-xrold)/xr)*100;
    xrold = xr;
    if func(xr)*func(xl) > 0
        xl = xr;
    else
        xu = xr;
    end
    if iter >= maxit
        break
    end
    iter = iter + 1;
end

% Define ending values
root = xr;
fx = func(root);
end
