function combineSessions(subID,EXP)

if nargin < 1
    subID = '153'
end

switch EXP.dataset
    case 'localizer'
        subSpecs_IowaLocalizer
    case 'CFS'
        subSpecs_IowaCFS
    case 'BM'
        subSpecs_IowaBM
end


%%
vSession = [];
for iSession= 1:SUB.nSession
    segDataDir{iSession} = [DIR.rawData '/' getfilenum(SUB.session(iSession),3) '/segmented/'];
    vSession = [vSession iSession]; %
end
%%
for iSession = vSession
    logDir = [DIR.beh ];
    loadfile = [ SUB.logFile{iSession} ];
    disp(['start loading : ' loadfile '  : ' datestr(now)])
    D{iSession} = load([logDir '/' loadfile]);
    nTrialsEachSession(iSession) = length(D{iSession}.correct_stim_responses) ;
end

%%
clear nTime nTrialsEachSession2
for iElectrode = SUB.chan
    allData = [];
    for iSession = vSession
        filename = [getfilenum(SUB.session(iSession),3) '_li' num2str(iElectrode) '_seg' SUB.ext '.mat'];
        segDataFile = ([segDataDir{iSession}  filename ]);
        
        disp(['start loading ' filename ' : ' datestr(now) ])
        if isempty(dir(segDataFile))
            disp(['not found : ' segDataFile])
            allData = [allData; nan*zeros(nTrialsEachSession2(iSession),nTime,2)];
            continue
        end
        load(segDataFile)
        
        % in some sessions (for 147, recordings are stopped before tasks
        % finished, or task finished before recordings were stopped.
        % need to adjust the trial
        nTrialsEachSession(iSession) = min( [size(segData,1) ...
            nTrialsEachSession(iSession)] );
        
        
        vTrials = 1:nTrialsEachSession(iSession);
        % cut segdata according to vTrials when the last trial was
        % curtailed
        tmp = double(segData(vTrials,:,:));
        %% combine across sessions
        allData = [allData; tmp];
    end
    if ~exist('nTime')
        nTime = size(allData,2)
    end
    if ~exist('nTrialsEachSession2')
        nTrialsEachSession2 = nTrialsEachSession
    end
    %%
    filename = ['combineSessions_' num2str(iElectrode) '_' subID SUB.ext '.mat'];
    %%
    disp(['saving : ' filename])
    save([DIR.combine '/' filename],'allData','nTrialsEachSession','nTrialsEachSession2')
    
    
end
