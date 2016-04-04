
if exist('iDim','var')
    DEC.saveCategory = DEC.allSaveCategory{iDim};
end

if ~exist('itt','var')
    itt=1;
end
DEC.times2decode = DEC.allTimes2decode{itt};

if ~exist('iff','var')
    iff = 1;
end
DEC.freq2decode         = DEC.allFreq2decode{iff};

if ~exist('iTW','var')
    iTW = PLOT.iTW;
end

if exist('DEC','var') && exist('EXP','var')
    dataDir = 'localizer';
    getDecodeDir_Iowa
end


[~, eachDec] = grep(DEC.allDimension,'each');
[~, multiDec] = grep(DEC.allDimension,'multi');

if eachDec(DEC.iDim2use) && ~multiDec(DEC.iDim2use)
    switch DEC.saveCategory
        case 'erp'
            DEC.ext     = ['rndmTr('  num2str(DEC.randomTrialSelection) '_' num2str(DEC.nTrials2select) ...
                ')_t(' num2str(DEC.times2decode(1)) '_' num2str(DEC.times2decode(2)) ')'...
                '_dsERP(' num2str(DEC.downsampleERP) '_' num2str(DEC.downsampleRate) ')_TW(' num2str(SPG.TW(iTW))  ')'...
                '_nFold(' num2str(DEC.nCrossVal) ')_L(' num2str(DEC.lambda,'%0.0e)')]; % extension for file name
            
        otherwise
            DEC.ext     = ['rndmTr('  num2str(DEC.randomTrialSelection) '_' num2str(DEC.nTrials2select) ...
                ')_t(' num2str(DEC.times2decode(1)) '_' num2str(DEC.times2decode(2)) ')'...
                '_f(' num2str(DEC.freq2decode(1)) '_' num2str(DEC.freq2decode(2)) ')_TW(' num2str(SPG.TW(iTW))  ')'...
                '_nFold(' num2str(DEC.nCrossVal) ')_L(' num2str(DEC.lambda,'%0.0e)')]; % extension for file name
    end
    
elseif multiDec(DEC.iDim2use) && ~eachDec(DEC.iDim2use)
    if ~exist('labelID','var')
        labelID = SUB.labelID;
    end
    
    switch DEC.saveCategory
        case 'erp'
            
            DEC.ext     = [DEC.channels2decode '_rndmTr('  num2str(DEC.randomTrialSelection) '_' num2str(DEC.nTrials2select) ...
                ')_t(' num2str(DEC.times2decode(1)) '_' num2str(DEC.times2decode(2)) ')'...
                '_dsERP(' num2str(DEC.downsampleERP) '_' num2str(DEC.downsampleRate) ')_TW(' num2str(SPG.TW(iTW))  ')'...
                '_' 'sepGrid(' num2str(DEC.separateStrips) '_' DEC.grid2decode{iGrid2decode} '_' labelID ')'  ...
                '_nFold(' num2str(DEC.nCrossVal) ')_L(' num2str(DEC.lambda,'%0.0e)')]; % extension for file name
            
        otherwise
            
            DEC.ext     = [DEC.channels2decode '_rndmTr('  num2str(DEC.randomTrialSelection) '_' num2str(DEC.nTrials2select) ...
                ')_t(' num2str(DEC.times2decode(1)) '_' num2str(DEC.times2decode(2)) ')'...
                '_f(' num2str(DEC.freq2decode(1)) '_' num2str(DEC.freq2decode(2)) ')_TW(' num2str(SPG.TW(iTW))  ')'...
                '_' 'sepGrid(' num2str(DEC.separateStrips) '_' DEC.grid2decode{iGrid2decode} '_' labelID ')'  ...
                '_nFold(' num2str(DEC.nCrossVal) ')_L(' num2str(DEC.lambda,'%0.0e)')]; % extension for file name
    end
    
end
% DEC.extOld  = ['nFold_' num2str(DEC.nCrossVal) '_L' num2str(DEC.lambda,'%0.0e')];

