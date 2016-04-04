function prepareSegmentWithPhDio(subID,EXP,PLOT)
nargin = 0;
% checked extensively for these subjects
checkedSubID = {'153','154a','168','173','178','180','181','186','232','242'};
% 1. load ex1(pport) file,
% 2. segment using pport info.
clear evnt ex1
clear PhotoDiodeThreshold ThresholdDirection iStart vStim

%%
if ~exist('subID')
    subID = '178';
end

subSpecs_IowaLocalizer
rmLineNoise=1;

DIR.fig = [DIR.figBase 'PhDio' filesep];
if ~exist(DIR.fig,'dir')
    mkdir(DIR.fig)
end

for iSession = 1:SUB.nSession
    clear filename v* t* PhDioEvnt ex1 iStart
    iStart = single(SUB.phDioStart(iSession));
    filename = [subID '-' getfilenum(SUB.session(iSession),3)];
    % S.AlignOnset{iSession} = 'PhDio'
    %%
    PLOT.allPhotoDiodeData = 0;
    PLOT.onsetTime_forEachTrial = 0;
    PLOT.onsetTime_forEachTrial2 = 0;
    PLOT.onsetTime_forAllTrials = 0;
    PLOT.rmLineNoise = 1;
    
    %% load photoDiode data
    switch SUB.alignOnset{iSession}
        case {'PPort','Beh'}
            disp('skip prepareSegment With PhDio')
            continue
            
        case 'PhDio'
            disp(['loading ex1 from ' filename ' : ' datestr(now) ])
            evntFiles = dir([DIR.base filesep '..' filesep 'Face_emotion_external_inputs' filesep 'Face_Localizer_' subID filesep 'pt*']);
            [~,evntIdx] =  grep({evntFiles.name}, filename);
            load([DIR.base filesep '..' filesep 'Face_emotion_external_inputs' filesep 'Face_Localizer_' subID filesep evntFiles(evntIdx).name],'ex1')
    end
    %% load event data
    if exist([DIR.seg filesep filename '_PPort.mat'],'file')
        load([DIR.seg '/' filename '_PPort.mat'])
        vStim = PPortEvnt.vStim;
        vTime = PPortEvnt.vTime;
    else
        load([DIR.seg '/' filename '_behav.mat'])
        vStim = behEvnt(1).vStim;
    end
    
    %% notch filter PhDio
    if rmLineNoise
        movingwin = [.5 .1];
        tau = 10;
        params.tapers = [5 9];
        params.pad=2;
        
        params.Fs = SUB.fs;
        disp(['session ' num2str(iSession) ' : start removing line noise by moving window = ' num2str(movingwin) ' : ' datestr(now) ])
        [ex1RMLN.dat datafit] = rmlinesmovingwinc(ex1.dat,movingwin,tau,params,[],'y');
        
    end
    
    %% get the time
    t = 1:length(ex1RMLN.dat);
    t = t/ex1.fs(1);
    
    %%
    if PLOT.rmLineNoise
        figureSettings
        plot(1:length(ex1.dat), ex1.dat)
        hold on
        plot(1:length(t), ex1RMLN.dat,'r')
        hold on
        plot(1:length(t),[repmat(SUB.phDioThreshold(iSession), 1, length(t))],'g','lineWidth',2)
        hold on
        plot([double(iStart)] * [1 1],ylim,'m','lineWidth',2)
        hold off
        xlim([iStart, (iStart+1000)])
        %     ylim([YLIM])
        switch subID
            case checkedSubID
            otherwise
                keyboard
        end
        
        savefilename = [filename '_startPhDio'];
        figureSave
    end
    
    %%
    if 1
        figureSettings
        plot(1:length(t), ex1RMLN.dat)
        
        switch SUB.phDioDirection{iSession}
            case 'negative'
                thresholdTrials = (ex1RMLN.dat < SUB.phDioThreshold(iSession));
            case 'positive'
                thresholdTrials = (ex1RMLN.dat > SUB.phDioThreshold(iSession));
        end
        
        hold on
        plot(find(thresholdTrials),ex1RMLN.dat(thresholdTrials),'*r')
        hold on
        plot(iStart,ex1RMLN.dat(iStart),'om','MarkerSize',20)
        hold off
        
        savefilename = [filename '_thresholds'];
        figureSave

    end
    
    nCol = 4;
    nRow = 4;
    
    clear tStartPnt tStartTime
    
    for iTrial = 1:length(vStim)
        
        if PLOT.onsetTime_forEachTrial
            iResidual = mod(iTrial-1,nCol*nRow)+1;
            if iResidual == 1
                figure(ceil(iTrial/nCol/nRow))
                set(gcf,'visible',PLOT.visible)
                clf
            end
            subplot(nCol,nRow,iResidual)
        end
        % cla
        
        vTmpTime = [1:ex1.fs(1)*4]+(iStart);
        tmp = ex1RMLN.dat(vTmpTime);
        
        switch SUB.phDioDirection{iSession}
            case 'negative'
                tmpStart = min(find(tmp<SUB.phDioThreshold(iSession)));
            case 'positive'
                tmpStart = min(find(tmp>SUB.phDioThreshold(iSession)));
        end
        
        tStartPnt(iTrial) = vTmpTime(tmpStart);
        tStartTime(iTrial) = vTmpTime(tmpStart)/ex1.fs(1);
        if PLOT.onsetTime_forEachTrial
            plot(tmp)
            axis tight
            hold on
            plot(tmpStart*[1 1],ylim,'r','lineWidth',2)
            title({['tr=' num2str(iTrial)];
                ['start at ' num2str(tStartPnt(iTrial)) ' pnt'];
                ['time = ' num2str(tStartTime(iTrial)) ' sec']})
        end
        iStart = tStartPnt(iTrial) + SUB.trialOffset(iSession) ;
        
        if PLOT.onsetTime_forEachTrial
            if iResidual == nCol*nRow || iTrial == length(vTime)
                figfilename =  [DIR.fig filesep 'pdEachTrial_' filename 'tr' num2str(iTrial) '.png'];
                print(gcf,'-dpng',figfilename)
            end
        end
    end
    
    if PLOT.onsetTime_forAllTrials
        figureSettings
        plot(t,ex1RMLN.dat)
        hold on
        for iTrial = 1:length(tStartPnt)
            plot(t(tStartPnt(iTrial)) .*[1 1],ylim,'r','lineWidth',2)
            %         plot((vTrialOnset(iTrial)).*[1 1],ylim,'y','lineWidth',2)
        end
        savefilename = [filename '_onsetTrials'];
        figureSave
        
    end
    
    %% use a different criterion to find the minimum differnece in onset time
    clear vTrialPnt vTrialTime
    if exist([DIR.seg filesep filename '_PPort.mat'],'file')
        for iTime = 1 :length(vStim)
            if PLOT.onsetTime_forEachTrial2
                iResidual = mod(iTime-1,nCol*nRow)+1;
                if iResidual == 1
                    figure(ceil(iTime/nCol/nRow))
                    set(gcf,'visible',PLOT.visible)
                    clf
                end
                % subplot(nCol,nRow,iResidual)
            end
            
            
            % [tmp, iiTime ] = min( abs (ex1.t - vTime(iTime)));
            [tmp, iiTime ] = min( abs (t - vTime(iTime)));
            % get a segment of photodiode resp
            
            seg = ex1RMLN.dat(iiTime:iiTime+4000);
            
            % 08 Oct 9 -- this is the off set time!
            % [a] = min(find(seg>.2));
            
            switch SUB.phDioDirection{iSession}
                case 'positive'
                    % tmpStart = min(find(tmp<SUB.phDioDirection{iSession}))
                    [a] = min(find(seg>SUB.phDioThreshold(iSession)));
                case 'negative'
                    % tmpStart = min(find(tmp<SUB.phDioDirection{iSession}))
                    [a] = min(find(seg<SUB.phDioThreshold(iSession)));
            end
            %     if isempty(a)
            %         keyboard
            %         continue,
            %     end
            
            % 08 Oct 9
            vTrialPnt(iTime) = iiTime + a - 1;  %% this is the onset of stimulus time (in pnt)
            % vTrialPnt(iTime) = iiTime - 1001 + a;  %% this is the onset of stimulus time (in pnt)
            vTrialTime(iTime) = vTrialPnt(iTime)/ex1.fs(1);
            
            if PLOT.onsetTime_forEachTrial2
                hold on
                vv = iiTime-1001+a-3:iiTime-1001+a+3;
                plot(ex1RMLN.dat(vv),'o')
                plot(seg)
                plot(a*[1 1],ylim,'r')
                title({['trial ' num2str(iTime) ];
                    ['start at ' num2str(vTrialPnt(iTime)) ];
                    ['time = ' num2str(vTrialTime(iTime)) ]
                    })
            end
            %    pause
        end
        
        %% check if both approach converges to the same answer
        
        if sum(tStartPnt-vTrialPnt) > 0
            disp('error')
            keyboard
        end
    end
    %%
    nRow = 10;
    
    figureSettings
    hold on
    tmp = 1: floor( length(ex1RMLN.dat)/nRow);
    ysep = max(ex1.dat)-min(ex1.dat);
    subplot(2,1,1), hold on
    trialsTmpEnd =zeros(nRow,1);
    for iRow = 1:nRow
        tmp2 = tmp + (iRow-1) * floor(length(ex1RMLN.dat)/nRow);
        plot(tmp/SUB.fs, ex1.dat(tmp2)-iRow*(ysep) );
        
        plot(tmp/SUB.fs, ex1RMLN.dat(tmp2)-iRow*(ysep) ,'r');
        axis on
        axis tight
        xlabel('sec')
        title([filename ' :  all segments : blue before : red after rmline'])
        
        trialsTmp = tStartPnt<tmp2(end);
        trialsTmpEnd(iRow) = length(find(trialsTmp));
        if iRow ~= 1
            trialsTmp(1:trialsTmpEnd(iRow-1)) = 0;
        end
        trialsTmpIdx = find(trialsTmp);
        YLIM = get(gca,'ylim');
        for iTrial = 1:length(find(trialsTmp))
            [~,t2plot] = min(abs(t(tStartPnt(trialsTmpIdx(iTrial)))-t(tmp2)));
            switch SUB.phDioDirection{iSession}
                case 'positive'
                    plot( t2plot/SUB.fs*[1 1],[-ysep 0]-(iRow-1)*ysep,'g','lineWidth',2)
                case 'negative'
                    plot( t2plot/SUB.fs*[1 1],[-ysep 0]-(iRow)*ysep,'g','lineWidth',2)
            end
            %         ylim([-iRow*ysep])
        end
        
    end
    
    subplot(2,1,2), hold on
    plot(tmp/SUB.fs, ex1.dat(tmp2));
    plot(tmp/SUB.fs, ex1RMLN.dat(tmp2),'r');
    axis tight
    title('last segment')
    
    savefilename = [filename '_onsetTrials'];
    figureSave
    
    %     if PLOT.print
    %         print(gcf,'-dpng',[DIR.fig '/photoDiode_effects_rmline_' Sub.dataFile '.png'])
    %         figure_name=[DIR.fig '/photoDiode_effects_rmline_' Sub.dataFile '.fig'];
    %         saveas(gcf,figure_name,'fig');
    %     end
    switch subID
        case checkedSubID
            % checked extensively for these subjects
        otherwise
            keyboard
    end
    %% save everything in 1 structure
    
    PhDioEvnt.nTrials               = length(tStartPnt);
    
    PhDioEvnt.photoDiodeThreshold   = SUB.phDioThreshold(iSession);
    PhDioEvnt.thresholdDirection    = SUB.phDioDirection{iSession};
    PhDioEvnt.ex1                   = ex1(:);
    PhDioEvnt.t                     = t;
    PhDioEvnt.tStartPnt             = tStartPnt;
    PhDioEvnt.tStartTime            = tStartTime;
    PhDioEvnt.SUB.trialOffset(iSession)           = SUB.trialOffset(iSession);
    if exist([DIR.seg filesep filename '_PPort.mat'],'file')
        PhDioEvnt.vTrialPnt             = vTrialPnt;
    end
    %% save
    disp(['saving ' filename '_PhDio.mat in ' DIR.seg ' : ' datestr(now)])
    save([DIR.seg '/' filename '_PhDio.mat'],'PhDioEvnt')
end
