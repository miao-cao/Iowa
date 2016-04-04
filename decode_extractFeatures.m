function [ALLFEAT, nFeatures] = decode_extractFeatures(DEC,data,iTime,iFreq)
%
% normalizing is done in evaluatePerformance_mem
%
ALLFEAT = [];


%% define searchlight time and frequency points
if DEC.searchlight
    if exist('iTime','var') && ~isempty(iTime)
        tmpTime2use = iTime + DEC.searchlightTimeWin;
        time2use = tmpTime2use(1):tmpTime2use(2);
        
        time2use(find(time2use<=0)) = [];
        time2use(find(time2use>DEC.nTime)) = [];
    end
    if exist('iFreq','var') && ~isempty(iFreq)
        tmpFreq2use = iFreq + DEC.searchlightFreqWin;
        freq2use = tmpFreq2use(1):tmpFreq2use(2);
        
        freq2use(find(freq2use<=0)) = [];
        freq2use(find(freq2use>DEC.nFreq)) = [];
    end
else
    if exist('iTime','var') && ~isempty(iTime)
        time2use = iTime;
    end
    if exist('iFreq','var') && ~isempty(iFreq)
        freq2use = iFreq;
    end
end



switch DEC.dimension
    case 'eachElectrodeEachTime'
        %% each electrode each time, with 1 timewindow
        switch DEC.saveCategory
            case 'phase'
                for iTimeDec = 1:numel(time2use)
                    if DEC.nFreq==1
                        tmp       = squeeze(data.phase(time2use(iTimeDec),:,:));
                    else
                        tmp       = squeeze(data.phase(time2use(iTimeDec),:,:))';
                    end
                    ALLFEAT   = [ALLFEAT sin(tmp), cos(tmp)];
                end
            case 'power'
                for iTimeDec = 1:numel(time2use)
                    if DEC.nFreq==1
                        ALLFEAT = [ALLFEAT squeeze(data.power(time2use(iTimeDec),:,:))];
                    else
                        ALLFEAT = [ALLFEAT squeeze(data.power(time2use(iTimeDec),:,:))'];
                    end
                end
            case 'powerNorm'
                for iTimeDec = 1:numel(time2use)
                    if DEC.nFreq==1
                        ALLFEAT = [ALLFEAT squeeze(data.powerNorm(time2use(iTimeDec),:,:))];
                    else
                        ALLFEAT = [ALLFEAT squeeze(data.powerNorm(time2use(iTimeDec),:,:))'];
                    end
                end
            case 'fft'
                for iTimeDec = 1:numel(time2use)
                    if DEC.nFreq==1
                        tmp     = squeeze(data.fft(time2use(iTimeDec),:,:));
                    else
                        tmp     = squeeze(data.fft(time2use(iTimeDec),:,:))';
                    end
                    ALLFEAT = [ALLFEAT real(tmp), imag(tmp)];
                end
                
            case 'erp'
                for iTimeDec = 1:numel(time2use)
                    if DEC.nFreq==1
                        ALLFEAT     = [ALLFEAT squeeze(data.erp(time2use(iTimeDec),:,:))];
                    else
                        ALLFEAT     = [ALLFEAT squeeze(data.erp(time2use(iTimeDec),:,:))'];
                    end
                end
            case 'fftNonLinear'
                for iTimeDec = 1:numel(time2use)
                    if DEC.nFreq==1
                        tmp     = squeeze(data.fft(time2use(iTimeDec),:,:));
                    else
                        tmp     = squeeze(data.fft(time2use(iTimeDec),:,:))';
                    end
                    ALLFEAT = [ALLFEAT real(tmp).^2, imag(tmp).^2];
                end
            case {'pac','powerAndPhase'}
                for iTimeDec = 1:numel(time2use)
                    if DEC.nFreqPhase==1
                        tmpPhase  = squeeze(data.phase(time2use(iTimeDec),:,:));
                    else
                        tmpPhase  = squeeze(data.phase(time2use(iTimeDec),:,:))';
                    end
                    
                    if DEC.nFreqPower==1
                        tmpPow = squeeze(data.power(time2use(iTimeDec),:,:));
                    else
                        tmpPow = squeeze(data.power(time2use(iTimeDec),:,:))';
                    end
                    
                    tmpPhase2 = [sin(tmpPhase), cos(tmpPhase)];
                    DEC.nFeaturesPhase = size(tmpPhase2,2);
                    DEC.nFeaturesPower = size(tmpPow,2);
                    ALLFEAT = [tmpPhase2 tmpPow];
                end
        end
        
        %%
    case 'eachElectrodeEachFreq'
        %% each electrode each time, with 1 timewindow
        switch DEC.saveCategory
            case 'phase'
                for iFreqDec = 1:numel(freq2use)
                    if DEC.nTime==1
                        tmp       = squeeze(data.phase(:,freq2use(iFreqDec),:));
                    else
                        tmp       = squeeze(data.phase(:,freq2use(iFreqDec),:))';
                    end
                    ALLFEAT   = [ALLFEAT sin(tmp), cos(tmp)];
                end
            case 'power'
                for iFreqDec = 1:numel(freq2use)
                    if DEC.nTime==1
                        ALLFEAT = [ALLFEAT squeeze(data.power(:,freq2use(iFreqDec),:))];
                    else
                        ALLFEAT = [ALLFEAT squeeze(data.power(:,freq2use(iFreqDec),:))'];
                    end
                end
            case 'powerNorm'
                for iFreqDec = 1:numel(freq2use)
                    if DEC.nTime==1
                        ALLFEAT = [ALLFEAT squeeze(data.powerNorm(:,freq2use(iFreqDec),:))];
                    else
                        ALLFEAT = [ALLFEAT squeeze(data.powerNorm(:,freq2use(iFreqDec),:))'];
                    end
                end
            case 'fft'
                for iFreqDec = 1:numel(freq2use)
                    if DEC.nTime==1
                        tmp     = squeeze(data.fft(:,freq2use(iFreqDec),:));
                    else
                        tmp     = squeeze(data.fft(:,freq2use(iFreqDec),:))';
                    end
                    ALLFEAT = [ALLFEAT real(tmp), imag(tmp)];
                end
            case 'erp'
                %                 for iFreqDec = 1:numel(freq2use)
                %                     if DEC.nTime==1
                %                         ALLFEAT     = squeeze(data.erp(:,freq2use(iFreqDec),:));
                %                     else
                %                         ALLFEAT     = squeeze(data.erp(:,freq2use(iFreqDec),:))';
                %                     end
                %                 end
            case 'fftNonLinear'
                for iFreqDec = 1:numel(freq2use)
                    if DEC.nTime==1
                        tmp     = squeeze(data.fft(:,freq2use(iFreqDec),:));
                    else
                        tmp     = squeeze(data.fft(:,freq2use(iFreqDec),:))';
                    end
                    ALLFEAT = [ALLFEAT real(tmp).^2, imag(tmp).^2];
                end
            case {'pac','powerAndPhase'}
                for iFreqDec = 1:numel(freq2use)
                    if DEC.nTime==1
                        tmpPhase  = squeeze(data.phase(:,freq2use(iFreqDec),:));
                    else
                        tmpPhase  = squeeze(data.phase(:,freq2use(iFreqDec),:))';
                    end
                    
                    if DEC.nTime==1
                        tmpPow = squeeze(data.power(:,freq2use(iFreqDec),:));
                    else
                        tmpPow = squeeze(data.power(:,freq2use(iFreqDec),:))';
                    end
                    
                    tmpPhase2 = [sin(tmpPhase), cos(tmpPhase)];
                    DEC.nFeaturesPhase = size(tmpPhase2,2);
                    DEC.nFeaturesPower = size(tmpPow,2);
                    ALLFEAT = [ALLFEAT tmpPhase2 tmpPow];
                end
        end
        %%
        
    case 'eachElectrodeEachTimeEachFreq'
        %% each electrode each time each freq, with 1 timewindow
        switch DEC.saveCategory
            case 'phase'
                for iTimeDec = 1:numel(time2use)
                    for iFreqDec = 1:numel(freq2use)
                        tmp     = squeeze(data.phase(time2use(iTimeDec),freq2use(iFreqDec),:));
                        ALLFEAT    = [ALLFEAT sin(tmp), cos(tmp)];
                    end
                end
            case 'power'
                for iTimeDec = 1:numel(time2use)
                    for iFreqDec = 1:numel(freq2use)
                        ALLFEAT = [ALLFEAT squeeze(data.power(time2use(iTimeDec),freq2use(iFreqDec),:))];
                    end
                end
            case 'powerNorm'
                for iTimeDec = 1:numel(time2use)
                    for iFreqDec = 1:numel(freq2use)
                        ALLFEAT = [ALLFEAT squeeze(data.powerNorm(time2use(iTimeDec),freq2use(iFreqDec),:))];
                    end
                end
            case 'fft'
                for iTimeDec = 1:numel(time2use)
                    for iFreqDec = 1:numel(freq2use)
                        tmp = squeeze(data.fft(time2use(iTimeDec),freq2use(iFreqDec),:));
                        ALLFEAT = [ALLFEAT real(tmp), imag(tmp)];
                    end
                end
            case 'erp'
                error('no separate frequencies in erp')
            case {'powerAndPhase'}
                for iTimeDec = 1:numel(time2use)
                    for iFreqDec = 1:numel(freq2use)
                        tmpPhase1   = squeeze(data.phase(time2use(iTimeDec),freq2use(iFreqDec),:));
                        tmpPhase2   = [sin(tmpPhase1), cos(tmpPhase1)];
                        tmpPow1 = squeeze(data.power(time2use(iTimeDec),freq2use(iFreqDec),:));
                        
                        DEC.nFeaturesPhase = size(tmpPhase2,2);
                        DEC.nFeaturesPower = size(tmpPow1,2);
                        ALLFEAT = [ALLFEAT tmpPhase2 tmpPow1];
                    end
                end
        end
    case 'eachElectrodeMultiTimeMultiFreq'
        %% each electrode multiple time and frequency points
        
        switch DEC.saveCategory
            case 'phase'
                for iTime = 1:DEC.nTime
                    if DEC.nFreq==1
                        tmp       = squeeze(data.phase(iTime,:,:));
                    else
                        tmp       = squeeze(data.phase(iTime,:,:))';
                    end
                    ALLFEAT   = [ALLFEAT sin(tmp), cos(tmp)];
                end
            case 'power'
                for iTime = 1:DEC.nTime
                    if DEC.nFreq==1
                        ALLFEAT   = [ALLFEAT squeeze(data.power(iTime,:,:))];
                    else
                        ALLFEAT   = [ALLFEAT squeeze(data.power(iTime,:,:))'];
                    end
                end
            case 'powerNorm'
                for iTime = 1:DEC.nTime
                    if DEC.nFreq==1
                        ALLFEAT   = [ALLFEAT squeeze(data.powerNorm(iTime,:,:))];
                    else
                        ALLFEAT   = [ALLFEAT squeeze(data.powerNorm(iTime,:,:))'];
                    end
                end
            case 'fft'
                for iTime = 1:DEC.nTime
                    if DEC.nFreq==1
                        tmp     = squeeze(data.fft(iTime,:,:));
                    else
                        tmp     = squeeze(data.fft(iTime,:,:))';
                    end
                    ALLFEAT   = [ALLFEAT real(tmp), imag(tmp)];
                end
            case 'erp'
                for iTime = 1:DEC.nTime
                    if DEC.nFreq==1
                        ALLFEAT   = [ALLFEAT squeeze(data.erp(iTime,:,:))];
                    else
                        ALLFEAT   = [ALLFEAT squeeze(data.erp(iTime,:,:))'];
                    end
                end
        end
    case 'multiElectrodeEachTime'
        %% each electrode each time, with 1 timewindow
        
        switch DEC.saveCategory
            case 'phase'
                for iChan = DEC.chan2use
                    for iTimeDec = 1:numel(time2use)
                        if DEC.nFreq==1
                            tmp       = squeeze(data.phase(iChan,time2use(iTimeDec),:,:));
                        else
                            tmp       = squeeze(data.phase(iChan,time2use(iTimeDec),:,:))';
                        end
                        ALLFEAT   = [ALLFEAT sin(tmp), cos(tmp)];
                    end
                end
            case 'power'
                for iChan = DEC.chan2use
                    for iTimeDec = 1:numel(time2use)
                        if DEC.nFreq==1
                            ALLFEAT   = [ALLFEAT squeeze(data.power(iChan,time2use(iTimeDec),:,:))];
                        else
                            ALLFEAT   = [ALLFEAT squeeze(data.power(iChan,time2use(iTimeDec),:,:))'];
                        end
                    end
                end
            case 'powerNorm'
                for iChan = DEC.chan2use
                    for iTimeDec = 1:numel(time2use)
                        if DEC.nFreq==1
                            ALLFEAT   = [ALLFEAT squeeze(data.powerNorm(iChan,time2use(iTimeDec),:,:))];
                        else
                            ALLFEAT   = [ALLFEAT squeeze(data.powerNorm(iChan,time2use(iTimeDec),:,:))'];
                        end
                    end
                end
            case 'fft'
                for iChan = DEC.chan2use
                    for iTimeDec = 1:numel(time2use)
                        if DEC.nFreq==1
                            tmp     = squeeze(data.fft(iChan,time2use(iTimeDec),:,:));
                        else
                            tmp     = squeeze(data.fft(iChan,time2use(iTimeDec),:,:))';
                        end
                        ALLFEAT   = [ALLFEAT real(tmp), imag(tmp)];
                    end
                end
            case 'erp'
                for iChan = DEC.chan2use
                    for iTimeDec = 1:numel(time2use)
                        if DEC.nFreq==1
                            ALLFEAT   = [ALLFEAT squeeze(data.erp(iChan,time2use(iTimeDec),:,:))];
                        else
                            ALLFEAT   = [ALLFEAT squeeze(data.erp(iChan,time2use(iTimeDec),:,:))'];
                        end
                    end
                end
            case 'fftNonLinear'
                for iChan = DEC.chan2use
                    for iTimeDec = 1:numel(time2use)
                        if DEC.nFreq==1
                            tmp     = squeeze(data.fft(iChan,time2use(iTimeDec),:,:));
                        else
                            tmp     = squeeze(data.fft(iChan,time2use(iTimeDec),:,:))';
                        end
                        ALLFEAT   = [ALLFEAT real(tmp).^2, imag(tmp).^2];
                    end
                end
            case {'pac','powerAndPhase'}
                for iChan = DEC.chan2use
                    if DEC.nFreqPhase==1
                        tmpPhase  = squeeze(data.phase(iChan,time2use,:,:));
                    else
                        tmpPhase  = squeeze(data.phase(iChan,time2use,:,:))';
                    end
                    tmpPhase2 = [sin(tmpPhase), cos(tmpPhase)];
                    
                    if DEC.nFreqPower==1
                        tmpPow = squeeze(data.power(iChan,time2use,:,:));
                    else
                        tmpPow = squeeze(data.power(iChan,time2use,:,:))';
                    end
                    DEC.nFeaturesPhase = size(tmpPhase2,2);
                    DEC.nFeaturesPower = size(tmpPow,2);
                    ALLFEAT   = [ALLFEAT tmpPhase2 tmpPow];
                end
        end
        %%
    case 'multiElectrodeEachFreq'
        %% multi electrode each freq, with 1 timewindow
        switch DEC.saveCategory
            case 'phase'
                for iChan = DEC.chan2use
                    for ifreqDec = 1:numel(freq2use)
                        if DEC.nTime==1
                            tmp       = squeeze(data.phase(iChan,:,freq2use(ifreqDec),:));
                        else
                            tmp       = squeeze(data.phase(iChan,:,freq2use(ifreqDec),:))';
                        end
                        ALLFEAT   = [ALLFEAT sin(tmp), cos(tmp)];
                    end
                end
            case 'power'
                for iChan = DEC.chan2use
                    for ifreqDec = 1:numel(freq2use)
                        if DEC.nTime==1
                            ALLFEAT   = [ALLFEAT squeeze(data.power(iChan,:,freq2use(ifreqDec),:))];
                        else
                            ALLFEAT   = [ALLFEAT squeeze(data.power(iChan,:,freq2use(ifreqDec),:))'];
                        end
                    end
                end
            case 'powerNorm'
                for iChan = DEC.chan2use
                    for ifreqDec = 1:numel(freq2use)
                        if DEC.nTime==1
                            ALLFEAT   = [ALLFEAT squeeze(data.powerNorm(iChan,:,freq2use(ifreqDec),:))];
                        else
                            ALLFEAT   = [ALLFEAT squeeze(data.powerNorm(iChan,:,freq2use(ifreqDec),:))'];
                        end
                    end
                end
            case 'fft'
                for iChan = DEC.chan2use
                    for ifreqDec = 1:numel(freq2use)
                        if DEC.nTime==1
                            tmp     = squeeze(data.fft(iChan,:,freq2use(ifreqDec),:));
                        else
                            tmp     = squeeze(data.fft(iChan,:,freq2use(ifreqDec),:))';
                        end
                        ALLFEAT   = [ALLFEAT real(tmp), imag(tmp)];
                    end
                end
            case 'fftNonLinear'
                for iChan = DEC.chan2use
                    for ifreqDec = 1:numel(freq2use)
                        if DEC.nTime==1
                            tmp     = squeeze(data.fft(iChan,:,freq2use(ifreqDec),:));
                        else
                            tmp     = squeeze(data.fft(iChan,:,freq2use(ifreqDec),:))';
                        end
                        ALLFEAT   = [ALLFEAT real(tmp).^2, imag(tmp).^2];
                    end
                end
        end
        
    case 'multiElectrodeEachTimeEachFreq'
        
        %% multi electrode each time each freq, with 1 timewindow
        switch DEC.saveCategory
            case 'phase'
                for iTimeDec = 1:numel(time2use)
                    for iFreqDec = 1:numel(freq2use)
                        tmp     = squeeze(data.phase(:,time2use(iTimeDec),freq2use(iFreqDec),:))';
                        ALLFEAT    = [ALLFEAT sin(tmp), cos(tmp)];
                    end
                end
            case 'power'
                for iTimeDec = 1:numel(time2use)
                    for iFreqDec = 1:numel(freq2use)
                        ALLFEAT = [ALLFEAT squeeze(data.power(:,time2use(iTimeDec),freq2use(iFreqDec),:))'];
                    end
                end
            case 'powerNorm'
                for iTimeDec = 1:numel(time2use)
                    for iFreqDec = 1:numel(freq2use)
                        ALLFEAT = [ALLFEAT squeeze(data.powerNorm(:,time2use(iTimeDec),freq2use(iFreqDec),:))'];
                    end
                end
            case 'fft'
                for iTimeDec = 1:numel(time2use)
                    for iFreqDec = 1:numel(freq2use)
                        tmp = squeeze(data.fft(:,time2use(iTimeDec),freq2use(iFreqDec),:))';
                        ALLFEAT = [ALLFEAT real(tmp), imag(tmp)];
                    end
                end
            case 'erp'
                error('no separate frequencies in erp')
            case {'powerAndPhase'}
                for iTimeDec = 1:numel(time2use)
                    for iFreqDec = 1:numel(freq2use)
                        tmpPhase1   = squeeze(data.phase(:,time2use(iTimeDec),freq2use(iFreqDec),:))';
                        tmpPhase2   = [sin(tmpPhase1), cos(tmpPhase1)];
                        tmpPow1 = squeeze(data.power(:,time2use(iTimeDec),freq2use(iFreqDec),:))';
                        
                        DEC.nFeaturesPhase = size(tmpPhase2,2);
                        DEC.nFeaturesPower = size(tmpPow1,2);
                        ALLFEAT = [ALLFEAT tmpPhase2 tmpPow1];
                    end
                end
        end
    case 'multiElectrodeMultiTimeMultiFreq'
        
        switch DEC.saveCategory
            case 'phase'
                for iChan = DEC.chan2use
                    for iTime = 1:DEC.nTime
                        if DEC.nFreq==1
                            tmp       = squeeze(data.phase(iChan,iTime,:,:));
                        else
                            tmp       = squeeze(data.phase(iChan,iTime,:,:))';
                        end
                        ALLFEAT   = [ALLFEAT sin(tmp), cos(tmp)];
                    end
                end
            case 'power'
                for iChan = DEC.chan2use
                    for iTime = 1:DEC.nTime
                        if DEC.nFreq==1
                            ALLFEAT   = [ALLFEAT squeeze(data.power(iChan,iTime,:,:))];
                        else
                            ALLFEAT   = [ALLFEAT squeeze(data.power(iChan,iTime,:,:))'];
                        end
                    end
                end
            case 'powerNorm'
                for iChan = DEC.chan2use
                    for iTime = 1:DEC.nTime
                        if DEC.nFreq==1
                            ALLFEAT   = [ALLFEAT squeeze(data.powerNorm(iChan,iTime,:,:))];
                        else
                            ALLFEAT   = [ALLFEAT squeeze(data.powerNorm(iChan,iTime,:,:))'];
                        end
                    end
                end
            case 'fft'
                for iChan = DEC.chan2use
                    for iTime = 1:DEC.nTime
                        if DEC.nFreq==1
                            tmp     = squeeze(data.fft(iChan,iTime,:,:));
                        else
                            tmp     = squeeze(data.fft(iChan,iTime,:,:))';
                        end
                        ALLFEAT   = [ALLFEAT real(tmp), imag(tmp)];
                    end
                end
            case 'erp'
                for iChan = DEC.chan2use
                    for iTime = 1:DEC.nTime
                        if DEC.nFreq==1
                            ALLFEAT   = [ALLFEAT squeeze(data.erp(iChan,iTime,:,:))];
                        else
                            ALLFEAT   = [ALLFEAT squeeze(data.erp(iChan,iTime,:,:))'];
                        end
                    end
                end
        end
end

nFeatures = size(ALLFEAT,2);

if size(ALLFEAT,1) ~= DEC.nTrials
    error('number of features doesn''t match with number of trials')
end