function [A] = plotTimeEnv22(t, signal1, signal2, fs, maxFreq)

A = [];

figure('Color','white', 'Units','centimeters', 'Position',[8 8 16 10]);

%% -------- Subplots --------

% (a)
ax1 = subplot(2,2,1);
plot(t, signal1, 'b', 'LineWidth', 1);
xlabel('Time / s', 'FontSize', 9, 'FontName', 'Times New Roman');
ylabel('Amplitude', 'FontSize', 9, 'FontName', 'Times New Roman');
set(ax1,'FontSize',9,'FontName','Times New Roman');
xlim([min(t), max(t)]);

% (b)
ax2 = subplot(2,2,2);
plot(t, signal2, 'b', 'LineWidth', 1);
xlabel('Time / s', 'FontSize', 9, 'FontName', 'Times New Roman');
ylabel('Amplitude', 'FontSize', 9, 'FontName', 'Times New Roman');
set(ax2,'FontSize',9,'FontName','Times New Roman');
xlim([min(t), max(t)]);

% (c)
ax3 = subplot(2,2,3);
[f1, a1] = EnvelSpec(signal1, fs, maxFreq);
plot(f1, a1, 'b', 'LineWidth', 1);
xlabel('Frequency / Hz', 'FontSize', 9, 'FontName', 'Times New Roman');
ylabel('Amplitude', 'FontSize', 9, 'FontName', 'Times New Roman');
set(ax3,'FontSize',9,'FontName','Times New Roman');
xlim([0, maxFreq]);

% (d)
ax4 = subplot(2,2,4);
[f2, a2] = EnvelSpec(signal2, fs, maxFreq);
plot(f2, a2, 'b', 'LineWidth', 1);
xlabel('Frequency / Hz', 'FontSize', 9, 'FontName', 'Times New Roman');
ylabel('Amplitude', 'FontSize', 9, 'FontName', 'Times New Roman');
set(ax4,'FontSize',9,'FontName','Times New Roman');
xlim([0, maxFreq]);
ylim([0, 1.1 * max(a2)]);

%% -------- Add external labels at LEFT-TOP --------

addLabelLeft(ax1, '(a)');
addLabelLeft(ax2, '(b)');
addLabelLeft(ax3, '(c)');
addLabelLeft(ax4, '(d)');

end


%% Helper: place label at LEFT-TOP outside the axis
function addLabelLeft(ax, txt)
    pos = get(ax, 'Position');  % [x y w h]
    x = pos(1) - 0.055;         % shift to LEFT outside
    y = pos(2) + pos(4) - 0.02; % slightly below top edge
    annotation('textbox', [x y 0.05 0.05], ...
        'String', txt, ...
        'FontWeight','bold', ...
        'FontSize',10, ...
        'FontName','Times New Roman', ...
        'LineStyle', 'none');
end
