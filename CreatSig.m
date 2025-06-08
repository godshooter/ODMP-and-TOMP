function [x,frequencies,amplitudes] = CreatSig(fs,N,num_components,max_freq )
t = (0:N-1) / fs; 
delta_f = fs / N;  

if max_freq / delta_f > 1
    frequencies = delta_f * randi([1, floor(max_freq / delta_f)], 1, num_components); 
else
    frequencies = delta_f * randi([ floor(max_freq / delta_f),1], 1, num_components) ;
end
amplitudes = randi([1, 10], 1, num_components);   

x = zeros(1, N);
for i = 1:num_components
    x = x + amplitudes(i) * cos(2 * pi * frequencies(i) * t); 
end
x = x';
