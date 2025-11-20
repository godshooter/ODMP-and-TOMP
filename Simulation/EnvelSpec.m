function [freq, amp] = EnvelSpec(signal, fs, maxFreq)
% ENVELSPEC - Plots the envelope spectrum of a signal
%
% Syntax:  [freq, amp] = EnvelSpec(signal, fs, maxFreq)
%
% Inputs:
%   signal   - Input time-domain signal
%   fs       - Sampling frequency (Hz)
%   maxFreq  - Max frequency (Hz) to plot
%
% Outputs:
%   freq     - Frequency vector
%   amp      - Envelope spectrum amplitude

% Hilbert envelope and FFT
env = abs(hilbert(signal));
fftResult = abs(fft(env));

N = length(fftResult);           % Number of FFT points
df = fs / N;                     % Frequency resolution
freq = (0:floor(N/2)-1) * df;    % Frequency vector (one-sided)
amp = 2 * fftResult(1:floor(N/2)) / N;  % Amplitude spectrum
amp(1) = 0;                      % Set DC component to 0

% Plot envelope spectrum
plot(freq, amp, 'LineWidth', 2);
xlim([0, maxFreq]);

end
