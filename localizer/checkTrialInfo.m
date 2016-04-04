function checkTrialInfo(subID,EXP)
%
% compares trial info across different (available) files (beh, pport and phdio)
%
% checks number of trials, timing of trials and vStim for every session
%
% output is an XLS and MAT file.
% XLS: overview of the comparisons made and the errors (if there).
% mat: file with all behavioural, PPort and PhDio data combined in one
% file. Corrected across files if necessary
%

output.XlsFile  = 1;
output.MatFile   = 1;

if ~exist('subID','var')
    subID = '153';
end

subSpecs_IowaLocalizer


for iSession =1:SUB.nSession
    
    filename = [subID '-' getfilenum(SUB.session(iSession),3)];
    
    savefilename = [filename '_trialCheck'];
    
    %% loading all available log files.
    behEvnt = struct([]);
    PPortEvnt = struct([]);
    PhDioEvnt = struct([]);
    
    % disp(['loading seg files from ' filename ' : ' datestr(now) ])
    FILE.behFile        = 0;
    FILE.PPortFile      = 0;
    FILE.PhDioFile      = 0;
    
    if exist([DIR.seg filesep filename '_behav.mat'],'file')
        FILE.behFile    = 1;
        load([DIR.seg filesep filename  '_behav.mat'])
    end
    
    if exist([DIR.seg filesep filename '_PPort.mat'],'file')
        FILE.PPortFile   = 1;
        load([DIR.seg filesep filename  '_PPort.mat'])
    end
    
    if exist([DIR.seg filesep filename '_PhDio.mat'],'file')
        FILE.PhDioFile    = 1;
        load([DIR.seg filesep filename  '_PhDio.mat'])
    end
    
    %% vectorize/extract useful information
    % now in separate prepareSegment scripts
    
    %% check number of trials
    %     fileIdx = 0;
    FILE.nTrialsCompare{1} = 'nTrial beh:PPort';
    FILE.nTrialsCompare{2} = 'nTrial beh:PhDio';
    FILE.nTrialsCompare{3} = 'nTrial PPort:PhDio';
    
    if FILE.behFile && FILE.PPortFile
        FILE.nTrials{1}           = 'same';
        
        if length(behEvnt.vStim) ~= PPortEvnt.nTrials
            
            FILE.nTrials{1} = ['beh ' num2str(length(behEvnt.vStim)) ':PPort ' num2str(PPortEvnt.nTrials)];
            warning(['different number of trials (beh and PPort) for session ' filename])
            %         keyboard
        end
    else
        FILE.nTrials{1}           = 'N.A.';
    end
    
    if FILE.behFile && FILE.PhDioFile
        FILE.nTrials{2}            = 'same';
        
        if length(behEvnt.vStim) ~= PhDioEvnt.nTrials
            FILE.nTrials{2}  = ['beh ' num2str(length(behEvnt.vStim)) ':PhDio ' num2str(PhDioEvnt.nTrials)];
            warning(['different number of trials (beh and PhDio) for session ' filename])
            %         keyboard
        end
    else
        FILE.nTrials{2}           = 'N.A.';
    end
    
    if FILE.PPortFile && FILE.PhDioFile
        FILE.nTrials{3}            = 'same';
        
        if PPortEvnt.nTrials ~= PhDioEvnt.nTrials
            
            FILE.nTrials{3}  = ['PPort ' num2str(PPortEvnt.nTrials) ':PhDio ' num2str(PhDioEvnt.nTrials)];
            warning(['different number of trials (PPort and PhDio) for session ' filename])
            %         keyboard
        end
    else
        FILE.nTrials{3}           = 'N.A.';
    end
    
    
    %% check events (vStim)
    
    if FILE.behFile && FILE.PPortFile
        FILE.different_VstimTrialIdx = [];
        
        for iTrial = 1:min(length(behEvnt.vStim),PPortEvnt.nTrials)
            if behEvnt.vStim(iTrial) ~= PPortEvnt.vStim(iTrial)
                FILE.different_VstimTrialIdx = [FILE.different_VstimTrialIdx iTrial];
            end
        end
        
        if isempty(FILE.different_VstimTrialIdx)
            FILE.evnt    = 'same';
        else
            FILE.evnt    = ['trial: ' num2str(FILE.different_VstimTrialIdx)];
        end
        
    else
        FILE.evnt        = 'N.A.';
        FILE.different_VstimTrialIdx = [];
    end
    
    
    %% check timing trials
    % if PPort and PhDio are both available, these are compared. If these
    % are not available (both of them), timing will be compared between PPort/PhDio and behavioural file (if .mat)
    
    FILE.timingDifferenceThreshold = 0.05; %50 ms difference allowed between PPort and PhDio timing?!
    
    FILE.different_timingTrialIdx = [];
    if FILE.PPortFile && FILE.PhDioFile
        FILE.timingCompare = 'PPort:PhDio';
        for iTrial = 1:min(PPortEvnt.nTrials,PhDioEvnt.nTrials)
            if abs(PPortEvnt.vTrialOnset(iTrial)-PhDioEvnt.tStartTime(iTrial) ) > FILE.timingDifferenceThreshold
                FILE.different_timingTrialIdx = [FILE.different_timingTrialIdx iTrial];
            end
        end
        
    elseif FILE.PPortFile && FILE.behFile && sum(find(strcmpi(fileExtBeh,'.mat')))
        FILE.timingCompare = 'PPort:Beh';
        for iTrial = 1:min(PPortEvnt.nTrials,length(behEvnt.vStim))
            if abs(PPortEvnt.vTrialOnset(iTrial)-behEvnt.startTrialTime(iTrial) ) > FILE.timingDifferenceThreshold
                FILE.different_timingTrialIdx = [FILE.different_timingTrialIdx iTrial];
            end
        end
        
        
    elseif FILE.PhDioFile && FILE.behFile && logical(strcmpi(fileExtBeh,'.mat'))
        FILE.timingCompare = 'PhDio:Beh';
        for iTrial = 1:min(PhDioEvnt.nTrials,length(behEvnt.vStim))
            if abs(PhDioEvnt.tStartTime(iTrial)-behEvnt.startTrialTime(iTrial) ) > FILE.timingDifferenceThreshold
                FILE.different_timingTrialIdx = [FILE.different_timingTrialIdx iTrial];
            end
        end
        
    else
        FILE.timingCompare      = 'N.A.';
        FILE.timing             = 'N.A.';
    end
    
    if isempty(FILE.different_timingTrialIdx)
        FILE.timing             = 'same';
    else
        FILE.timing             = ['trial: ' num2str(FILE.different_timingTrialIdx)];
    end
    
    %% send to xls and mat file
    
    columnTitels = {'fileName','behavFile','PPortFile','PhDioFile',...
        'nTrials beh:PPort','nTrials beh:PhDio','nTrials PPort:PhDio','vStim compare',...
        'timing compare','timing',...
        'task','pHit','pFA'; ...
        };
    
    switch behEvnt.file
        case 'xls'
            A = {filename, num2str(FILE.behFile), num2str(FILE.PPortFile), num2str(FILE.PhDioFile), ...
                FILE.nTrials{:}, FILE.evnt, ...
                FILE.timingCompare, FILE.timing...
                NaN,NaN,NaN...
                };
        case 'mat'
            A = {filename, num2str(FILE.behFile), num2str(FILE.PPortFile), num2str(FILE.PhDioFile), ...
                FILE.nTrials{:}, FILE.evnt, ...
                FILE.timingCompare, FILE.timing...
                behEvnt.task,behEvnt.pHit,behEvnt.pFA...
                };
    end
    
    if output.XlsFile
        cd(DIR.seg)
        f = fopen([savefilename '.xls'], 'w');
        fprintf(f,'%s\t',columnTitels{1,:});
        fprintf(f,'\n');
        
        for n = 1%:(nSession)
            %     fprintf(f, '%s\t%d\t%s\n', A(n), B(n), C{n});
            fprintf(f,'%s\t',A{n,:});
            fprintf(f,'\n');
        end
        fclose(f);
    end
    %%
    if output.MatFile
        
        trialNumbers.beh     = NaN;
        trialNumbers.PhDio   = NaN;
        trialNumbers.PhDio   = NaN;
        
        if FILE.behFile
            trialNumbers.beh     = length(behEvnt.vStim);
        end
        if FILE.PPortFile
            trialNumbers.PPort   = PPortEvnt.nTrials;
        end
        if FILE.PhDioFile
            trialNumbers.PhDio   = PhDioEvnt.nTrials;
        end
        
        errorVstim      = FILE.different_VstimTrialIdx;
        errorTiming     = FILE.different_timingTrialIdx;
        
        if exist([DIR.seg filesep filename '_PPort.mat'],'file') && exist([DIR.seg filesep filename '_behav.mat'],'file')
            
            if trialNumbers.beh ~= trialNumbers.PPort ||...
                    trialNumbers.PPort ~= trialNumbers.PhDio
                
                if isempty(errorVstim) && isempty(errorTiming)
                    % this is the case for e.g. sub 153, session 064 and 132
                    %(['different trialnumbers, but no differences in vStim or timing must be last trials that are not recorded in behavioural data \n'])
                    %(['now only saving data for the trials for which all
                    %information is available
                    
                    %%
                    if ~isnan(trialNumbers.PPort)
                        PPortEvnt.nTrials               = trialNumbers.beh;
                        PPortEvnt.vStim                 = PPortEvnt.vStim           (1:trialNumbers.beh);
                        PPortEvnt.vFixationChange       = PPortEvnt.vFixationChange (1:trialNumbers.beh);
                        PPortEvnt.vTime                 = PPortEvnt.vTime           (1:trialNumbers.beh);
                        PPortEvnt.vTrialOnset           = PPortEvnt.vTrialOnset     (1:trialNumbers.beh);
                        PPortEvnt.vvTrial               = PPortEvnt.vvTrial         (1:trialNumbers.beh);
                        if length(PPortEvnt.vvTrialOnset) == trialNumbers.PPort
                            PPortEvnt.vvTrialOnset          = PPortEvnt.vvTrialOnset    (1:trialNumbers.beh);
                        end
                    end
                    if ~isnan(trialNumbers.PhDio)
                        PhDioEvnt.nTrials               = trialNumbers.beh;
                        PhDioEvnt.tStartPnt             = PhDioEvnt.tStartPnt       (1:trialNumbers.beh);
                        PhDioEvnt.tStartTime            = PhDioEvnt.tStartTime      (1:trialNumbers.beh);
                        PhDioEvnt.vTrialPnt             = PhDioEvnt.vTrialPnt       (1:trialNumbers.beh);
                    end
                else
                    
                    disp('trial information is not consistent across different files (behav, PPort, PhDio), check information manually')
%                     keyboard
                end
            end
        end
        save([DIR.seg filesep savefilename '.mat'],'A','columnTitels','trialNumbers','errorTiming','errorVstim','behEvnt','PPortEvnt','PhDioEvnt','subID','FILE')
        
    end
    
end


end



