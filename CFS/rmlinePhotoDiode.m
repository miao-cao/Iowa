function rmlinePhotoDiode(subID,dataset)
% nargin = 0; 
% rewritten by NT 2009 Jan 11
% based on getEventOnsetTiming
dbstop if error
if nargin < 1
    subID = '168'
end

addpath(genpath('/Volumes/Jochem_4T/MATLAB_3rdPartyToolbox/chronux/'));
%% rewritten by NT, 2009 Jan 10

switch dataset
    case 'localizer'
%         subSpecsIowaFaceLocalizer
    case 'CFS'
        subSpecs_IowaCFS
    case 'BM'
        subSpecsIowaBM
end

DIR.fig = [DIR.figBase 'photoDiode' filesep];
if isempty(dir(DIR.fig))
    mkdir(DIR.fig)
end
    
%% load photoDiode data
clear pd fs 
vSession = []; 
for iSession= 1:SUB.nSession
    clear tmp tmp2
    rawDataDir{iSession} = [DIR.rawData '/' getfilenum(SUB.session(iSession),3) '/rawEachChan/'];
    photoDiodeFile{iSession} = dir([rawDataDir{iSession} '/*ex*1.mat']); 
    
    if isempty(photoDiodeFile{iSession})
        photoDiodeFile{iSession} = dir([DIR.rawData '/*' num2str(SUB.session(iSession)) '_photodiode.mat']);
        
        if isempty(photoDiodeFile{iSession})
            disp(['photoDiodeFile not found for ' rawDataDir{iSession} ' : readEvntData' ])            
            continue
        end
        tmp = load([DIR.rawData '/' photoDiodeFile{iSession}.name],'ex1');
        photoDiodeFile{iSession}.name = [photoDiodeFile{iSession}.name(1:end-(length('photodiode.mat'))) 'ex1.mat'];
    else
        tmp = load([rawDataDir{iSession} photoDiodeFile{iSession}.name]);  
    end
    
    vSession = [vSession iSession]; % 
    
    if isfield(tmp,'ex1')
        tmp2 = tmp.ex1;
    else
        tmp2 = tmp.ext1;
    end
    
    pd{iSession} = tmp2; 
    % time = ex1.t; % this is not used 
    fs(iSession) = unique(tmp2.fs);     
end
clear tmp tmp2
%% remove line noise
% best parameters
movingwin = [.5 .1]; 
tau = 10;
params.tapers = [5 9]; 
params.pad=2;

% %% original parameters as in CFS/analysis
% movingwin = [.5 .1]; 
% tau = 10;
% params.tapers = [3 5]; 

% % parameters in Nao's email - even worse result
% movingwin = [4 2];
% tau = 10;
% params.tapers = [5 9];

% % improves somehow, but line noise not properly characterised in most windows (params1)
% movingwin = [.5 .4]; 
% tau = 10;
% params.tapers = [3 5]; 

% % very bad
% movingwin = [2 1.8]; 
% tau = 10;
% params.tapers = [3 5]; 

clear rmpd rmfitted rmAmp rmFreqs
for iSession = vSession 
    params.Fs = round(fs(iSession));
    disp(['session ' num2str(iSession) ' : start removing line noise by moving window = ' num2str(movingwin) ' : ' datestr(now) ]) 
    % [rmpd{iSession} rmfitted{iSession} rmAmp{iSession} rmFreqs{iSession}] = rmlinesmovingwinc(pd{iSession},movingwin,tau,params);
    [rmpd{iSession} rmfitted{iSession} rmAmp{iSession} rmFreqs{iSession}] = rmlinesmovingwinc(pd{iSession},movingwin,tau,params,[],'y');
    % keyboard;
end
%% save the filtered results 
disp('save photodiode resp after line source noise removal')
for iSession = vSession
    RMPD = rmpd{iSession};
    RMFITTED = rmfitted{iSession};
    RMAMP = rmAmp{iSession};
    RMFREQS = rmFreqs{iSession};
    save([rawDataDir{iSession} strrep( photoDiodeFile{iSession}.name ,'.mat' ,'_rmln.mat') ],...
        'RMPD','RMFITTED','RMAMP' ,'RMFREQS','movingwin','tau','params')
end
return 
