function [Dic] = LapDic(rawSignal, samplingFre, Ws, fre, dam)
% LapDic - Generate a Laplace wavelet dictionary 
%
% Syntax:
%   Dic = LapDic(rawSignal, samplingFre, Ws, fre, dam)
%
% Inputs:
%   rawSignal    - Input signal (1D vector)
%   samplingFre  - Sampling frequency (Hz)
%   Ws           - Wavelet support duration (in seconds)
%   fre          - Center frequency of the Laplace wavelet (Hz)
%   dam          - Damping ratio (0 < dam < 1)
%
% Output:
%   Dic          - Wavelet dictionary (each column is a Laplace wavelet shifted in time)


    % Basic time information
    blockSize = length(rawSignal);  % total number of samples
    t = 0:1/samplingFre:(blockSize - 1)/samplingFre;  % time vector

    % Use entire signal for wavelet segment
    waveletBlockSize = blockSize;
    windowedSignal = rawSignal(1:waveletBlockSize);

    % Preallocate wavelet and inner product vector
    lap = zeros(waveletBlockSize, 1);  % single wavelet container
    waveletT = t;                      % time shift positions for wavelet center
    waveletInners = zeros(1, length(waveletT));  % similarity scores
    Dic = [];  % wavelet dictionary

    % Precompute damping decay constant
    decay = dam / sqrt(1 - dam^2);

    % Construct wavelet dictionary by time-shifting
    for wt = 1:length(waveletT)
        for i = 1:waveletBlockSize
            if t(i) >= waveletT(wt) && t(i) < waveletT(wt) + Ws
                timeDiff = t(i) - waveletT(wt);
                lap(i) = exp(-decay * 2 * pi * fre * timeDiff) * sin(2 * pi * fre * timeDiff);
            else
                lap(i) = 0;  % outside wavelet support
            end
        end

        % Compute normalized correlation (optional analysis)
        waveletInners(wt) = abs(sum(lap .* windowedSignal)) / (norm(windowedSignal, 2) * norm(lap, 2));

        % Append wavelet to dictionary
        Dic = [Dic lap];
    end

    % Normalize each atom in the dictionary
    Dic = NormDict(Dic);
end
