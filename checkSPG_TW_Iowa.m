function checkSPG_TW_Iowa(subID,iChan,EXP,PLOT,loadfilenameBase,savefilenameBase,dataSet)


subplot = @(m,n,p) subtightplot (m,n,p);

if 0
    SPG.window2check.phase.ff = [1 40];
    SPG.window2check.phase.tt = [0.1 0.6];
    
    SPG.window2check.power.ff = [50 150];
    SPG.window2check.power.tt = [0.1 0.6];
    savefilenameBase = ['SIGN_' savefilenameBase];
else
    SPG.window2check.phase.ff = [];
    SPG.window2check.phase.tt = [];
    
    SPG.window2check.power.ff = [];
    SPG.window2check.power.tt = [];
end

PLOT.colorScale.power = [];
PLOT.colorScale.phase = [];
XLIM = [-0.5 1];


switch dataSet
    case 'localizer'
        subSpecs_IowaLocalizer
    case 'CFS'
        subSpecs_IowaCFS
    case 'BM'
        subSpecs_IowaBM
end
getSPGsettings_Iowa
%%
colormap default
DIR.fig = [DIR.figBase 'SPG' filesep EXP.cond filesep];
if ~exist(DIR.fig,'dir')
    mkdir(DIR.fig)
end


%% check SPG MTSPEC
for iTW = SPG.nTW
    clear tmpSPG tmpMTSPEC tempChan phase power
    
    loadfilename = [loadfilenameBase '_' num2str(SPG.TW(iTW)) '.mat'];
    
    load([DIR.SPG loadfilename],['chan' num2str(iChan)]);
    eval(['tmpSPG=chan' num2str(iChan) ';']);
    
    tt = tmpSPG(1).ttPower-abs(SPG.times2compute(1));
    switch dataSet
        case 'localizer'
            [tmpSPG,~,EXP] = getSeparateConditions_IowaLocalizer(subID,tmpSPG,[],EXP);
        case 'CFS'
            [tmpSPG,~,EXP] = getSeparateConditions_IowaCFS(subID,tmpSPG,[],EXP,iChan);
        case 'BM'
            [tmpSPG,~,EXP] = getSeparateConditions_IowaBM(subID,tmpSPG,[],EXP);
    end
    %             tmpSPG = tmpSPG;
    
    [~,baselineIdx(1)] = min(abs(SPG.baseline(1)-tt));
    [~,baselineIdx(2)] = min(abs(SPG.baseline(2)-tt));
    
    if 1
        [~,iffPhase(1)] = min(abs(SPG.ff2checkPhase(1) - tmpSPG(1).ffPhase));
        [~,iffPhase(2)] = min(abs(SPG.ff2checkPhase(2) - tmpSPG(1).ffPhase));
        
        [~,iffPower(1)] = min(abs(SPG.ff2checkPower(1) - tmpSPG(1).ffPower));
        [~,iffPower(2)] = min(abs(SPG.ff2checkPower(2) - tmpSPG(1).ffPower));
    else
        iffPhase = [1 length(tmpSPG(1).ffPhase)];
        iffPower = [1 length(tmpSPG(1).ffPower)];
    end
    ffPhase = tmpSPG(1).ffPhase(iffPhase(1):iffPhase(2));
    ffPower = tmpSPG(1).ffPower(iffPower(1):iffPower(2));
    
    if ~isempty(SPG.window2check.power.ff)
        [~,window.ffPowerIdx(1)] =  min(abs(SPG.window2check.power.ff(1) - tmpSPG(1).ffPower));
        [~,window.ffPowerIdx(2)] =  min(abs(SPG.window2check.power.ff(2) - tmpSPG(1).ffPower));
        
        [~,window.ttPowerIdx(1)] = min(abs(SPG.window2check.power.tt(1)-tt));
        [~,window.ttPowerIdx(2)] = min(abs(SPG.window2check.power.tt(2)-tt));
        
    end
    
    if ~isempty(tmpSPG)
        figureSettings
        for trialType = 1:EXP.nCond
            phase(trialType).meanTrialPhase = squeeze(abs(mean(exp(1i*(tmpSPG(trialType).phase)),3)));
            phase(trialType).trialPhase = squeeze(abs(exp(1i*(tmpSPG(trialType).phase))));
            power(trialType).meanTrialPower = (squeeze(mean(tmpSPG(trialType).power,3)));
            power(trialType).trialPower = tmpSPG(trialType).power;
            
            clear phaseBaseline powerBaseline powerBaselineAllTrials powerBaselineMean
            for iFreq = 1:length(tmpSPG(trialType).ffPower)
                %% phase
                phaseBaseline_data = squeeze(mean(phase(trialType).meanTrialPhase(baselineIdx(1):baselineIdx(2),iFreq),1));
                phaseBaseline(:,iFreq) =  phase(trialType).meanTrialPhase(:,iFreq) - repmat(phaseBaseline_data,[size(tmpSPG(trialType).ttPhase,2) 1]);
                
                %% power
                powerBaseline_data = squeeze(mean(power(trialType).meanTrialPower(baselineIdx(1):baselineIdx(2),iFreq),1));
                powerBaselineMean(:,iFreq) =  (power(trialType).meanTrialPower(:,iFreq) - repmat(powerBaseline_data,[size(tmpSPG(trialType).ttPower,2) 1]));
                powerBaselineAllTrials(:,iFreq,:) = squeeze(power(trialType).trialPower(:,iFreq,:)) - repmat(powerBaseline_data,[size(tmpSPG(trialType).ttPower,2) size(power(trialType).trialPower,3)]);
            end
            phase(trialType).phaseBaseline = phaseBaseline;
            power(trialType).powerBaselineMean = (powerBaselineMean);
            power(trialType).powerBaselineAllTrials = powerBaselineAllTrials;
            
            if ~isempty(SPG.window2check.power.ff)
                power(trialType).window2check = squeeze(mean(mean(power(trialType).powerBaselineAllTrials(window.ttPowerIdx(1):window.ttPowerIdx(2),window.ffPowerIdx(1):window.ffPowerIdx(2),:),1),2));
            end
            
            if ~isempty(SPG.window2check.power.ff)
                power(trialType).window2check = squeeze(mean(mean(power(trialType).powerBaselineAllTrials(window.ttPowerIdx(1):window.ttPowerIdx(2),window.ffPowerIdx(1):window.ffPowerIdx(2),:),1),2));
            end
        end
        %%
        
        figureSettings
        for trialType = 1:EXP.nCond
            imagesc(tt,ffPhase,phase(trialType).phaseBaseline(:,iffPhase(1):iffPhase(2))')
            [climPhase(trialType,:)] = get(gca,'clim');
            clf
            imagesc(tt,ffPower,power(trialType).powerBaselineMean(:,iffPower(1):iffPower(2))')
            [climPower(trialType,:)] = get(gca,'clim');
            clf
        end
        if isempty(PLOT.colorScale.power)
            [clim2usePhase(1),~] = min(min(climPhase(:,1)));
            [clim2usePhase(2),~] = max(max(climPhase(:,2)));
            
            [clim2usePower(1),~] = min(min(climPower(:,1)));
            [clim2usePower(2),~] = max(max(climPower(:,2)));
        else
            clim2usePower = PLOT.colorScale.power;
            clim2usePhase = PLOT.colorScale.phase;
        end
        
        
        %% plotting
        for trialType = 1:EXP.nCond
            %% phase
            subplot(2,EXP.nCond+1,trialType)
            
            imagesc(tt,ffPhase,phase(trialType).phaseBaseline(:,iffPhase(1):iffPhase(2))',clim2usePhase)
            axis xy
            axis square
            title([EXP.legendtxt{trialType}],'interpret','none')
            xlim(XLIM)
            %                     ylabel('freq (Hz)')
            if ~(trialType==1)
                set(gca,'yTickLabel','')
            end
            
            if trialType==EXP.nCond
                subplot(2,EXP.nCond+1,trialType+1)
                h1 = subplotColorbar(gca,'Default',clim2usePhase,'west');
                h1.FontSize = 15;
                h1.Label.String = 'ITPC';
                h1.Label.FontSize = 20;
                h1.Ticks = linspace(clim2usePhase(1),clim2usePhase(2),5);
                h1.TickLabels = round(linspace(clim2usePhase(1),clim2usePhase(2),5),1);
                
            end
            %% power
            subplot(2,EXP.nCond+1,trialType+EXP.nCond+1)
            imagesc(tt,ffPower,power(trialType).powerBaselineMean(:,iffPower(1):iffPower(2))',clim2usePower)
            axis xy
            axis square
            %                     title('power')
            xlim(XLIM)
            %                     ylabel
            if ~isempty(SPG.window2check.power.ff)
                YLIM = get(gca,'ylim');
                hold on
                plot([tt(window.ttPowerIdx(1)) tt(window.ttPowerIdx(1))],[ffPower(window.ffPowerIdx(1)) ffPower(window.ffPowerIdx(2))],'w--','lineWidth',2)
                plot([tt(window.ttPowerIdx(2)) tt(window.ttPowerIdx(2))],[ffPower(window.ffPowerIdx(1)) ffPower(window.ffPowerIdx(2))],'w--','lineWidth',2)
                
                plot([tt(window.ttPowerIdx(1)) tt(window.ttPowerIdx(2))],[ffPower(window.ffPowerIdx(1)) ffPower(window.ffPowerIdx(1))],'w--','lineWidth',2)
                plot([tt(window.ttPowerIdx(1)) tt(window.ttPowerIdx(2))],[ffPower(window.ffPowerIdx(2)) ffPower(window.ffPowerIdx(2))],'w--','lineWidth',2)
                
                [H,P,~,stat]=ttest2(power(1).window2check,power(2).window2check);
                title(['H=' num2str(H) ', P=' num2str(P) ', T=' num2str(stat.tstat)])
            end
            
            if ~(trialType==1)
                set(gca,'yTickLabel','')
            end
            if trialType==EXP.nCond
                subplot(2,EXP.nCond+1,trialType+EXP.nCond+2)
                h1 = subplotColorbar(gca,'Default',clim2usePower,'west');
                h1.FontSize = 15;
                h1.Label.String = 'dB';
                h1.Label.FontSize = 20;
                h1.Ticks = linspace(clim2usePower(1),clim2usePower(2),5);
                h1.TickLabels = round(linspace(clim2usePower(1),clim2usePower(2),5),1);
%                 for iTick = 1:length(tickLabels)
%                     h2.TickLabels{iTick} = tickLabels(iTick);
%                 end
% %                 
%                 h2 = colorbar;
%                 axis off
%                 h2.Limits = [cAxis(1) cAxis(2)];
%                 h2.Ticks = linspace(cAxis(1),cAxis(2),5);
%                 tickLabels = linspace(clim2usePower(1),clim2usePower(2),5);
%                 for iTick = 1:length(tickLabels)
%                     h2.TickLabels{iTick} = tickLabels(iTick);
%                 end
%                 h2.FontSize = 15;
%                 h2.Label.String = 'dB';
%                 h2.Label.FontSize = 20;
%                 h2.Location = 'west';
%                 colormap jet
% 
                
            end
        end
        savefilename = [savefilenameBase '_' num2str(SPG.TW(iTW)) ];
        figureSave
%         YLIM = [-2 6]
%         colors = colormap(hsv(4));
% %         switch EXP.decodeType
%             case 'allVisibility_allContrasts'
%                 figureSettings
%                 for iVis = 1:4
%                     clear h legendTxt
%                     [~,visIdx] = grep(conditions,['V' num2str(iVis)]);
%                     %% phase
%                     subplot(1,4,iVis)
%                     line2plot = 0;
%                     for iVisIdx = find(visIdx)
%                         line2plot = line2plot+1;
%                         h(line2plot) = plot(tt,squeeze(mean(power(iVisIdx).powerBaselineMean(:,iffPower(1):iffPower(2)),2)),'color',colors(line2plot,:),'lineWidth',2);
%                         axis xy
%                         axis square
%                         hold on
%                         %                     title('power')
%                         ylim(YLIM)
%                         xlim(XLIM)
%                         %                     ylabel
%                         legendTxt{line2plot} = conditions{iVisIdx};
%                         
%                         if ~(iVis==1)
%                             set(gca,'yTickLabel','')
%                         end
%                         legend(h,legendTxt)
%                         
%                     end
%                 end
%                 savefilename = [savefilenameBase '_' num2str(SPG.TW(iTW)) '_linePlot_vis'];
%                 figureSave
%                 
%                 
%                 
%                 figureSettings
%                 for iCon = 1:3
%                     clear h legendTxt
%                     [~,conIdx] = grep(conditions,['C' num2str(iCon)]);
%                     %% phase
%                     subplot(1,3,iCon)
%                     line2plot = 0;
%                     for iConIdx = find(conIdx)
%                         line2plot = line2plot+1;
%                         h(line2plot) = plot(tt,squeeze(mean(power(iConIdx).powerBaselineMean(:,iffPower(1):iffPower(2)),2)),'color',colors(line2plot,:),'lineWidth',2);
%                         axis xy
%                         axis square
%                         hold on
%                         %                     title('power')
%                         ylim(YLIM)
%                         xlim(XLIM)
%                         %                     ylabel
%                         legendTxt{line2plot} = conditions{iConIdx};
%                         
%                         if ~(iVis==1)
%                             set(gca,'yTickLabel','')
%                         end
%                         legend(h,legendTxt)
%                         
%                     end
%                 end
%                 
%                 savefilename = [savefilenameBase '_' num2str(SPG.TW(iTW)) '_linePlot_con'];
%                 figureSave
%         end
    end
end
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    %
