function [rFreAxis,rSpectrum ]= plotSig(signal,fs,freMax,title0)
N = length(signal);
t = (0:N-1)/fs;
%freMax = floor(freMax/(fs/N));
%% time
figure;
subplot(2,1,1)
plot(t(1:end),signal(1:end),'k')
title(title0)

%%  AP
subplot(2,1,2)
f1 = 0; f2 = freMax;
spectrum = fft(signal); 
freAxis =fs/N:fs/N:fs/2;  lenFFT = N;
amp1=floor( f1* lenFFT/fs+1); amp2=floor(f2 * lenFFT/fs);
plot(freAxis(amp1:amp2),abs(spectrum(amp1:amp2) * 2 / N),'k');
xlim([1,freMax])
title("amplitude spectrum")
rFreAxis = freAxis(amp1:amp2);
rSpectrum = abs(spectrum(amp1:amp2) * 2 / N);




