function sim = SimEstiSeg(rawSignal, atom)


rawSignal = rawSignal(:);
atom = atom(:);

n = length(rawSignal);
L = length(atom);

atom = atom / (norm(atom) + eps);

sim = zeros(n,1);

for t = 1:n
    idx_end = min(t + L - 1, n);
    overlapLen = idx_end - t + 1;

    segment_slice = rawSignal(t:idx_end);
    atom_slice = atom(1:overlapLen);

    segment_norm = norm(segment_slice, 2);

    if segment_norm > eps
        sim_val = abs(segment_slice' * atom_slice) / segment_norm;

        sim(t) = sim_val * (overlapLen / L);
    else
        sim(t) = 0;
    end
end

end
