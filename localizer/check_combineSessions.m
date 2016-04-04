function check_combineSessions(subID,iChan,EXP,PLOT)

qid = 0.05;

PLOT.subtractBaseline = 1;
baseline_t = [-.3 -0.1];
times2use = [-0.2 0.8];
if ~exist('subID')
    subID = '178';
end
subSpecs_IowaLocalizer

%%
iSession = 1;
clear tt nTrialPerClass vClass

val = ['li',num2str(iChan)];

DIR.fig = [DIR.figBase '/combine/'];

if isempty(dir(DIR.fig))
    mkdir(DIR.fig)
end

savefilename    = [subID '_' num2str(length(SUB.vSession)) '_' SUB.stimCat{SUB.vSession(1)} '_sessions_' val '_t(' SUB.ext ')'];
load([DIR.combine '/' savefilename '.mat'],'allERP')

if ~exist('tt')
    tt = 1:size(allERP{1},2);
    tt = tt / SUB.fs;
    tt = tt - abs(SUB.tRange(1)); % stim onset = 0.5;
    vBaseline_t = find(baseline_t(1) <= tt & tt <= baseline_t(2));
end


if PLOT.subtractBaseline
    disp('subtracting baseline')
    for trialType = 1:length(allERP)
        baseline_data = mean(allERP{trialType}(:,vBaseline_t),2);
        allERP{trialType} = allERP{trialType} - repmat(baseline_data,[1 size(allERP{trialType},2)]);
    end
else
    disp('not subtracting baseline')
end

if exist('times2use','var')
    [~,times2useIdx(1)] = min(abs(times2use(1) - tt));
    [~,times2useIdx(2)] = min(abs(times2use(2) - tt));
    for trialType = 1:length(allERP)
        allERP{trialType} = allERP{trialType}(:,times2useIdx(1):times2useIdx(2));
    end
    tt = tt(times2useIdx(1):times2useIdx(2));
end
%% anova
tmp2=[];
clear anovap
if ~exist('nTrialPerClass')
    for trialType = 1:length(allERP)
        nTrialPerClass(trialType) = size(allERP{trialType},1);
        vTrials = sum(nTrialPerClass(1:trialType-1))+1:sum(nTrialPerClass(1:trialType));
        vClass(vTrials) = trialType;
    end
end
if PLOT.onlySignificant
    for iTime = 1:length(tt)
        tmpData = zeros(sum(nTrialPerClass),1);
        for trialType = 1:length(allERP)
            vTrials = sum(nTrialPerClass(1:trialType-1))+1:sum(nTrialPerClass(1:trialType));
            tmpData(vTrials) = allERP{trialType}(:,iTime);
        end
        [anovap(iTime)] = anova1(tmpData,vClass,'off');
    end
    
    tmp2 = FDR(anovap,qid);
end
%%
if isempty(tmp2)
    disp(['anova1 not significant : ' val ': ' datestr(now) ' ' savefilename])
    if PLOT.onlySignificant
        return
    end
else
    disp(['SIGNIFICANT : ' val ': ' datestr(now) ' ' filename])
end
pid = tmp2;
% end
%%
for trialType = 1:length(allERP)
    allERP{trialType} = double(allERP{trialType}');
end
for trialType = 1:length(allERP)
    mTmp(:,trialType) = squeeze(mean(allERP{trialType},2));
end
%%
figure(1000),clf
set(gcf,'visible',PLOT.visible)
% for trialType = 1:5
% subplot(3,2,trialType)
%    subplot(2,1,1)
plot(tt,mTmp,'lineWidth',2)
axis tight
switch SUB.stimCat{iSession}
    case 'ekman'
        legendtxt = {'upright F','invert F','houses','tools','Mondrian'};
    case 'animal'
        legendtxt = {'Animals','Persons','Landmards','Vehcles','Flowers'};
end
h = legend(legendtxt);
set(h,'box','off')

%    subplot(2,1,2)
YLIM = ylim;
if PLOT.onlySignificant
    
    tmp = find(anovap<=pid);
    hold on
    
    plot(tt(tmp),YLIM(2),'bo')
end
ylim([YLIM(1) YLIM(2)*1.05])
%    set(gca,'yscale','log')
hold on
axis square
if PLOT.onlySignificant
    
    plot(xlim,[1 1]*pid)
end
title({[subID ' : ' SUB.stimCat{iSession} ' : ' num2str(length(SUB.session)) ' sessions : p <' num2str(pid,2) ' : q=' num2str(qid) ];
    ['# of trials = ' num2str(nTrialPerClass) ' : baseline subtract = ' num2str(PLOT.subtractBaseline) ' : baseline = ' num2str(baseline_t)]})

%%
figureSave
end

%%
