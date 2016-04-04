function batchPreprocess_IowaDF(subID,EXP)
%% all computations of Preprocessing, SPG and decoding for Iowa Localizer data.
% arrayID here used for channels, only after preprocessing. So for
% preprocessing, don't run as a function
tic
EXP.dataset = 'DF';
MATLABPOOL = 0;
if MATLABPOOL
    if matlabpool('size')==0
        matlabpool open 8
    end
end
if isdir([ filesep 'Users' filesep 'jochemvankempen' filesep 'Dropbox' filesep 'repositories' filesep 'Tsuchiya' filesep 'Iowa' filesep ])
    %laptop
    addpath(genpath([ filesep 'Users' filesep 'jochemvankempen' filesep 'Dropbox' filesep 'repositories' filesep 'Tsuchiya' filesep 'Iowa' filesep ]));
    addpath(genpath([ filesep 'Users' filesep 'jochemvankempen' filesep 'Dropbox' filesep 'repositories' filesep 'Tsuchiya' filesep 'setPathFunctions' filesep ]));
    addpath(genpath([ filesep 'Users' filesep 'jochemvankempen' filesep 'Documents' filesep 'MATLAB' filesep 'Toolboxes' filesep 'Chronux_2_10' filesep ]));
elseif isdir(['C:' filesep 'Users' filesep 'njv20' filesep]) 
    % newcastle university
    addpath(genpath([ 'C:' filesep 'Users' filesep 'njv20' filesep 'Dropbox' filesep 'repositories' filesep 'Tsuchiya' filesep 'Iowa' filesep ]));
    addpath(genpath([ 'C:' filesep 'Users' filesep 'njv20' filesep 'Dropbox' filesep 'repositories' filesep 'Tsuchiya' filesep 'setPathFunctions' filesep ]));
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
    addpath(genpath([ filesep 'export' filesep 'kani' filesep 'jochem' filesep 'repositories' filesep 'scripts' filesep 'Iowa' filesep]));
    addpath(genpath([ filesep 'export' filesep 'kani' filesep 'jochem' filesep 'repositories' filesep 'scripts' filesep 'setPathFunctions' filesep ]));
    %     addpath(genpath([ filesep 'export' filesep 'kani' filesep 'jochem' filesep 'eeglab11_0_5_4b' filesep ]));
    
    serverDir = [ filesep 'export' filesep 'kani' filesep 'shared' filesep ];
    ToolboxDir = [serverDir filesep 'MATLAB_3rdPartyToolbox' filesep];
    addpath(genpath([ToolboxDir 'Psychtoolbox']));
end

subReadyForAnalysis = {'147'}; 

if ~exist('subID','var')
    subID = '147'
else
    disp(subID)
end
% disp(subID)
subSpecs_IowaDF

%% PLOT

PLOT.visible                    = 'on';
PLOT.onlySignificant            = 0;
PLOT.printPNG                   = 1;
PLOT.printEPS                   = 0;
PLOT.plotOnMap                  = 1; %
%% Jobs Preprocessing


Job.separateEachElectrode           = 1;
Job.correctForGainAndRmLineNoise    = 1;
Job.prepareSegmentWithBeh           = 1;

switch subID
    case '153'
        Job.prepareSegmentWithPPort = 1;
        Job.prepareSegmentWithPhDio = 1;
end

if 1
    Job.prepareSegmentWithPPort     = 0;
    Job.prepareSegmentWithPhDio     = 0;
end

Job.checkTrialInfo                      = 0; % compare info between behavioural, PPort and PhDio
Job.compareTiming                       = 0;
Job.getGridLabels                       = 0;
Job.separateStrips                      = 0; % was needed for sub 178, but is needed for all subs because createBipolarNew uses subject specific cntInfo
Job.createBipolar_Iowa                  = 0;
Job.segmentFaceLocalizer                = 1;
Job.check_segmentFaceLocalizer          = 0; % -- for each session, for all use check_combinedSessions instead
Job.combineSessions_IowaLocalizer       = 1;
Job.combineSessionsChan                 = 1; %for sub 154
% Job.cleanTrials                         = 1;
Job.check_combineSessions               = 1;

Job.createLogForAllSub_IowaLocalizer    = 1;


%% Preprocessing

if Job.separateEachElectrode
    separateEachElectrode(subID,EXP,'DF')
end

if Job.correctForGainAndRmLineNoise
    correctForGainAndRmLineNoise(subID,EXP,'DF')
end

if 0
    if Job.getContactInfo
        getContactInfo
    end
    if Job.getGridLabels
        getGridLabels(subID,SUB,DIR)
    end
    if Job.separateStrips
        separateStrips(subID,SUB,DIR)
    end
end

if Job.createBipolar_Iowa
    if exist('bCNT','var')
        createBipolar_Iowa(subID,EXP,SUB,DIR,bCNT)
    else
        createBipolar_Iowa(subID,EXP,SUB,DIR,[])
    end
end

if Job.segment_IowaDF
    segment_IowaDF(subID)
end

if Job.prepareSegmentWithBeh
    prepareSegmentWithBeh(subID,EXP)
end

if Job.prepareSegmentWithPPort
    prepareSegmentWithPPort(subID,EXP,PLOT)
end

if Job.prepareSegmentWithPhDio
    prepareSegmentWithPhDio(subID,EXP,PLOT)
end

if Job.checkTrialInfo
    checkTrialInfo(subID,EXP)
end

if Job.compareTiming
    compareTiming(subID,EXP,PLOT)
end

if Job.segmentFaceLocalizer
    segment_IowaLocalizer(subID,EXP);
end

if Job.check_segmentFaceLocalizer    
    for iSession = SUB.vSession
        for iChan = SUB.chan
            checkSegment_IowaLocalizer(subID,iSession,iChan,EXP,PLOT)
        end
    end
end

if Job.combineSessions_IowaLocalizer
    combineSessions_IowaLocalizer(subID,EXP)
end

if Job.combineSessionsChan
    combineSessionChan(subID,EXP,'LOC')
end

% switch subID
%     case {'154a','154b'}
%         subID = '154';
% end
% subSpecs_IowaLocalizer
% % keyboard
% if Job.cleanTrials
%     cleanTrials(subID)
% end
% 
if Job.check_combineSessions
    for iChan = arrayID% 1:length(bCNT.label)
        check_combineSessions(subID,iChan,EXP,PLOT)
    end
end
%% 

if Job.createLogForAllSub_IowaLocalizer
   createLogForAllSub_IowaLocalizer(subReadyForAnalysis,EXP)
end


