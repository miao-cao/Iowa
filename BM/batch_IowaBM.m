function batch_IowaBM(subID,arrayID,iDec,tmpCondIdx)

%% all computations of SPG and decoding for Iowa BM data, run after
% batchPreprocess

tic
PARPOOL = 0;
if PARPOOL
    if isempty(gcp('nocreate'))
        parpool 
    end
end
    
if isdir('/Users/jochemvankempen/Dropbox/repositories/Tsuchiya/Iowa/')
    addpath(genpath('/Users/jochemvankempen/Dropbox/repositories/Tsuchiya/Iowa/'));
    addpath(genpath('/Users/jochemvankempen/Dropbox/repositories/Tsuchiya/setPathFunctions/'));
elseif isdir('/home/vjochem/Monash052/')%M2
    addpath(genpath('/home/vjochem/Monash052/jochem/repositories/scripts/human/'));
    addpath(genpath('/home/vjochem/Monash052/jochem/repositories/scripts/setPathFunctions/'));
    addpath(genpath('/home/vjochem/Monash052/jochem/Toolboxes/'));
    %     addpath(genpath('/home/vjochem/Monash052/jochem/human/Iowa/bin/'))
    addpath(genpath('/home/vjochem/Monash052/MATLAB_3rdPartyToolbox/Psychtoolbox'));
elseif isdir('/home/vjochem/M1/')%M1getDecodeSettings_TW_Iowa
    addpath(genpath('/home/vjochem/Monash052_scratch/repositories/scripts/human/Iowa/'));
    addpath(genpath('/home/vjochem/Monash052_scratch/repositories/scripts/human/communal/'));
    addpath(genpath('/home/vjochem/Monash052_scratch/repositories/scripts/setPathFunctions/'));
    addpath(genpath('/home/vjochem/Monash052_scratch/Toolboxes/'));
    addpath(genpath('/home/vjochem/Monash052_scratch/human/Iowa/bin/'))
    addpath(genpath('/home/vjochem/Monash052_scratch/MATLAB_3rdPartyToolbox/Psychtoolbox'));
    
elseif isdir('/export/kani/jochem/')
    addpath(genpath('/export/kani/jochem/repositories/scripts/human/Iowa/'));
    addpath(genpath('/export/kani/jochem/repositories/scripts/human/communal/'));
    addpath(genpath('/export/kani/jochem/repositories/scripts/setPathFunctions/'));
%     addpath(genpath('/export/kani/jochem/eeglab11_0_5_4b/'));
    addpath(genpath(['/export/kani/jochem/human/Iowa/bin/']))
    
    serverDir = '/export/kani/shared/';
    ToolboxDir = [serverDir '/MATLAB_3rdPartyToolbox/'];
    addpath(genpath([ToolboxDir 'Psychtoolbox']));
    
elseif isdir('/Users/jochemvankempen/')%imac monash
    addpath(genpath('/Users/jochemvankempen/Dropbox/repositories/scripts/'));
end


% subReadyForAnalysis = {'153','154a','154b','156','168','178','180a','180b','186','232'}; %used in across subject stats
subReadyForAnalysis = {'147','153','154','156','162','178'};

if ~exist('subID','var')
% %     subID = '147'
    subID = '153'
%     subID = '154'
%     subID = '156'
%     subID = '162'
%     subID = '173'
%     subID = '178'
end

subSpecs_IowaBM

% dbstop if error

% nChan per subject (bipolar) --> INPUT FOR MASSIVE
% 153   = 308
% 154a  = 312
% 154b  = 296
% 156   = 308
% 168   = 481, was 477 but now with unconnected channels included
% 178   = 598
% 180   = 562
% 186   = 571
% 232   = 313
% 242   =

% nChan per subject (bipolar) after removing NOT CONNECTED
% 153   = 308
% 154a  = 296
% 154b  = 280
% 156   = 308
% 168   = 477
% 178   = 570

%% select condition
EXP.dataset = 'BM';
if ~exist('tmpCondIdx') || isempty(tmpCondIdx)
    EXP.condIdx = 5;
else
    EXP.condIdx = tmpCondIdx;
end
getCondition_IowaBM

%% PLOT

PLOT.visible                    = 'on';
PLOT.onlySignificant            = 0;
PLOT.printPNG                   = 1;
PLOT.printEPS                   = 0;

PLOT.YLIM                       = [0.3 1];
PLOT.XLIM                       = [-0.5 1];
PLOT.markerSize                 = 20;

%% SPG Jobs
Job.computeSPG_Iowa     = 0;
Job.checkSPG_TW_Iowa    = 0;

%% decode Jobs
Job.decodeSPG_TW_Iowa   = 1;
Job.checkDecode_TW_Iowa = 1;
Job.plotDecode_TW_Iowa  = 1;

%% SPG settings

getSPGsettings_Iowa

%% decode settings

if exist('iDec','var')
    DEC.iDim2use           = iDec;
else
    DEC.iDim2use           = 4;
end

[DEC] = getDecodeSettings_Iowa(subID,DEC,SPG,[],EXP.dataset);

subID
DEC
EXP
bigMatrixBM=0;

%% SPG
if Job.computeSPG_Iowa
    disp('compute SPG')
    for iChan = arrayID
        val = ['li' num2str(iChan)];
        
        savefilenameBase = [subID '_' val '_TW_' num2str(length(SPG.TW)) '_SPG'];
        filename = [subID '_' num2str(length(SUB.vSession)) '_sessions_' val ':t_' SUB.ext];
        ERP = load([DIR.combine filename '.mat']);
        tmp{1} = ERP.allERP;
        computeSPG_Iowa(tmp,iChan,SPG,SUB,savefilenameBase,DIR.SPG)
    end
end

%% check SPG
if Job.checkSPG_TW_Iowa
    for iChan=arrayID
        val = ['li' num2str(iChan)];
        loadfilenameBase = [subID '_' val '_TW_' num2str(length(SPG.TW)) '_SPG'];
        savefilenameBase = [subID '_' val '_' EXP.cond '_' num2str(length(SPG.TW)) '_SPG'];
        checkSPG_TW_Iowa(subID,iChan,EXP,PLOT,loadfilenameBase,savefilenameBase,'BM')
    end
    loadfilenameBase=[];
end



%% decoding

if Job.decodeSPG_TW_Iowa
    clear savefilename tmpData    
    switch DEC.dimension
        case {'eachElectrodeEachTime','eachElectrodeEachFreq','eachElectrodeEachTimeEachFreq'}
            for iChan = arrayID
                disp(['decoding chan ' num2str(iChan)]);
                decode_eachElectrode_TW_Iowa(subID,iChan,DEC,SPG,EXP)
            end
        case {'multiElectrodeEachTime','multiElectrodeEachFreq','multiElectrodeEachTimeEachFreq','multiElectrodeMultiTimeMultiFreq'}
            decode_allChan_TW_Iowa(subID,DEC,SPG,EXP)
    end
end

%% check decoding (stats, permutation)
if Job.checkDecode_TW_Iowa
    checkDecode_TW_Iowa(subID,SPG,DEC,EXP,DIR)
end
%% 

if Job.plotDecode_TW_Iowa
    plotDecode_TW_Iowa(subReadyForAnalysis,SPG,DEC,EXP,DIR,PLOT,arrayID)
end
































