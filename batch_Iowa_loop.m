function batch_Iowa_loop%(vargin)
% Runs all computations for localizer, cfs and BM
% Loops over datasets, subjects, conditions, decode dimensions
%
% INPUT:
% arrayID, channel number. Used for input to massive.
%
%%
PARPOOL = 1;
%~isdir(['F:\Jochem']) && 
% define parrallel computations
if PARPOOL
    if ~isdir(['F:\Jochem']) && ~isdir([ filesep 'Users' filesep 'jochemvankempen' filesep ])  % laptop has matlab 2014, others older versions
        matlabpool open 
    else
        if isempty(gcp('nocreate'))
            myPool = parpool(4,'IdleTimeout', 120);
        end
    end
end
%% addpaths for specific setups/servers.
if isdir([ filesep 'Users' filesep 'jochemvankempen' filesep 'Dropbox' filesep 'repositories' filesep 'Tsuchiya' filesep 'Iowa' filesep ])
    %laptop
    addpath(genpath([ filesep 'Users' filesep 'jochemvankempen' filesep 'Dropbox' filesep 'repositories' filesep 'Tsuchiya' filesep 'Iowa' filesep ]));
    addpath(genpath([ filesep 'Users' filesep 'jochemvankempen' filesep 'Dropbox' filesep 'repositories' filesep 'Tsuchiya' filesep 'setPathFunctions' filesep ]));
elseif isdir(['C:' filesep 'Users' filesep 'njv20' filesep])
    % newcastle university
    addpath(genpath([ 'F:\Jochem\Dropbox' filesep 'repositories' filesep 'Tsuchiya' filesep 'Iowa' filesep ]));
    addpath(genpath([ 'F:\Jochem\Dropbox' filesep 'repositories' filesep 'Tsuchiya' filesep 'setPathFunctions' filesep ]));
    addpath(genpath([ 'F:\Jochem\Dropbox\repositories\setPath']))
%     addpath(genpath([ 'C:' filesep 'Program Files' filesep 'Psychtoolbox' filesep]));
    addpath(genpath('K:\MATLAB_3rdPartyToolbox\Psychtoolbox'))
    %     addpath(genpath([ 'C:' filesep 'Users' filesep 'njv20' filesep 'Documents' filesep 'MATLAB' filesep 'toolboxes' filesep 'chronux_2_10' filesep]));
    %     addpath(genpath([ 'H:' filesep 'MATLAB' filesep 'toolboxes' filesep 'chronux_2_10' filesep]));
    addpath(genpath([ 'F:\Jochem\Dropbox' filesep 'repositories' filesep 'Toolboxes' filesep]));
elseif isdir([ filesep 'gpfs' filesep 'M2Home' filesep 'projects' filesep 'Monash052' filesep 'jochem' filesep ])
    % Massive2
    addpath(genpath([ filesep 'gpfs' filesep 'M2Home' filesep 'projects' filesep 'Monash052' filesep 'jochem' filesep 'repositories' filesep 'scripts' filesep 'human' filesep 'Iowa' filesep ]));
    addpath(genpath([ filesep 'gpfs' filesep 'M2Home' filesep 'projects' filesep 'Monash052' filesep 'jochem' filesep 'repositories' filesep 'scripts' filesep 'setPathFunctions' filesep ]));
    addpath(genpath([ filesep 'home' filesep 'vjochem' filesep 'Monash052' filesep 'jochem' filesep 'Toolboxes' filesep ]));
    addpath(genpath([ filesep 'home' filesep 'vjochem' filesep 'Monash052' filesep 'MATLAB_3rdPartyToolbox' filesep 'Psychtoolbox']));
elseif isdir([ filesep 'home' filesep 'vjochem' filesep 'M1' filesep ])
    % Massive1
    addpath(genpath([ filesep 'home' filesep 'vjochem' filesep 'Monash052_scratch' filesep 'repositories' filesep 'scripts' filesep 'human' filesep 'Iowa' filesep ]));
    addpath(genpath([ filesep 'home' filesep 'vjochem' filesep 'Monash052_scratch' filesep 'repositories' filesep 'scripts' filesep 'setPathFunctions' filesep ]));
    addpath(genpath([ filesep 'home' filesep 'vjochem' filesep 'Monash052_scratch' filesep 'Toolboxes' filesep ]));
    addpath(genpath([ filesep 'home' filesep 'vjochem' filesep 'Monash052_scratch' filesep 'MATLAB_3rdPartyToolbox' filesep 'Psychtoolbox']));
elseif isdir([filesep 'export' filesep 'kani' filesep 'jochem' filesep])
    % Kani server
    addpath(genpath([ filesep 'export' filesep 'kani' filesep 'jochem' filesep 'repositories' filesep 'scripts' filesep 'human' filesep 'Iowa' filesep ]));
    addpath(genpath([ filesep 'export' filesep 'kani' filesep 'jochem' filesep 'repositories' filesep 'scripts' filesep 'setPathFunctions' filesep ]));
    %     addpath(genpath([ filesep 'export' filesep 'kani' filesep 'jochem' filesep 'eeglab11_0_5_4b' filesep ]));
    
    serverDir = [ filesep 'export' filesep 'kani' filesep 'shared' filesep ];
    ToolboxDir = [serverDir filesep 'MATLAB_3rdPartyToolbox' filesep];
    addpath(genpath([ToolboxDir 'Psychtoolbox']));
end

%% Set datasets, subjects, conditions and decoding strategies to analyze
EXP.allSubID = {'147','153','154','156','162','168','173','178','180','181','186','232','242'};

EXP.allDataset = {'localizer','CFS','BM_4S'};
EXP.dataset2check = [1 2  3 ];
lambda = 1e8;

decodeDimensionIdx  =[6:8  10];% 1:10]; % 1-5: eachElectrodeDecoding.. see getDecodeSettings_Iowa.m for details


if ~exist('vargin','var')
    arrayID = [];
else
    arrayID = vargin;
end



%%
for iDataset = EXP.dataset2check
    EXP.dataset = EXP.allDataset{iDataset};
    disp(EXP.dataset)
    
    switch EXP.dataset
        case 'localizer'
            %             subID2check = [2 3 4 6 9  12];
            subID2check = [2 3 4 6 8 ];
%             subID2check = [8 ];
            conditions2check = [3];
        case 'CFS'
            subID2check = [1 2 3 6 8];
%             subID2check = [ 3];
            %             subID2check = [ 2];
%                         subID2check = [ 6];
            conditions2check = [5  ];%26
            %             conditions2check = [ 83 ];
        case 'BM_4S'
            subID2check = [1 2 3 4 5 8];
%                         subID2check = [8];
            %             conditions2check = [12 11 2 5 6 9 10];

            conditions2check = [11 48 ];
    end
    for iDecDimension = decodeDimensionIdx
        
        for iCond = conditions2check
            for iSub = subID2check
                subID = EXP.allSubID{iSub};
                EXP.condIdx = iCond;
                batch_Iowa(EXP,subID,arrayID,iDecDimension,iCond)
            end
        end
    end
    
end
