function segment_IowaLocalizer(subID,EXP)
nargin = 0;
%% before patient 173, use photodiode to get the trial segment
% from 173, use pport to get the trial segment
PLOT.allChan =0;

if ~exist('subID')
    subID = '153';
end
subSpecs_IowaLocalizer

for iSession = SUB.vSession
    
    filename = [subID '-' getfilenum(SUB.session(iSession),3)];
        
    rawChanDir      = [DIR.rawData  filesep getfilenum(SUB.session(iSession),3) filesep 'rawEachChan' filesep];
    rawSessionDir   = [DIR.rawData  filesep getfilenum(SUB.session(iSession),3) filesep 'correctEachChan' filesep];
    segDataDir      = [DIR.rawData filesep getfilenum(SUB.session(iSession),3) filesep 'segmented' filesep];
    
    if ~exist(segDataDir,'dir')
        mkdir(segDataDir)
    end
    
    %% load subject trialOnset data, (load output from checkTrialInfo.m),
    %select right file (PPort, PhDio, Beh)
    load([DIR.seg filesep filename '_trialCheck.mat'] )
    
    switch SUB.alignOnset{iSession}
        case 'PPort'
            disp('segment using PPort')
            trialOnset2use  = PPortEvnt.vTrialOnset;
            vStim           = PPortEvnt.vStim;
            nTrials         = PPortEvnt.nTrials;
        case 'PhDio'
            disp('segment using PhDio')
            trialOnset2use  = PhDioEvnt.tStartTime;
            switch filename
                case '242-057'
                    vStim = PPortEvnt.vStim;
                otherwise
                    vStim = behEvnt.vStim;
            end
            nTrials         = length(vStim);
        case 'Beh'
            disp('segment using Beh')
            vStim           = behEvnt.vStim;
            nTrials         = length(behEvnt.vStim);
            trialOnset2use = zeros(1,nTrials);
            for iTrial = 1:nTrials
                trialOnset2use(iTrial)  = behEvnt.startTrialTime(iTrial) - behEvnt.startTrialTime(1) + SUB.tStartTime(iSession);
            end
    end
    
    % add time for PhDio delay
    switch filename
        case {'154b-134','154b-135'}
            trialOnset2use = trialOnset2use+0.031;%based on other sessions of sub 154a, see compareTiming
        case {'156-142'}
            trialOnset2use = trialOnset2use+0.037;%based on other sessions of sub 156, see compareTiming
        case {'232-054'}
            trialOnset2use = trialOnset2use-0.005;%based on other sessions of sub 232, see compareTiming
        otherwise
            %         time2add = 0;
    end
    
    %% load 1 channel to get timing information
    % fs = round(SUB.samplerate(iSession));
    load([rawChanDir filesep  getfilenum(SUB.session(iSession),3) '_li1'],'li1');
    nAllPnts = length(li1.dat);
    tAllPnts = 1:nAllPnts;
    tAllPnts = tAllPnts / SUB.fs;
    
    grange = round([SUB.tRange(1):1/SUB.fs:SUB.tRange(2)]*SUB.fs);

    %% get trialTiming
    trialIdx = [];
    for iTrial = 1:nTrials
        clear iStartPnt iEndPnt vvTime
        [~, iStartPnt]  = min(abs(tAllPnts-trialOnset2use(iTrial)));
        trialIdx(iTrial,:)  = iStartPnt+grange;
    end
    
    disp(['time points per trial for session ' num2str(iSession) ' = ' num2str(size(trialIdx,2))])
    
    %% segment data
    for iChan = SUB.chan
        clear dat tmp val
        
        val = ['li' num2str(iChan)];
        load([rawSessionDir filesep getfilenum(SUB.session(iSession),3) '_' val '.mat']);
        saveFilename = [getfilenum(SUB.session(iSession),3) '_' val '_t(' SUB.ext ')_seg_lfp_' SUB.alignOnset{iSession} '.mat'];
        
%         if exist([segDataDir filesep saveFilename ],'file')
%             continue
%         end
%         
        disp(['segment and save data: ' getfilenum(SUB.session(iSession),3) '_' val ' : ' datestr(now)])
        
        eval(['tmp = ' val ';' ])
        
        %%
        vNtrials = zeros(5,1);
        for iTrial = 1:nTrials
            trialType = vStim(iTrial);
            vNtrials(trialType) = vNtrials(trialType) + 1;
            
            dat{trialType}(vNtrials(trialType),:) = tmp.dat(trialIdx(iTrial,:));
            
        end
        eval([val '= dat;'])
        
        save([segDataDir filesep saveFilename ],['li' num2str(iChan)],'vNtrials')
        clear(val)
    end
end
