function batch_Iowa(EXP,subID,arrayID,tmpDecIdx,tmpCondIdx)

tic

PARPOOL = 0;
if PARPOOL
    if isempty(gcp('nocreate'))
        parpool 
    end
end

if isdir([ filesep 'Users' filesep 'jochemvankempen' filesep 'Dropbox' filesep 'repositories' filesep 'Tsuchiya' filesep 'Iowa' filesep ])
    %laptop
    addpath(genpath([ filesep 'Users' filesep 'jochemvankempen' filesep 'Dropbox' filesep 'repositories' filesep 'Tsuchiya' filesep 'Iowa' filesep ]));
    addpath(genpath([ filesep 'Users' filesep 'jochemvankempen' filesep 'Dropbox' filesep 'repositories' filesep 'Tsuchiya' filesep 'setPathFunctions' filesep ]));
    addpath(genpath([ filesep 'Users' filesep 'jochemvankempen' filesep 'Dropbox' filesep 'repositories' filesep 'setPath' filesep ]));
    addpath(genpath([ filesep 'Users' filesep 'jochemvankempen' filesep 'Documents' filesep 'MATLAB' filesep 'Toolboxes' filesep 'Chronux_2_10' filesep ]));
elseif isdir(['C:' filesep 'Users' filesep 'njv20' filesep]) 
    % newcastle university
    addpath(genpath([ 'C:' filesep 'Users' filesep 'njv20' filesep 'Dropbox' filesep 'repositories' filesep 'Tsuchiya' filesep 'Iowa' filesep ]));
    addpath(genpath([ 'C:' filesep 'Users' filesep 'njv20' filesep 'Dropbox' filesep 'repositories' filesep 'Tsuchiya' filesep 'setPathFunctions' filesep ]));
    addpath(genpath([ 'C:' filesep 'Program Files' filesep 'Psychtoolbox' filesep]));
    addpath(genpath([ 'C:' filesep 'Users' filesep 'njv20' filesep 'Dropbox' filesep 'repositories' filesep 'Toolboxes' filesep]));
elseif isdir([ filesep 'gpfs' filesep 'M2Home' filesep 'projects' filesep 'Monash052' filesep 'jochem' filesep ])
    % Massive2
    addpath(genpath([ filesep 'gpfs' filesep 'M2Home' filesep 'projects' filesep 'Monash052' filesep 'jochem' filesep 'repositories' filesep 'scripts' filesep 'human' filesep 'Iowa' filesep ]));
    addpath(genpath([ filesep 'gpfs' filesep 'M2Home' filesep 'projects' filesep 'Monash052' filesep 'jochem' filesep 'repositories' filesep 'scripts' filesep 'setPathFunctions' filesep ]));
    addpath(genpath([ filesep 'home' filesep 'vjochem' filesep 'Monash052' filesep 'jochem' filesep 'Toolboxes' filesep ]));
    addpath(genpath([ filesep 'home' filesep 'vjochem' filesep 'Monash052' filesep 'MATLAB_3rdPartyToolbox' filesep 'Psychtoolbox']));
elseif isdir([ filesep 'home' filesep 'vjochem' filesep 'M1' filesep ])
    % Massive1
    addpath(genpath([ filesep 'home' filesep 'vjochem' filesep 'Monash052_scratch' filesep 'repositories' filesep 'scripts' filesep 'human' filesep 'Iowa' filesep ]));
    addpath(genpath([ filesep 'home' filesep 'vjochem' filesep 'Monash052_scratch' filesep 'repositories' filesep 'scripts' filesep 'human' filesep 'communal' filesep ]));
    addpath(genpath([ filesep 'home' filesep 'vjochem' filesep 'Monash052_scratch' filesep 'repositories' filesep 'scripts' filesep 'setPathFunctions' filesep ]));
    addpath(genpath([ filesep 'home' filesep 'vjochem' filesep 'Monash052_scratch' filesep 'Toolboxes' filesep ]));
    addpath(genpath([ filesep 'home' filesep 'vjochem' filesep 'Monash052_scratch' filesep 'MATLAB_3rdPartyToolbox' filesep 'Psychtoolbox']));
elseif isdir([filesep 'export' filesep 'kani' filesep 'jochem' filesep])
    % Kani server
    addpath(genpath([ filesep 'export' filesep 'kani' filesep 'jochem' filesep 'repositories' filesep 'scripts' filesep 'human' filesep 'Iowa' filesep ]));
    addpath(genpath([ filesep 'export' filesep 'kani' filesep 'jochem' filesep 'repositories' filesep 'scripts' filesep 'human' filesep 'communal' filesep ]));
    addpath(genpath([ filesep 'export' filesep 'kani' filesep 'jochem' filesep 'repositories' filesep 'scripts' filesep 'setPathFunctions' filesep ]));
    %     addpath(genpath([ filesep 'export' filesep 'kani' filesep 'jochem' filesep 'eeglab11_0_5_4b' filesep ]));
    
    serverDir = [ filesep 'export' filesep 'kani' filesep 'shared' filesep ];
    ToolboxDir = [serverDir filesep 'MATLAB_3rdPartyToolbox' filesep];
    addpath(genpath([ToolboxDir 'Psychtoolbox']));
end

%% get subID and subject and condition specifics

if ~exist('subID','var')
    subID = '153'
%     subID = '154'
%     subID = '156'
%     subID = '162'
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

if ~exist('EXP','var') || ~isfield(EXP,'dataset')  
    EXP.dataset = 'localizer';
    EXP.dataset = 'CFS';
end

EXP.allSubID = {'147','153','154','156','162','168','173','178','180','181','186','232','242'};

% EXP.allSubID = {'147','153','154','156','162','168','173','178','180','181','186','232','242'};
switch EXP.dataset
    case 'localizer'
        subSpecs_IowaLocalizer
        if exist('tmpCondIdx','var')
            EXP = getCondition_IowaLocalizer(EXP,subID,tmpCondIdx);
        else
            EXP = getCondition_IowaLocalizer(EXP,subID);
        end
        
        EXP.subIdx = [2 3 4 6 8 ];
%         subReadyForAnalysis = {'153','154','156','168','180'};
        EXP.subReadyForAnalysis = EXP.allSubID(EXP.subIdx);
        
    case 'CFS'
        
        subSpecs_IowaCFS
        if ~exist('tmpCondIdx','var')
            EXP.condIdx = 11;%cont3_onoff_hitt
            EXP.condIdx = 5;
            EXP.condIdx = 28;
        end
        getCondition_IowaCFS
        EXP.decodeInterval = 'first'; % interval 1 ('first'), 2 ('second') or both ('all') 
        
%         subReadyForAnalysis = {'147','153','154a','168','178'};
        EXP.subIdx = [1 2 3 6 8];
        EXP.subReadyForAnalysis = EXP.allSubID(EXP.subIdx);
        
        
        % select subject 154a instead of 154. This excludes the 3rd session
        % which is corrupted.
%         if strcmpi(subID,'154')
%             subID = '154a';
%         end
%         [~,tmp]=grep(EXP.subReadyForAnalysis,'154');
%         if sum(tmp)
%             EXP.subReadyForAnalysis{tmp} = '154a';
%         end
        
    case 'BM_4S'
        subSpecs_IowaBM
        if ~exist('tmpCondIdx') || isempty(tmpCondIdx)
            EXP.condIdx = 48;
        else
            EXP.condIdx = tmpCondIdx;
        end
        getCondition_IowaBM
%         subReadyForAnalysis = {'147','153','154','156','162','178'};
        EXP.subIdx = [1 2 3 4 5 8];
        EXP.subReadyForAnalysis = EXP.allSubID(EXP.subIdx);
end

if skipChan
    return
end

% nChan per subject (uni- + bipolar) --> INPUT FOR MASSIVE
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
%% PLOT settings

PLOT.visible                    = 'on';
PLOT.onlySignificant            = 0;
PLOT.printPNG                   = 1;
PLOT.printEPS                   = 0;
PLOT.printFIG                   = 0;

PLOT.YLIM                       = [0.1 1];
PLOT.XLIM                       = [-0.5 1];
PLOT.markerSize                 = 20;
PLOT.cScale                     = [0.5 NaN]; % if empty, defined later in plotDecode scripts. Also possible to give either lower or upper threshold and leave the other a NaN. This value will be determined based on the min or max value.

PLOT.fontsizeSmall  = 10; % usually within plot text
PLOT.fontsizeMedium = 12; % axes
PLOT.fontsizeLarge  = 15; % axes labels

PLOT.sign = {'*','**','***'};

PLOT.onlySignificantSubs        = 0;

PLOT.subjectColor = [...
    1 1 0 ; ... % yelow
    0 0 1 ; ... % Blue
    0 1 0 ; ... % Bright green
    0 1 1 ; ... % Cyan
    1 0 0 ; ... % Bright red
    1 0 1 ; ... % Pink
    0.9412 0.4706 0 ; ... % Orange
    0.251 0 0.502 ; ... % Purple
    0.502 0.251 0 ; ... % Brown
    0 0.251 0 ; ... % Dark Green
    0.502 0.502 0.502 ; ... % Gray
    0 0.502 0.502 ; ... % Turquoise
    1 0.502 0.502 ; ... % Peach
    ];
    
% [1 1 0]	Yellow
% [0 0 0]	Black
% [0 0 1]	Blue
% [0 1 0]	Bright green
% [0 1 1]	Cyan
% [1 0 0]	Bright red
% [1 0 1]	Pink
% [1 1 1]	White
% [0.9412 0.4706 0]	Orange
% [0.251 0 0.502]	Purple
% [0.502 0.251 0]	Brown
% [0 0.251 0]	Dark green
% [0.502 0.502 0.502]	Gray
% [0.502 0.502 1]	Light purple
% [0 0.502 0.502]	Turquoise
% [0.502 0 0]	Burgundy 
% [1 0.502 0.502]	Peach
%% Jobs
% behavior
Job.checkBehavior_IowaLocalizer  = 0;
Job.checkBehavior_IowaCFS        = 0;
Job.checkBehavior_IowaBM         = 0;

% LFP
Job.check_combineSessions_Iowa  = 0;
% SPG
Job.computeSPG_Iowa             = 0;
Job.checkSPG_TW_Iowa            = 0;
% decode 
Job.decode_TW_Iowa              = 1; % subdevided in each and multi chan decoding
Job.checkDecode_TW_Iowa         = 1;
Job.plotDecode_TW_Iowa          = 1;

% if isdir(['C:' filesep 'Users' filesep 'njv20' filesep]) 
% Job.plotDecode_TW_Iowa          = 0;
% end


%% SPG settings

getSPGsettings_Iowa;

%% decode settings

if exist('tmpDecIdx','var')
    DEC.iDim2use            = tmpDecIdx;
else
    DEC.iDim2use            = [6];
end

[DEC] = getDecodeSettings_Iowa(subID,DEC,SPG,[],EXP.dataset);

subID
DEC
EXP

    

%% Behav
switch EXP.dataset
    case 'Localizer'
        if Job.checkBehavior_IowaLocalizer
           checkBehavior_IowaLocalizer(EXP) 
        end
    case 'CFS'
        if Job.checkBehavior_IowaCFS
            checkBehavior_IowaCFS(EXP,PLOT)
        end
    case 'BM_4S'
        if Job.checkBehavior_IowaBM
            checkBehavior_IowaBM(EXP,PLOT)
        end
        
end
%% ERP
if Job.check_combineSessions_Iowa
    for iChan = arrayID
        check_combineSessions_Iowa(subID,iChan,EXP,PLOT,EXP.dataset)
    end
end

%% SPG
if Job.computeSPG_Iowa
    disp('compute SPG')
    for iChan = arrayID
        val = ['li' num2str(iChan)];        
        savefilenameBase = [subID '_' val '_TW_' num2str(length(SPG.TW)) '_SPG'];
        
        switch EXP.dataset
            case 'localizer'
                filename = [subID '_' num2str(length(SUB.vSession)) '_' SUB.stimCat{SUB.vSession(1)} '_sessions_' val '_t(' SUB.ext ')'];
                tmp = load([DIR.combine filename '.mat']);
                ERP = tmp.allERP;
            case 'CFS'
                loadfilename = ['cleanTrials_' num2str(iChan) '_' subID SUB.ext];
                load([DIR.clean '/' loadfilename '.mat'],'removedData');
                ERP{1} = squeeze(removedData(:,:,1));%interval 1
                ERP{2} = squeeze(removedData(:,:,2));%interval 2
            case 'BM_4S'
                filename = [subID '_' num2str(length(SUB.vSession)) '_sessions_' val '_t(' SUB.ext ')'];
                tmp = load([DIR.combine filename '.mat']);
                ERP{1} = tmp.allERP;
        end
        
        computeSPG_Iowa(ERP,iChan,SPG,SUB,savefilenameBase,DIR.SPG)
    end
end
%% check SPG
if Job.checkSPG_TW_Iowa
    for iChan=arrayID
        disp(['checking SPG for chan ' num2str(iChan)]);
        val = ['li' num2str(iChan)];
        loadfilenameBase = [subID '_' val '_TW_' num2str(length(SPG.TW)) '_SPG'];
        savefilenameBase = [subID '_' val '_' EXP.cond '_' num2str(length(SPG.TW)) '_SPG'];
        switch EXP.dataset
            case 'localizer'
                checkSPG_TW_Iowa(subID,iChan,EXP,PLOT,loadfilenameBase,savefilenameBase,'localizer')
            case 'CFS'
                checkSPG_TW_Iowa(subID,iChan,EXP,PLOT,loadfilenameBase,savefilenameBase,'CFS')
            case 'BM_4S'
                checkSPG_TW_Iowa(subID,iChan,EXP,PLOT,loadfilenameBase,savefilenameBase,'BM')
        end
    end
    loadfilenameBase=[];
end

%% decoding

if Job.decode_TW_Iowa
    DEC.dimension
    switch DEC.dimension
        case {'eachElectrodeEachTime','eachElectrodeEachFreq','eachElectrodeEachTimeEachFreq','eachElectrodeMultiTimeMultiFreq'}
            for iChan = arrayID
                disp(['decoding chan ' num2str(iChan)]);
                decode_eachElectrode_TW_Iowa(subID,iChan,DEC,SPG,EXP)
            end
        case {'multiElectrodeEachTime','multiElectrodeEachFreq','multiElectrodeEachTimeEachFreq','multiElectrodeMultiTimeMultiFreq'}
            decode_multiElectrode_TW_Iowa(subID,DEC,SPG,EXP)
    end
end
%% check decoding (including permutation?)
if Job.checkDecode_TW_Iowa
    checkDecode_TW_Iowa(subID,SPG,DEC,EXP,DIR)
end

%% plot decoding results

if Job.plotDecode_TW_Iowa
    
    plotDecode_TW_Iowa({subID},SPG,DEC,EXP,DIR,PLOT,arrayID)
    
    if 1
    if strcmpi(subID,EXP.subReadyForAnalysis{end})
        switch DEC.dimension
            case {'multiElectrodeEachTime','multiElectrodeEachFreq','multiElectrodeEachTimeEachFreq','multiElectrodeMultiTimeMultiFreq','multiElectrodeCombinePlot'}
                plotDecode_TW_Iowa(EXP.subReadyForAnalysis,SPG,DEC,EXP,DIR,PLOT,arrayID)
        end
    end
    end
end

toc
end











