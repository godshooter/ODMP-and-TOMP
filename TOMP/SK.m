function y_filtered = SK(signal, fs, level)
% SK - Spectral Kurtosis based band-pass filtering with kurtogram plotting
%
% Inputs:
%   signal - Input signal (column vector)
%   fs     - Sampling frequency (Hz)
%   level  - Decomposition level (recommended: 3 to 5)
%
% Output:
%   y_filtered - Band-pass filtered signal

   if nargin < 3
        level = 3;
    end

    signal = signal(:);

    try
        [Kmap, Kmax, Klevel, fc, bw] = kurtogram(signal', fs, level);
    catch ME
        error("Kurtogram computation failed: %s", ME.message);
    end

    figure('Color', 'white', 'Units', 'centimeters', 'Position', [10 8 12 6]);
    kurtogram(signal, fs, level);
    [~, ~, ~, fc, ~, bw] = kurtogram(signal', fs, level);

    set(gca, 'FontName', 'Times New Roman', 'FontSize', 9);
    xlabel('Frequency [kHz]', 'FontSize', 9, 'FontName', 'Times New Roman');
    ylabel('Decomposition Level', 'FontSize', 9, 'FontName', 'Times New Roman');
    title(sprintf('Spectral Kurtosis Map (Best Band: %.1f ± %.1f Hz)', fc, bw/2), ...
        'FontSize', 10, 'FontName', 'Times New Roman');
    hcb = colorbar;
    ylabel(hcb, 'Spectral Kurtosis', 'FontSize', 9, 'FontName', 'Times New Roman');
    set(hcb, 'FontName', 'Times New Roman', 'FontSize', 9);
    yticklabels({'0','1','1.6','2','2.6','3'})

    W_low = 2 * (fc - bw/2) / fs;
    W_high = 2 * (fc + bw/2) / fs;

    W_low = max(W_low, 0.001);
    W_high = min(W_high, 0.999);

    if W_low >= W_high
        warning("Invalid band: W_low >= W_high. Skipping filtering.");
        y_filtered = signal;
        return;
    end

    [b, a] = butter(4, [W_low, W_high], 'bandpass');
    y_filtered = filter(b, a, signal);

end