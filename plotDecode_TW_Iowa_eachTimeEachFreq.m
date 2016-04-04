function plotDecode_TW_Iowa_eachTimeEachFreq(SUB,EXP,SPG,DEC,DIR,PLOT,TEST,savefilename)

subplot = @(m,n,p) subtightplot (m,n,p,0.1,0.1,0.1);

[nSub,nGrid, nDim, ~] = size(TEST);
if nSub>1
    return
end

for i=1:nGrid
    tt = TEST(1,i,1,DEC.iDim2use).tt;
    freq = TEST(1,i,1,DEC.iDim2use).freq;
    if ~isempty(tt)
        break
    end
end

[~,startTrial]=min(abs(0-tt));
colormap Hot

figureSettings
%% get colorbar
clim = zeros(nGrid,length(DEC.vDim),2);
for iGrid2decode = 1:nGrid
    iDim2plot = 0;
    for iDim = DEC.vDim
        iDim2plot = iDim2plot+1;
        if ~isempty(TEST(1,iGrid2decode,1,DEC.iDim2use).pMeanTestCorr)
            imagesc(tt,freq,TEST(1,iGrid2decode,iDim,DEC.iDim2use).pMeanTestCorr.TF');
            [clim(iGrid2decode,iDim,:)] = get(gca,'clim');
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

figureSettings
iDim2plot = 0;
iPlot = 0;
for iGrid2decode = 1:nGrid
    if isempty(TEST(1,iGrid2decode,1,DEC.iDim2use).pMeanTestCorr)
        continue
    end
    
    for iDim = DEC.vDim
        iDim2plot = iDim2plot+1;
        getDecode_dimTimeFreq_Iowa
        
        iPlot = iPlot+1;
        subplot(nGrid,length(DEC.vDim)+1,iPlot)
        
        h(iDim2plot) = imagesc(tt,freq,TEST(1,iGrid2decode,iDim,DEC.iDim2use).pMeanTestCorr.TF',clim2use);
        hold on
        
        if DEC.permute
            tmpPerm = squeeze(mean(TEST(1,iGrid2decode,iDim,DEC.iDim2use).pMeanTestCorrPerm.TF,3))';
            pPerm = zeros(length(tt),length(freq));
            pPerm(TEST(1,iGrid2decode,iDim,DEC.iDim2use).pCorr.pCorr) = 1;
            contour(tt,freq,pPerm',1,'linecolor','c','lineWidth',2)
        end
        
        plot([tt(startTrial) tt(startTrial)],[freq(1) freq(end)],'w--','lineWidth',2)
        
        set(gca,'fontSize',15)
        axis xy
        axis square
        xlim(PLOT.XLIM)
        
        if iDim == DEC.vDim(1)
            ylabel('freq (Hz)','fontSize',20)
        else
            set(gca,'yTickLabel','')
        end
        
        if iGrid2decode==1
            title([DEC.saveCategory],'fontSize',20)
        elseif iGrid2decode==nGrid
            xlabel('time (s)','fontSize',20)
        end
        
        if iGrid2decode~=nGrid
            set(gca,'xTickLabel','')
        end
        if iDim==DEC.vDim(end)
            iPlot=iPlot+1;
        end
    end
    subplot(nGrid,length(DEC.vDim)+1,iPlot)
    text(0,1,[DEC.grid2decode{iGrid2decode}],'fontSize',15)
    axis off
    
end
subplot(nGrid,length(DEC.vDim)+1,iPlot)
hC = subplotColorbar(gca,'Hot',clim2use,'east');
hC.Label.String = ['A'''];
hC.FontSize = 15;
hC.Label.FontSize = 20;
if nSub==1
    mtit([SUB.id ' ' EXP.cond],'interpret','none')
else
    mtit([EXP.cond],'interpret','none')
end

figureSave



