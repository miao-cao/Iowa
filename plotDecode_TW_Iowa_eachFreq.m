function plotDecode_TW_Iowa_eachFreq(SUB,EXP,SPG,DEC,DIR,PLOT,TEST,savefilename)

subplot = @(m,n,p) subtightplot (m,n,p,0.1,0.1,0.1);

% gridBorder  = [1 1 1 1];
% axBorder    = [.5 .5 .5 .5];
[nSub,nGrid, nDim, ~] = size(TEST);

if nSub>1
    return
end

for i=1:nGrid
    freq = TEST(1,i,1,DEC.iDim2use).freq;
    if ~isempty(freq)
        break
    end
end

PLOT.signY = [0.2 0.25 0.3];
PLOT.color = {'g','b'};
figureSettings

for iGrid2decode = 1:nGrid
    
    if isempty(TEST(1,iGrid2decode,1,DEC.iDim2use).pMeanTestCorr)
        continue
    end
    FIG = getSubplotSettings(nGrid,iGrid2decode,1,0);
    
    
    for iDim = DEC.vDim
        getDecode_dimTimeFreq_Iowa
        LEGEND{iDim} = DEC.saveCategory;
        
        
        h(iDim) = plot(freq,TEST(1,iGrid2decode,iDim,DEC.iDim2use).pMeanTestCorr.TF,PLOT.color{iDim});
        hold on
        
        
        
        if DEC.permute
            hPerm(iDim) = boundedline(freq,squeeze(mean(TEST(1,iGrid2decode,iDim,DEC.iDim2use).pMeanTestCorrPerm.TF,2)),...
                std(TEST(1,iGrid2decode,iDim,DEC.iDim2use).pMeanTestCorrPerm.TF,[],2),'cmap',h(iDim).Color);
            
            plotY = repmat(PLOT.signY(iDim),1,length(freq));
            plot(freq(TEST(1,iGrid2decode,iDim,DEC.iDim2use).pCorr.pCorr),plotY(TEST(1,iGrid2decode,iDim,DEC.iDim2use).pCorr.pCorr),'.','color',h(iDim).Color)
        end
        
        
    

    end
    
    hold on
    plot(freq,repmat(1/EXP.nCond,1,length(freq)),'r--','lineWidth',2)
    %     plot([freq(startTrial) freq(startTrial)],[PLOT.YLIM(1) PLOT.YLIM(2)],'k--','lineWidth',2)
    axis xy
    axis square
    %     xlim(PLOT.XLIM)
    ylim(PLOT.YLIM)
    
    if FIG.xLabel(iGrid2decode)
        xlabel('freq (Hz)','fontSize',20)
    else
        set(gca,'xticklabel','')
    end
    
    if FIG.yLabel(iGrid2decode)
        ylabel('A''','fontSize',20)
    else
        set(gca,'yticklabel','')
    end
    set(gca,'fontSize',15)
    if nGrid>1
        title(DEC.grid2decode{iGrid2decode})
    end
end

getSubplotSettings(nGrid,iGrid2decode,1,1);
legH = subplotLegend(gca,h,LEGEND,'vertical');

legH.FontSize = 15;
if nSub==1
    mtit([SUB.id ' ' EXP.cond],'interpret','none')
else
    mtit([EXP.cond],'interpret','none')
end

figureSave



