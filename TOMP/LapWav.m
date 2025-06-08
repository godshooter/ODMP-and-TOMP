function Lap = LapWav(fre, dam,N,fs)
% lap - Generate a Laplace wavelet with specified parameters
%
% Syntax:
%   Lap = lap(fre, dam, N, fs)
%
% Inputs:
%   fre - Central frequency of the Laplace wavelet (Hz)
%   dam - Damping ratio (0 < dam < 1)
%   N   - Length of the wavelet (number of samples)
%   fs  - Sampling frequency (Hz)
%
% Output:
%   Lap - A row vector containing the Laplace wavelet of length N

    t = (0:N-1) / fs;  % Time vector
    Lap = zeros(1, N); % Preallocate output

    for i = 1:N
        Lap(i) = exp(-dam/(sqrt(1 - dam^2)) * 2 * pi * fre * t(i)) ...
                * sin(2 * pi * fre * t(i));
    end
end