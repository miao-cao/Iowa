function checkSegment_IowaLocalizer(subID,iSession,iChan,EXP,PLOT)

%% before patient 173, use photodiode to get the trial segment
% from 173, use pport to get the trial segment
if ~exist('subID')
    subID = '153';
end

if ~exist('iSession')
    iSession = 1;
end

times2use = [-0.2 0.8];

qid = 0.05;
subSpecs_IowaLocalizer
filename = [subID '-' getfilenum(SUB.session(iSession),3)];

segDataDir      = [DIR.rawData '/' getfilenum(SUB.session(iSession),3) '/segmented/'];
DIR.fig = [DIR.figBase '/checkSegment/' getfilenum(SUB.session(iSession),3) filesep ];
if isempty(dir(DIR.fig))
    mkdir(DIR.fig)
end

%% load Pport and PhotoDiode
switch SUB.alignOnset{iSession}
    case 'PPort'
        load([DIR.seg '/' filename '_PPort.mat']);
    case 'PhDio'
        load([DIR.seg '/' filename '_PhDio.mat']);
        load([DIR.seg '/' filename '_behav.mat']);
end

%%
clear tt nTrialPerClass vClass
%% segment data
% for iChan = Channels2check
val = ['li',num2str(iChan)];
clear tmp
loadfilename = [getfilenum(SUB.session(iSession),3) '_' val '_t(' SUB.ext ')_seg_lfp_' SUB.alignOnset{iSession} '.mat'];
load([segDataDir loadfilename]);
savefilename = [filename '_' val];
eval(['tmp = ' val ';' ])

if ~exist('tt')
    tt = 1:size(tmp{1},2);
    tt = tt / SUB.fs;
    tt = tt - abs(SUB.tRange(1)); % stim onset = 0.5;
end

if exist('times2use','var')
    [~,times2useIdx(1)] = min(abs(times2use(1) - tt));
    [~,times2useIdx(2)] = min(abs(times2use(2) - tt));
    for trialType = 1:5
        tmp{trialType} = tmp{trialType}(:,times2useIdx(1):times2useIdx(2));
    end
    tt = tt(times2useIdx(1):times2useIdx(2));
end


%% anova
if PLOT.onlySignificant
    clear anovap
    if ~exist('nTrialPerClass')
        for trialType = 1:5
            nTrialPerClass(trialType) = size(tmp{trialType},1);
            vTrials = sum(nTrialPerClass(1:trialType-1))+1:sum(nTrialPerClass(1:trialType));
            vClass(vTrials) = trialType;
        end
    end
    for iTime = 1:length(tt)
        tmpData = zeros(sum(nTrialPerClass),1);
        for trialType = 1:5
            vTrials = sum(nTrialPerClass(1:trialType-1))+1:sum(nTrialPerClass(1:trialType));
            tmpData(vTrials) = tmp{trialType}(:,iTime);
        end
        [anovap(iTime)] = anova1(tmpData,vClass,'off');
    end
    
    tmp2 = FDR(anovap,qid);
    if isempty(tmp2)
        disp(['anova1 not significant : ' val ': ' datestr(now) ' ' savefilename])
        
        return
    else
        pid = tmp2;
        disp(['SIGNIFICANT : ' val ': ' datestr(now) ' ' savefilename])
        
    end
end
%%
for trialType = 1:5
    tmp{trialType} = double(tmp{trialType}');
    % 		[s,t,f] = mtspecgramc(tmp{trialType},params.movingwin,params);
    % 		sdb = 10*log10(s);
    %
    % 		tBaseline = find(t<0.5);
    % 		baseline = sdb(tBaseline,:,:);
    % 		dsdb{trialType} = sdb - repmat( mean(baseline,1) , [length(t) 1 1]);
end
if 1
    for trialType = 1:5
        mTmp(:,trialType) = squeeze(mean(tmp{trialType},2));
    end
    figureSettings
    % for trialType = 1:5
    % subplot(3,2,trialType)
    if PLOT.onlySignificant
    subplot(2,1,1)
    end
    plot(tt,mTmp)
    axis tight
    switch SUB.stimCat{iSession}
        case 'ekman'
            legendtxt = {'upright F','invert F','houses','tools','Mondrian'};
        case 'animal'
            legendtxt = {'Animals','Persons','Landmards','Vehcles','Flowers'};
    end
    h = legend(legendtxt);
    set(h,'box','off')
    if PLOT.onlySignificant
    subplot(2,1,2)
    plot(tt,anovap)
    set(gca,'yscale','log')
    hold on
    plot(xlim,[1 1]*pid)
    end
    figureSave
    
end
% end

%%
