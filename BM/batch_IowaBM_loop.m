% function batch_IowaBM_loop



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



tmpCondIdx      = [5 7 8 9 10];
tmpDecIdx    = [7];
% tmpDecIdx    = [4];



if ~exist('arrayID','var')
    arrayID = [];
end

% subReadyForAnalysis = {'153','154a','154b','156','168','178','180a','180b','186','232'}; 
subReadyForAnalysis = {'147','153','154','156','162','178'};
subID2check = [1];
for iSub = subID2check
    subID = subReadyForAnalysis{iSub};
    for iCond = 1:length(tmpCondIdx)
        tmpCondIdx2use = tmpCondIdx(iCond);        
        for iDec = tmpDecIdx
            batch_IowaBM(subID,arrayID,iDec,tmpCondIdx2use)
        end
    end
end








