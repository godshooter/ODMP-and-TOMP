%% demo_sim.m  
% Simulation results reported in the manuscript
%
% This script loads the pre-generated simulation results used in the paper.
% Running this script will reproduce all figures and numerical results 
% without rerunning the entire simulation workflow.


close all; clear;

fs = 10000;                     % Sampling frequency
duration = 2;                  % Signal duration (seconds)
dampingRatio = 0.07;           % Damping ratio
pulseDuration = 0.02;          % Single impact duration (seconds)
t = (0:1/fs:duration - 1/fs)'; % Time vector

load pureSig
load wholeSig
pureSig = sigMain(:)';         % Pure signal
sig = sig(:)';                 % Measured/mixed signal
plotTimeEnv22(t, pureSig, sig, fs, 100)

N = length(sig);               % Total signal length

%% Parameter search
freqList = 1000:20:fs/2;       % Frequency candidates
dampList = 0.05:0.01:0.08;     % Damping ratio candidates
lapLen = pulseDuration * fs;   % Atom length in samples

bestScore = -inf;
bestFreq = NaN;
bestDamp = NaN;

tic;
for i = 1:length(freqList)
    for d = 1:length(dampList)

        f = freqList(i);
        z = dampList(d);

        atom = LapWav(f, z, lapLen, fs);   % Generate Laplace atom
        simVec = SimEstiSeg(sig, atom);    % Similarity curve (Nx1)

        score = max(simVec);               % Only need maximum similarity

        % Update global best
        if score > bestScore
            bestScore = score;
            bestFreq = f;
            bestDamp = z;
        end

    end
end
t_param = toc;

fprintf('Best frequency = %.4f\n', bestFreq);
fprintf('Best damping   = %.4f\n', bestDamp);
fprintf('Parameter search time = %.4f seconds\n', t_param);

%% Build dictionary
tic;
Lap = LapWav(bestFreq, bestDamp, N, fs);   % Construct one Laplace wavelet
simTarget = 99;                            % Similarity threshold %
[L, similarity] = SimLength(Lap, simTarget); % Get effective support length
Ws = L / fs;                               % Support length in seconds
D = LapDic(sig', fs, Ws, bestFreq, bestDamp); % Dictionary construction
t_dic = toc;

fprintf('Dictionary construction time = %.4f seconds\n', t_dic);

%% TOMP sparse reconstruction
tic;
pWs = round(Ws * fs);         % Wavelet support in samples
A2 = TOMP(D, sig', 30, pWs);  % Sparse coefficients
ss2 = D * A2;                 % Reconstructed signal
t_tomp = toc;

fprintf('TOMP reconstruction time = %.4f seconds\n', t_tomp);

plotTimeEnv(t, ss2, fs, 100);
