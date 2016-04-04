function [DP] = decode_extractTimeFreqTrialInfo(DP,data)



switch DP.dimension
    case {'eachElectrodeEachTime','eachElectrodeEachTimeEachFreq','eachElectrodeOneTimeEachFreq','eachElectrodeEachFreq'}
        
        if ~DP.multipleTimeWindow
            switch DP.saveCategory
                case 'phase'
                    [DP.nTime, DP.nFreq, DP.nTrials] = size(data.phase);
                case 'power'
                    [DP.nTime, DP.nFreq, DP.nTrials] = size(data.power);
                case 'logPower'
                    [DP.nTime, DP.nFreq, DP.nTrials] = size(data.logPower);
                case 'logPowerPlus1'
                    [DP.nTime, DP.nFreq, DP.nTrials] = size(data.logPowerPlus1);
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
                case {'logPac','logPowerAndPhase'}
                    [DP.nTime, DP.nFreqPhase, DP.nTrials] = size(data.phase);
                    [~, DP.nFreqPower, ~] = size(data.logPower);
                    switch DP.dimension
                        case 'pac'
                            DP.permute=1;
                        case 'powerAndPhase'
                    end
                case {'logPlus1Pac','logPowerPlus1AndPhase'}
                    [DP.nTime, DP.nFreqPhase, DP.nTrials] = size(data.phase);
                    [~, DP.nFreqPower, ~] = size(data.logPowerPlus1);
                    switch DP.dimension
                        case 'pac'
                            DP.permute=1;
                        case 'powerAndPhase'
                    end
            end
        else
            switch DP.saveCategory
                case 'phase'
                    [DP.nTime, DP.timeWin, DP.nFreq, DP.nTrials] = size(data.phase);
                case 'power'
                    [DP.nTime, DP.timeWin, DP.nFreq, DP.nTrials] = size(data.power);
                case 'logPower'
                    [DP.nTime, DP.timeWin, DP.nFreq, DP.nTrials] = size(data.logPower);
                case 'logPowerPlus1'
                    [DP.nTime, DP.timeWin, DP.nFreq, DP.nTrials] = size(data.logPowerPlus1);
                case 'fft'
                    [DP.nTime, DP.timeWin, DP.nFreq, DP.nTrials] = size(data.fft);
                case 'erp'
                    [DP.nTime, DP.timeWin, DP.nFreq, DP.nTrials] = size(data.erp);%nFreq here used as timepoint features
                case 'fftNonLinear'
                    [DP.nTime, DP.timeWin, DP.nFreq, DP.nTrials] = size(data.fft);
                case 'pac'
                    [DP.nTime, DP.nffPhase, DP.nTrials] = size(data.phase);
                    [~, ~, DP.timeWin, DP.nffPower, ~] = size(data.power);
                    DP.permute=1;
                case 'powerAndPhase'
                    [DP.nTime, DP.timeWinPhase, DP.nFreq, DP.nTrials] = size(data.phase);
                    [~, DP.timeWinPower, DP.nFreqPower, ~] = size(data.power);
                case 'logPowerAndPhase'
                    [DP.nTime, DP.timeWinPhase, DP.nFreq, DP.nTrials] = size(data.phase);
                    [~, DP.timeWinPower, DP.nFreqPower, ~] = size(data.logPower);
                case 'logPowerplus1AndPhase'
                    [DP.nTime, DP.timeWinPhase, DP.nFreq, DP.nTrials] = size(data.phase);
                    [~, DP.timeWinPower, DP.nFreqPower, ~] = size(data.logPowerPlus1);
            end
        end
    case {'allElectrodeEachTime','allElectrodeEachFreq','allElectrodeEachTimeEachFreq'}
        if ~DP.multipleTimeWindow
            switch DP.saveCategory
                case 'phase'
                    [DP.nChan, DP.nTime, DP.nFreq, DP.nTrials] = size(data.phase);
                case 'power'
                    [DP.nChan, DP.nTime, DP.nFreq, DP.nTrials] = size(data.power);
                case 'logPower'
                    [DP.nChan, DP.nTime, DP.nFreq, DP.nTrials] = size(data.logPower);
                case 'logPowerPlus1'
                    [DP.nChan, DP.nTime, DP.nFreq, DP.nTrials] = size(data.logPowerPlus1);
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
                case {'logPac','logPowerAndPhase'}
                    [DP.nChan, DP.nTime, DP.nFreqPhase, DP.nTrials] = size(data.phase);
                    [~, ~, DP.nFreqPower, ~] = size(data.logPower);
                    switch DP.dimension
                        case 'logPac'
                            DP.permute=1;
                        case 'logPowerAndPhase'
                    end
                case {'logPlus1Pac','logPowerPlus1AndPhase'}
                    [DP.nChan, DP.nTime, DP.nFreqPhase, DP.nTrials] = size(data.phase);
                    [~, ~, DP.nFreqPower, ~] = size(data.logPowerPlus1);
                    switch DP.dimension
                        case 'logPac'
                            DP.permute=1;
                        case 'logPowerAndPhase'
                    end
            end
        else
            switch DP.saveCategory
                case 'phase'
                    [DP.nChan, DP.nTime, DP.timeWin, DP.nFreq, DP.nTrials] = size(data.phase);
                case 'power'
                    [DP.nChan, DP.nTime, DP.timeWin, DP.nFreq, DP.nTrials] = size(data.power);
                case 'logPower'
                    [DP.nChan, DP.nTime, DP.timeWin, DP.nFreq, DP.nTrials] = size(data.logPower);
                case 'logPowerPlus1'
                    [DP.nChan, DP.nTime, DP.timeWin, DP.nFreq, DP.nTrials] = size(data.logPowerPlus1);
                case 'fft'
                    [DP.nChan, DP.nTime, DP.timeWin, DP.nFreq, DP.nTrials] = size(data.fft);
                case 'erp'
                    [DP.nChan, DP.nTime, DP.timeWin, DP.nFreq, DP.nTrials] = size(data.erp);%nFreq here used as timepoint features
                case 'fftNonLinear'
                    [DP.nChan, DP.nTime, DP.timeWin, DP.nFreq, DP.nTrials] = size(data.fft);
                case 'pac'
                    [DP.nChan, DP.nTime, DP.nFreqPhase, DP.nTrials] = size(data.phase);
                    [~, ~, DP.timeWin, DP.nFreqPower, ~] = size(data.power);
                    DP.permute=1;
                case 'powerAndPhase'
                    [DP.nChan, DP.nTime, DP.timeWinPhase, DP.nFreqPhase, DP.nTrials] = size(data.phase);
                    [~, ~, DP.timeWinPower, DP.nFreqPower, ~] = size(data.power);
                case 'logPowerAndPhase'
                    [DP.nChan, DP.nTime, DP.timeWinPhase, DP.nFreqPhase, DP.nTrials] = size(data.phase);
                    [~, ~, DP.timeWinPower, DP.nFreqPower, ~] = size(data.logPower);
                case 'logPowerPlus1AndPhase'
                    [DP.nChan, DP.nTime, DP.timeWinPhase, DP.nFreqPhase, DP.nTrials] = size(data.phase);
                    [~, ~, DP.timeWinPower, DP.nFreqPower, ~] = size(data.logPowerPlus1);
            end
        end
        
end

