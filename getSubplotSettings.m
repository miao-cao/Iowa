function FIG = getSubplotSettings(nSubplot,iSubplot,withLegend,Legendplot)

if nSubplot==1
    nCol = 1;
    nRow = 1;
elseif nSubplot==2
    nCol = 2;
    nRow = 1;
elseif nSubplot==3
    nCol = 2;
    nRow = 2;
elseif nSubplot>3
    if withLegend
        nCol = round(nSubplot/2)+1;
    else
        nCol = round(nSubplot/2);
    end
    nRow = round(nSubplot/2);
end
    
if ~Legendplot
    if withLegend
        if nSubplot==1 || nSubplot==2
            subplot(nRow,nCol+1,iSubplot)
        elseif nSubplot==3
            subplot(nRow,nCol,iSubplot)
        elseif nSubplot>3
            if iSubplot>=nCol
                iSubplot = iSubplot+1;
            end
            subplot(nRow,nCol,iSubplot)
        end
    else
        if nSubplot==1 || nSubplot==2
            subplot(nRow,nCol,iSubplot)
        elseif nSubplot==3
            subplot(nRow,nCol,iSubplot)
        elseif nSubplot>3
            subplot(nRow,nCol,iSubplot)
        end
    end
    
    if nRow==1
        FIG.xLabel = ones(1,nSubplot);
        FIG.yLabel = zeros(1,nSubplot);
        FIG.yLabel(1) = 1;
    elseif nRow>1
        FIG.xLabel = ones(1,nSubplot);
        FIG.yLabel = zeros(1,nSubplot);
        
        if nSubplot>3
            FIG.yLabel(1:nCol-1:end) = 1;
            FIG.xLabel(1:nCol-1) = 0;        
        else
            FIG.xLabel(1:nCol) = 0;
            if mod(iSubplot,nCol)
                FIG.yLabel(iSubplot)=1;
            end
        end
    end
else
    FIG.xLabel=[];
    FIG.yLabel=[];
    if nSubplot==1 || nSubplot==2
        subplot(nRow,nCol+1,iSubplot+1)
    elseif nSubplot==3
        subplot(nRow,nCol,iSubplot+1)
    elseif nSubplot>3
        subplot(nRow,nCol,iSubplot+2)
    end
end