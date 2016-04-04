function checkBehavior_IowaCFS(EXP,PLOT)
% Plot behavioral results for the CFS paradigm, both for single and
% multiple subjects. Single: plots the number of trials per visibility
% level for each contrast. Multiple: plots percentage correct per
% visibility level. Stats across multiple subjects.
%
% INPUT
% subID: Cell with one or multiple subject IDs
% PLOT: structure with plotting settings.

tmpSUB = EXP.subReadyForAnalysis;
if nargin<1
    tmpSUB = {'153'};
end

if nargin<2
    PLOT.visible = 'on';
    PLOT.printPNG = 1;
    PLOT.printEPS = 1;
    PLOT.fontsizeSmall  = 10;
    PLOT.fontsizeMedium = 12;
    PLOT.fontsizeLarge  = 15;
    PLOT.sign = {'*','**','***'};
end

nSub = numel(tmpSUB);

visCorrectPercent   = zeros(nSub,4);
nContrast           = zeros(1,nSub);
correctAcrossSes    = zeros(nSub,4);
figureSettings


for iSub = 1:nSub
    clear correctLabel stimCont
    nTrials = struct([]);
    %% load data and determine the number of contrasts used across sessions
    subID = tmpSUB{iSub};
    subSpecs_IowaCFS
    for iSession =1:SUB.nSession
        Beh{iSub,iSession} = load([DIR.beh SUB.logFile{iSession}]);
        try % subjects 147-168
            stimCont{iSession} = Beh{iSub,iSession}.FaceContrast;
        catch % subject 178
            stimCont{iSession} = Beh{iSub,iSession}.S.vStimCont;
        end
    end
    
    contrasts = stimCont{1};
    if SUB.nSession>1
        for iSession=1:SUB.nSession-1
            contrasts = [contrasts stimCont{iSession+1}];
            contrasts = unique(contrasts);
        end
    else
        contrasts = unique(contrasts);
    end
    nContrast(iSub)=length(contrasts);
    
    %% Determine the number of trials per contrast and visibility level. Calculate the percentage correct per visibility level
    tmp_visCorrect      = zeros(length(Beh(iSub,:)),4);
    tmp_nTrialPerVis    = zeros(length(Beh(iSub,:)),4);
    for iSession=1:SUB.nSession
        for iContrast = 1:3; %only 3 contrasts per session
           
            for iVis = 1:4
                nTrials(iSession).cont(iContrast).vis(iVis)  = length(find(ismember(find(Beh{iSub,iSession}.vStimCont==iContrast),find(Beh{iSub,iSession}.visibility_resp==iVis))));
                tmp_visCorrect(iSession,iVis)                = length(find(ismember(find(Beh{iSub,iSession}.visibility_resp==iVis),find(Beh{iSub,iSession}.correct_stim_responses==1))));
                tmp_nTrialPerVis(iSession,iVis)              = length(find(Beh{iSub,iSession}.visibility_resp==iVis));
            end
            nTrials(iSession).cont(iContrast).corr       = length(find(ismember(find(Beh{iSub,iSession}.vStimCont==iContrast),find(Beh{iSub,iSession}.correct_stim_responses==1))));
        end
    end
    tmp_nTrialPerVis = sum(tmp_nTrialPerVis,1);
    tmp_visCorrect = sum(tmp_visCorrect,1);
    
    visCorrectPercent(iSub,:) = (tmp_visCorrect./tmp_nTrialPerVis)*100;
    
    %%
    clear correct cont
    cont = zeros(SUB.nSession,nContrast(iSub),4);
    
    [minCont,tmp] = min([stimCont{:}]);%find smallest contrast
    minContSes = ceil(tmp/3); %only 3 contrasts per session

    for iSession=1:SUB.nSession
        if nContrast(iSub)>3
            if ismember(iSession,minContSes)
                contrast2save = 1:3;
            else
                contrast2save = 2:4;
            end
        else
            contrast2save = 1:3;
        end
        for iContrast=1:3
            correct(iSession,contrast2save(iContrast))=0;

            correct(iSession,contrast2save(iContrast)) = correct(iSession,contrast2save(iContrast))+nTrials(iSession).cont(iContrast).corr;
            for iVis = 1:4
                cont(iSession,contrast2save(iContrast),iVis) = cont(iSession,contrast2save(iContrast),iVis) + nTrials(iSession).cont(iContrast).vis(iVis);
            end
        end
    end
    cont = squeeze(sum(cont,1));
    nTrialsPerCont = sum(cont,2);
    if nContrast(iSub)==3
        correctAcrossSes(iSub,:) = [(sum(correct,1)./nTrialsPerCont') * 100 NaN];
    else
        correctAcrossSes(iSub,:) = (sum(correct,1)./nTrialsPerCont') * 100;
    end
    for iContrast = 1:nContrast(iSub)
        correctLabel{iContrast} = [num2str(round(correctAcrossSes(iSub,iContrast)))];
        if iContrast == nContrast(iSub)
            correctLabel{iContrast} = [correctLabel{iContrast} '%'];
        end
    end
    
    if nSub > 1
        subplot(ceil(nSub/2), ceil(nSub/2), iSub)
    else
        subplot(1,2,1)
    end
    
    hB = bar(1:nContrast(iSub),[cont(:,1), cont(:,2), cont(:,3), cont(:,4)],'stack','lineWidth',2);
    set(gca,'fontsize',PLOT.fontsizeMedium)
    xtick = get(gca,'xtick');
    text(xtick-0.2,repmat(max(nTrialsPerCont)+SUB.nSession/2,1,nContrast(iSub))+1,correctLabel,'fontSize',PLOT.fontsizeSmall)
    title(subID)
    ylim([0 (max(nTrialsPerCont)+SUB.nSession*2)])
    ylabel('# trials','fontsize',PLOT.fontsizeLarge)
    xlabel('contrast level','fontsize',PLOT.fontsizeLarge)
    axis square
    colormap gray

end
LEGEND = {['Visibility 1'],['Visibility 2'],['Visibility 3'],['Visibility 4']};
% legend(hB,LEGEND)


if nSub > 1
    subplot(ceil(nSub/2), ceil(nSub/2), iSub+1)
else
    subplot(1,2,2)
end
legH = subplotLegend(gca,hB,LEGEND,'vertical');

% subplotLegend(hB,[],['visibility 1, ' num2str(visCorrectPercent(1)) ],['visibility 2, ' num2str(visCorrectPercent(2)) ],...
%     ['visibility 3, ' num2str(visCorrectPercent(3)) ],['visibility 4, ' num2str(visCorrectPercent(4)) ],'Location','EastOutside')

if nSub==1
    DIR.fig = [DIR.figBase filesep 'beh' filesep];
    if ~exist(DIR.fig,'dir')
        mkdir(DIR.fig)
    end
    savefilename = [subID '_' 'nSes(' num2str(SUB.nSession) ')_stack'];
else
    DIR.fig = [DIR.data filesep 'multiSub' filesep 'figures' filesep 'beh' filesep];
    if ~exist(DIR.fig,'dir')
        mkdir(DIR.fig)
    end
    
    savefilename=[];
    for iSub = 1:nSub
        savefilename = [savefilename tmpSUB{iSub} '_'];
    end
    savefilename = [savefilename 'stack'];
end
figureSave

%% correct per visibility level

if nSub==1
    return
end

if find(isnan(visCorrectPercent))
    warning('NaN values in correctpercent')
end
[pAnova, table] = anova_rm(visCorrectPercent,'off');

for iVis = 1:4
    [hTtest(iVis),pTtest(iVis),~,statsTtest(iVis)] = ttest(visCorrectPercent(:,iVis),50);
end

YLIM = [0.4 1]*110;
XLIM = [0.4 4.6];

figureSettings


subplot(3,1,[1 2])
if 0
    hB = barwitherr(std(visCorrectPercent,1), mean(visCorrectPercent,1));
else
    for iSub = 1:length(EXP.subReadyForAnalysis)
        plotColor(iSub,:) = PLOT.subjectColor(EXP.subIdx(iSub),:);
        
        plot(1:size(visCorrectPercent,2),  visCorrectPercent(iSub,:),'color',plotColor(iSub,:));
        hold on
        h(iSub) = plot(1:size(visCorrectPercent,2),  visCorrectPercent(iSub,:),['o']);
        set(h(iSub),'color',plotColor(iSub,:))
    end
    
    hM = plot(mean(visCorrectPercent,1),'dk','markersize',10);
    set(hM,'markerfacecolor','k')
    plot([1:size(visCorrectPercent,2);1:size(visCorrectPercent,2)],[(mean(visCorrectPercent,1) -std(visCorrectPercent,1)); (mean(visCorrectPercent,1) + std(visCorrectPercent,1))],'k','linewidth',2)
    
    tmpX = [[1:size(visCorrectPercent,2)] - 0.05 ;[1:size(visCorrectPercent,2)] + 0.05 ]';
    tmpY1 = [(mean(visCorrectPercent,1) -std(visCorrectPercent,1))]' * [1 1];
    tmpY2 = [(mean(visCorrectPercent,1) +std(visCorrectPercent,1))]' * [1 1];
    for iX = 1:length(tmpX)
        for iY = 1:2
            eval(['tmpY =  tmpY' num2str(iY) ';'])
            plot(tmpX(iX,:),tmpY(iX,:),'k','linewidth',2)
        end
    end
end
[hL, oH, pL, textL] = legend(h,EXP.subReadyForAnalysis,'location','southeast');
for iPl = 1:length(pL)
    oH(iPl).Color = plotColor(iPl,:);
    oH(length(pL)+iPl*2).Visible='off';
%     pL(iPl).HandleVisibility = 'off';
    
end
% set(hL, 'TextColor',h.Color)

set(gca,'fontsize',PLOT.fontsizeMedium)
ylim(YLIM)
xlim(XLIM)
ylabel('Percentage correct','fontSize',PLOT.fontsizeLarge)
xlabel('Visibility level','fontSize',PLOT.fontsizeLarge)

hold on
plot([0 5],[50 50],'k--')
for iVis = 1:4
    if hTtest(iVis)
        if pTtest(iVis) < 0.001
            sign2use = 3;
            text(iVis-(0.1),105,[PLOT.sign{sign2use}],'color','k','fontsize',20)
        elseif pTtest(iVis) < 0.01
            sign2use = 2;
            text(iVis-(0.075),105,[PLOT.sign{sign2use}],'color','k','fontsize',20)
        elseif pTtest(iVis) < 0.05
            sign2use = 1;
            text(iVis-(0.035),105,[PLOT.sign{sign2use}],'color','k','fontsize',20)
        end
    end
end


subplot(3,1,3)
axis off
text(0,1,['main effect of subject, p=' num2str(pAnova(2))])
text(0,0.9,['main effect of subject, F=' num2str(table{3,5})])
text(0,0.8,['main effect of visibility, p=' num2str(pAnova(1))])
text(0,0.7,['main effect of visibility, F=' num2str(table{2,5})])


text(0,0.5,['tTest visibility1, t=' num2str(statsTtest(1).tstat) ', p=' num2str(pTtest(1))])
text(0,0.4,['tTest visibility2, t=' num2str(statsTtest(2).tstat) ', p=' num2str(pTtest(2))])
text(0,0.3,['tTest visibility3, t=' num2str(statsTtest(3).tstat) ', p=' num2str(pTtest(3))])
text(0,0.2,['tTest visibility4, t=' num2str(statsTtest(4).tstat) ', p=' num2str(pTtest(4))])

savefilename=[];
for iSub = 1:nSub
    savefilename = [savefilename tmpSUB{iSub} '_'];
end
savefilename = [savefilename 'percentage'];

figureSave
% text(0,0.5,['ttest per visibility level, p=' (

