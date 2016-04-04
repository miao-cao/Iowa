

if isdir([ filesep 'Volumes' filesep 'Jochem_4T' filesep 'Iowa' filesep ]) % laptop with external hard drive
    DIR.base = [filesep 'Volumes' filesep 'Jochem_4T' filesep 'Iowa' filesep EXP.dataset filesep];
    DIR.map  = [filesep 'Users' filesep 'jochemvankempen' filesep 'Documents' filesep 'Tsuchiya' filesep 'Iowa' filesep 'MAP' filesep ];
elseif isdir([ filesep 'Users' filesep 'jochemvankempen' filesep 'Documents' filesep ]) % laptop without external hard drive
    DIR.base = [filesep 'Users' filesep 'jochemvankempen' filesep 'Documents' filesep 'Tsuchiya' filesep 'Iowa' filesep EXP.dataset filesep];
    DIR.map  = [filesep 'Users' filesep 'jochemvankempen' filesep 'Documents' filesep 'Tsuchiya' filesep 'Iowa' filesep 'MAP' filesep ];
elseif isdir(['J:' filesep 'Iowa' filesep])
    DIR.base = ['J:' filesep 'Iowa' filesep EXP.dataset filesep];
    DIR.map  = ['J:' filesep 'Iowa' filesep 'MAP' filesep ];
elseif isdir([filesep 'gpfs' filesep 'M2Home' filesep 'projects' filesep 'Monash052' filesep 'jochem' filesep ])
    DIR.base = [filesep 'gpfs' filesep 'M2Home' filesep 'projects' filesep 'Monash052' filesep 'jochem' filesep 'human' filesep 'Iowa' filesep EXP.dataset filesep];
elseif isdir([filesep 'home' filesep 'vjochem' filesep 'M1' filesep])%M1
    DIR.base = [ filesep 'home' filesep 'vjochem' filesep 'Monash052_scratch' filesep 'human' filesep 'Iowa' filesep EXP.dataset filesep ];
elseif isdir([ filesep 'export' filesep 'kani' filesep 'jochem' filesep ])
    DIR.base = [ filesep 'export' filesep 'kani' filesep 'jochem' filesep 'Iowa' filesep EXP.dataset filesep ];
end

if ~isfield(DIR,'map')
    DIR.map         = [DIR.base '..' filesep 'MAP' filesep];
end

DIR.mapMatFile  = [DIR.map 'mapMatFiles' filesep];

DIR.data = [DIR.base 'data' filesep];
DIR.sub = [DIR.data subID filesep];
DIR.rawData = [DIR.sub 'rawData' filesep];

DIR.clean = [DIR.sub 'cleanTrials' filesep];
if isempty(dir(DIR.clean))
    mkdir(DIR.clean)
end

DIR.combine = [DIR.sub filesep 'combine' filesep];
if ~exist(DIR.combine,'dir')
    mkdir(DIR.combine)
end

switch EXP.dataset
    case 'Localizer'
        DIR.beh = [DIR.sub 'seg' filesep];
        DIR.beh = [DIR.data 'task_behavior' filesep subID filesep];
        DIR.seg = [DIR.sub filesep 'seg' filesep];
        if ~exist(DIR.seg,'dir')
            mkdir(DIR.seg)
        end
    case 'CFS'
        switch subID
            case {'154a','154b'}
                DIR.beh = [DIR.data 'task_behavior' filesep '154' filesep];
            otherwise
                DIR.beh = [DIR.data 'task_behavior' filesep subID filesep];
        end
    case 'BM_4S'
        DIR.beh = [DIR.sub 'behavior' filesep];
        DIR.behBase = [DIR.data 'task_behavior' filesep];
    case 'DF'
%         DIR.beh = [DIR.sub 'seg' filesep];        
end

DIR.figBase = [DIR.sub filesep 'figures' filesep];
if ~exist(DIR.figBase,'dir')
    mkdir(DIR.figBase)
end

DIR.wrongfile = [DIR.base filesep 'wrongfile' filesep];
if ~exist(DIR.wrongfile,'dir')
    mkdir(DIR.wrongfile)
end
%% level 1 computations
% 
DIR.SPG = [DIR.sub filesep 'SPG' filesep];
if ~exist(DIR.SPG,'dir')
    mkdir(DIR.SPG)
end

if exist('DEC','var') && exist('EXP','var') && exist('C','var') 
    if isfield(EXP,'exp')
        dataDir = 'CFS';
        getDecodeDir_Iowa
    end
end


