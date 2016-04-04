function plotDecode_TW_Iowa_multiTimeMultiFreq(SUB,EXP,SPG,DEC,DIR,PLOT,DATA,savefilename)

subplot = @(m,n,p) subtightplot (m,n,p,0.02,0.02,0.02);

% tt = TEST(1).times2downsample;

[nSub, nGrid, nDim, nDimDecode, ntt, nff] = size(DATA);

if nSub>1
    if DEC.permute
        DIR.fig = DIR.fig(1:end-5);
    end
end

PLOT.signY = [0.2 ];
PLOT.varX = {[0]; [-0.2 0.2]; [-.2 0 0.2]};

%% get decodeDim idx

[~,decIdx] = (grep(DEC.allDimension,'multiElectrodeMultiTimeMultiFreq'));
[~,decIdx] = find(decIdx);

%% extract data 2 plot

DATA2PLOT = NaN(nSub,nGrid,nDim);

for iSub = 1:nSub
    for iGrid2decode = 1:nGrid
        for iDim = DEC.vDim
            for itt = 1:ntt
                for iff = 1:nff
                    if ~isempty(DATA(iSub,iGrid2decode,iDim,decIdx).pMeanTestCorr)
                        DATA2PLOT(iSub,iGrid2decode,iDim,itt,iff)       = DATA(iSub,iGrid2decode,iDim,decIdx,itt,iff).pMeanTestCorr.TF;
                        
                        if DEC.permute
                            PERM2PLOT(iSub,iGrid2decode,iDim,itt,iff,:)         = DATA(iSub,iGrid2decode,iDim,decIdx,itt,iff).pMeanTestCorrPerm.TF;
                            PCORR2PLOT(iSub,iGrid2decode,iDim,itt,iff).pCorr    = DATA(iSub,iGrid2decode,iDim,decIdx,itt,iff).pCorr.pCorr;
                        end
                    end
                end
            end
        end
    end
end

%%
figureSettings
for itt = 1:ntt
    for iGrid2decode = 1:nGrid
        
        %     if isempty(DATA(iGrid,1).pMeanTestCorr)
        %         continue
        %     end
        if nSub==1
            FIG = getSubplotSettings(nGrid,iGrid2decode,0,0);
        else
            FIG = getSubplotSettings(nGrid,iGrid2decode,1,0);
        end
        iPlot = 0;
        Accuracy = NaN(nSub, length(DEC.vDim)*nff - nff);
        for iDim = DEC.vDim
            for iff = 1:nff
                getDecode_dimTimeFreq_Iowa       
                if strcmpi(DEC.saveCategory,'erp') && iff>1
                    continue
                end
                iPlot = iPlot+1;
                
                Accuracy(:,iPlot) = DATA2PLOT(:,iGrid2decode,iDim,itt,iff);
                
                if strcmpi(DEC.saveCategory,'erp') 
                    LEGEND{iPlot} = [DEC.saveCategory];
                else
                    LEGEND{iPlot} = [DEC.saveCategory ' ' num2str(DEC.allFreq2decode{iff})];
                end
            end
        end
        [tmp,~]=find(isnan(Accuracy));
        Accuracy(unique(tmp),:) = NaN;
        
        %         Accuracy = squeeze(Accuracy);
        if nSub==1
            h = plot(1:iPlot,Accuracy,'.','markerSize',PLOT.markerSize);
        else
            for iSub = 1:nSub
                h(iSub) = plot(1:iPlot,Accuracy(iSub,:),'.','markerSize',PLOT.markerSize,'color',PLOT.subjectColor(EXP.subIdx(iSub),:));
                hold on
            end
        end
        xlim([0 iPlot+1])
        ylim(PLOT.YLIM)
        
        if DEC.permute
            if nSub==1
                hold on
                
                meanAccuracyPerm = zeros(1,iPlot);
                stdAccuracyPerm = zeros(1,iPlot);
                
                iPlot = 0;
                for iDim = DEC.vDim
                    for iff = 1:nff
                        getDecode_dimTimeFreq_Iowa
                        if strcmpi(DEC.saveCategory,'erp') && iff>1
                            continue
                        end
                        iPlot = iPlot+1;
                        
                        
                        meanAccuracyPerm(iPlot) = squeeze(mean(PERM2PLOT(1,iGrid2decode,iDim,itt,iff,:),6));
                        stdAccuracyPerm(iPlot)  = squeeze(std(PERM2PLOT(1,iGrid2decode,iDim,itt,iff,:),[],6));
                        plot(iPlot, meanAccuracyPerm(iPlot) ,'.r','markerSize', PLOT.markerSize)
                        plot([iPlot iPlot], [(meanAccuracyPerm(iPlot)-stdAccuracyPerm(iPlot)) (meanAccuracyPerm(iPlot)+stdAccuracyPerm(iPlot))],'r','lineWidth',2)
                        
                        if ~isempty(PCORR2PLOT(iSub,iGrid2decode,iDim,itt,iff).pCorr)
                            plot(iPlot,PLOT.signY(PCORR2PLOT(iSub,iGrid2decode,iDim,itt,iff).pCorr),'.','color',h.Color)
                        end
                    end
                end
                
                
            end
        end
        
        %% stats
        if nSub>1
            meanPerSub = mean(Accuracy,2);
            nSub2test = sum(~isnan(Accuracy(:,1)));
            accuracy2test = reshape(Accuracy(~isnan(Accuracy)),nSub2test,iPlot);
            [p_old,table]=anova_rm(accuracy2test,'off');
            
            Accuracy_corrected = Accuracy - repmat(meanPerSub,1,iPlot);
            
            hold on
            errorbar(1:iPlot,nanmean(Accuracy,1),nanstd(Accuracy_corrected),'dk','MarkerSize',10,'lineWidth',2)
        end
        %%
        
        hold on
        plot([0 iPlot+1],repmat(1/EXP.nCond,1,length([0 iPlot+1])),'r--','lineWidth',2)
        axis xy
        axis square
        
        if FIG.yLabel(iGrid2decode)
            ylabel('A''','fontSize',12)
        else
            set(gca,'yticklabel','')
        end
        
        set(gca,'fontSize',10)
        set(gca,'xtick',0:iPlot+1)
        XTICKLABEL = get(gca,'xticklabel');
        XTICKLABEL(2:iPlot+1) = LEGEND';
        XTICKLABEL(1) = {''};
        XTICKLABEL(end) = {''};
        
        if nSub>1
            title({DEC.grid2decode{iGrid2decode};['pDim:' num2str(p_old(1),'%0.0e') ', pSub:' num2str(p_old(2),'%0.0e')]})
        else
            title(DEC.grid2decode{iGrid2decode})
        end
        
        set(gca,'xticklabel',XTICKLABEL)
        set(gca,'xticklabelrotation',-45)
    end
    
    if nSub>1
        FIG = getSubplotSettings(nGrid,iGrid2decode,1,1);
        if isfield(DEC,'sub2del') && ~isempty(DEC.sub2del)
            legH = subplotLegend(gca,h,EXP.subReadyForAnalysis(~DEC.sub2del),'vertical');
            delSub = [];
            for iTmp = find(DEC.sub2del)
                delSub = [delSub num2str(EXP.subReadyForAnalysis{iTmp}) ' '];
            end
            if DEC.excludeSub
                text(0,0,['deleted ' delSub],'interpret','none')
            else
                text(0,0,'excluding subjects failed')
            end
        else
            legH = subplotLegend(gca,h,EXP.subReadyForAnalysis,'vertical');
        end
        legH.Box = 'off';
        
    end
    
    if nSub==1
        mtit([SUB.id ' ' EXP.cond],'interpret','none')
    else 
        mtit([EXP.cond],'interpret','none')
    end
    figureSave
    
end



