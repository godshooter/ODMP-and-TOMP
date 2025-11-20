%% simulation_full_process.m
% This file includes the complete simulation procedure used in the manuscript.
% Users may run this script to reproduce the full workflow, including signal
% synthesis, parameter identification, dictionary construction, and sparse
% reconstruction.
%
% Due to the randomness introduced by noise generation, the correlation-based
% parameter estimation may occasionally exhibit noticeable deviations. Such
% variations do not affect the validity of the overall workflow or the
% conclusions reported in the paper.


close all; clear;

%% ========== Basic parameter settings ==========
fs = 10000;                     % Sampling frequency
duration = 2;                   % Signal duration (seconds)
dampingRatio = 0.07;            % Damping ratio
pulseDuration = 0.02;           % Single impact duration (seconds)
jitterRange = pulseDuration * 0.1;
t = (0:1/fs:duration - 1/fs)';  % Time vector


%% ========== Generate periodic impact signal ==========
K_main = 15;                    % Number of periodic impacts
freq_main = 2000;              % Main impact frequency
amplitude = 1;

[sigMain, ~, ~, impactTimes] = CreatPeriodLap(fs, duration, dampingRatio, freq_main, K_main, amplitude, pulseDuration, jitterRange);

figure
plot(sigMain);

noise = normrnd(0, 0.4, length(t), 1);  
sig = sigMain' + noise;
N = length(sig);               % Total signal length

plotTimeEnv(t, sigMain, fs, 600);
plotTimeEnv(t, sig, fs, 600);

%% Parameter candidates
freqList = 1000:20:fs/2;
dampList = 0.05:0.01:0.08;
lapLen = pulseDuration * fs;

%% ========== Parameter search ==========
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

        % Update global optimum
        if score > bestScore
            bestScore = score;
            bestFreq = f;
            bestDamp = z;
        end

    end
end
t_param = toc;

fprintf('Best frequency from similarity = %.4f Hz\n', bestFreq);
fprintf('Best damping ratio = %.4f\n', bestDamp);
fprintf('Parameter search time = %.4f seconds\n', t_param);

%% ========== Dictionary construction ==========
tic;
Lap = LapWav(bestFreq, bestDamp, N, fs);   % Construct base Laplace wavelet
simTarget = 99;                            % Similarity threshold (%)
[L, similarity] = SimLength(Lap, simTarget); % Determine support length
Ws = L / fs;                               % Support length (seconds)
D = LapDic(sig', fs, Ws, bestFreq, bestDamp);  % Dictionary matrix
t_dic = toc;

fprintf('Dictionary construction time = %.4f seconds\n', t_dic);

%% ========== TOMP sparse reconstruction ==========
tic;
pWs = round(Ws * fs);          % Support length in samples
A2 = TOMP(D, sig, 30, pWs);    % Sparse coefficient solving
ss2 = D * A2;                  % Reconstructed signal
t_tomp = toc;

fprintf('TOMP reconstruction time = %.4f seconds\n', t_tomp);

plotTimeEnv(t, ss2, fs, 100);
