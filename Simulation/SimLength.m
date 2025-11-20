function [L, similarity] = simLength(V, A)
% SimLength - Find the minimal length to reach a target similarity
%
% Inputs:
%   V - Input vector (row or column)
%   A - Target similarity in percentage (0–100), e.g., A = 90 for 90%
%
% Outputs:
%   L - Minimum number of leading elements required to reach A% similarity
%   similarity - Actual similarity reached at length L

    V = V(:);                  % Ensure column vector
    N = length(V);
    target_similarity = A / 100;

    L = 0;
    similarity = 0;

    for i = 1:N
        V_cut = V;
        V_cut((i+1):end) = 0;  % Zero out elements after i
        sim = dot(V_cut, V) / (norm(V_cut) * norm(V));  % Cosine similarity

        if sim >= target_similarity
            L = i;
            similarity = sim;
            return;
        end
    end

    % If not found, default to full length (100% similarity)
    L = N;
    similarity = 1;
end
