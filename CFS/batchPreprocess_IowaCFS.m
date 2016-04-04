function batchPreprocess_IowaCFS(subID,arrayID,tmpDecodeType,EXP)
%% all computations of SPG and decoding for Iowa Localizer data, run after
% batchPreprocess

tic
MATLABPOOL = 0;
if MATLABPOOL
    if matlabpool('size')==0
        matlabpool open 8
    end 
end

if isdir('/Users/jochemvankempen/Dropbox/repositories/Tsuchiya/Iowa/')
    addpath(genpath('/Users/jochemvankempen/Dropbox/repositories/Tsuchiya/Iowa/'));
    addpath(genpath('/Users/jochemvankempen/Dropbox/repositories/Tsuchiya/setPathFunctions/'));
elseif isdir('/gpfs/M2Home/projects/Monash052/jochem/')
    addpath(genpath('/gpfs/M2Home/projects/Monash052/jochem/repositories/scripts/human/Iowa/'));
    addpath(genpath('/gpfs/M2Home/projects/Monash052/jochem/repositories/scripts/human/communal/'));
    addpath(genpath('/gpfs/M2Home/projects/Monash052/jochem/repositories/scripts/setPathFunctions/'));
    addpath(genpath('/home/vjochem/Monash052/jochem/Toolboxes/'));
    addpath(genpath(['/gpfs/M2Home/projects/Monash052/jochem/human/Iowa/bin/']))
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
EXP.dataset = 'CFS';


if ~exist('subID','var')
%         subID = '147'
    %     subID = '149'
%         subID = '153'
%         subID = '154a'
%         subID = '154b'
    %     subID = '156'
%         subID = '168'
    %     subID = '173'
        subID = '178'
    %     subID = '180a' %session1 and 4, animal
    %     subID = '180b' %session 2 and 3, ekman
    %     subID = '181'
    %     subID = '186'
    %     subID = '206'
%         subID = '222'
    %     subID = '232'
    %     subID = '242'
end

subSpecs_IowaCFS

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

%% PLOT

PLOT.visible                    = 'off';
PLOT.onlySignificant            = 1;
PLOT.printPNG                   = 1;
PLOT.printEPS                   = 0;
%% Jobs Preprocessing

Job.separateEachElectrode           = 0; % executed with no errors - sub 147, 149, 153, 154a, 154b, 156, 168, 178 - 140313
Job.correctForGainAndRmLineNoise    = 1; % executed with no errors - sub 147, 153, 154a, 154b, 178,
Job.equalizeNumberOfDataPoints      = 0; % only for sub 156
Job.getGridLabels                   = 0;
Job.separateStrips                  = 0; % was needed for sub 178, but is needed for all subs because createBipolarNew uses subject specific cntInfo
Job.createBipolar_Iowa              = 0;

Job.rmlinePhotoDiode                = 0; % executed with no errors - sub 147, 149, 153, 168, 178
Job.analyzePhotoDiodeTiming         = 0; % executed with no errors - sub 147, 149, 153, 168, 178
Job.compareTimingPhotoDiodeEvnt     = 0; % special treatment for sub 149, executed with no errors - sub 147, 149, 153, 168, 178
% Job.getEventOnsetTiming           = 1; %% -- needs to be worked out

% scripts for segmenting raw data
Job.segmentData                     = 0; % executed with no errors - sub 147, 153, 168, 178
Job.combineSessions                 = 0; % executed with no errors - sub 147, 153, 168, 178
Job.cleanTrials                     = 0; % executed with no errors - sub 147, 153, 168, 178
Job.combineSessionsChan             = 0; % only for sub 154,156
Job.check_combineSessions_Iowa      = 1;
%% preprocessing

if Job.separateEachElectrode
    separateEachElectrode(subID,'CFS')
end

if Job.correctForGainAndRmLineNoise
    correctForGainAndRmLineNoise(subID,'CFS')
end

if Job.equalizeNumberOfDataPoints
    equalizeNumberOfDataPoints(subID)
end

if 0
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

if Job.rmlinePhotoDiode
    rmlinePhotoDiode(subID,'CFS')
end
if Job.analyzePhotoDiodeTiming
    analyzePhotoDiodeTiming(subID)
end
if Job.compareTimingPhotoDiodeEvnt
    compareTimingPhotoDiodeEvnt(subID)
end
% if Job.getEventOnsetTiming
%     getEventOnsetTiming(subID)
% end

% if Job.rmline_before_segment
%     rmline_before_segment(subID)
% end
% if Job.getBipolarMontage
%     getBipolarMontage(subID)
% end
if Job.segmentData
    segmentData(subID,EXP)
end
if Job.combineSessions
    combineSessions(subID,EXP)
end

if Job.cleanTrials
    cleanTrials(subID,EXP)
end

if Job.combineSessionsChan
    combineSessionChan(subID,EXP)
end


