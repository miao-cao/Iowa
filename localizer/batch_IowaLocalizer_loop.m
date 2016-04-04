function batch_IowaLocalizer_loop(vargin)
%%
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
elseif isdir('/home/vjochem/M1/')%M1
    addpath(genpath('/home/vjochem/Monash052_scratch/repositories/scripts/human/Iowa/'));
    addpath(genpath('/home/vjochem/Monash052_scratch/repositories/scripts/setPathFunctions/'));
    addpath(genpath('/home/vjochem/Monash052_scratch/Toolboxes/'));
    %     addpath(genpath('/home/vjochem/Monash052_scratch/human/Iowa/bin/'))
    addpath(genpath('/home/vjochem/Monash052_scratch/MATLAB_3rdPartyToolbox/Psychtoolbox'));
    
elseif isdir('/export/kani/jochem/')
    addpath(genpath('/export/kani/jochem/repositories/scripts/Iowa//'));
    addpath(genpath('/export/kani/jochem/repositories/scripts/setPathFunctions/'));
    addpath(genpath('/export/kani/jochem/eeglab11_0_5_4b/'));
    
    serverDir = '/export/kani/shared/';
    ToolboxDir = [serverDir '/MATLAB_3rdPartyToolbox/'];
    addpath(genpath([ToolboxDir 'Psychtoolbox']));
    
elseif isdir('/Users/Jochem/Documents/UvA/')
    addpath(genpath('/Users/Jochem/Dropbox/repositories/scripts/'));
end



if ~exist('vargin','var')
    subIdx = [1:7];
else
    arrayID = vargin;
%     subIdx = vargin;
end


tmpCondIdx      = [3];
tmpDecIdx    = [8];



if ~exist('arrayID','var')
    arrayID = [];
end
EXP.dataset = 'Localizer';

%% preprocess loop
if 1
    allSubID = {'153','154a','154b','154','156','168','173','178','180','181','186','232','242'};
    subID2check = [1 2 3 4 8 10 11];
%     subID2check = [ 11];
    
    for iSub = subID2check
        subID = allSubID{iSub};
        batchPreprocess_IowaLocalizer(subID,EXP)
    end
    
%% SPG and decode loop 
else
    allSubID = {'153','154','156','168','173','178','180','181','186','232','242'};
    subID2check = [1 2 3 4 7 10];
    for iSub = subID2check   
        subID = allSubID{iSub};
        for iCond = 1:length(tmpCondIdx)
            tmpCondIdx2use = tmpCondIdx(iCond);
            switch tmpCondIdx2use
                case {2,3}
                    switch subID
                        case {'173','178'}
                            condIdx = 2;
                        otherwise
                            condIdx = 3;
                    end
                otherwise
                    condIdx = tmpCondIdx2use;
                    
            end
            
            for iDec = tmpDecIdx
                batch_IowaLocalizer(subID,arrayID,iDec,tmpCondIdx2use)
            end
        end
    end
end
end



