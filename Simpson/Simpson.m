function [I] = Simpson(x, y)
% Simpson numerically evaluates the integral of a data set given by inputs x and y and uses the trapezoidal rule
% for the last interval if an odd number of intervals is detected.
% Inputs
%   x = the vector of equally spaced independent variable
%   y = the vector of function values with respect to x
% Outputs:
%   I = the numerical integral calculated

% Make sure the arrays are of the same length
testX = length(x);
testY = length(y);
if testX ~= testY
    error('Arrays x and y must be of the same length')
end

% Makes sure the arrays are equally spaced
checkSpace = x(2)-x(1);
for i = 3:length(x)
    if x(i)-x(i-1) ~= checkSpace
        error('Array x must consist of equally spaced values')
    end
end

% Warns the user if trapezoidal rule will be used over the last interval
n = length(x)-1;
testEven = (n/2);
if testEven-floor(testEven) ~= 0
    odd = 1;
    warning('Odd intervals require trapezoidal rule to be used over the last interval')
else
    odd = 0;
end

% Embedded loops that perform the integration
c = length(x);
a = x(c-1);
b = x(c);
h = (x(2)-x(1));
if odd == 0 && n > 1
    inner = y(1)+y(c);
    for i = 2:(c-1)
        testEven = (i/2);
        if testEven-floor(testEven) ~= 0
            inner = inner+(2*y(i));
        elseif testEven-floor(testEven) == 0
            inner = inner+(4*y(i));
        end
    end
    I = (h/3)*(inner);
elseif odd == 1 && n > 1
    inner = y(1)+y(c-1);
    for i = 2:(c-2)
        testEven = (i/2);
        if testEven-floor(testEven) ~= 0
            inner = inner+(2*y(i));
        elseif testEven-floor(testEven) == 0
            inner = inner+(4*y(i));
        end
    end
    trap = (b-a)*((y(c-1)+y(c))/2);
    I = ((h/3)*inner)+trap;
elseif odd == 1 && h == 1
    trap = (b-a)*((y(c-1)+y(c))/2);
    I = trap;
end


end
