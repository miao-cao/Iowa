function [ALLFEAT DP] = decode_extractFeatures(DP,data,iTime,iFreq)
%
% normalizing is done in evaluatePerformance_mem
%
ALLFEAT = [];

switch DP.dimension
    case 'eachElectrodeEachTime'
        if ~DP.multipleTimeWindow
            %% each electrode each time, with 1 timewindow
            switch DP.saveCategory
                case 'phase'
                    if DP.nFreq==1
                        tmp       = squeeze(data.phase(iTime,:,:));
                    else
                        tmp       = squeeze(data.phase(iTime,:,:))';
                    end
                    ALLFEAT   = [sin(tmp), cos(tmp)];
                case 'power'
                    if DP.nFreq==1
                        ALLFEAT = squeeze(data.power(iTime,:,:));
                    else
                        ALLFEAT = squeeze(data.power(iTime,:,:))';
                    end
                case 'logPower'
                    if DP.nFreq==1
                        ALLFEAT = squeeze(data.logPower(iTime,:,:));
                    else
                        ALLFEAT = squeeze(data.logPower(iTime,:,:))';
                    end
                case 'logPowerPlus1'
                    if DP.nFreq==1
                        ALLFEAT = squeeze(data.logPowerPlus1(iTime,:,:));
                    else
                        ALLFEAT = squeeze(data.logPowerPlus1(iTime,:,:))';
                    end
                case 'fft'
                    if DP.nFreq==1
                        tmp     = squeeze(data.fft(iTime,:,:));
                    else
                        tmp     = squeeze(data.fft(iTime,:,:))';
                    end
                    ALLFEAT = [real(tmp), imag(tmp)];
                case 'erp'
                    if DP.nFreq==1
                        ALLFEAT     = squeeze(data.erp(iTime,:,:));
                    else
                        ALLFEAT     = squeeze(data.erp(iTime,:,:))';
                    end
                case 'fftNonLinear'
                    if DP.nFreq==1
                        tmp     = squeeze(data.fft(iTime,:,:));
                    else
                        tmp     = squeeze(data.fft(iTime,:,:))';
                    end
                    ALLFEAT = [real(tmp).^2, imag(tmp).^2];
                case {'pac','powerAndPhase'}
                    if DP.nFreqPhase==1
                        tmpPhase  = squeeze(data.phase(iTime,:,:));
                    else
                        tmpPhase  = squeeze(data.phase(iTime,:,:))';
                    end
                    
                    if DP.nFreqPower==1
                        tmpPow = squeeze(data.power(iTime,:,:));
                    else
                        tmpPow = squeeze(data.power(iTime,:,:))';
                    end
                    
                    tmpPhase2 = [sin(tmpPhase), cos(tmpPhase)];
                    DP.nFeaturesPhase = size(tmpPhase2,2);
                    DP.nFeaturesPower = size(tmpPow,2);
                    ALLFEAT = [tmpPhase2 tmpPow];
                case {'logPac','logPowerAndPhase'}
                    if DP.nFreqPhase==1
                        tmpPhase  = squeeze(data.phase(iTime,:,:));
                    else
                        tmpPhase  = squeeze(data.phase(iTime,:,:))';
                    end
                    
                    if DP.nFreqPower==1
                        tmpPow = squeeze(data.logPower(iTime,:,:));
                    else
                        tmpPow = squeeze(data.logPower(iTime,:,:))';
                    end
                    
                    tmpPhase2 = [sin(tmpPhase), cos(tmpPhase)];
                    
                    DP.nFeaturesPhase = size(tmpPhase2,2);
                    DP.nFeaturesPower = size(tmpPow,2);
                    ALLFEAT = [tmpPhase2 tmpPow];
                case {'logPlus1Pac','logPowerPlus1AndPhase'}
                    if DP.nFreqPhase==1
                        tmpPhase  = squeeze(data.phase(iTime,:,:));
                    else
                        tmpPhase  = squeeze(data.phase(iTime,:,:))';
                    end
                    
                    if DP.nFreqPower==1
                        tmpPow = squeeze(data.logPowerPlus1(iTime,:,:));
                    else
                        tmpPow = squeeze(data.logPowerPlus1(iTime,:,:))';
                    end
                    tmpPhase2 = [sin(tmpPhase), cos(tmpPhase)];
                    DP.nFeaturesPhase = size(tmpPhase2,2);
                    DP.nFeaturesPower = size(tmpPow,2);
                    ALLFEAT = [tmpPhase2 tmpPow];
            end
        else
            %% each electrode each time, add multiple timewindows as separate features
            switch DP.saveCategory
                case 'phase'
                    tmp     = squeeze(data.phase(iTime,:,:,:));
                    for itimeWin = 1:DP.timeWin
                        ALLFEAT = [ALLFEAT, sin(squeeze(tmp(itimeWin,:,:)))' , cos(squeeze(tmp(itimeWin,:,:)))'];
                    end
                case 'power'
                    tmp = squeeze(data.power(iTime,:,:,:));
                    for itimeWin = 1:DP.timeWin
                        ALLFEAT = [ALLFEAT, squeeze(tmp(itimeWin,:,:))'];
                    end
                case 'logPower'
                    tmp = squeeze(data.logPower(iTime,:,:,:));
                    for itimeWin = 1:DP.timeWin
                        ALLFEAT = [ALLFEAT, squeeze(tmp(itimeWin,:,:))'];
                    end
                case 'logPowerPlus1'
                    tmp = squeeze(data.logPowerPlus1(iTime,:,:,:));
                    for itimeWin = 1:DP.timeWin
                        ALLFEAT = [ALLFEAT, squeeze(tmp(itimeWin,:,:))'];
                    end
                case 'fft'
                    tmp     = squeeze(data.fft(iTime,:,:,:));
                    for itimeWin = 1:DP.timeWin
                        ALLFEAT = [ALLFEAT, real(squeeze(tmp(itimeWin,:,:)))' , imag(squeeze(tmp(itimeWin,:,:)))'];
                    end
                case 'erp'
                    tmp = squeeze(data.erp(iTime,:,:,:));
                    for itimeWin = 1:DP.timeWin
                        ALLFEAT = [ALLFEAT, squeeze(tmp(itimeWin,:,:))' , squeeze(tmp(itimeWin,:,:))'];
                    end
                case 'fftNonLinear'
                    tmp     = squeeze(data.fft(iTime,:,:,:));
                    for itimeWin = 1:DP.timeWin
                        ALLFEAT = [ALLFEAT, (real(squeeze(tmp(itimeWin,:,:))).^2)' , (imag(squeeze(tmp(itimeWin,:,:))).^2)'];
                    end
                case {'pac'}
                    tmpPhase    = squeeze(data.phase(iTime,:,:))';
                    tmpPhase2   = [sin(tmpPhase), cos(tmpPhase)];
                    
                    tmpPow = squeeze(data.power(iTime,:,:,:));
                    tmpPow2 = [];
                    for itimeWin = 1:DP.timeWin
                        tmpPow2 = [tmpPow2, squeeze(tmpPow(itimeWin,:,:))'];
                    end
                    ALLFEAT = [tmpPhase2 tmpPow2];
                    
                    DP.nFeaturesPhase = size(tmpPhase2,2);
                    DP.nFeaturesPower = size(tmpPow2,2);
                case {'logPac'}
                    tmpPhase    = squeeze(data.phase(iTime,:,:))';
                    tmpPhase2   = [sin(tmpPhase), cos(tmpPhase)];
                    
                    tmpPow = squeeze(data.logPower(iTime,:,:,:));
                    tmpPow2 = [];
                    for itimeWin = 1:DP.timeWin
                        tmpPow2 = [tmpPow2, squeeze(tmpPow(itimeWin,:,:))'];
                    end
                    ALLFEAT = [tmpPhase2 tmpPow2];
                    
                    DP.nFeaturesPhase = size(tmpPhase2,2);
                    DP.nFeaturesPower = size(tmpPow2,2);
                case 'powerAndPhase'
                    tmpPhase1     = squeeze(data.phase(iTime,:,:,:));
                    tmpPhase2    = [];
                    for itimeWin = 1:DP.timeWinPhase
                        tmpPhase2 = [tmpPhase2, sin(squeeze(tmpPhase1(itimeWin,:,:)))' , cos(squeeze(tmpPhase1(itimeWin,:,:)))'];
                    end
                    
                    tmpPow1 = squeeze(data.power(iTime,:,:,:));
                    tmpPow2    = [];
                    for itimeWin = 1:DP.timeWinPower
                        tmpPow2 = [tmpPow2, squeeze(tmpPow1(itimeWin,:,:))'];
                    end
                    
                    DP.nFeaturesPhase = size(tmpPhase2,2);
                    DP.nFeaturesPower = size(tmpPow2,2);
                    ALLFEAT = [tmpPhase2 tmpPow2];
                case 'logPowerAndPhase'
                    tmpPhase1     = squeeze(data.phase(iTime,:,:,:));
                    tmpPhase2    = [];
                    for itimeWin = 1:DP.timeWinPhase
                        tmpPhase2 = [tmpPhase2, sin(squeeze(tmpPhase1(itimeWin,:,:)))' , cos(squeeze(tmpPhase1(itimeWin,:,:)))'];
                    end
                    
                    tmpPow1 = squeeze(data.logPower(iTime,:,:,:));
                    tmpPow2    = [];
                    for itimeWin = 1:DP.timeWinPower
                        tmpPow2 = [tmpPow2, squeeze(tmpPow1(itimeWin,:,:))'];
                    end
                    
                    DP.nFeaturesPhase = size(tmpPhase2,2);
                    DP.nFeaturesPower = size(tmpPow2,2);
                    ALLFEAT = [tmpPhase2 tmpPow2];
                case 'logPowerPlus1AndPhase'
                    tmpPhase1     = squeeze(data.phase(iTime,:,:,:));
                    tmpPhase2    = [];
                    for itimeWin = 1:DP.timeWinPhase
                        tmpPhase2 = [tmpPhase2, sin(squeeze(tmpPhase1(itimeWin,:,:)))' , cos(squeeze(tmpPhase1(itimeWin,:,:)))'];
                    end
                    
                    tmpPow1 = squeeze(data.logPowerPlus1(iTime,:,:,:));
                    tmpPow2    = [];
                    for itimeWin = 1:DP.timeWinPower
                        tmpPow2 = [tmpPow2, squeeze(tmpPow1(itimeWin,:,:))'];
                    end
                    
                    DP.nFeaturesPhase = size(tmpPhase2,2);
                    DP.nFeaturesPower = size(tmpPow2,2);
                    ALLFEAT = [tmpPhase2 tmpPow2];
                    
            end
        end
    case 'eachElectrodeEachFreq'
        
        if ~DP.multipleTimeWindow
            %% each electrode each freq, combining 1 or multiple time points
            switch DP.saveCategory
                case 'phase'
                    if DP.nTime==1
                        tmp       = squeeze(data.phase(:,iFreq,:));
                    else
                        tmp       = squeeze(data.phase(:,iFreq,:))';
                    end
                    ALLFEAT   = [sin(tmp), cos(tmp)];
                case 'power'
                    if DP.nTime==1
                        ALLFEAT = squeeze(data.power(:,iFreq,:));
                    else
                        ALLFEAT = squeeze(data.power(:,iFreq,:))';
                    end
                case 'logPower'
                    if DP.nTime==1
                        ALLFEAT = squeeze(data.logPower(:,iFreq,:));
                    else
                        ALLFEAT = squeeze(data.logPower(:,iFreq,:))';
                    end
                case 'logPowerPlus1'
                    if DP.nTime==1
                        ALLFEAT = squeeze(data.logPowerPlus1(:,iFreq,:));
                    else
                        ALLFEAT = squeeze(data.logPowerPlus1(:,iFreq,:))';
                    end
                case 'fft'
                    if DP.nTime==1
                        tmp     = squeeze(data.fft(:,iFreq,:));
                    else
                        tmp     = squeeze(data.fft(:,iFreq,:))';
                    end
                    ALLFEAT = [real(tmp), imag(tmp)];
                case 'fftNonLinear'
                    if DP.nTime==1
                        tmp     = squeeze(data.fft(:,iFreq,:));
                    else
                        tmp     = squeeze(data.fft(:,iFreq,:))';
                    end
                    ALLFEAT = [real(tmp).^2, imag(tmp).^2];
            end
        end
        
        %%
    case 'eachElectrodeEachTimeEachFreq'
        if ~DP.multipleTimeWindow
            %% each electrode each time each freq, with 1 timewindow
            switch DP.saveCategory
                case 'phase'
                    tmp     = squeeze(data.phase(iTime,iFreq,:));
                    ALLFEAT    = [sin(tmp), cos(tmp)];
                case 'power'
                    ALLFEAT = squeeze(data.power(iTime,iFreq,:));
                case 'logPower'
                    ALLFEAT = squeeze(data.logPower(iTime,iFreq,:));
                case 'logPowerPlus1'
                    ALLFEAT = squeeze(data.logPowerPlus1(iTime,iFreq,:));
                case 'fft'
                    tmp = squeeze(data.fft(iTime,iFreq,:));
                    ALLFEAT = [real(tmp), imag(tmp)];
                case 'erp'
                    error('no separate frequencies in erp')
                case {'powerAndPhase'}
                    tmpPhase1   = squeeze(data.phase(iTime,iFreq,:));
                    tmpPhase2   = [sin(tmpPhase1), cos(tmpPhase1)];
                    tmpPow1 = squeeze(data.power(iTime,iFreq,:));
                    
                    DP.nFeaturesPhase = size(tmpPhase2,2);
                    DP.nFeaturesPower = size(tmpPow1,2);
                    ALLFEAT = [tmpPhase2 tmpPow1];
                case {'logPowerAndPhase'}
                    tmpPhase1   = squeeze(data.phase(iTime,iFreq,:));
                    tmpPhase2   = [sin(tmpPhase1), cos(tmpPhase1)];
                    tmpPow1 = squeeze(data.logPower(iTime,iFreq,:));
                    
                    DP.nFeaturesPhase = size(tmpPhase2,2);
                    DP.nFeaturesPower = size(tmpPow1,2);
                    ALLFEAT = [tmpPhase2 tmpPow1];
                case {'logPowerPlus1AndPhase'}
                    tmpPhase1   = squeeze(data.phase(iTime,iFreq,:));
                    tmpPhase2   = [sin(tmpPhase1), cos(tmpPhase1)];
                    tmpPow1 = squeeze(data.logPowerPlus1(iTime,iFreq,:));
                    
                    DP.nFeaturesPhase = size(tmpPhase2,2);
                    DP.nFeaturesPower = size(tmpPow1,2);
                    ALLFEAT = [tmpPhase2 tmpPow1];
            end
        else
            %% each electrode each time each freq, add multiple timewindows as separate features
            switch DP.saveCategory
                case 'phase'
                    tmp = squeeze(data.phase(iTime,:,iFreq,:))';
                    ALLFEAT = [sin(squeeze(tmp)) , cos(squeeze(tmp))];
                case 'power'
                    ALLFEAT = squeeze(data.power(iTime,:,iFreq,:))';
                case 'logPower'
                    ALLFEAT = squeeze(data.logPower(iTime,:,iFreq,:))';
                case 'logPowerPlus1'
                    ALLFEAT = squeeze(data.logPowerPlus1(iTime,:,iFreq,:))';
                case 'fft'
                    tmp = squeeze(data.fft(iTime,:,iFreq,:))';
                    ALLFEAT = [real(squeeze(tmp)) , imag(squeeze(tmp))];
                case 'erp'
                    error('no separate frequencies in erp')
                case 'powerAndPhase'
                    tmpPhase1 = squeeze(data.phase(iTime,:,iFreq,:))';
                    tmpPhase2 = [sin(squeeze(tmpPhase1)) , cos(squeeze(tmpPhase1))];
                    tmpPow1 = squeeze(data.power(iTime,:,iFreq,:))';
                    
                    ALLFEAT = [tmpPhase2 tmpPow1];
                    DP.nFeaturesPhase = size(tmpPhase2,2);
                    DP.nFeaturesPower = size(tmpPow1,2);
                case 'logPowerAndPhase'
                    tmpPhase1 = squeeze(data.phase(iTime,:,iFreq,:))';
                    tmpPhase2 = [sin(squeeze(tmpPhase1)) , cos(squeeze(tmpPhase1))];
                    tmpPow1 = squeeze(data.logPower(iTime,:,iFreq,:))';
                    
                    ALLFEAT = [tmpPhase2 tmpPow1];
                    DP.nFeaturesPhase = size(tmpPhase2,2);
                    DP.nFeaturesPower = size(tmpPow1,2);
                case 'logPowerPlus1AndPhase'
                    tmpPhase1 = squeeze(data.phase(iTime,:,iFreq,:))';
                    tmpPhase2 = [sin(squeeze(tmpPhase1)) , cos(squeeze(tmpPhase1))];
                    tmpPow1 = squeeze(data.logPowerPlus1(iTime,:,iFreq,:))';
                    
                    ALLFEAT = [tmpPhase2 tmpPow1];
                    DP.nFeaturesPhase = size(tmpPhase2,2);
                    DP.nFeaturesPower = size(tmpPow1,2);
                    
            end
        end
    case 'allElectrodeEachTime'
        if ~DP.multipleTimeWindow
            %% each electrode each time, with 1 timewindow
            switch DP.saveCategory
                case 'phase'
                    for iChan = 1:DP.nChan
                        if DP.nFreq==1
                            tmp       = squeeze(data.phase(iChan,iTime,:,:));                            
                        else
                            tmp       = squeeze(data.phase(iChan,iTime,:,:))';
                        end
                        ALLFEAT   = [ALLFEAT sin(tmp), cos(tmp)];
                    end
                case 'power'
                    for iChan = 1:DP.nChan
                        if DP.nFreq==1
                            ALLFEAT   = [ALLFEAT squeeze(data.power(iChan,iTime,:,:))];
                        else
                            ALLFEAT   = [ALLFEAT squeeze(data.power(iChan,iTime,:,:))'];
                        end
                    end
                case 'logPower'
                    for iChan = 1:DP.nChan
                        if DP.nFreq==1
                            ALLFEAT   = [ALLFEAT squeeze(data.logPower(iChan,iTime,:,:))];
                        else
                            ALLFEAT   = [ALLFEAT squeeze(data.logPower(iChan,iTime,:,:))'];
                        end
                    end
                case 'logPowerPlus1'
                    for iChan = 1:DP.nChan
                        if DP.nFreq==1
                            ALLFEAT   = [ALLFEAT squeeze(data.logPowerPlus1(iChan,iTime,:,:))];
                        else
                            ALLFEAT   = [ALLFEAT squeeze(data.logPowerPlus1(iChan,iTime,:,:))'];
                        end
                    end
                case 'fft'
                    for iChan = 1:DP.nChan
                        if DP.nFreq==1
                            tmp     = squeeze(data.fft(iChan,iTime,:,:));
                        else
                            tmp     = squeeze(data.fft(iChan,iTime,:,:))';
                        end
                        ALLFEAT   = [ALLFEAT real(tmp), imag(tmp)];
                    end
                case 'erp'
                    for iChan = 1:DP.nChan
                        if DP.nFreq==1
                            ALLFEAT   = [ALLFEAT squeeze(data.erp(iChan,iTime,:,:))];
                        else
                            ALLFEAT   = [ALLFEAT squeeze(data.erp(iChan,iTime,:,:))'];
                        end
                    end
                case 'fftNonLinear'
                    for iChan = 1:DP.nChan
                        if DP.nFreq==1
                            tmp     = squeeze(data.fft(iChan,iTime,:,:));
                        else
                            tmp     = squeeze(data.fft(iChan,iTime,:,:))';
                        end
                        ALLFEAT   = [ALLFEAT real(tmp).^2, imag(tmp).^2];
                    end
                case {'pac','powerAndPhase'}
                    for iChan = 1:DP.nChan
                        if DP.nFreqPhase==1
                            tmpPhase  = squeeze(data.phase(iChan,iTime,:,:));
                        else
                            tmpPhase  = squeeze(data.phase(iChan,iTime,:,:))';
                        end
                        tmpPhase2 = [sin(tmpPhase), cos(tmpPhase)];
                        
                        if DP.nFreqPower==1
                            tmpPow = squeeze(data.power(iChan,iTime,:,:));
                        else
                            tmpPow = squeeze(data.power(iChan,iTime,:,:))';
                        end
                        DP.nFeaturesPhase = size(tmpPhase2,2);
                        DP.nFeaturesPower = size(tmpPow,2);
                        ALLFEAT   = [ALLFEAT tmpPhase2 tmpPow];
                    end
                case {'logPac','logPowerAndPhase'}
                    for iChan = 1:DP.nChan
                        if DP.nFreqPhase==1
                            tmpPhase  = squeeze(data.phase(iChan,iTime,:,:));
                        else
                            tmpPhase  = squeeze(data.phase(iChan,iTime,:,:))';
                        end
                        tmpPhase2 = [sin(tmpPhase), cos(tmpPhase)];
                        
                        if DP.nFreqPower==1
                            tmpPow = squeeze(data.logPower(iChan,iTime,:,:));
                        else
                            tmpPow = squeeze(data.logPower(iChan,iTime,:,:))';
                        end
                        DP.nFeaturesPhase = size(tmpPhase2,2);
                        DP.nFeaturesPower = size(tmpPow,2);
                        ALLFEAT   = [ALLFEAT tmpPhase2 tmpPow];
                    end
                case {'logPlus1Pac','logPowerPlus1AndPhase'}
                    for iChan = 1:DP.nChan
                        if DP.nFreqPhase==1
                            tmpPhase  = squeeze(data.phase(iChan,iTime,:,:));
                        else
                            tmpPhase  = squeeze(data.phase(iChan,iTime,:,:))';
                        end
                        tmpPhase2 = [sin(tmpPhase), cos(tmpPhase)];
                        
                        if DP.nFreqPower==1
                            tmpPow = squeeze(data.logPowerPlus1(iChan,iTime,:,:));
                        else
                            tmpPow = squeeze(data.logPowerPlus1(iChan,iTime,:,:))';
                        end
                        DP.nFeaturesPhase = size(tmpPhase2,2);
                        DP.nFeaturesPower = size(tmpPow,2);
                        ALLFEAT   = [ALLFEAT tmpPhase2 tmpPow];
                    end
            end
        else
            %% each electrode each time, add multiple timewindows as separate features
            switch DP.saveCategory
                case 'phase'
                    for iChan = 1:DP.nChan
                        tmp     = squeeze(data.phase(iChan,iTime,:,:,:));
                        for itimeWin = 1:DP.timeWin
                            ALLFEAT = [ALLFEAT, sin(squeeze(tmp(itimeWin,:,:)))' , cos(squeeze(tmp(itimeWin,:,:)))'];
                        end
                    end
                case 'power'
                    for iChan = 1:DP.nChan
                        tmp = squeeze(data.power(iChan,iTime,:,:,:));
                        for itimeWin = 1:DP.timeWin
                            ALLFEAT = [ALLFEAT, squeeze(tmp(itimeWin,:,:))'];
                        end
                    end
                case 'logPower'
                    for iChan = 1:DP.nChan
                        tmp = squeeze(data.logPower(iChan,iTime,:,:,:));
                        for itimeWin = 1:DP.timeWin
                            ALLFEAT = [ALLFEAT, squeeze(tmp(itimeWin,:,:))'];
                        end
                    end
                case 'logPowerPlus1'
                    for iChan = 1:DP.nChan
                        tmp = squeeze(data.logPowerPlus1(iChan,iTime,:,:,:));
                        for itimeWin = 1:DP.timeWin
                            ALLFEAT = [ALLFEAT, squeeze(tmp(itimeWin,:,:))'];
                        end
                    end
                case 'fft'
                    for iChan = 1:DP.nChan
                        tmp     = squeeze(data.fft(iChan,iTime,:,:,:));
                        for itimeWin = 1:DP.timeWin
                            ALLFEAT = [ALLFEAT, real(squeeze(tmp(itimeWin,:,:)))' , imag(squeeze(tmp(itimeWin,:,:)))'];
                        end
                    end
                case 'erp'
                    for iChan = 1:DP.nChan
                        tmp = squeeze(data.erp(iChan,iTime,:,:,:));
                        for itimeWin = 1:DP.timeWin
                            ALLFEAT = [ALLFEAT, squeeze(tmp(itimeWin,:,:))' , squeeze(tmp(itimeWin,:,:))'];
                        end
                    end
                case 'fftNonLinear'
                    for iChan = 1:DP.nChan
                        tmp     = squeeze(data.fft(iChan,iTime,:,:,:));
                        for itimeWin = 1:DP.timeWin
                            ALLFEAT = [ALLFEAT, (real(squeeze(tmp(itimeWin,:,:))).^2)' , (imag(squeeze(tmp(itimeWin,:,:))).^2)'];
                        end
                    end
                case {'pac'}
                    for iChan = 1:DP.nChan
                        tmpPhase    = squeeze(data.phase(iChan,iTime,:,:))';
                        tmpPhase2   = [sin(tmpPhase), cos(tmpPhase)];
                        
                        tmpPow = squeeze(data.power(iChan,iTime,:,:,:));
                        tmpPow2 = [];
                        for itimeWin = 1:DP.timeWin
                            tmpPow2 = [tmpPow2, squeeze(tmpPow(itimeWin,:,:))'];
                        end
                        ALLFEAT = [ALLFEAT, tmpPhase2, tmpPow2];
                        
                        DP.nFeaturesPhase = size(tmpPhase2,2);
                        DP.nFeaturesPower = size(tmpPow2,2);
                    end
                case {'logPac'}
                    for iChan = 1:DP.nChan
                        tmpPhase    = squeeze(data.phase(iChan,iTime,:,:))';
                        tmpPhase2   = [sin(tmpPhase), cos(tmpPhase)];
                        
                        tmpPow = squeeze(data.logPower(iChan,iTime,:,:,:));
                        tmpPow2 = [];
                        for itimeWin = 1:DP.timeWin
                            tmpPow2 = [tmpPow2, squeeze(tmpPow(itimeWin,:,:))'];
                        end
                        ALLFEAT = [ALLFEAT, tmpPhase2, tmpPow2];
                        
                        DP.nFeaturesPhase = size(tmpPhase2,2);
                        DP.nFeaturesPower = size(tmpPow2,2);
                    end
                case 'powerAndPhase'
                    for iChan = 1:DP.nChan
                        tmpPhase1     = squeeze(data.phase(iChan,iTime,:,:,:));
                        tmpPhase2    = [];
                        for itimeWin = 1:DP.timeWinPhase
                            tmpPhase2 = [tmpPhase2, sin(squeeze(tmpPhase1(itimeWin,:,:)))' , cos(squeeze(tmpPhase1(itimeWin,:,:)))'];
                        end
                        
                        tmpPow1 = squeeze(data.power(iChan,iTime,:,:,:));
                        tmpPow2    = [];
                        for itimeWin = 1:DP.timeWinPower
                            tmpPow2 = [tmpPow2, squeeze(tmpPow1(itimeWin,:,:))'];
                        end
                        
                        DP.nFeaturesPhase = size(tmpPhase2,2);
                        DP.nFeaturesPower = size(tmpPow2,2);
                        ALLFEAT = [ALLFEAT, tmpPhase2, tmpPow2];
                    end
                case 'logPowerAndPhase'
                    for iChan = 1:DP.nChan
                        tmpPhase1     = squeeze(data.phase(iChan,iTime,:,:,:));
                        tmpPhase2    = [];
                        for itimeWin = 1:DP.timeWinPhase
                            tmpPhase2 = [tmpPhase2, sin(squeeze(tmpPhase1(itimeWin,:,:)))' , cos(squeeze(tmpPhase1(itimeWin,:,:)))'];
                        end
                        
                        tmpPow1 = squeeze(data.logPower(iChan,iTime,:,:,:));
                        tmpPow2    = [];
                        for itimeWin = 1:DP.timeWinPower
                            tmpPow2 = [tmpPow2, squeeze(tmpPow1(itimeWin,:,:))'];
                        end
                        
                        DP.nFeaturesPhase = size(tmpPhase2,2);
                        DP.nFeaturesPower = size(tmpPow2,2);
                        ALLFEAT = [ALLFEAT, tmpPhase2, tmpPow2];
                    end
                case 'logPowerPlus1AndPhase'
                    for iChan = 1:DP.nChan
                        tmpPhase1     = squeeze(data.phase(iChan,iTime,:,:,:));
                        tmpPhase2    = [];
                        for itimeWin = 1:DP.timeWinPhase
                            tmpPhase2 = [tmpPhase2, sin(squeeze(tmpPhase1(itimeWin,:,:)))' , cos(squeeze(tmpPhase1(itimeWin,:,:)))'];
                        end
                        
                        tmpPow1 = squeeze(data.logPowerPlus1(iChan,iTime,:,:,:));
                        tmpPow2    = [];
                        for itimeWin = 1:DP.timeWinPower
                            tmpPow2 = [tmpPow2, squeeze(tmpPow1(itimeWin,:,:))'];
                        end
                        
                        DP.nFeaturesPhase = size(tmpPhase2,2);
                        DP.nFeaturesPower = size(tmpPow2,2);
                        ALLFEAT = [ALLFEAT, tmpPhase2, tmpPow2];
                    end
            end
        end
        %%
    case 'allElectrodeEachFreq'
        if ~DP.multipleTimeWindow
            %% each electrode each freq, with 1 timewindow
            switch DP.saveCategory
                case 'phase'
                    for iChan = 1:DP.nChan
                        if DP.nTime==1
                            tmp       = squeeze(data.phase(iChan,:,iFreq,:));                            
                        else
                            tmp       = squeeze(data.phase(iChan,:,iFreq,:))';
                        end
                        ALLFEAT   = [ALLFEAT sin(tmp), cos(tmp)];
                    end
                case 'power'
                    for iChan = 1:DP.nChan
                        if DP.nTime==1
                            ALLFEAT   = [ALLFEAT squeeze(data.power(iChan,:,iFreq,:))];
                        else
                            ALLFEAT   = [ALLFEAT squeeze(data.power(iChan,:,iFreq,:))'];
                        end
                    end
                case 'logPower'
                    for iChan = 1:DP.nChan
                        if DP.nTime==1
                            ALLFEAT   = [ALLFEAT squeeze(data.logPower(iChan,:,iFreq,:))];
                        else
                            ALLFEAT   = [ALLFEAT squeeze(data.logPower(iChan,:,iFreq,:))'];
                        end
                    end
                case 'logPowerPlus1'
                    for iChan = 1:DP.nChan
                        if DP.nTime==1
                            ALLFEAT   = [ALLFEAT squeeze(data.logPowerPlus1(iChan,:,iFreq,:))];
                        else
                            ALLFEAT   = [ALLFEAT squeeze(data.logPowerPlus1(iChan,:,iFreq,:))'];
                        end
                    end
                case 'fft'
                    for iChan = 1:DP.nChan
                        if DP.nTime==1
                            tmp     = squeeze(data.fft(iChan,:,iFreq,:));
                        else
                            tmp     = squeeze(data.fft(iChan,:,iFreq,:))';
                        end
                        ALLFEAT   = [ALLFEAT real(tmp), imag(tmp)];
                    end
                case 'fftNonLinear'
                    for iChan = 1:DP.nChan
                        if DP.nTime==1
                            tmp     = squeeze(data.fft(iChan,:,iFreq,:));
                        else
                            tmp     = squeeze(data.fft(iChan,:,iFreq,:))';
                        end
                        ALLFEAT   = [ALLFEAT real(tmp).^2, imag(tmp).^2];
                    end
            end
        end
    case 'allElectrodeEachTimeEachFreq'
        if ~DP.multipleTimeWindow
            %% each electrode each time each freq, with 1 timewindow
            switch DP.saveCategory
                case 'phase'
                    tmp     = squeeze(data.phase(:,iTime,iFreq,:))';
                    ALLFEAT    = [sin(tmp), cos(tmp)];
                case 'power'
                    ALLFEAT = squeeze(data.power(:,iTime,iFreq,:))';
                case 'logPower'
                    ALLFEAT = squeeze(data.logPower(:,iTime,iFreq,:))';
                case 'logPowerPlus1'
                    ALLFEAT = squeeze(data.logPowerPlus1(:,iTime,iFreq,:))';
                case 'fft'
                    tmp = squeeze(data.fft(:,iTime,iFreq,:))';
                    ALLFEAT = [real(tmp), imag(tmp)];
                case 'erp'
                    error('no separate frequencies in erp')
                case {'powerAndPhase'}
                    tmpPhase1   = squeeze(data.phase(:,iTime,iFreq,:))';
                    tmpPhase2   = [sin(tmpPhase1), cos(tmpPhase1)];
                    tmpPow1 = squeeze(data.power(:,iTime,iFreq,:))';
                    
                    DP.nFeaturesPhase = size(tmpPhase2,2);
                    DP.nFeaturesPower = size(tmpPow1,2);
                    ALLFEAT = [tmpPhase2 tmpPow1];
                case {'logPowerAndPhase'}
                    tmpPhase1   = squeeze(data.phase(:,iTime,iFreq,:))';
                    tmpPhase2   = [sin(tmpPhase1), cos(tmpPhase1)];
                    tmpPow1 = squeeze(data.logPower(:,iTime,iFreq,:))';
                    
                    DP.nFeaturesPhase = size(tmpPhase2,2);
                    DP.nFeaturesPower = size(tmpPow1,2);
                    ALLFEAT = [tmpPhase2 tmpPow1];
                case {'logPowerPlus1AndPhase'}
                    tmpPhase1   = squeeze(data.phase(:,iTime,iFreq,:))';
                    tmpPhase2   = [sin(tmpPhase1), cos(tmpPhase1)];
                    tmpPow1 = squeeze(data.logPowerPlus1(:,iTime,iFreq,:))';
                    
                    DP.nFeaturesPhase = size(tmpPhase2,2);
                    DP.nFeaturesPower = size(tmpPow1,2);
                    ALLFEAT = [tmpPhase2 tmpPow1];
            end
        else
            %% each electrode each time each freq, add multiple timewindows as separate features
            switch DP.saveCategory
                case 'phase'
                    for iChan = 1:DP.nChan
                        tmp = squeeze(data.phase(iChan,iTime,:,iFreq,:))';
                        ALLFEAT = [ALLFEAT sin(squeeze(tmp)) , cos(squeeze(tmp))];
                    end
                case 'power'
                    for iChan = 1:DP.nChan
                        ALLFEAT = [ALLFEAT squeeze(data.power(iChan,iTime,:,iFreq,:))'];
                    end
                case 'logPower'
                    for iChan = 1:DP.nChan
                        ALLFEAT = [ALLFEAT squeeze(data.logPower(iChan,iTime,:,iFreq,:))'];
                    end
                case 'logPowerPlus1'
                    for iChan = 1:DP.nChan
                        ALLFEAT = [ALLFEAT squeeze(data.logPowerPlus1(iChan,iTime,:,iFreq,:))'];
                    end
                case 'fft'
                    for iChan = 1:DP.nChan
                        tmp = squeeze(data.fft(iChan,iTime,:,iFreq,:))';
                        ALLFEAT = [ALLFEAT real(squeeze(tmp)) , imag(squeeze(tmp))];
                    end
                case 'erp'
                    for iChan = 1:DP.nChan
                        error('no separate frequencies in erp')
                    end
                case 'powerAndPhase'
                    for iChan = 1:DP.nChan
                        tmpPhase1 = squeeze(data.phase(iChan,iTime,:,iFreq,:))';
                        tmpPhase2 = [sin(squeeze(tmpPhase1)) , cos(squeeze(tmpPhase1))];
                        tmpPow1 = squeeze(data.power(iChan,iTime,:,iFreq,:))';
                        
                        ALLFEAT = [ALLFEAT tmpPhase2 tmpPow1];
                        DP.nFeaturesPhase = size(tmpPhase2,2);
                        DP.nFeaturesPower = size(tmpPow1,2);
                    end
                case 'logPowerAndPhase'
                    for iChan = 1:DP.nChan
                        tmpPhase1 = squeeze(data.phase(iChan,iTime,:,iFreq,:))';
                        tmpPhase2 = [sin(squeeze(tmpPhase1)) , cos(squeeze(tmpPhase1))];
                        tmpPow1 = squeeze(data.logPower(iChan,iTime,:,iFreq,:))';
                        
                        ALLFEAT = [ALLFEAT tmpPhase2 tmpPow1];
                        DP.nFeaturesPhase = size(tmpPhase2,2);
                        DP.nFeaturesPower = size(tmpPow1,2);
                    end
                case 'logPowerPlus1AndPhase'
                    for iChan = 1:DP.nChan
                        tmpPhase1 = squeeze(data.phase(iChan,iTime,:,iFreq,:))';
                        tmpPhase2 = [sin(squeeze(tmpPhase1)) , cos(squeeze(tmpPhase1))];
                        tmpPow1 = squeeze(data.logPowerPlus1(iChan,iTime,:,iFreq,:))';
                        
                        ALLFEAT = [ALLFEAT tmpPhase2 tmpPow1];
                        DP.nFeaturesPhase = size(tmpPhase2,2);
                        DP.nFeaturesPower = size(tmpPow1,2);
                    end
                    
            end
        end
        
end

DP.nFeatures = size(ALLFEAT,2);

if size(ALLFEAT,1) ~= DP.nTrials
    error('number of features doesn''t match with number of trials')
end