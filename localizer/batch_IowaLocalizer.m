function batch_IowaLocalizer(subID,arrayID,tmpDecIdx,tmpCondIdx)
% function batchTW_IowaLocalizer(subID,arrayID)
% function batchTW_IowaLocalizer(arrayID)
% run this script from combine sessions Iowa Face Localizer
tic

PARPOOL = 0;
if PARPOOL
    if isempty(gcp('nocreate'))
        parpool 
    end
end

if isdir([ filesep 'Users' filesep 'jochemvankempen' filesep 'Dropbox' filesep 'repositories' filesep 'Tsuchiya' filesep 'Iowa' filesep ])
    addpath(genpath([ filesep 'Users' filesep 'jochemvankempen' filesep 'Dropbox' filesep 'repositories' filesep 'Tsuchiya' filesep 'Iowa' filesep ]));
    addpath(genpath([ filesep 'Users' filesep 'jochemvankempen' filesep 'Dropbox' filesep 'repositories' filesep 'Tsuchiya' filesep 'setPathFunctions' filesep ]));
elseif isdir(['C:' filesep 'Users' filesep 'njv20' filesep]) % newcastle university
    addpath(genpath([ 'C:' filesep 'Users' filesep 'njv20' filesep 'Dropbox' filesep 'repositories' filesep 'Tsuchiya' filesep 'Iowa' filesep ]));
    addpath(genpath([ 'C:' filesep 'Users' filesep 'njv20' filesep 'Dropbox' filesep 'repositories' filesep 'Tsuchiya' filesep 'setPathFunctions' filesep ]));
elseif isdir([ filesep 'gpfs' filesep 'M2Home' filesep 'projects' filesep 'Monash052' filesep 'jochem' filesep ])
    addpath(genpath([ filesep 'gpfs' filesep 'M2Home' filesep 'projects' filesep 'Monash052' filesep 'jochem' filesep 'repositories' filesep 'scripts' filesep 'human' filesep 'Iowa' filesep ]));
    addpath(genpath([ filesep 'gpfs' filesep 'M2Home' filesep 'projects' filesep 'Monash052' filesep 'jochem' filesep 'repositories' filesep 'scripts' filesep 'setPathFunctions' filesep ]));
    addpath(genpath([ filesep 'home' filesep 'vjochem' filesep 'Monash052' filesep 'jochem' filesep 'Toolboxes' filesep ]));
    addpath(genpath([ filesep 'home' filesep 'vjochem' filesep 'Monash052' filesep 'MATLAB_3rdPartyToolbox' filesep 'Psychtoolbox']));
elseif isdir([ filesep 'home' filesep 'vjochem' filesep 'M1' filesep ])%M1getDecodeSettings_TW_Iowa
    addpath(genpath([ filesep 'home' filesep 'vjochem' filesep 'Monash052_scratch' filesep 'repositories' filesep 'scripts' filesep 'human' filesep 'Iowa' filesep ]));
    addpath(genpath([ filesep 'home' filesep 'vjochem' filesep 'Monash052_scratch' filesep 'repositories' filesep 'scripts' filesep 'human' filesep 'communal' filesep ]));
    addpath(genpath([ filesep 'home' filesep 'vjochem' filesep 'Monash052_scratch' filesep 'repositories' filesep 'scripts' filesep 'setPathFunctions' filesep ]));
    addpath(genpath([ filesep 'home' filesep 'vjochem' filesep 'Monash052_scratch' filesep 'Toolboxes' filesep ]));
    addpath(genpath([ filesep 'home' filesep 'vjochem' filesep 'Monash052_scratch' filesep 'MATLAB_3rdPartyToolbox' filesep 'Psychtoolbox']));
elseif isdir([filesep 'export' filesep 'kani' filesep 'jochem' filesep])
    addpath(genpath([ filesep 'export' filesep 'kani' filesep 'jochem' filesep 'repositories' filesep 'scripts' filesep 'human' filesep 'Iowa' filesep ]));
    addpath(genpath([ filesep 'export' filesep 'kani' filesep 'jochem' filesep 'repositories' filesep 'scripts' filesep 'human' filesep 'communal' filesep ]));
    addpath(genpath([ filesep 'export' filesep 'kani' filesep 'jochem' filesep 'repositories' filesep 'scripts' filesep 'setPathFunctions' filesep ]));
    %     addpath(genpath([ filesep 'export' filesep 'kani' filesep 'jochem' filesep 'eeglab11_0_5_4b' filesep ]));
    
    serverDir = [ filesep 'export' filesep 'kani' filesep 'shared' filesep ];
    ToolboxDir = [serverDir filesep 'MATLAB_3rdPartyToolbox' filesep];
    addpath(genpath([ToolboxDir 'Psychtoolbox']));
end

% subReadyForAnalysis = {'153','154a','154b','156','168','178','180a','180b','186','232'}; %used in across subject stats
subReadyForAnalysis = {'153','154','156','168','180','232'};
if ~exist('subID','var')
    subID = '153'
%     subID = '154'
%     subID = '156'
%     subID = '168'
%     subID = '173'
%     subID = '178'
%     subID = '180'
%     subID = '181'
%     subID = '186'
%     subID = '206'
%     subID = '232'
%     subID = '242'
end

subSpecs_IowaLocalizer

if skipChan
    return
end
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
if exist('tmpCondIdx','var')
    EXP = getConditions_IowaLocalizer(tmpCondIdx);
else
    EXP = getConditions_IowaLocalizer;
end
EXP.dataset = 'localizer';
%% PLOT

PLOT.visible                    = 'on';
PLOT.onlySignificant            = 1;
PLOT.printPNG                   = 1;
PLOT.printEPS                   = 0;

PLOT.YLIM                       = [0.1 1];
PLOT.XLIM                       = [-0.5 1];
PLOT.markerSize                 = 20;
%% SPG Jobs
Job.computeSPG_Iowa  = 0;
Job.checkSPG_TW_Iowa = 0;

%% decode Jobs
Job.decodeSPG_TW_Iowa                                                   = 1;
Job.checkDecode_TW_Iowa                                                 = 1;
Job.plotDecode_TW_Iowa                                                  = 1;

%% SPG settings

getSPGsettings_Iowa;

%% decode settings

if exist('tmpDecIdx','var')
    DEC.iDim2use            = tmpDecIdx;
else
    DEC.iDim2use            = 7;
end

[DEC] = getDecodeSettings_Iowa(subID,DEC,SPG,[],EXP.dataset);

subID
DEC
EXP
%% SPG
if Job.computeSPG_Iowa
    disp('compute SPG')
    for iChan = arrayID
        val = ['li' num2str(iChan)];
        savefilenameBase = [subID '_' val '_TW_' num2str(length(SPG.TW)) '_SPG'];
        filename = [subID '_' num2str(length(SUB.vSession)) '_' SUB.stimCat{SUB.vSession(1)} '_sessions_' val ':t_' SUB.ext];
        
        ERP = load([DIR.combine filename '.mat']);
        computeSPG_Iowa(ERP.allERP,iChan,SPG,SUB,savefilenameBase,DIR.SPG)
    end
end
%% check SPG
if Job.checkSPG_TW_Iowa
    for iChan=arrayID
        val = ['li' num2str(iChan)];
        loadfilenameBase = [subID '_' val '_TW_' num2str(length(SPG.TW)) '_SPG'];
        savefilenameBase = [subID '_' val '_' EXP.cond '_' num2str(length(SPG.TW)) '_SPG'];
        checkSPG_TW_Iowa(subID,iChan,EXP,PLOT,loadfilenameBase,savefilenameBase,'localizer')
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
%% check decoding (including permutation)
if Job.checkDecode_TW_Iowa
    checkDecode_TW_Iowa(subID,SPG,DEC,EXP,DIR)
end

%% plot decoding results

if Job.plotDecode_TW_Iowa
    plotDecode_TW_Iowa(subID,SPG,DEC,EXP,DIR,PLOT,arrayID)
end

end











