function [DP] = decode_extractTimeFreqTrialInfo(DP,data)



switch DP.dimension
    case {'eachElectrodeEachTime','eachElectrodeEachTimeEachFreq','eachElectrodeOneTimeEachFreq','eachElectrodeEachFreq','eachElectrodeMultiTimeMultiFreq'}
        
        switch DP.saveCategory
            case 'phase'
                [DP.nTime, DP.nFreq, DP.nTrials] = size(data.phase);
            case 'power'
                [DP.nTime, DP.nFreq, DP.nTrials] = size(data.power);
            case 'powerNorm'
                [DP.nTime, DP.nFreq, DP.nTrials] = size(data.powerNorm);
            case 'erp'
                [DP.nTime, DP.nFreq, DP.nTrials] = size(data.erp); %
                % here nFreq is used as nTimepoint. nTimepoint is the
                % size of the timewindow (movingwindow) used to
                % estimate phase/power, the number of samples
            case 'fft'
                [DP.nTime, DP.nFreq, DP.nTrials] = size(data.fft);
            case 'fftNonLinear'
                [DP.nTime, DP.nFreq, DP.nTrials] = size(data.fft);
            case {'pac','powerAndPhase'}
                [DP.nTime, DP.nFreqPhase, DP.nTrials] = size(data.phase);
                [~, DP.nFreqPower, ~] = size(data.power);
                switch DP.dimension
                    case 'pac'
                        DP.permute=1;
                    case 'powerAndPhase'
                end
        end
    case {'multiElectrodeEachTime','multiElectrodeEachFreq','multiElectrodeEachTimeEachFreq','multiElectrodeMultiTimeMultiFreq'}
        switch DP.saveCategory
            case 'phase'
                [DP.nChan, DP.nTime, DP.nFreq, DP.nTrials] = size(data.phase);
            case 'power'
                [DP.nChan, DP.nTime, DP.nFreq, DP.nTrials] = size(data.power);
            case 'powerNorm'
                [DP.nChan, DP.nTime, DP.nFreq, DP.nTrials] = size(data.powerNorm);
            case 'erp'
                [DP.nChan, DP.nTime, DP.nFreq, DP.nTrials] = size(data.erp); %
                % here nFreq is used as nTimepoint. nTimepoint is the
                % size of the timewindow (movingwindow) used to estimate phase/power
            case 'fft'
                [DP.nChan, DP.nTime, DP.nFreq, DP.nTrials] = size(data.fft);
            case 'fftNonLinear'
                [DP.nTime, DP.nFreq, DP.nTrials] = size(data.fft);
            case {'pac','powerAndPhase'}
                [DP.nChan, DP.nTime, DP.nFreqPhase, DP.nTrials] = size(data.phase);
                [~, ~, DP.nFreqPower, ~] = size(data.power);
                switch DP.dimension
                    case 'pac'
                        DP.permute=1;
                    case 'powerAndPhase'
                end
        end
        
end

