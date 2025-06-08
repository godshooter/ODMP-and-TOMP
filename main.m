clc
clear 
close all

fs = 25600;
N =30000;
num_components = 50;
dicFre = 12800; 
fRes = fs/N; 
plotFreMax = 12800;

%% Creat signal and Orthogonal dictionary
[sig,freqs,amps]=CreatSig(fs,N,num_components,plotFreMax);
plotSig(sig,fs,plotFreMax,"rawSig");
[D,dicCol] = DCT(N, fs,dicFre);


%% reconstruct the signal and compara the running time 
tic;
[A1]=OMP(D,sig,num_components);
t1 = toc;
ss1=D*A1;
plotSig(ss1,fs,plotFreMax,"OMP");

tic;
[A2]=ODM1(D,sig,num_components);
t2 = toc;
ss2=D*A2;
plotSig(ss2,fs,plotFreMax,"ODM1");

tic;
[A3]=ODM2(D,sig,1e-6);
t3 = toc;
ss2=D*A3;
[rFreAxis,rSpectrum ]= plotSig(ss2,fs,plotFreMax,"ODM2");

fprintf("The running time of the OMP algorithm : %.6f s \n",t1);
fprintf("The running time of the ODM1 algorithm : %.6f s \n",t2);
fprintf("The running time of the ODM2 algorithm : %.6f s \n",t3);