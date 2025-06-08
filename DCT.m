function [D1, dicCol] = DCT(N, fs, dicFre)

freRes = fs / N;    
dicFre = dicFre / freRes;  

num_atoms = ceil(dicFre); 
dicCol = num_atoms; 

D1 = zeros(N, dicCol); 
t = 0:N-1; 
fres = zeros(1, dicCol); 

for i = 0:dicCol-1
    freq = i / N * fs;  
    D1(:, i + 1) = cos(2 * pi * freq / fs * t);  
    fres(i+1)=  freq;
end

for j = 1:dicCol
    D1(:, j) = D1(:, j) / norm(D1(:, j));  
end

end
