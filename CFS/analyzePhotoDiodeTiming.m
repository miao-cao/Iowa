function analyzePhotoDiodeTiming(subID)
% nargin = 0;
% rewritten by NT 2009 Jan 11
% based on getEventOnsetTiming
dbstop if error
if nargin < 1
    subID = '168'
end
PLOT.print = 1;
PLOT.visible = 'on ';
%% rewritten by NT, 2009 Jan 10

subSpecs_IowaCFS
DIR.fig = [DIR.figBase 'figurePhotoDiodeTiming/'];
if isempty(dir(DIR.fig))
    mkdir(DIR.fig)
end

%% load rmlined photoDiode data
clear rmpd
vSession = [];
for iSession= 1:SUB.nSession
    clear tmp tmp2
    rawDataDir{iSession} = [DIR.rawData '/' getfilenum(SUB.session(iSession),3) '/rawEachChan/'];
    PhotoDiodeFile{iSession} = dir([rawDataDir{iSession} '/*ex*1.mat']);
    rmPhotoDiodeFile{iSession} = dir([rawDataDir{iSession} '/*ex*1_rmln.mat']);
    
    if isempty(rmPhotoDiodeFile{iSession})
        disp(['photoDiodeFile not found for ' rawDataDir{iSession}])
        continue
    end
    
    vSession = [vSession iSession]; %
    if isempty(PhotoDiodeFile{iSession})
        PhotoDiodeFile{iSession} = dir([DIR.rawData '/*' num2str(SUB.session(iSession)) '_photodiode.mat']);
        
        if isempty(PhotoDiodeFile{iSession})
            disp(['photoDiodeFile not found for ' rawDataDir{iSession} ' : readEvntData' ])            
            continue
        end
        tmp = load([DIR.rawData '/' PhotoDiodeFile{iSession}.name],'ex1');
        PhotoDiodeFile{iSession}.name = [PhotoDiodeFile{iSession}.name(1:end-(length('photodiode.mat'))) 'ex1.mat'];
    else
        tmp = load([rawDataDir{iSession} PhotoDiodeFile{iSession}.name]);  
    end

%     tmp = load([rawDataDir{iSession} PhotoDiodeFile{iSession}.name]);
    load([rawDataDir{iSession} rmPhotoDiodeFile{iSession}.name],'RMPD');
    rmpd{iSession} = RMPD;
    
    
    switch PhotoDiodeFile{iSession}.name
        % for 153-128, remove segment ~173 sec to 175 sec.
        case '128_ex1.mat'
            if strcmpi(subID,'153')
                rmpd{iSession}(353000:354000)=0.05;
            end% for 153-128, remove segment ~173 sec to 175 sec.
        case 'pt1561214am_156-154_ex1.mat'
                rmpd{iSession}(94709:94750)=-0.25;
                rmpd{iSession}(834350:end)=-0.25;
        case '168-55_ex1.mat'
            rmpd{iSession}(493920:494300)=0.34;
        case '056_ex1.mat'
            if strcmpi(subID,'232')
                rmpd{iSession}(573010:584970)=-0.025;
                rmpd{iSession}(795000:800000)=-0.025;
            end
        case '057_ex1.mat'
            if strcmpi(subID,'232')
                rmpd{iSession}(573010:584970)=-0.025;
                rmpd{iSession}(795000:800000)=-0.025;
            end
    end
    
    
    
    if isfield(tmp,'ex1')
        tmp2 = tmp.ex1;
    else
        tmp2 = tmp.ext1;
    end
    
    pd{iSession} = tmp2.dat;
    % time = ex1.t; % this is not used
    fs(iSession) = unique(tmp2.fs);
end

%% check the photodiode responnse
nRow = 10;
for iSession = vSession
    
    
    
    figure(iSession),clf
    set(gcf,'visible',PLOT.visible)
    hold on
    tmp = 1: floor( length(rmpd{iSession})/nRow);
    ysep = max(pd{iSession})-min(pd{iSession});
    subplot(2,1,1), hold on
    
    for iRow = 1:nRow
        tmp2 = tmp + (iRow-1) * floor(length(rmpd{iSession})/nRow);
        plot(tmp/fs(iSession), pd{iSession}(tmp2)-iRow*(ysep) );
        
        plot(tmp/fs(iSession), rmpd{iSession}(tmp2)-iRow*(ysep) ,'r');
        
        axis on
        axis tight
        xlabel('sec')
        title([SUB.dataFile{iSession} ' :  all segments : blue before : red after rmline'])
    end
    
    subplot(2,1,2), hold on
    plot(tmp/fs(iSession), pd{iSession}(tmp2));
    plot(tmp/fs(iSession), rmpd{iSession}(tmp2),'r');
    axis tight
    title('last segment')
    
    if PLOT.print
        print(gcf,'-dpng',[DIR.fig '/photoDiode_effects_rmline_' SUB.dataFile{iSession} '.png'])
        figure_name=[DIR.fig '/photoDiode_effects_rmline_' SUB.dataFile{iSession} '.fig'];
        saveas(gcf,figure_name,'fig');
    end
end
%%
nRow = 3 ;

for iSession = vSession
    % SUB.photoDiodeTriggerVoltage(iSession)=-0.35; % temporary fix, we will need to edit id_CFS_Patient3.csv in windows - not need for this now, we can use libreoffice
    clear trigger
    figure(iSession+1000),clf
    set(gcf,'visible',PLOT.visible)
    tmp = 1: floor( length(rmpd{iSession})/nRow);
    for iRow = 1:nRow
        subplot(nRow,1,iRow), hold on
        
        tmp2 = tmp + (iRow-1) * floor(length(rmpd{iSession})/nRow);
        plot(tmp/fs(iSession), rmpd{iSession}(tmp2) ,'r');
        axis on
        axis tight
        switch iRow
            case nRow
                xlabel('sec')
            case 1
                title([SUB.dataFile{iSession} ' :  after rmline'],'interpret','none')
        end
        
        if ~isnan(SUB.photoDiodeReadyVoltage(iSession))
            plot(xlim,SUB.photoDiodeReadyVoltage(iSession) *[1 1],'b')
            plot(xlim,SUB.photoDiodeTriggerVoltage(iSession) *[1 1],'g')
        end
    end
    
    % detect ready and trigger
    %     tmpReadyFlag = rmpd{iSession};
    %     tmpTriggerFlag = tmpReadyFlag;
    
    if ~isnan(SUB.photoDiodeReadyVoltage(iSession))
        photoDiodePolarity = SUB.photoDiodeReadyVoltage(iSession) > SUB.photoDiodeTriggerVoltage(iSession)
        
        if photoDiodePolarity == 1
% downward_crossings are actually upward_crossings with this polarity
            downward_crossings=1+find(rmpd{iSession}(2:end)  > SUB.photoDiodeReadyVoltage(iSession) & rmpd{iSession}(1:end-1) < SUB.photoDiodeReadyVoltage(iSession));
            upward_crossings=1+find(rmpd{iSession}(2:end)  < SUB.photoDiodeTriggerVoltage(iSession) & rmpd{iSession}(1:end-1) > SUB.photoDiodeTriggerVoltage(iSession));
            index_down=1;
            index_up=1;
            index_trial=1;
            while(index_down<=length(downward_crossings) & index_up<=length(upward_crossings))
                if (upward_crossings(index_up) > downward_crossings(index_down))
                    if((upward_crossings(index_up)-downward_crossings(index_down))/fs(iSession)<2)
                        trigger(index_trial)=upward_crossings(index_up);
                        index_trial=index_trial+1;
                        index_down=index_down+1;
                        index_up=index_up+1;
                    else
                        index_down=index_down+1;
                    end
                else
                    index_up=index_up+1;
                    
                end
                
            end            
            
            
            
        else
            
            downward_crossings=1+find(rmpd{iSession}(2:end)  < SUB.photoDiodeReadyVoltage(iSession) & rmpd{iSession}(1:end-1) > SUB.photoDiodeReadyVoltage(iSession));
            upward_crossings=1+find(rmpd{iSession}(2:end)  > SUB.photoDiodeTriggerVoltage(iSession) & rmpd{iSession}(1:end-1) < SUB.photoDiodeTriggerVoltage(iSession));
            index_down=1;
            index_up=1;
            index_trial=1;
            while(index_down<=length(downward_crossings) & index_up<=length(upward_crossings))
                if (upward_crossings(index_up) > downward_crossings(index_down))
                    if((upward_crossings(index_up)-downward_crossings(index_down))/fs(iSession)<2)
                        trigger(index_trial)=upward_crossings(index_up);
                        index_trial=index_trial+1;
                        index_down=index_down+1;
                        index_up=index_up+1;
                    else
                        index_down=index_down+1;
                    end
                else
                    index_up=index_up+1;
                    
                end
                
            end
            
        end
        
        
        % OLD VERSION BELOW
        %         if photoDiodePolarity == 1
        %             for iTrial = 1:SUB.Trial_Num(iSession)*2 % *2 for two intervals
        %                 minReady   = min(find  (tmpReadyFlag   > SUB.photoDiodeReadyVoltage(iSession)));
        %                 minTrigger = min(find( (tmpTriggerFlag < SUB.photoDiodeTriggerVoltage(iSession)) & (minReady < [1:length(tmpTriggerFlag)]') ) );
        %
        %                 trigger(iTrial) = minTrigger;
        %
        %                 tmpReadyFlag(1:minTrigger) = nan;
        %                 tmpTriggerFlag(1:minTrigger) = nan;
        %
        %             end
        %         else
        %             for iTrial = 1:SUB.Trial_Num(iSession)*2 % *2 for two intervals
        %                 minReady   = min(find  (tmpReadyFlag   < SUB.photoDiodeReadyVoltage(iSession)));
        %                 minTrigger = min(find( ...
        %                     (tmpTriggerFlag > SUB.photoDiodeTriggerVoltage(iSession)) ...
        %                     & (minReady < [1:length(tmpTriggerFlag)]') ) );
        %
        %                 trigger(iTrial) = minTrigger;
        %
        %                 tmpReadyFlag(1:minTrigger) = nan;
        %                 tmpTriggerFlag(1:minTrigger) = nan;
        %
        %             end
        %         end
        
        iTrigger = 0;
        for iRow = 1:nRow
            subplot(nRow,1,iRow), hold on
            
            % tmp2 = tmp + (iRow-1) * floor(length(pd{iSession})/nRow);
            tmp2 = tmp + (iRow-1) * floor(length(rmpd{iSession})/nRow);
            
            vTrialsInThisSegment = trigger( ismember( trigger , tmp2));
            
            % plot(tmp/fs(iSession), rmpd{iSession}(tmp2) ,'r');
            
            % plot([1 1]'*(vTrialsInThisSegment-tmp2(1)+1)/fs(iSession), ylim, 'k');
            for iTrigger2 = 1:length(vTrialsInThisSegment)
                plot([1 1]'*(vTrialsInThisSegment(iTrigger2)-tmp2(1)+1)/fs(iSession), ylim, 'k');
                
                iTrigger = iTrigger + 1;
                text((vTrialsInThisSegment(iTrigger2)-tmp2(1)+1)/fs(iSession),...
                    SUB.photoDiodeReadyVoltage(iSession) , num2str(iTrigger));
                
            end
            axis tight
        end
    end
    
    if PLOT.print
        print(gcf,'-dpng',[DIR.fig '/trialOnsetTiming_' SUB.dataFile{iSession} '.png'])
        figure_name=[DIR.fig '/trialOnsetTiming_' SUB.dataFile{iSession} '.fig'];
        saveas(gcf,figure_name,'fig');
    end
    
    if exist('trigger')
        savefilename = [rawDataDir{iSession} strrep( rmPhotoDiodeFile{iSession}.name ,'_rmln' ,'_trig')];
        save(savefilename,'trigger');
    end
end
