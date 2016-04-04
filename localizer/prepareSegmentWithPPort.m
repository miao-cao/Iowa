function prepareSegmentWithPPort(subID,EXP,PLOT)
%% sort parallel port intputs
% 08 Oct 9 by NT
% evnt.evnt
% -- paralell port values
% for one back task, --
% -- stimulus duration = .5 sec
% -- ITI ~ 3 sec.
%
% evnt.evnt(1:3:300) repeats 1-10 (indicating trial number
% S.nTrial = 100;
%
% evnt.evnt(2:3:300) reapeats stimulus category
% 15 upright face
% 25 inverted face
% 35 place
% 45 tool
% 55 mondrian
%
% evnt.evnt(3:3:300) repeats 100 or 200 depending on whether this is a
% one-back repeat trial or not.

%%
if ~exist('subID')
    subID = '153';
end
subSpecs_IowaLocalizer

DIR.fig = [DIR.figBase 'PPort' filesep];
if ~exist(DIR.fig,'dir')
    mkdir(DIR.fig)
end
for iSession = 1:SUB.nSession
    clear v* t* evnt n* PP*
    filename = [subID '-' getfilenum(SUB.session(iSession),3)]
    %%
    PLOT.check_trial_number = 0;
    
    %% load PPort files
    evntFiles = dir([DIR.base '..' filesep 'Face_emotion_external_inputs' filesep 'Face_Localizer_' subID filesep 'pt*']);
    [~,evntIdx] =  grep({evntFiles.name}, filename);
    load([DIR.base filesep '..' filesep 'Face_emotion_external_inputs' filesep 'Face_Localizer_' subID filesep evntFiles(evntIdx).name],'evnt')
    
    %% remove bad events manually -- mostly due to manual stop after several
    % trials
    switch filename
        case '156-142'
            evnt = evnt(1);
            evnt.evnt = evnt.evnt(7:end);
            evnt.time = evnt.time(7:end);
        case {'156-110','156-111','156-143'}
            evnt = evnt(1);
        case {'181-001','181-002'}
            evnt = evnt(1);
    end
    
    if isempty(evnt.evnt)
        continue
        error
        keyboard
    elseif isnan(evnt.evnt)
        continue
        error
        keyboard
    end
    
    %% check # of trials
    vvTrial = find(evnt.evnt <= 10);
    for iTrial = 1:length(vvTrial)
        if evnt.evnt(vvTrial(iTrial)) ~= mod(iTrial-1,10) + 1
            disp('warning')
            keyboard
        else
            %		disp('ok')
        end
    end
    nTrials = iTrial;
    
    disp(['total of trials = ' num2str(nTrials)])
    %%
    if PLOT.check_trial_number
        figure(1)
        subplot(2,1,1)
        plot(evnt.evnt(vvTrial))
        subplot(2,1,2)
        hist(evnt.evnt(vvTrial))
    end
    
    %% check trial categories
    
    vvStim = find(10<evnt.evnt & evnt.evnt <100);
    vStim = evnt.evnt(vvStim);
    
    vvFixationChange = find(100<= evnt.evnt & evnt.evnt <=210);
    vFixationChange = evnt.evnt(vvFixationChange);
    
    %% get the timing of trial labels
    vTime = evnt.time(vvTrial);
    
    %% get the timing of trial labels
    vvTrialOnset = find(evnt.evnt == 255);
    % for patient before 173, we don't have stim onset evnt.  extrapolate from
    % p173's results
    if isempty(vvTrialOnset)
        vTrialOnset = evnt.time(vvFixationChange)+0.187;
    else
        vTrialOnset = evnt.time(vvTrialOnset);
    end
    
    %% save everything in one structure
    
    PPortEvnt.evnt                  = evnt;
    PPortEvnt.vTime                 = vTime;
    PPortEvnt.vvTrial               = vvTrial;
    PPortEvnt.nTrials               = nTrials;
    PPortEvnt.vStim(vStim == 15)    = 1;% upright
    PPortEvnt.vStim(vStim == 25)    = 2;% inverted
    PPortEvnt.vStim(vStim == 35)    = 3;% place
    PPortEvnt.vStim(vStim == 45)    = 4; % tool
    PPortEvnt.vStim(vStim == 55)    = 5;% modrian
    PPortEvnt.vFixationChange       = vFixationChange;
    PPortEvnt.vTrialOnset           = vTrialOnset;
    PPortEvnt.vvTrialOnset          = vvTrialOnset;
    
    %% save
    disp(['saving ' filename '_PPort.mat in ' DIR.seg ' : ' datestr(now)])
    save([DIR.seg '/' filename '_PPort.mat'],'PPortEvnt')
    %% check delay between trial onset and last event from pport
    if 1
        figure(iSession),clf
        tmp =vTrialOnset-evnt.time(vvFixationChange);
        plot(tmp)
        title({[filename ' :  vTrialOnset-evnt.time(vvFixationChange)'];
            ['mean = ' num2str(mean(tmp)) ' : std = ' num2str(std(tmp)) ]})
        xlabel('trial')
        ylabel('sec')
        savefilename = [filename '_trialOnsetDelay'];
        figureSave
    end
end