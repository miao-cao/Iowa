function compareTiming(subID,EXP,PLOT)
clear meanDelay evntDelay alignOnset trialOnset2use
if nargin < 1
    subID = '168'
end
dbstop if error
%%
PLOT.visible = 'on';
PLOT.print = 1;

subSpecs_IowaLocalizer

DIR.fig = [DIR.figBase filesep 'compareTiming' filesep];
if ~exist(DIR.fig,'dir')
    mkdir(DIR.fig)
end


if ~exist('iSession')
    iSession = 1;
end
vvSession=[];
for iSession = SUB.vSession
    filename = [subID '-' getfilenum(SUB.session(iSession),3)];
    
    %% load subject trialOnset data, (load output from checkTrialInfo.m),
    %select right file (PPort, PhDio, Beh)
    load([DIR.seg filesep filename '_trialCheck.mat'] )
    try
        switch subID
            case '232'
                switch filename
                    case '232-054'
                        tmpStartTime= tStartTime;
                    case '232-055'
                        
                        tmpStartTime = PhDioEvnt.tStartTime(1);
                end
                trialOnset2use(iSession).beh = zeros(1,length(PhDioEvnt.tStartTime));
                for iTrial = 1:length(PhDioEvnt.tStartTime)
                    trialOnset2use(iSession).beh(iTrial)  = behEvnt.startTrialTime(iTrial) - behEvnt.startTrialTime(1) + tmpStartTime;
                end
        end
        
        trialOnset2use(iSession).PPort  = PPortEvnt.vTrialOnset;
        trialOnset2use(iSession).PhDio  = PhDioEvnt.tStartTime;
        
        vvSession=[vvSession iSession];
    catch
        alignOnset = SUB.alignOnset{iSession};
    end
end
%%
switch subID 
    case '154a'
       alignOnset='PPort';
end

if ~exist('alignOnset','var')
    alignOnset='PPort';
end

figure(1);clf
set(gcf,'visible',PLOT.visible)
for iSession = vvSession
    filename = [subID '-' getfilenum(SUB.session(iSession),3)];
    
    subplot(2,2,iSession)
    switch alignOnset
        case 'PPort'
            evntDelay = trialOnset2use(iSession).PPort-trialOnset2use(iSession).PhDio;
        case 'Beh'
            evntDelay = trialOnset2use(iSession).beh-trialOnset2use(iSession).PhDio;
    end
    hist(evntDelay)
    meanDelay(iSession) = mean(evntDelay);
    title({[filename] ;
        [ 'pd-evnt = ' num2str(mean(evntDelay)*1000,2) '+-' num2str(std(evntDelay)*1000,2) '[ms] (mean+std)']},...
        'interpret','none')
end

meanDelay(meanDelay==0)=[];

disp(['mean Delay = ' num2str(mean(meanDelay))])

savefilename = [subID '_compare_PhDio_' alignOnset];
figureSave
end

