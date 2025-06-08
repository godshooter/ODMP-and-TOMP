function [coeff]=OMP(D,X,K)
%=============================================
% Orthogonal Matching Pursuit algorithm
% input arguments: 
%       D - the dictionary (its columns MUST be normalized).
%       X - the signals to represent
%       K- the max. number of coefficients for each signal.
% output arguments: 
%       coeff - sparse coefficient matrix.
%=============================================
%% Inititation
[~,L]=size(D);
residual=X;            
P=[]; 
indx=zeros(K,1); 
coeff = [];

%% Iteration
for i=1:1:K
    proj=D'*residual;   
    [~,pos]=max(abs(proj));    
    pos=pos(1);    
    indx(i)=pos;                
    P=pinv(D(:,indx(1:i)))*X;    
     %a=pinv(D(:,indx(1:j)))*x;  
    residual=X-D(:,indx(1:i))*P;    
end

%% result 
temp=zeros(L,1);
temp(indx(1:i))=P;
%temp(indx(1:i))=pinv;
coeff(:,1)=sparse(temp);

return;
