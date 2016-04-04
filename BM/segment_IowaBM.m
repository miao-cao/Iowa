function segment_IowaBM(subID,EXP)
% function getTrialTiming_IowaBM(subID)
% based on /export/kani/shared/IowaData/BM/analysis/process_data.m
%
% segment data and correct for gain

% ######################################################################
% # Parallel port codes are
% #		 Fixation Cross Off: 	253
% #		 Target Presentation:	1 + Location*4 + Expression*32
% #		 Location Question: 	132
% #		 Expression Question:   136
% #		 Buttons:               (1)140, (2)141, (3)144, (4)145
% ######################################################################
%%
subSpecs_IowaBM
%%
bigMatrixBM = 0;

if bigMatrixBM
    % based on process_data
    rawChanDir{1} = [DIR.rawData 'allSessions' filesep 'rawEachChan' filesep];
    segChanDir{1} = [DIR.rawData 'allSessions' filesep 'segEachChan' filesep];
    
    if ~exist(segChanDir{1},'dir')
        mkdir(segChanDir{1})
    end
    load([rawChanDir{1} 'allSession' '_li1.mat']);

    %% get tChop
    clear evnts
    for iSession = SUB.vSession
        try
            tmpEvnt         = load([DIR.rawData SUB.evntFile{iSession}]);
        catch me
            tmpEvnt         = load([DIR.rawData getfilenum(SUB.session(iSession),3) filesep 'rawEachChan' filesep SUB.evntFile{iSession}]);
        end
        EVNT(iSession)      = tmpEvnt.evnt;
    end
    t = 0;

    X = []; T =[];EVTS=[];
    for iSession = 1:length(SUB.vSession)
        load([DIR.rawData getfilenum(SUB.session(SUB.vSession(iSession)),3) filesep 'rawEachChan' filesep getfilenum(SUB.session(SUB.vSession(iSession)),3) '_li1.mat']);
        x = li1;
        
        xdn = double(x.dat); % denoiseContinuous(double(x.dat),SUB.fs);
        X = cat(1,X,xdn);
        t(iSession+1)  = length(x.dat)./SUB.fs+t(iSession);
        T = cat(2,T,EVNT(SUB.vSession(iSession)).time+t(iSession));
        EVTS = cat(2,EVTS,EVNT(SUB.vSession(iSession)).evnt);
    end
    grange = round([SUB.tRange(1):1./SUB.fs:SUB.tRange(2)]*SUB.fs);
    %% modified by NT (09 Aug 28)
    clear tronset
    switch subID
        case '147'
            tronset= round(T(2:6:end)*SUB.fs);
            tronset2= round(T(find(EVTS==1)+1)*SUB.fs);
            
            if sum(tronset~=tronset2)
                disp('error')
                keyboard
            end
            
        case '178' % hack for 178
            EVTS2 = EVTS(EVTS < 137); % remove button response
            T2 = T(EVTS < 137) ;
            v136 = find(EVTS2==136);
            
            for iTrial = 1:length(v136)
                if ismember( EVTS2(v136(iTrial)-1) ,132)
                    if EVTS2(v136(iTrial)-3) == 1
                        flag(iTrial) = EVTS2(v136(iTrial)-2) ;
                        tronset(iTrial) = round( T2(v136(iTrial)-2)*SUB.fs) ;
                    else
                        EVTS2(v136(iTrial)-4:v136(iTrial))
                        disp(['irregular 1  trial ' num2str(iTrial)])
                        keyboard
                    end
                else
                    EVTS2(v136(iTrial)-4:v136(iTrial))
                    disp(['irregular 3 trial ' num2str(iTrial)])
                    keyboard
                end
            end
        case '162'%?
            fxoff = find(EVTS == 1);
            tronset = round(T(fxoff+1)*SUB.fs);
            
        otherwise
            tronset= round(T(find(EVTS==1)+1)*SUB.fs);
%             tronset= round(T(EVTS < 132)*SUB.fs);
    end
    %% modified by NT (09 Aug 28)
%     Tchop = repmat(grange',1,length(tronset)) + repmat(tronset,length(grange),1);
    
    if 0
        filename = ['BM' subID '.mat'];
        load([DIR.rawData filename] ,'Tchop')
    else
        Tchop = repmat(grange',1,length(tronset)) + repmat(tronset,length(grange),1);
% %         Tchop = repmat(SUB.tRange',1,length(tronset)) + repmat(tronset,length(SUB.tRange),1);
    end
    
    for iChan = SUB.chan
        clear tmp
        val = ['li' num2str(iChan)];
        if isempty(dir([rawChanDir{1} filesep 'allSession_' val  '.mat']))
            disp([val ' not found'])
            continue
        end
        load([rawChanDir{1} filesep 'allSession_' val  '.mat'])
        eval(['tmp = ' val ';'])
        
        %% correct gain
        switch subID
            case {'147','149','153','154','156'}
                disp('correct for gain')
                tmp.dat = tmp.dat /20 ;
        end
        
        tmpChan.dat = tmp.dat(Tchop);
        eval([val ' = tmpChan.dat;'])
        saveFilename = ['allSessions' '_' val '_t(' SUB.ext ')_seg_lfp_' 'PPort' '.mat'];

        save([segChanDir{1} saveFilename],val)
        disp([subID ' segmenting and saving ' val])
        eval(['clear ' val ])
    end
    
    
else
    
    %% get trial Timing
    for iSession = SUB.vSession
        rawChanDir{iSession} = [DIR.rawData getfilenum(SUB.session(iSession),3) filesep 'correctEachChan' filesep];
        segChanDir{iSession} = [DIR.rawData getfilenum(SUB.session(iSession),3) filesep 'segEachChan' filesep];
        
        if ~exist(segChanDir{iSession},'dir')
            mkdir(segChanDir{iSession})
        end
        
        try
            tmpEvnt         = load([DIR.rawData getfilenum(SUB.session(iSession),3) filesep 'rawEachChan' filesep SUB.evntFile{iSession}]);
        catch me
            tmpEvnt         = load([DIR.rawData filesep SUB.evntFile{iSession}]);
%             tmpEvnt         = load([rawChanDir{iSession} SUB.evntFile{iSession}]);
        end
        EVNT(iSession)      = tmpEvnt.evnt;
        %%
        switch subID
            case '147'
                trOnset{iSession}   = round(EVNT(iSession).time(2:6:end)*SUB.fs);
                trOnset2{iSession}  = round(EVNT(iSession).time(find(EVNT(iSession).evnt==1)+1)*SUB.fs);
                if sum(trOnset{iSession} - trOnset2{iSession})
                    keyboard
                end
            otherwise
                %             trOnset{iSession}   = round(EVNT(iSession).time(EVNT(iSession).evnt < 132)*SUB.fs);
                trOnset{iSession}  = round(EVNT(iSession).time(find(EVNT(iSession).evnt==1)+1)*SUB.fs);
        end
        
%         for iTrial = 1:length(trOnset{iSession})
%             [~,trTimeIdx{iSession}(iTrial)] = min(abs( trOnset{iSession}(iTrial) - time{iSession}  ));
%             %         if iTrial == 1 && iSession == 1
%             %             [~,trTimeIdx{iSession}(iTrial,2)] = min(abs( trOnset{iSession}(iTrial) - (time{iSession} + abs(SUB.tRange(2))) ));
%             %             nPntsPerTrial       = length(trTimeIdx{iSession}(iTrial,1):trTimeIdx{iSession}(iTrial,2));
%             %         else
%             %             trTimeIdx{iSession}(iTrial,2)  = trTimeIdx{iSession}(iTrial,1)+nPntsPerTrial-1;
%             %         end
%         end
    end
    gRange = round([SUB.tRange(1):1./SUB.fs:SUB.tRange(2)]*SUB.fs);
    %% segment
    for iSession = SUB.vSession
        disp(['session ' num2str(iSession)])
        for iChan = SUB.chan
            val = ['li' num2str(iChan)];
            disp(['segment ' val ' ' datestr(now)])
            
            filename = [getfilenum(SUB.session(iSession),3) '_' val];
            saveFilename = [getfilenum(SUB.session(iSession),3) '_' val '_t(' SUB.ext ')_seg_lfp_' 'PPort' '.mat'];
            
            load([DIR.rawData getfilenum(SUB.session(iSession),3) filesep 'correctEachChan' filesep filename]);
            eval(['tmpChan = ' val ';']); 
                        
            for iTrial = 1:length(trOnset{iSession})
                %             tmpChan.erp(iTrial,:) = tmpChan.dat(trTimeIdx{iSession}(iTrial,1):trTimeIdx{iSession}(iTrial,2));
                tmpChan.erp(iTrial,:) = tmpChan.dat(trOnset{iSession}(iTrial)+gRange);
            end
            eval([val '= tmpChan.erp;'])
            save([segChanDir{iSession} filesep saveFilename ],['li' num2str(iChan)])
            clear(val)
        end
    end
end


