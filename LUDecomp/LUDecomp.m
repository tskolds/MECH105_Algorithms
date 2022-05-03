function [L, U, P] = luFactor(A)
% luFactor performs LU decomposition on matrix A with pivoting if necessary
% INPUTS:
% - A: the coefficient matrix to be factored
% OUTPUTS:
% - L: lower triangular matrix
% - U: upper triangular matrix
% - P: the permutation (pivot) matrix

% Verify that matrix is square
[r,c] = size(A);
if r ~= c
    error('Matrix must be square')
end

% Make basic L, U, and P matrices
L = zeros(r);
U = A;
P = eye(r);

% For loop that is the meat of the function
for i = 1:(r-1)
    pivTest = max(abs(U(i:r,i)));
    if pivTest ~= U(i,i)
        pivot = 1;
        cTest = U(i:r,i);
        cTest = cTest';
        cTest = abs(cTest);
        if i == 1
            [M,cElement] = max(cTest);
        elseif i > 1
            [M,cElement] = max(cTest);
            cElement = cElement+(i-1);
        end
        prevU = U(i,:);
        U(i,:) = U(cElement,:);
        U(cElement,:) = prevU;
        prevP = P(i,:);
        P(i,:) = P(cElement,:);
        P(cElement,:) = prevP;
        multVal = U(i+1,i)/U(i,i);
        sub = U(i,:).*multVal;
        U(i+1,:) = U(i+1,:)-sub;
        L(i+1,i) = multVal;
        if i > 1
            for z = 1:(i-1)
                prevL = L(i,z);
                L(i,z) = L(cElement,z);
                L(cElement,z) = prevL;
            end
        end
        if sum(U(:,i)) ~= U(i,i)
            for z = (i+2):r
                multVal = U(z,i)/U(i,i);
                sub = U(i,:).*multVal;
                U(z,:) = U(z,:)-sub;
                L(z,i) = multVal;
            end
        end
    else
        pivot = 0;
        multVal = U(i+1,i)/U(i,i);
        sub = U(i,:).*multVal;
        U(i+1,:) = U(i+1,:)-sub;
        L(i+1,i) = multVal;
        if sum(U(:,i)) ~= U(i,i)
            for z = (i+2):r
                multVal = U(z,i)/U(i,i);
                sub = U(i,:).*multVal;
                U(z,:) = U(z,:)-sub;
                L(z,i) = multVal;
            end
        end
    end
end
    
for q = 1:c
    L(q,q) = 1;
end
           
end
