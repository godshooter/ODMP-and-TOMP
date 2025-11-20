function D = NormDict( D, delta );
% NormDict normalizes a given dictionary
%  
% Usage:    D = NormDict( D, delta );
%           D = NormDict( D );
%
% Inputs:
%   D       non-normalized dictionary
%   delta   parameter, the discrete norm of D is multiplied by sqrt(delta) 
%           (default value is 1)  
% Outputs:
%   D       normalized dictionary
%
% Remark: It normalizes the columns of matrix D.

% See http://www.ncrg.aston.ac.uk/Projects/BiOrthog/ for more details
  
name='NORMDICT';
   
tol=1e-11;  
if nargin==1 delta=1;end  
N=size(D,2);

for i=1:N
  nor=norm(D(:,i))*sqrt(delta);
  if nor>tol 
    D(:,i)= D(:,i)/nor;
  else  
    fprintf('\n%s: Function with inner product equaled to %g found\n',name,nor); 
  end 
end


%Copyright (C) 2006 Miroslav ANDRLE and Laura REBOLLO-NEIRA
%
%This program is free software; you can redistribute it and/or modify it under the terms 
%of the GNU General Public License as published by the Free Software Foundation; either 
%version 2 of the License, or (at your option) any later version.
%
%This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
%without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
%See the GNU General Public License for more details.
%
%You should have received a copy of the GNU General Public License along with this program;
%if not, write to the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
%Boston, MA  02110-1301, USA.
