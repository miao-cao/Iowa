function compareTimingPhotoDiodeEvnt(subID)
% based on getEventOnsetTiming
% use this to analyze timing for 149 for whom we don't have photodiode 
% nargin = 0;
if nargin < 1
    subID = '168'
end
dbstop if error
%%
PLOT.visible = 'on';
PLOT.print = 1;

%% rewritten by NT, 2009 Jan 10
subSpecs_IowaCFS
DIR.fig = [DIR.figBase 'figureEventOnsetTiming/'];
if isempty(dir(DIR.fig))
    mkdir(DIR.fig)
end
%% load trigger based on photodiode
vSession = [];
for iSession = 1:SUB.nSession
    clear trig evnt
    rawDataDir{iSession} = [DIR.rawData '/' getfilenum(SUB.session(iSession),3) '/rawEachChan/'];
    pdTriggerFile{iSession} = dir([rawDataDir{iSession} '/*_trig.mat']);
    if isempty(pdTriggerFile{iSession})
        disp(['photoDiode trigger not found for ' rawDataDir{iSession}])
        % continue
        vSession = [vSession iSession];
        % load([rawDataDir{iSession} pdTriggerFile{iSession}.name]);
        TRIG{iSession} = [];
        
    else
        vSession = [vSession iSession];
        load([rawDataDir{iSession} pdTriggerFile{iSession}.name]);
        TRIG{iSession} = trigger;
    end

    % pdFile{iSession} = dir([rawDataDir{iSession} '/*ex*1.mat']);
    % load([rawDataDir{iSession} pdFile{iSession}.name]);

    %% load evnt
    evntFile{iSession} = dir([rawDataDir{iSession} '/*evnt.mat']);
    load([rawDataDir{iSession} evntFile{iSession}.name]);
    EVNT{iSession} = evnt.evnt;
    TIME{iSession} = evnt.time;
end
%%

rangeForSearchBeforeTrigger = 0.2; % sec;
clear evntTrig timeTrig

for iSession = vSession
    jCandidateTime149 = 0;
%     figure(iSession),clf, hold on
%     plot(TIME{iSession},EVNT{iSession},'o')
    for iTrial = 1:SUB.Trial_Num(iSession)
        if ~isempty(TRIG{iSession})
            tmp1 = TRIG{iSession}(iTrial*2-1)/SUB.fs;
            iCandidateTime = find( tmp1-rangeForSearchBeforeTrigger <TIME{iSession} &  TIME{iSession} < tmp1 ) ;
            if isempty(iCandidateTime)
                iCandidateTime = find( tmp1+rangeForSearchBeforeTrigger >TIME{iSession} &  TIME{iSession} > tmp1 ) ;
            end                
        else % for 149 
            while 1
                jCandidateTime149 = jCandidateTime149 + 1;
                if jCandidateTime149 > length(EVNT{iSession})
                    break
                end
                tmp = EVNT{iSession}([0 1 2] + jCandidateTime149);
                if tmp(1) == 3 & tmp(2) == 3 & tmp(3) == 2
                    iCandidateTime = jCandidateTime149
                    tmp
                    tmpTrial = EVNT{iSession}(-5+iCandidateTime);
                    if tmpTrial == iTrial 
                        disp(['trial : ' num2str(tmpTrial)])
                        break
                    else
                        tmpTrial = EVNT{iSession}(-6+iCandidateTime);
                        if tmpTrial == iTrial 
                            disp(['trial : ' num2str(tmpTrial)])
                            break
                        else
                            keyboard
                        end
                    end
                end                    
            end
                
        end
%         disp(EVNT{iSession}(iCandidateTime))
%         plot(TIME{iSession}(iCandidateTime),EVNT{iSession}(iCandidateTime),'o')
        if length(iCandidateTime) == 1 && EVNT{iSession}(iCandidateTime) == 3 && EVNT{iSession}(iCandidateTime+1) == 3
%             iCandidateTime = iCandidateTime+1
            vTrig{iSession}(iTrial,1) = iCandidateTime;
            evntTrig{iSession}(iTrial,1) = EVNT{iSession}(iCandidateTime);
            timeTrig{iSession}(iTrial,1) = TIME{iSession}(iCandidateTime);
            if ~isempty(TRIG{iSession})
                pdTrig{iSession}(iTrial,1) = TRIG{iSession}(iTrial*2-1)/SUB.fs;
            else                
                pdTrig{iSession}(iTrial,1) = nan; 
                vTrig{iSession}(iTrial,2) = iCandidateTime + 1 ;
                evntTrig{iSession}(iTrial,2) = EVNT{iSession}(iCandidateTime+1);
                timeTrig{iSession}(iTrial,2) = TIME{iSession}(iCandidateTime+1);
                pdTrig{iSession}(iTrial,2) = nan;
            end
        elseif isempty(iCandidateTime)
            disp(['no event marker found : trial ' num2str(iTrial)])
                keyboard
        else
            keyboard
        end


        if ~isempty(TRIG{iSession})
            tmp2 = TRIG{iSession}(iTrial*2)/SUB.fs;
            jCandidateTime = find( tmp2-rangeForSearchBeforeTrigger <TIME{iSession} &  TIME{iSession} < tmp2 ) ;
            if isempty(jCandidateTime)
                jCandidateTime = find( tmp2+rangeForSearchBeforeTrigger >TIME{iSession} &  TIME{iSession} > tmp2 ) ;
            end
%             plot(TIME{iSession}(jCandidateTime),EVNT{iSession}(jCandidateTime),'rx')
            if length(jCandidateTime) == 1 & EVNT{iSession}(jCandidateTime) == 3
                vTrig{iSession}(iTrial,2) = jCandidateTime;
                evntTrig{iSession}(iTrial,2) = EVNT{iSession}(jCandidateTime);
                timeTrig{iSession}(iTrial,2) = TIME{iSession}(jCandidateTime);
                pdTrig{iSession}(iTrial,2) = TRIG{iSession}(iTrial*2)/SUB.fs;
            elseif isempty(jCandidateTime)
                disp(['no event marker found : trial ' num2str(iTrial)])
                keyboard
            else
                keyboard
            end
        end
    end
end
%% plot with rows
nRow = 3 ;
for iSession = vSession
    figure(iSession+1000),clf
    set(gcf,'visible',PLOT.visible)

    tmp = [0 TIME{iSession}(end)/nRow];
    for iRow = 1:nRow
        subplot(nRow,1,iRow), hold on

        tmp2 = tmp + (iRow-1) * TIME{iSession}(end)/nRow ;

        vThisSegments = find(tmp2(1)<timeTrig{iSession}(:,1) & timeTrig{iSession}(:,1) < tmp2(2));
        plot(timeTrig{iSession}(vThisSegments,1),evntTrig{iSession}(vThisSegments,1),'ro');
        plot(timeTrig{iSession}(vThisSegments,2),evntTrig{iSession}(vThisSegments,2),'bx');

        for iSubTrial = vThisSegments
            text(timeTrig{iSession}(iSubTrial,1),...
                evntTrig{iSession}(iSubTrial,1),...
                num2str(iSubTrial));
            plot(timeTrig{iSession}(iSubTrial,1)*[1 1],...
                ylim,...
                'r');
            plot(timeTrig{iSession}(iSubTrial,2)*[1 1],...
                ylim,...
                'b');
            plot([1 1]'*pdTrig{iSession}(iSubTrial,1)',ylim,'k')

        end

        axis on
        axis tight
        set(gca,'xlim',tmp2)
        switch iRow
            case nRow
                xlabel('sec')
            case 1
                title([SUB.dataFile{iSession} ' :  after rmline'])
        end
        %         tmp2 = tmp + (iRow-1) * floor(length(pd{iSession})/nRow);
        %
        %         vTrialsInThisSegment = trigger( ismember( trigger , tmp2));
        %
        %         % plot(tmp/SUB.fs(iSession), rmpd{iSession}(tmp2) ,'r');
        %         plot([1 1]'*(vTrialsInThisSegment-tmp2(1)+1)/SUB.fs(iSession), ylim, 'k');
        %         if ~isnan(SUB.photoDiodeReadyVoltage(iSession))
        %             plot(xlim,SUB.photoDiodeReadyVoltage(iSession) *[1 1],'b')
        %             plot(xlim,SUB.photoDiodeTriggerVoltage(iSession) *[1 1],'g')
        %         end
    end
    if PLOT.print
        print(gcf,'-dpng',[DIR.fig '/CompareTrialOnsetTiming_' SUB.dataFile{iSession} '.png'])
    end
end

%% histgram for the delay
figure(99);clf
set(gcf,'visible',PLOT.visible)
for iSession = vSession
    subplot(2,2,iSession)
    evntDelay = pdTrig{iSession}-timeTrig{iSession};
    hist(evntDelay)
    title({[SUB.dataFile{iSession}] ;
        [ 'pd-evnt = ' num2str(mean(evntDelay)*1000,2) '+-' num2str(std(evntDelay)*1000,2) '[ms] (mean+std)']},...
        'interpret','none')
end
if PLOT.print
    print(gcf,'-dpng',[DIR.fig '/CompareTrialOnsetTimingHist_' subID '.png'])
end
%% save pdTrig and timeTrig
if exist('trigger')
    for iSession = vSession
        savefilename = [rawDataDir{iSession} strrep( pdTriggerFile{iSession}.name ,'_trig' ,'_PdEvtrig')];
        save(savefilename,'pdTrig','timeTrig');
    end
else % for 149 
    for iSession = vSession
        %% there are ~50ms delay 
        pdTrig{iSession} = timeTrig{iSession} + 0.05; 
        % savefilename = [rawDataDir{iSession} strrep( pdTriggerFile{iSession}.name ,'_trig' ,'_PdEvtrig')];
        savefilename = [rawDataDir{iSession} '/' getfilenum(SUB.session(iSession),3) '_PdEvtrig.mat']
        save(savefilename,'pdTrig','timeTrig');
    end
end


