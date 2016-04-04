function [DEC] = getDecodeSettings_Iowa(subID,DEC,SPG,lambda,dataset)
% set decoding settings for different decoding strategies.


DEC.meanHighFreq             = 0;
% DP.freq2meanHigh            = [40 120; 120 200];
% DP.freq2decode              = [0 round(fs/2)];
% DP.freq2decode              = [0 200];

DEC.permute                  = 0;%shuffle trials accross cond
DEC.nPermutes                = 100;

DEC.permutePAC               = 0;%shuffle power compared to phase values in PAC,
% DP.permuteCondition         = 'acrossCondition'; %shuffle trials across all cond (for PAC)
DEC.permuteCondition         = 'withinCondition'; %shuffle trials within condition (for PAC), keep condition specific information

DEC.samplingRate2test        = 100;%timepoints

DEC.freq2checkPower          = [40 200];
DEC.meanPowerFreq            = 1;
DEC.freq2meanPower           = [40 120; 120 200];
DEC.freq2checkPhase          = [0 20];

DEC.powerTimeWindow          = 1; % will take multiple datapoints, linearly spaced timepoints (n = movingwinLow(1)/movingwinHigh(1)) over the size of the movingwinLow(1).

DEC.downsampleERP           = 1;
DEC.downsampleRate          = 4; % use 1:DEC.downsampleRate:end


switch dataset
    case 'localizer'
        DEC.task = 'IowaLocalizer';
    case 'CFS'
        DEC.task = 'IowaCFS';
    case 'BM'
        DEC.task = 'IowaBM';
end

DEC.nCrossVal          = 10;
DEC.permute            = 0;

DEC.allDimension       = {'eachElectrodeEachTime','eachElectrodeEachFreq','eachElectrodeEachTimeEachFreq',...
                          'eachElectrodeMultiTimeMultiFreq',... % decoding combining times and frequencies
                          'eachElectrodeCombinePlot',... % decoding per channel
                          'multiElectrodeEachTime','multiElectrodeEachFreq','multiElectrodeEachTimeEachFreq',... % decoding combining channels, each time/freq/timeFreq
                          'multiElectrodeMultiTimeMultiFreq',... % decoding combining channels, times and frequencies
                          'multiElectrodeCombinePlot'};% plot decoding, one figure with all multi channel decoding strategies for phase and power
                            
DEC.dimension          = DEC.allDimension{DEC.iDim2use};

DEC.statsCheckDecode = 1;

DEC.allDecodeSPG             = {'FFT','MTSPEC'}; %
DEC.decodeSPGIdx             = 2;
DEC.decodeSPG                = DEC.allDecodeSPG{DEC.decodeSPGIdx};
DEC.FDR = 0.05;

%%
switch DEC.dimension
    case {'eachElectrodeEachTimeEachFreq','multiElectrodeEachTimeEachFreq'}
        DEC.allTimes2decode          = {[-0.5 1]};
        DEC.allFreq2decode           = {[1 200]};
    case {'eachElectrodeEachTime','multiElectrodeEachTime'}
        DEC.allTimes2decode          = {[-0.5 1]};
        DEC.allFreq2decode           = {[1 200]};
    case {'eachElectrodeEachFreq','multiElectrodeEachFreq'}
        DEC.allTimes2decode          = {[-0.5 1];[-0.5 0];[0 0.5];[0.5 1]};
        DEC.allFreq2decode           = {[1 200]};
    case {'eachElectrodeMultiTimeMultiFreq','multiElectrodeMultiTimeMultiFreq'}
        DEC.allTimes2decode         = {[0 0.5],[-0.2 0.7],[-0.5 0],[0.5 1],[-0.5 1],[0.2 0.5]};
        DEC.allFreq2decode          = {[1 200]};
    case {'eachElectrodeCombinePlot','multiElectrodeCombinePlot'}
        DEC.allTimes2decode          = {[-0.5 1]};
        DEC.allFreq2decode           = {[1 200]};
end

%
if ~exist('lambda','var') || isempty(lambda)
    DEC.lambda               = [1e8];
else
    DEC.lambda = lambda;
end

DEC.nLam                  = 1;
DEC.randomSampleTest      = .3;
DEC.spaceAverage          = 0;

DEC.ext = ['nFold(' num2str(DEC.nCrossVal) ')_L(' num2str(DEC.lambda,'%0.0e)')];
DEC.extOld = ['nFold_' num2str(DEC.nCrossVal) '_L' num2str(DEC.lambda,'%0.0e')];

DEC.allSaveCategory = {'phase','power','erp','logPowerAndPhase','fft','lowLogPower','highLogPower','highLogPowerAndPhase','power','logBasePower','powerAndPhase','pac','fftNonLinear','logPowerPlus1','logPowerPlus1AndPhase'};

% DEC.independentChan = 1; %only independent bipolar channels (when combining channels)
% % DP.independentChanDir = 'horizontal'; 
% DEC.independentChanDir = 'vertical'; 

DEC.nTW      = [10];

DEC.randomTrialSelection     = 0; %if 0, all trials are used, if 1 it selects a random number of trials from each condition
DEC.nTrials2select           = 20; %randomly selected trials per condition
DEC.separateStrips           = 1; %
DEC.channels2decode          = 'bipolar';
%         DEC.grid2decode              = {'allSeparate','ventral','temporal'};
DEC.grid2decode              = {'ventral','temporal','frontal','parietal'};
%         end
switch DEC.separateStrips
    case 0
        DEC.nGrids2decode = 0;
    case 1
        DEC.nGrids2decode = length(DEC.grid2decode);
end


switch DEC.dimension
    case 'eachElectrodeEachTime'
        DEC.vDim     = [1 2 3];
    case 'eachElectrodeEachFreq'
        DEC.vDim     = [1 2];
    case 'eachElectrodeEachTimeEachFreq'
        DEC.vDim     = [1 2];
    case 'eachElectrodeMultiTimeMultiFreq'
        DEC.vDim     = [1 2 3];
    case 'eachElectrodeCombinePlot'
        DEC.vDim     = [1 2 3];
    case 'multiElectrodeEachTime'
        DEC.vDim     = [1 2 3];
    case 'multiElectrodeEachFreq'
        DEC.vDim    = [1 2 ] ;
    case 'multiElectrodeEachTimeEachFreq'
        DEC.vDim    = [1 2 ] ;
    case 'multiElectrodeMultiTimeMultiFreq'
        DEC.vDim     = [1 2 3];
    case 'multiElectrodeCombinePlot'
        DEC.vDim     = [1 2 3];
end

