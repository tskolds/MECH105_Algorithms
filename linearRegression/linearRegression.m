function [fX, fY, slope, intercept, Rsquared] = linearRegression(x,y)
%linearRegression Computes the linear regression of a data set
%   Compute the linear regression based on inputs:
%     1. x: x-values for our data set
%     2. y: y-values for our data set
%
%   Outputs:
%     1. fX: x-values with outliers removed
%     2. fY: y-values with outliers removed
%     3. slope: slope from the linear regression y=mx+b
%     4. intercept: intercept from the linear regression y=mx+b
%     5. Rsquared: R^2, a.k.a. coefficient of determination

%Tim Skolds

% Check that there are enough inputs
if nargin ~= 2
    error('This function requires two inputs')
end

% Sorts the arrays
[fY, sortOrder] = sort(y);
fX = x(sortOrder);

% Finds the interquartile range
n = length(y)
Q1index = floor((n+1)/4);
Q3index = floor((3*n+3)/4);
Q1 = y(Q1index);
Q3 = y(Q3index);
IQR = Q3-Q1;

% Discard outliers
i = 1;
while i <= n
    if fY(i) < (Q1-(1.5*IQR)) | fY(i) > (Q3+(1.5*IQR))
        fY(i) = [];
        fX(i) = [];
        n = length(fY);
    else
        i = i+1;
    end
end

% Linear regression
SX = fX(1);
for i = 2:n
    SX = SX+fX(i);
end
SY = fY(1);
for i = 2:n
    SY = SY+fY(i);
end
SXY = 0;
for i = 1:n
    SXY = SXY+(fX(i)*fY(i));
end
SXsq1 = 0;
for i = 1:n
    SXsq1 = SXsq1+(fX(i))^2;
end
SXsq2 = SX^2;
Yavg = mean(fY);
Xavg = mean(fX);

n = length(fX);
slope = ((n*SXY)-(SX*SY))/((n*SXsq1)-SXsq2);
intercept = Yavg-(slope*Xavg);

% Rsquared
SStot = 0;
for i = 1:n
    SStot = SStot+(fY(i)-Yavg)^2;
end
f = @(x) (slope*x)+intercept;
SSres = 0;
for i = 1:n
    SSres = SSres+(fY(i)-f(fX(i)))^2;
end
Rsquared = 1-(SSres/SStot);



end
