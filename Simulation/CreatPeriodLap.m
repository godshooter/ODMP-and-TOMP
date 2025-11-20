function [signal, timeVec, numSamples, impactTimes] = CreatPeriodLap(fs, duration, dampingRatio, naturalFreq, K, amplitude, pulseDuration, jitterRange)

    numSamples = round(fs * duration);
    timeVec = (0:numSamples - 1) / fs;
    signal = zeros(size(timeVec));

    decayFactor = dampingRatio / sqrt(1 - dampingRatio^2);
    templateLen = round(pulseDuration * fs);
    tTemplate = (0:templateLen - 1) / fs;

    template = exp(-decayFactor * 2 * pi * naturalFreq * tTemplate) ...
             .* sin(2 * pi * naturalFreq * tTemplate);
    template = amplitude * template / max(abs(template));

    basePeriod = duration / K;

    impactTimes = zeros(1, K);
    for k = 1:K
        baseTime = (k - 1) * basePeriod;
        jitter = (2 * rand - 1) * jitterRange;  % [-jitterRange, +jitterRange]
        impactTimes(k) = baseTime + jitter;
    end

    impactTimes = max(0, min(duration, impactTimes));
    impactSamples = round(impactTimes * fs);

    for k = 1:K
        idx = impactSamples(k);
        if idx > 0 && idx + templateLen - 1 <= numSamples
            signal(idx : idx + templateLen - 1) = ...
                signal(idx : idx + templateLen - 1) + template;
        end
    end
end
