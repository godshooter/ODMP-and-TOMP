function [coeff]=ODM1(D,X,K)
%=============================================
% Orthogonal Dictionary Match Algorithm
% input arguments: 
%       D - the dictionary (its columns MUST be normalized).
%       X - the signals to represent
%       K- the max. number of coefficients for each signal.
% output arguments: 
%       coeff - sparse coefficient matrix.
%=============================================

[~,L]=size(D);
proj=D'*X;
[val, indx] = maxk(abs(proj), K);

%% result
temp = zeros(L,1);
temp(indx) = val;
coeff(:,1)=sparse(temp);

return;
