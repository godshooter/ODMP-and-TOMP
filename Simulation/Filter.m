function [waveletInners,freqCorre] = Filter(rawSignal,Fs,Ws,freVec,damplingVec)

blockSize=length(rawSignal);%采样点数
t=0: 1/Fs : (blockSize-1)/Fs; %时间序列

waveletBlockSize = length(rawSignal);
windowedSignal=rawSignal(1:waveletBlockSize);
lap=zeros(waveletBlockSize,1);%小波

waveletT=0: 1/Fs : (blockSize-1)/Fs;
waveletInners = zeros(length(waveletT),length(freVec));
wavSim = zeros(length(freVec),length(damplingVec),length(damplingVec));

for f=1:length(freVec)
    for d=1:length(damplingVec)
        for wt=1:length(waveletT)
            for i=1:waveletBlockSize
                if t(i)>=waveletT(wt) && t(i)< waveletT(wt)+Ws
                    lap(i)=exp(-damplingVec(d)/(sqrt(1-damplingVec(d)^2))*2*pi*freVec(f)*((t(i)-waveletT(wt))))*(sin(2*pi*freVec(f)*(t(i)-waveletT(wt))));
                else
                    lap(i)=0;
                end
            end
                waveletInners(wt,f,d)=abs(sum(lap.*windowedSignal));
        end
        %waveletInners(wt,f,d)=abs(sum(lap.*windowedSignal))/(norm(windowedSignal,2)*norm(lap,2));
    end
    f
end
    [maxVal, linearIdx] = max(waveletInners(:));    % 找到整体最大值及其线性索引
    [rowIdx, colIdx] = ind2sub(size(waveletInners), linearIdx);  % 转换为行列索引
    freqIndex = colIdx;        % 这一列对应 freVec 的下标
    freqCorre = freVec(freqIndex);   % 对应的频率值


end