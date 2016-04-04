function cleanTrials(subID,EXP)
% nargin = 0;
% rewritten by NT 2009 Aug 7
% separated from checkSegmentData
dbstop if error
if nargin < 1
    subID = '153'
end
% experiment.name = 'CFS'; % CFS_localizer

Job.saveData = 1


%% rewritten by NT, 2009 Jan 10

subSpecs_IowaCFS
DIR.fig = [DIR.figBase '/figure_cleanTrials/'];
if isempty(dir(DIR.fig))
    mkdir(DIR.fig)
end

PLOT.visible = 'on'; % this is important to check.  See the plot for every subject
%%
SUB.ext = [num2str( SUB.tRange(1) ) '_' num2str( SUB.tRange(2) )];

%%
vSession = 1:SUB.nSession;

%% get only segment
tt = floor(SUB.tRange(1)*SUB.fs) : ceil(SUB.tRange(2)*SUB.fs) ;
tt = tt / SUB.fs ;
%%
loadContactInfo_bipolar_CFS
%% remove all 0 trials
% check all trials

clear removeTrialsEachChanEachInt
for iElectrode = SUB.chan
    filename = dir([DIR.combine '/combineSessions_' num2str(iElectrode) '_*' SUB.ext '*']);
    load([DIR.combine '/' filename.name])
    disp(['clean trials: check ' filename.name])
    
    if iElectrode == 1
        figure(1),clf
        set(gcf,'visible', PLOT.visible)
        subplot(2,2,1)
        imagesc([],tt,allData(:,:,1)')
        ylabel('sec')
        xlabel('all trials')
        title([subID ' : ' num2str(size(allData,1)) ' trials : 1st interval'])
        subplot(2,2,2)
        imagesc([],tt,allData(:,:,2)')
        xlabel('all trials')
        title(['chan ' num2str(iElectrode) ' : 2nd interval'])
        subplot(2,2,3)
        imagesc([],tt,(allData(:,:,1)==0)')
        title(['1st interval is zero'])
        xlabel('all trials')
        subplot(2,2,4)
        imagesc([],tt,(allData(:,:,2)==0)'   )
        title(['2nd interval is zero'])
        xlabel('all trials')
        
        print(gcf,'-dpng',[DIR.fig '/checkERPimage_alltrials_bothIntervals_' subID '_el' num2str(iElectrode) '.png'])
        
    end
    
    for iInt = 1:2
        removeTrialsEachChanEachInt(:,iElectrode,iInt) = all(allData(:,:,iInt)==0,2);
    end
end
%%
removeTrialsEachChan = sum(removeTrialsEachChanEachInt,3);
%% 10 Mar 13, add this part to remove non-recorded channels for 178
removeChan = sum(removeTrialsEachChan);
vRemoveChan = find(removeChan>0);
if ~isempty(vRemoveChan)
    figure(10),clf
    plot(vRemoveChan,1,'o')
    title([num2str(length(vRemoveChan)) ' channels have no data : removed'])
    removeTrialsEachChan(:, vRemoveChan) = nan;
end

%%
removeTrials = nansum(removeTrialsEachChan,2);
%%
figure(2),clf
set(gcf,'visible', PLOT.visible)

subplot(2,1,1)
imagesc(removeTrialsEachChan')
title([subID ' : ' num2str(size(allData,1)) ' trials : 1st interval'])
% title('which trials to remove')
xlabel('trial')
ylabel('chan')
colorbar
subplot(2,1,2)
plot(removeTrials,'o-')
xlabel('trial')
axis tight
ylabel('# of removed channel')
hold on
%%
plot((cumsum(nTrialsEachSession)'*[1 1])',ylim,'k')
%%
title(['# of trials for each session =' num2str(nTrialsEachSession)])


print(gcf,'-dpng',[DIR.fig '/checkERPimage_alltrials_allChan_' subID '.png'])

%%
if Job.saveData
    for iElectrode = SUB.chan
        filename = dir([DIR.combine '/combineSessions_' num2str(iElectrode) '_*' SUB.ext '*']);
        load([DIR.combine '/' filename.name])
        
        removedData = allData(removeTrials==0,:,:);
        switch subID
            case '178'
            otherwise                
                removedData = removedData / 20 ; % gain by 20
        end
        removedData = double(removedData);
        savefilename = ['cleanTrials_' num2str(iElectrode) '_' subID SUB.ext '.mat'];
        disp(['saving ' savefilename])
        save([DIR.clean '/' savefilename],'removedData','vRemoveChan')
    end
else
    disp('don''t save the data')
end

%% plot as a function of trial types
% face vs non face
% load behavioral file
clear D vFaceOnData vFaceOffData
for iSession = SUB.vSession
    logDir = [DIR.beh ];
    loadfile = [ SUB.logFile{iSession} ];
    disp(['start loading : ' loadfile '  : ' datestr(now)])
    D{iSession} = load([logDir '/' loadfile]);
    
    vTrials = 1:nTrialsEachSession(iSession);
    vStimPos{iSession} = D{iSession}.vStimPos(vTrials);
    vStimCont{iSession} = D{iSession}.vStimCont(vTrials);
    vCorrResp{iSession} = D{iSession}.correct_stim_responses(vTrials);
    vVisibility{iSession} = D{iSession}.visibility_resp(vTrials);
    vStimType{iSession} =  D{iSession}.vStimType(vTrials);
    vStimID{iSession} = D{iSession}.vStimID(vTrials);
end

%%
allStimPos = [];
allStimCont = [];
allCorrResp = [];
allVisibility = [];
allStimType = [];
allStimID = [];
for iSession = SUB.vSession
    allStimPos = [allStimPos, vStimPos{iSession}];
    allStimCont = [allStimCont, vStimCont{iSession}];
    allCorrResp = [allCorrResp, vCorrResp{iSession}];
    allVisibility = [allVisibility, vVisibility{iSession}];
    allStimType = [allStimType, vStimType{iSession}];
    allStimID = [allStimID, vStimID{iSession}];
    
end
%%
removedStimPos = allStimPos(removeTrials==0);
removedStimCont = allStimCont(removeTrials==0);
removedCorrResp = allCorrResp(removeTrials==0);
removedVisibility = allVisibility(removeTrials==0);
removedStimType = allStimType(removeTrials==0);
removedStimID = allStimID(removeTrials==0);
%%
clear vRemovedTrials
for iSession = SUB.vSession
    vTrials = (sum(nTrialsEachSession(1:iSession-1))+1) : sum(nTrialsEachSession(1:iSession)) ;
    vRemovedTrials{iSession} = find(ismember(vTrials,find(removeTrials>0)));
    nRemovedTrials(iSession) = length(vRemovedTrials{iSession});
    nTrialsAfterRemove(iSession) = nTrialsEachSession(iSession) - nRemovedTrials(iSession);
end


%%
savefilename = ['cleanTrials_' subID SUB.ext '.mat'];
save([DIR.clean '/' savefilename ],'removedStimPos','removedStimCont',...
    'removedCorrResp','removedVisibility',...
    'removedStimType','removedStimID',...
    'nRemovedTrials','vRemovedTrials','nTrialsAfterRemove')
%%
