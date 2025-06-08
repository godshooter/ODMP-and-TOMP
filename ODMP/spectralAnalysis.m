function [amp1, amp2,lenFFT,envSpectrum,freAxis] = spectralAnalysis(Signal, fre1, fre2, samplingFre)

envelopeSpectrum=hilbert(Signal);
amlitudeSpectrum=abs(envelopeSpectrum);

lenFFT= 2^nextpow2(length(amlitudeSpectrum));
amlitudeSpectrum=amlitudeSpectrum-mean(amlitudeSpectrum);
envSpectrum=fft(amlitudeSpectrum,lenFFT);
freAxis=samplingFre*(1:lenFFT/2-1)/lenFFT;

amp1=round(fre1 * lenFFT/samplingFre+1);
amp2=round(fre2 * lenFFT/samplingFre+1);
end