function batch_IowaCFS(subID,arrayID,iDecodeType,EXP,lambda,iDim2use)
% function batch_IowaCFS(subID)
%% all computations of SPG and decoding for Iowa Localizer data, run after
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
elseif isdir('/gpfs/M2Home/projects/Monash052/jochem/')
    addpath(genpath('/gpfs/M2Home/projects/Monash052/jochem/repositories/scripts/human/Iowa/'));
    addpath(genpath('/gpfs/M2Home/projects/Monash052/jochem/repositories/scripts/human/communal/'));
    addpath(genpath('/gpfs/M2Home/projects/Monash052/jochem/repositories/scripts/setPathFunctions/'));
    addpath(genpath('/home/vjochem/Monash052/jochem/Toolboxes/'));
    addpath(genpath('/home/vjochem/Monash052/MATLAB_3rdPartyToolbox/Psychtoolbox'));
elseif isdir('/home/vjochem/M1/')%M1getDecodeSettings_TW_Iowa
    addpath(genpath('/home/vjochem/Monash052_scratch/repositories/scripts/human/Iowa/'));
    addpath(genpath('/home/vjochem/Monash052_scratch/repositories/scripts/human/communal/'));
    addpath(genpath('/home/vjochem/Monash052_scratch/repositories/scripts/setPathFunctions/'));
    addpath(genpath('/home/vjochem/Monash052_scratch/Toolboxes/'));
    addpath(genpath('/home/vjochem/Monash052_scratch/MATLAB_3rdPartyToolbox/Psychtoolbox'));
    
elseif isdir('/export/kani/jochem/')
    addpath(genpath('/export/kani/jochem/repositories/scripts/human/Iowa/'));
    addpath(genpath('/export/kani/jochem/repositories/scripts/human/communal/'));
    addpath(genpath('/export/kani/jochem/repositories/scripts/setPathFunctions/'));
    %     addpath(genpath('/export/kani/jochem/eeglab11_0_5_4b/'));
    
    serverDir = '/export/kani/shared/';
    ToolboxDir = [serverDir '/MATLAB_3rdPartyToolbox/'];
    addpath(genpath([ToolboxDir 'Psychtoolbox']));
    
elseif isdir('/Users/Jochem/Documents/UvA/')
    addpath(genpath('/Users/Jochem/Dropbox/repositories/scripts/'));
elseif isdir('/Users/jochemvankempen/')%imac monash
    addpath(genpath('/Users/jochemvankempen/Dropbox/repositories/scripts/'));
end


% subReadyForAnalysis = {'153','156','168','178','180a','180b','186','232'}; %used in across subject stats
subReadyForAnalysis = {'147','153','154','168','178'};

if ~exist('subID','var')
%     subID = '147'
%     subID = '149'
    subID = '153'
%     subID = '154a'
%     subID = '154b'
%     subID = '154'
%     subID = '156'
%     subID = '168'
%     subID = '173'
%     subID = '178'
%     subID = '180'
%     subID = '181'
%     subID = '186'
%     subID = '206'
%     subID = '222'
%     subID = '232'
%     subID = '242'
end

subSpecs_IowaCFS
if skipChan
    return
end
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

%%
EXP.dataset = 'CFS';
EXP.decodeInterval    = 'first'; %second / all

%% PLOT

PLOT.visible                    = 'off';
PLOT.onlySignificant            = 0;
PLOT.printPNG                   = 1;
PLOT.printEPS                   = 0;

PLOT.YLIM                       = [0.3 1];
PLOT.XLIM                       = [-0.5 1];
PLOT.markerSize                 = 20;

%% Beh, LFP
Job.checkBehavior_IowaCFS       = 0;
Job.check_combineSessions_Iowa  = 0;

%% Jobs SPG

Job.computeSPG_Iowa  = 0;
Job.checkSPG_TW_Iowa = 0;

%% Jobs Decoding

Job.decodeSPG_TW_Iowa                           = 1;
Job.checkDecode_TW_Iowa                         = 1;
Job.plotDecode_TW_Iowa                          = 1;

%% set SPG Params
getSPGsettings_Iowa

%% get conditions
if ~exist('iDecodeType','var')
    iDecodeType = 82;
end

getDecodeTypeDecodeMode
%% decode settings

if exist('iDim2use','var')
    DEC.iDim2use            = iDim2use;
else
    DEC.iDim2use             =8;
end

[DEC] = getDecodeSettings_Iowa(subID,DEC,SPG,[],EXP.dataset);

%% Behav

if Job.checkBehavior_IowaCFS
    checkBehavior_IowaCFS(subID,PLOT)
end

%% ERP
if Job.check_combineSessions_Iowa
    parfor iChan = arrayID
        check_combineSessions_Iowa(subID,iChan,EXP,PLOT,'CFS')
    end
end

%% SPG
if Job.computeSPG_Iowa
    disp(['compute SPG for sub ' subID])
    for iChan = arrayID
        val = ['li' num2str(iChan)];
        
        savefilenameBase = [subID '_' val '_TW_' num2str(length(SPG.TW)) '_SPG'];
        loadfilename = ['cleanTrials_' num2str(iChan) '_' subID SUB.ext];
        load([DIR.clean '/' loadfilename '.mat'],'removedData');
        data{1} = squeeze(removedData(:,:,1));%interval 1
        data{2} = squeeze(removedData(:,:,2));%interval 2
        computeSPG_Iowa(data,iChan,SPG,SUB,savefilenameBase,DIR.SPG)
        
        %     parfor iChan=arrayID
        %         computeSPG_IowaCFS(subID,iChan,SPG,DEC,C,EXP,params,movingwin)
        %     end
    end
end


%% check SPG
if Job.checkSPG_TW_Iowa
    for iChan=arrayID
        val = ['li' num2str(iChan)];
        loadfilenameBase = [subID '_' val '_TW_' num2str(length(SPG.TW)) '_SPG'];
        savefilenameBase = [subID '_' val '_' EXP.cond '_' num2str(length(SPG.TW)) '_SPG'];
        checkSPG_TW_Iowa(subID,iChan,EXP,PLOT,loadfilenameBase,savefilenameBase,'CFS')
    end
    loadfilenameBase=[];
end

%% decoding
if Job.decodeSPG_TW_Iowa
    switch DEC.dimension
        case {'eachElectrodeEachTime','eachElectrodeEachFreq','eachElectrodeEachTimeEachFreq','eachElectrodeMultiTimeMultiFreq'}
            for iChan = arrayID
                disp(['decode chan ' num2str(iChan)])
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

%% Plot decoding results
if Job.plotDecode_TW_Iowa
    plotDecode_TW_Iowa(subID,SPG,DEC,EXP,DIR,PLOT,arrayID)
end











