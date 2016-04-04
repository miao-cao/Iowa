function [DEC] = getDecodeSettings_Iowa(subID,DEC,SPG,lambda,dataset)
% set decoding settings for different decoding strategies.

DEC.permute                 = 0; % shuffle trials accross conditions
DEC.nPermutes               = 100;
DEC.nCrossVal               = 10; % number of cross validations, is set to one later in this script for multiChan when DEC.randChanSelection==1;
DEC.statsCheckDecode        = 1; % check significance of dec accuracy against permutations
DEC.FDR                     = 0.05; % false discovery rate
DEC.searchlightChan         = 1; % group information of multiple nearby channels.
DEC.searchlightMinChan      = 4; % minimum number of channels used in searlight
DEC.searchlight             = 1; % get surrounding time and frequency points. if decoding strategy is multiTimeMultiFreq, automatically is 0.
DEC.searchlightTimeWin      = [-1 1];
DEC.searchlightFreqWin      = [-2 2];
DEC.randChanSelection       = 1; % will select DEC.randChanPercentage from channels to perform the decoding procedure
DEC.randChanPercentage      = 50; % of chan selected in each DEC.randChanCrossVal  
DEC.randChanCrossVal        = 20;

DEC.downsampleERP           = 1; % 1: downsample erp just before decoding. 0: do not.
DEC.downsampleRate          = 4; % use 1:DEC.downsampleRate:end


switch dataset
    case 'localizer'
        DEC.task = 'IowaLocalizer';
    case 'CFS'
        DEC.task = 'IowaCFS';
    case 'BM'
        DEC.task = 'IowaBM';
end

%% select dec strategy
DEC.allDimension       = {...
    'eachElectrodeEachTime',...           % 1: combine datapoints (freq/samples) for a specific time window
    'eachElectrodeEachFreq',...           % 2: combine timepoints to get frequency accuracy
    'eachElectrodeEachTimeEachFreq',...   % 3: decode each time freq point
    'eachElectrodeMultiTimeMultiFreq',... % 4: decoding combining times and frequencies
    'eachElectrodeCombinePlot',...        % 5: plot one figure with eachTime, eachFreq and eachTimeEachFreq
    'multiElectrodeEachTime',...          % 6
    'multiElectrodeEachFreq',...          % 7
    'multiElectrodeEachTimeEachFreq',...  % 8
    'multiElectrodeMultiTimeMultiFreq',...% 9
    'multiElectrodeCombinePlot'};         % 10

DEC.dimension           = DEC.allDimension{DEC.iDim2use}; % select one of the above strategies


%% define time and frequency windows, %% select vDim,
% in cell structure, it loops across several time and freq windows

DEC.allSaveCategory = {'phase','powerNorm','erp','powerNorm'};

switch DEC.dimension
    case {'eachElectrodeEachTime','multiElectrodeEachTime'}
        DEC.allTimes2decode          = {[-0.5 1]};
        DEC.allFreq2decode           = {[1 200]};
        DEC.allFreq2decode           = {[1 200],[1 30]};
%         DEC.phaseFreq2decode         = {[1 30]};
        DEC.vDim                     = [1 2 3];

    case {'eachElectrodeEachFreq','multiElectrodeEachFreq'}
%         DEC.allTimes2decode          = {[-0.5 1];[-0.5 0];[0 0.5];[0.5 1]};
%         DEC.allTimes2decode          = {[-0.5 1];[0 0.5];};
        DEC.allTimes2decode          = {[-0.5 1]};
        DEC.allFreq2decode           = {[1 200]};
        DEC.vDim                     = [1 2 ];
    case {'eachElectrodeEachTimeEachFreq','multiElectrodeEachTimeEachFreq'}
        DEC.allTimes2decode          = {[-0.5 1]};
        DEC.allFreq2decode           = {[1 200]};
        DEC.vDim                     = [1 2 ];
    case {'eachElectrodeMultiTimeMultiFreq','multiElectrodeMultiTimeMultiFreq'}
%         DEC.allTimes2decode         = {[0 0.5],[-0.2 0.7],[-0.5 0],[0.5 1],[-0.5 1],[0.2 0.5]};
%         DEC.allTimes2decode         = {[0 0.5],[-0.5 1],[0.2 0.5]};
%         DEC.allTimes2decode          = {[-0.5 1],[0 0.5]};
        DEC.allFreq2decode           = {[1 200],[1 30],[50 150]};
        DEC.allTimes2decode          = {[0 0.5]};
%         DEC.allFreq2decode           = {[1 30],[50 150]};
        DEC.searchlightTF              = 0; % this decoding strategy already selects multiple time and frequency points.
        DEC.vDim                     = [1 2 3 ];
    case {'eachElectrodeCombinePlot','multiElectrodeCombinePlot'}
        DEC.allTimes2decode          = {[-0.5 1]};
        DEC.allFreq2decodePhase      = {[1 30]};
        DEC.allFreq2decodePower      = {[1 200]};
        DEC.vDim                     = [1 2 3 ];
end

%% lambda, reqularisation
if ~exist('lambda','var') || isempty(lambda)
    DEC.lambda               = [1e8];
else
    DEC.lambda = lambda;
end

DEC.nLam                  = 1;
DEC.randomSampleTest      = .3;
DEC.spaceAverage          = 0;

%%

[~, eachDec] = grep(DEC.allDimension,'each');
[~, multiDec] = grep(DEC.allDimension,'multi');

if multiDec(DEC.iDim2use) && DEC.randChanSelection
    DEC.nCrossVal = 1;
else
    DEC.randChanSelection=0;
end


%%
% DEC.independentChan = 1; %only independent bipolar channels (when combining channels)
% % DP.independentChanDir = 'horizontal';
% DEC.independentChanDir = 'vertical';

DEC.nTW      = [10];% this index refers to the time windows (TW) defined in getSPGsettings.

DEC.randomTrialSelection     = 0; %if 0, all trials are used, if 1 it selects a random number of trials (DEC.nTrials2select) from each condition. NOTE: CHECK CODE!!!
DEC.nTrials2select           = 20; %randomly selected trials per condition
DEC.separateStrips           = 1; %
DEC.channels2decode          = 'bipolar';
%         DEC.grid2decode              = {'allSeparate','ventral','temporal'};
% DEC.gr id2decode              = {'ventral','temporal','frontal','parietal'};
DEC.grid2decode              = {'ventral','temporal'};
%         end
switch DEC.separateStrips
    case 0
        DEC.nGrids2decode = 0;
    case 1
        DEC.nGrids2decode = length(DEC.grid2decode);
end

