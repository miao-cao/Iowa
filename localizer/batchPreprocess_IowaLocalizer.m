function batchPreprocess_IowaLocalizer(subID,EXP)
%% all computations of Preprocessing, SPG and decoding for Iowa Localizer data.
% arrayID here used for channels, only after preprocessing. So for
% preprocessing, don't run as a function
tic
EXP.dataset = 'Localizer';
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

subReadyForAnalysis = {'147','153','154a','154b','156','168','173','178','180','181','186','206','232'}; 

if ~exist('subID','var')
    subID = '147'
%     subID = '153'
%     subID = '154a'
%     subID = '154b'
%     subID = '156'
%     subID = '168'
%     subID = '173'
%     subID = '178'
%     subID = '180' %session1 and 4, animal. %session 2 and 3, ekman
%     subID = '181'
%     subID = '186'
%     subID = '206'
%     subID = '232'
%     subID = '242'
else
    disp(subID)
end
% disp(subID)
subSpecs_IowaLocalizer

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

%% PLOT

PLOT.visible                    = 'off';
PLOT.onlySignificant            = 0;
PLOT.printPNG                   = 1;
PLOT.printEPS                   = 0;
PLOT.plotOnMap                  = 1; %
%% Jobs Preprocessing


Job.separateEachElectrode           = 0;
Job.correctForGainAndRmLineNoise    = 0;
Job.prepareSegmentWithBeh           = 0;

switch subID
    case '153'
        Job.prepareSegmentWithPPort = 1;
        Job.prepareSegmentWithPhDio = 1;
    case '154a'
        Job.prepareSegmentWithPPort = 1;
        Job.prepareSegmentWithPhDio = 1;
    case '154b'
        Job.prepareSegmentWithPPort = 1;
        Job.prepareSegmentWithPhDio = 0;
    case '156'
        Job.prepareSegmentWithPPort = 1;
        Job.prepareSegmentWithPhDio = 1;
    case '168'
        Job.prepareSegmentWithPPort = 1;
        Job.prepareSegmentWithPhDio = 1;
    case '173'
        Job.prepareSegmentWithPPort = 1;
        Job.prepareSegmentWithPhDio = 0;
    case '178'
        Job.prepareSegmentWithPPort = 1;
        Job.prepareSegmentWithPhDio = 1;
    case '180'
        Job.prepareSegmentWithPPort = 1;
        Job.prepareSegmentWithPhDio = 1;
    case '181'
        Job.prepareSegmentWithPPort = 1;
        Job.prepareSegmentWithPhDio = 1;
    case '186'
        Job.prepareSegmentWithPPort = 0;
        Job.prepareSegmentWithPhDio = 1;
    case '206'
        Job.prepareSegmentWithPPort = 0;
        Job.prepareSegmentWithPhDio = 1;
    case '232'
        Job.prepareSegmentWithPPort = 1;
        Job.prepareSegmentWithPhDio = 1;
    case '242'
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
    separateEachElectrode(subID,EXP,'localizer')
end

if Job.correctForGainAndRmLineNoise
    correctForGainAndRmLineNoise(subID,EXP,'localizer')
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


