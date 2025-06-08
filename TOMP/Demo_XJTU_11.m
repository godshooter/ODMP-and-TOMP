clc;
clear;
close all;

%% Load signal
load XJTU_11_78.mat           % Load bearing fault signal
sig = data(1:20000,1);             % Extract first 20000 samples for analysis
fs = 25600;                   % Sampling frequency (Hz)

N = length(sig);              % Total signal length
T = 1/fs;                     % Sampling period
t = (0:N-1)*T;                % Time vector
K = 150;                      % Iteration

% Plot time-domain signal and envelope spectrum
plotTimeEnv(t, sig, fs, 600);    

%% Generate Laplace wavelet dictionary
fre = 4260; dam = 0.07;       % Set frequency and damping ratio
Lap = LapWav(fre, dam, N, fs);        % Construct one Laplace wavelet
simTarget = 99;  % Similarity threshold in percentage
[L, similarity] = SimLength(Lap, simTarget);  % Determine support length covering simTarget% similarity
Ws = L / fs;                          % Convert support length to time duration
fprintf("Selected maximum time interval Ws = %.6f s\n", Ws);
D = LapDic(sig, fs, Ws, fre, dam);    % Build Laplace wavelet dictionary

%% Reconstruct signal using OMP
tic;
A1 = OMP(D, sig, K);          % Sparse coding using Orthogonal Matching Pursuit
t1 = toc;
ss1 = D * A1;                 % Reconstructed signal
fprintf("Running time of OMP: %.6f s\n", t1);

% Plot reconstructed signal
plotTimeEnv(t, ss1, fs, 600); 
%% Reconstruct signal using TOMP (Temporal Orthogonal Matching Pursuit )
tic;
pWs = round(Ws * fs);   % Wavelet support in samples
A2 = TOMP(D, sig, K, pWs);  % Sparse coding using TOMP
t2 = toc;
ss2 = D * A2;                 % Reconstructed signal
fprintf("Running time of TOMP: %.6f s\n", t2);

% Plot reconstructed signal
plotTimeEnv(t, ss2, fs, 600); 

%%  Reconstruct signal using SK (fast Kurtogram)
level = 4;
y_filtered = SK(sig, fs, level);

% Plot reconstructed signal
plotTimeEnv(t, y_filtered, fs, 600);

