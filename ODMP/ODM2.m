function [coeff]=ODM2(D,X,targetError)
%=============================================
% Orthogonal Dictionary Match Algorithm
% input arguments: 
%       D - the dictionary (its columns MUST be normalized).
%       X - the signals to represent
%       K- the max. number of coefficients for each signal.
% output arguments: 
%       coeff - sparse coefficient matrix.
%=============================================
maxIter = 1000;
[~,L]=size(D);
indx = []; vals = [];
residual = X;
proj = D'*residual;
for i= 1:1:maxIter
    [val, pos] = max(abs(proj));
    pos = pos(1);
    proj(pos) = 0;
    indx(i) = pos;
    vals(i) = val;
    residual=X-D(:,indx(1:i))*vals';    
    if sum(residual.^2) < targetError
        break;
    end
end

%% result
temp = zeros(L,1);
temp(indx) = vals;
coeff(:,1)=sparse(temp);

return;
