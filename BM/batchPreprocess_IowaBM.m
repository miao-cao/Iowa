function batchPreprocess_IowaBM(subID,arrayID,tmpDecodeType,EXP)

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
    
elseif isdir('/Users/Jochem/Documents/UvA/')
    addpath(genpath('/Users/Jochem/Dropbox/repositories/scripts/'));
elseif isdir('/Users/jochemvankempen/')%imac monash
    addpath(genpath('/Users/jochemvankempen/Dropbox/repositories/scripts/'));
end


% subReadyForAnalysis = {'153','154a','154b','156','168','178','180a','180b','186','232'}; %used in across subject stats
subReadyForAnalysis = {'147','153','154','156','162','178'};

if ~exist('subID','var')
%     subID = '145'
%     subID = '147'
%     subID = '153'
%     
%     subID = '154'
%     subID = '156'
%     subID = '162'
    subID = '178'
%     
end

EXP.dataset = 'BM_4S';

subSpecs_IowaBM


%%
EXP.condIdx = 6;
getCondition_IowaBM
% 
%% PLOT

PLOT.visible                    = 'off';
PLOT.onlySignificant            = 0;
PLOT.printPNG                   = 1;
PLOT.printEPS                   = 0;

%% Jobs Preprocessing

Job.separateEachElectrode           = 0; % executed with no errors - sub 147, 149, 153, 154, 162, 178
Job.correctForGainAndRmLineNoise    = 1; % executed with no errors - sub 147, 149, 153, 154, 162, 178
Job.getGridLabels                   = 0;
Job.separateStrips                  = 0; % was needed for sub 178, but is needed for all subs because createBipolarNew uses subject specific cntInfo
Job.createBipolar_Iowa              = 0; % executed with no errors - sub 147, 153, 154

% scripts for segmenting raw data
Job.segment_IowaBM                  = 0; % executed with no errors - sub 147, 153, 154
Job.combineSessions_IowaBM          = 0; % executed with no errors - sub 147, 153, 154
Job.check_combineSessions_IowaBM    = 0; % executed with no errors - sub 147, 153, 154
%% preprocessing

if Job.separateEachElectrode
    separateEachElectrode(subID,'BM')

%     separateEachElectrode_IowaBM(subID)
end

if Job.correctForGainAndRmLineNoise
    correctForGainAndRmLineNoise(subID,'BM')
end

if Job.prepareBehavior_IowaBM
    prepareBehavior_IowaBM(subID)
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

if Job.segment_IowaBM
    segment_IowaBM(subID,EXP)
end
if Job.combineSessions
    combineSessions_IowaBM(subID,EXP)
end

if Job.check_combineSessions_IowaBM
    for iSub = 1:length(subReadyForAnalysis)
        subID = subReadyForAnalysis{iSub};
        subSpecs_IowaBM
        parfor iChan = 1:SUB.chan(end)
            check_combineSessions_IowaBM(subID,iChan,EXP,PLOT)
        end
    end
end

