function plotDecode_TW_Iowa_eachTime_eachFreq_eachTimeEachFreq(SUB,EXP,SPG,DEC,DIR,PLOT,DATA,tmpSavefilename)

subplot = @(m,n,p) subtightplot (m,n,p,0.02,0.05,0.15);

[nSub, nGrid, nDim, nDimDecode] = size(DATA);
colors = {'r','g','b'};

PLOT.signY = [0.2 0.25 0.3];


fontSize = 14;
%% get decodeDim idx

switch DEC.dimension
    case 'eachElectrodeCombinePlot'
        [~,dIdxT] = (grep(DEC.allDimension,'eachElectrodeEachTime'));
        [~,dIdxF] = (grep(DEC.allDimension,'eachElectrodeEachFreq'));
        [~,dIdxTF] = (grep(DEC.allDimension,'eachElectrodeEachTimeEachFreq'));
    case 'multiElectrodeCombinePlot'
        [~,dIdxT] = (grep(DEC.allDimension,'multiElectrodeEachTime'));
        [~,dIdxF] = (grep(DEC.allDimension,'multiElectrodeEachFreq'));
        [~,dIdxTF] = (grep(DEC.allDimension,'multiElectrodeEachTimeEachFreq'));
end
[dIdxT]    = min(find(dIdxT));
[~,dIdxF]  = find(dIdxF);
[~,dIdxTF] = find(dIdxTF);

%% get time and freq
tt = DATA(1,1,1,dIdxT).tt;
freq = DATA(1,1,1,dIdxF).freq;
if isempty(tt)
    %     keyboard
    return
end


[~,startTrial]=min(abs(0-tt));
colormap Hot

%% extract data 2 plot

D2PLOT.time         = NaN(nSub,nGrid,nDim,length(tt));
D2PLOT.freqPhase    = NaN(nSub,nGrid,length(freq));
D2PLOT.freqPower    = NaN(nSub,nGrid,length(freq));
D2PLOT.timeFreqPhase     = NaN(nSub,nGrid,length(tt),length(freq));
D2PLOT.timeFreqPower     = NaN(nSub,nGrid,length(tt),length(freq));
D2PLOT.timePerm     = NaN(nSub,nGrid,nDim,length(tt),DEC.nPermutes);
D2PLOT.freqPerm     = NaN(nSub,nGrid,nDim,length(freq),DEC.nPermutes);
D2PLOT.timeFreqPerm = NaN(nSub,nGrid,nDim,length(tt),length(freq),DEC.nPermutes);

for iSub = 1:nSub
    for iGrid2decode = 1:nGrid
        for iDim = DEC.vDim
            if ~isempty(DATA(iSub,iGrid2decode,iDim,dIdxT).pMeanTestCorr)
                D2PLOT.time(iSub,iGrid2decode,iDim,:)       = DATA(iSub,iGrid2decode,iDim,dIdxT).pMeanTestCorr.TF;
                if DEC.permute
                    D2PLOT.timePerm(iSub,iGrid2decode,iDim,:,:)     = DATA(iSub,iGrid2decode,iDim,dIdxT).pMeanTestCorrPerm.TF;
                    D2PLOT.timePCorr(iSub,iGrid2decode,iDim).pCorr  = DATA(iSub,iGrid2decode,iDim,dIdxT).pCorr.pCorr;
                end
            end
        end
%         for iDim = 1:2
            if ~isempty(DATA(iSub,iGrid2decode,1,dIdxF).pMeanTestCorr)
                
                D2PLOT.freqPhase(iSub,iGrid2decode,:)         = DATA(iSub,iGrid2decode,1,dIdxF).pMeanTestCorr.TF;
                D2PLOT.timeFreqPhase(iSub,iGrid2decode,:,:)   = DATA(iSub,iGrid2decode,1,dIdxTF).pMeanTestCorr.TF;
            end
            if ~isempty(DATA(iSub,iGrid2decode,2,dIdxF).pMeanTestCorr)
                D2PLOT.freqPower(iSub,iGrid2decode,:)         = squeeze(DATA(iSub,iGrid2decode,2,dIdxF).pMeanTestCorr.TF);
                D2PLOT.timeFreqPower(iSub,iGrid2decode,:,:)   = squeeze(DATA(iSub,iGrid2decode,2,dIdxTF).pMeanTestCorr.TF);
            end
                if DEC.permute
                    D2PLOT.freqPerm(iSub,iGrid2decode,iDim,:,:)         = DATA(iSub,iGrid2decode,iDim,dIdxF).pMeanTestCorrPerm.TF;
                    D2PLOT.timeFreqPerm(iSub,iGrid2decode,iDim,:,:,:)   = DATA(iSub,iGrid2decode,iDim,dIdxTF).pMeanTestCorrPerm.TF;
                    D2PLOT.freqPCorr(iSub,iGrid2decode,iDim).pCorr      = DATA(iSub,iGrid2decode,iDim,dIdxF).pCorr.pCorr;
                    D2PLOT.timeFreqPCorr(iSub,iGrid2decode,iDim).pCorr  = DATA(iSub,iGrid2decode,iDim,dIdxTF).pCorr.pCorr;
                end
            
%         end
    end
end
%% get clim
figureSettings
clim = zeros(nGrid,2,2);
for iGrid2decode = 1:nGrid
    iDim2plot = 0;
    for iDim = 1:2
        iDim2plot = iDim2plot+1;
        if ~isempty(DATA(1,iGrid2decode,1,dIdxTF).pMeanTestCorr)
            if iDim==1
                D2PLOT.timeFreq = D2PLOT.timeFreqPhase;
            else
                D2PLOT.timeFreq = D2PLOT.timeFreqPower;
            end
            imagesc(tt,freq,squeeze(nanmean(D2PLOT.timeFreq(:,iGrid2decode,:,:),1)));
            [clim(iGrid2decode,1,:)] = get(gca,'clim');
        else
            [clim(iGrid2decode,iDim,:)] = NaN;
        end
    end
end

if isempty(PLOT.cScale)
    [clim2use(1),~] = min(min(min(clim)));
    [clim2use(2),~] = max(max(max(clim)));
    clim2use = round(clim2use*100)/100;
elseif find(isnan(PLOT.cScale))
    switch find(isnan(PLOT.cScale))
        case 1
            [clim2use(1),~] = min(min(min(clim)));
            clim2use(2) = PLOT.cScale(2);
        case 2
            [clim2use(2),~] = max(max(max(clim)));
            clim2use(1) = PLOT.cScale(1);
    end
    clim2use = round(clim2use*100)/100;
else
    clim2use = PLOT.cScale;
end

%% PLOT
subplotSettings = [3 3];

% subplots
sPlotT          = [8];
sPlotF          = [1 4];
sPlotTF         = [2 5];
sPlotDetails    = [7];
sPlotCBarIdx    = [6];
sPlotLegIdx     = [9];

for iGrid2decode = 1:nGrid
    figureSettings
    %     if isempty(DATA(iGrid,1,decIdxTimeFreq).pMeanTestCorr)
    %         continue
    %     end
    iDim2plot = 0;
    
    for iDim = 1:2
        
        iDim2plot = iDim2plot+1;
        getDecode_dimTimeFreq_Iowa
        
        if iDim==1
            ff2testIdx = intersect(find(freq>DEC.allFreq2decodePhase{1}(1)),find(freq<DEC.allFreq2decodePhase{1}(2)));
            ff2test(1) = ff2testIdx(1);
            ff2test(2) = ff2testIdx(end);
            tmpFreq = freq(ff2testIdx(1):ff2testIdx(end));
            D2PLOT.freq = D2PLOT.freqPhase(:,:,ff2testIdx(1):ff2testIdx(end));
            D2PLOT.timeFreq = D2PLOT.timeFreqPhase(:,:,:,ff2testIdx(1):ff2testIdx(end));
        else
            ff2testIdx = intersect(find(freq>DEC.allFreq2decodePower{1}(1)),find(freq<DEC.allFreq2decodePower{1}(2)));
            ff2test(1) = ff2testIdx(1);
            ff2test(2) = ff2testIdx(end);
            tmpFreq = freq(ff2testIdx(1):ff2testIdx(end));
            D2PLOT.freq = D2PLOT.freqPower(:,:,ff2testIdx(1):ff2testIdx(end));
            D2PLOT.timeFreq = D2PLOT.timeFreqPower(:,:,:,ff2testIdx(1):ff2testIdx(end));
        end
        
        %% plot frequency
        iPlot = sPlotF(iDim2plot);
        subplot(subplotSettings(1),subplotSettings(2),iPlot)
        if nSub>1
            h(iDim) = plot(squeeze(nanmean(D2PLOT.freq(:,iGrid2decode,:))),tmpFreq,'lineWidth',2);
            %             boundedline?
        else
            h(iDim) = plot(squeeze(D2PLOT.freq(1,iGrid2decode,:)),tmpFreq,'lineWidth',2);
            if DEC.permute
                hPerm(iDim) = boundedline(squeeze(mean(D2PLOT.freqPerm(1,iGrid2decode,iDim,:,:),5)),tmpFreq,...
                    squeeze(std(D2PLOT.freqPerm(1,iGrid2decode,iDim,:,:),[],5)),'cmap',h(iDim).Color,'orientation','horiz');
                
                plotY = repmat(PLOT.signY(1),1,length(tmpFreq));
                plot(plotY(D2PLOT.freqPCorr(1,iGrid2decode,iDim).pCorr),tmpFreq(D2PLOT.freqPCorr(1,iGrid2decode,iDim).pCorr),'.','color',h(iDim).Color)
            end
            
        end
        hold on
        plot(repmat(1/EXP.nCond,1,length(tmpFreq)),tmpFreq,'r--','lineWidth',2)
        axis xy
        axis square
        %     xlim(PLOT.XLIM)
        xlim(PLOT.YLIM)
        if (iDim == DEC.vDim(2))
            xlabel('A''','fontSize',12)
        else
            set(gca,'xTickLabel','')
        end
        ylabel([DEC.saveCategory ' freq (Hz)'],'fontSize',15)
        set(gca,'xdir','reverse')
        %% plot timeFreq
        iPlot = sPlotTF(iDim2plot);
        subplot(subplotSettings(1),subplotSettings(2),iPlot)
        
        imagesc(tt,tmpFreq,squeeze(nanmean(D2PLOT.timeFreq(:,iGrid2decode,:,:),1))',clim2use);
        curAx = get(gca);
        hold on
        if nSub>1
        else
            if DEC.permute
                pPerm = zeros(length(tt),length(freq));
                pPerm(D2PLOT.timeFreqPCorr(1,iGrid2decode,iDim).pCorr) = 1;
                contour(tt,freq,pPerm',1,'linecolor','c','lineWidth',2)
            end
        end
        
        plot([tt(startTrial) tt(startTrial)],[tmpFreq(1) tmpFreq(end)],'w--','lineWidth',2)
        
        axis xy
        axis square
        xlim(PLOT.XLIM)
        set(gca,'yTickLabel','')
        set(gca,'xTickLabel','')
        
        
    end
    %% plot colorbar
    iPlot = sPlotCBarIdx;
    subplot(subplotSettings(1),subplotSettings(2),iPlot)
    hC = subplotColorbar(gca,'Hot',clim2use,'west');
    hC.Label.String = ['A'''];
    hC.FontSize = 12;
    hC.Label.FontSize = 12;
    
    %% plot time
    iPlot = sPlotT;
    subplot(subplotSettings(1),subplotSettings(2),iPlot)
    
    for iDim = DEC.vDim
        if nSub>1
            h(iDim) = plot(tt,squeeze(nanmean(D2PLOT.time(:,iGrid2decode,iDim,:),1)),'lineWidth',2,'color',colors{iDim});
        else
            h(iDim) = plot(tt,squeeze(D2PLOT.time(1,iGrid2decode,iDim,:)),'lineWidth',2,'color',colors{iDim});
        end
        hold on
        
        if DEC.permute
            if nSub>1
            else
                hPerm(iDim) = boundedline(tt,squeeze(mean(D2PLOT.timePerm(1,iGrid2decode,iDim,:,:),5)),...
                    squeeze(std(D2PLOT.timePerm(1,iGrid2decode,iDim,:,:),[],5)),'cmap',h(iDim).Color);
                
                plotY = repmat(PLOT.signY(iDim),1,length(tt));
                plot(tt(D2PLOT.timePCorr(1,iGrid2decode,iDim).pCorr),plotY(D2PLOT.timePCorr(1,iGrid2decode,iDim).pCorr),'.','color',h(iDim).Color)
            end
            
            
        end
        
        LEGEND{iDim} = DEC.allSaveCategory{iDim};
    end
    hold on
    plot(tt,repmat(1/EXP.nCond,1,length(tt)),'r--','lineWidth',2)
    plot([tt(startTrial) tt(startTrial)],[PLOT.YLIM(1) PLOT.YLIM(2)],'k--','lineWidth',2)
    axis xy
    axis square
    xlim(PLOT.XLIM)
    ylim(PLOT.YLIM)
    
    xlabel('time (s)','fontSize',15)
    ylabel('A''','fontSize',12)
    
    %% plot legend
    iPlot = sPlotLegIdx;
    subplot(subplotSettings(1),subplotSettings(2),iPlot)
    legH = subplotLegend(gca,h,LEGEND,'vertical');
    
    legH.FontSize = 12;
    legH.Box = 'off';
    
    
    %% get details
    
    iPlot = sPlotDetails;
    subplot(subplotSettings(1),subplotSettings(2),iPlot)
    
    if nSub>1
        nSubPerGrid = squeeze(D2PLOT.time(:,iGrid2decode,3,1));
        nSubPerGrid = length(find(~isnan(nSubPerGrid)));
        text(-0.3,0.8,['nSub:' num2str(nSubPerGrid)],'fontSize',fontSize)
        text(-0.3,0.7,EXP.dataset,'fontSize',fontSize)
        text(-0.3,0.6,EXP.cond,'fontSize',fontSize,'interpret','none')
        switch DEC.dimension
            case 'eachElectrodeCombinePlot'
                text(-0.3,0.4,[SUB.chanLocation],'fontSize',fontSize,'interpret','none')
            case 'multiElectrodeCombinePlot'
                text(-0.3,0.4,[DEC.grid2decode{iGrid2decode}],'fontSize',fontSize)
        end
    else
        text(-0.3,0.8,SUB.id,'fontSize',fontSize)
        text(-0.3,0.7,EXP.dataset,'fontSize',fontSize)
        text(-0.3,0.6,EXP.cond,'fontSize',fontSize,'interpret','none')
        text(-0.3,0.5,['nTrials:' num2str(EXP.nTrialsPerClass)],'fontSize',fontSize)
        
        switch DEC.dimension
            case 'eachElectrodeCombinePlot'
                text(-0.3,0.4,[SUB.chanLocation],'fontSize',fontSize,'interpret','none')
            case 'multiElectrodeCombinePlot'
                
                text(-0.3,0.4,[DEC.grid2decode{iGrid2decode}],'fontSize',fontSize)
                
                switch DEC.grid2decode{iGrid2decode}
                    case 'ventral'
                        EXP.nChan = length(EXP.chanIdx.ventralBipolar);
                    case 'temporal'
                        EXP.nChan = length(EXP.chanIdx.tempBipolar);
                    case 'parietal'
                        EXP.nChan = length(EXP.chanIdx.parietalBipolar);
                    case 'frontal'
                        EXP.nChan = length(EXP.chanIdx.frontalBipolar);
                end
                text(-0.3,0.3,['nChan:' num2str(EXP.nChan)],'fontSize',fontSize)
        end
    end
    axis off
    savefilename = [tmpSavefilename '_' DEC.grid2decode{iGrid2decode}];
    figureSave
end



