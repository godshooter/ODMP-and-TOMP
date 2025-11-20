function [A] = plotTimeEnv(t, signal, fs, maxFreq)
% plotTimeEnv - Plots time-domain signal and its envelope spectrum
%
% Syntax:  [A] = plotTimeEnv(t, signal, fs, maxFreq)
%
% Inputs:
%   t           - Time vector
%   signal      - Time-domain signal
%   fs          - Sampling frequency (Hz)
%   maxFreq     - Maximum frequency to display in envelope spectrum
%
% Output:
%   A           - Dummy return value (not used)

A = []; % Dummy output

figure('Color','white', 'Units','centimeters', 'Position',[10 10 10 6]);

% ----- Time-domain plot -----
subplot(2,1,1);
plot(t, signal, 'b', 'LineWidth', 1);
xlabel('Time / s', 'FontSize', 9, 'FontName', 'Times New Roman');
ylabel('Amplitude', 'FontSize', 9, 'FontName', 'Times New Roman');
set(gca, 'FontSize', 9, 'FontName', 'Times New Roman');
xlim([min(t), max(t)]);

% ----- Envelope spectrum plot -----
subplot(2,1,2);
[f1, a1] = EnvelSpec(signal, fs, maxFreq);
plot(f1, a1, 'b', 'LineWidth', 1);
xlabel('Frequency / Hz', 'FontSize', 9, 'FontName', 'Times New Roman');
ylabel('Amplitude', 'FontSize', 9, 'FontName', 'Times New Roman');
set(gca, 'FontSize', 9, 'FontName', 'Times New Roman');
xlim([0, maxFreq]);
ylim([0, 1.1 * max(a1)]);

end
