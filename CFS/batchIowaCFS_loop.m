function batchIowaCFS_loop(vargin)
%%
PARPOOL = 1;
if PARPOOL
    if isempty(gcp('nocreate'))
%         parpool 
        myPool = parpool('IdleTimeout', 120);
    end
end

if isdir('/Users/jochemvankempen/Dropbox/repositories/Tsuchiya/Iowa/')
    addpath(genpath('/Users/jochemvankempen/Dropbox/repositories/Tsuchiya/Iowa/'));
    addpath(genpath('/Users/jochemvankempen/Dropbox/repositories/Tsuchiya/setPathFunctions/'));
elseif isdir('/home/vjochem/Monash052/')%M2
    addpath(genpath('/home/vjochem/Monash052/jochem/repositories/scripts/human/'));
    addpath(genpath('/home/vjochem/Monash052/jochem/repositories/scripts/setPathFunctions/'));
    addpath(genpath('/home/vjochem/Monash052/jochem/Toolboxes/'));
    addpath(genpath('/home/vjochem/Monash052/MATLAB_3rdPartyToolbox/Psychtoolbox'));
elseif isdir('/home/vjochem/M1/')%M1
    addpath(genpath('/home/vjochem/Monash052_scratch/repositories/scripts/human/Iowa/'));
    addpath(genpath('/home/vjochem/Monash052_scratch/repositories/scripts/setPathFulength(tmpSPG)>1nctions/'));
    addpath(genpath('/home/vjochem/Monash052_scratch/Toolboxes/'));
    addpath(genpath('/home/vjochem/Monash052_scratch/MATLAB_3rdPartyToolbox/Psychtoolbox'));
elseif isdir('/export/kani/jochem/')
    addpath(genpath('/export/kani/jochem/repositories/scripts/human/Iowa/localizer/'));
    addpath(genpath('/export/kani/jochem/repositories/scripts/human/communal/'));
    addpath(genpath('/export/kani/jochem/repositories/scripts/setPathFunctions/'));
    addpath(genpath('/export/kani/jochem/eeglab11_0_5_4b/'));
    addpath(genpath(['/export/kani/jochem/human/Iowa/bin/']))
    
    serverDir = '/export/kani/shared/';
    ToolboxDir = [serverDir '/MATLAB_3rdPartyToolbox/'];
    addpath(genpath([ToolboxDir 'Psychtoolbox']));
    
end
%%
decodeTypes2check = [4 5 82];

if ~exist('vargin','var')
    arrayID = [];
else
    arrayID = vargin;
%     arrayID = vargin;
end

allSubID = {'147','153','154','156','168','173','178','180','181','186','232','242'};
% subID2check = [1 2 3 4 5 7 8 9 11 12 ];


subID2check = [3 5 7 1 2 ];

lambda = 1e8;
if 0
    %
    % for iDimension = 1:length(dimensionIdx)
    %     tmpDimensionIdx = dimensionIdx(iDimension);
    for iSub = subID2check
        
        subID = allSubID{(iSub)};
        %         for iexp = 1
        %             EXP.exp = allEXP{iexp};
        %             for iDecodeType = decodeTypes2check
        %                 batchIowaCFS(subID,arrayID,iDecodeType,EXP,lambda,tmpDimensionIdx)
        batchIowaCFS(subID)%,iDecodeType,EXP,lambda,tmpDimensionIdx)
        %             end
    end
    
else
    dimensionIdx  =[1 2 3 5];
    
    for iSub = 1:length(subID2check)
        tmpS = subID2check(iSub);
        subID = allSubID{(tmpS)};
        for iDimension = 1:length(dimensionIdx)
            tmpDimensionIdx = dimensionIdx(iDimension);
            for iDecodeType = decodeTypes2check
                batch_IowaCFS(subID,arrayID,iDecodeType,EXP,lambda,tmpDimensionIdx)
            end
        end
    end
end
% end
