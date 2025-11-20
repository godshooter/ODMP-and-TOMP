function [coeff] = TOMP(D, X, K, pWs)
% TOMP: Temporal Orthogonalized Matching Pursuit
%
% Inputs:
%   D     - Dictionary matrix (size: M × N)
%   X     - Input signal (column vector of length M)
%   K     - Sparsity level (number of atoms to select)
%   pWs  - Points in Wavelet support
%
% Output:
%   coeff - Sparse coefficient vector (length N), only K non-zero entries,
%           each corresponding to selected atoms with enforced separation
%
% Note:
%   This method is useful when dictionary atoms have temporal locality, such 
%   as Laplace or wavelet atoms shifted in time, and we want to avoid overlapping.

    [~, L] = size(D);         % L: number of atoms in dictionary
    indx = []; vals = [];     % Indices and values of selected atoms
    residual = X;             % Initialize residual
    proj = D' * residual;     % Initial projection

    sel_idx = [];             % Record of selected atom indices

    for i = 1:K
        if all(proj == 0)
            disp('All projections are zero. Early termination.');
            break;
        end

        [val, pos] = max(abs(proj));  % Find atom with maximum absolute correlation
        pos = pos(1);                 % Handle possible ties

        % Check if the selected atom is too close to any previously selected atoms
        if any(abs(pos - sel_idx) < pWs)
            proj(pos) = 0;            % Temporarily suppress this atom
            i = i - 1;                % Do not count this attempt
            continue;
        end

        % Suppress the region around the selected atom to prevent future selection
        end_idx = floor(min(pos + pWs, length(proj)));
        proj(pos:end_idx) = 0;

        indx(i) = pos;                % Store selected atom index
        vals(i) = val;                % Store projection value

        sel_idx = [sel_idx, pos];     % Update list of selected atom centers
    end

    %% Build sparse coefficient vector
    valid_mask = indx > 0 & indx <= L;     % Filter valid indices
    indx = indx(valid_mask);
    vals = vals(valid_mask);

    temp = zeros(L, 1);
    temp(indx) = vals;              % Assign values to selected atom positions
    coeff(:,1) = sparse(temp);      % Return sparse coefficient vector
end
