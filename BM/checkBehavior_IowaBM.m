function checkBehavior_IowaBM(EXP,PLOT)
% Plot behavioral results for the CFS paradigm, both for single and
% multiple subjects. Single: plots the number of trials per visibility
% level for each contrast. Multiple: plots percentage correct per
% visibility level. Stats across multiple subjects.
%
% INPUT
% EXP: structure with subject specific settings
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

figureSettings

for iSub = 1:nSub
    %% load data and determine the number of contrasts used across sessions
    subID = tmpSUB{iSub};
    subSpecs_IowaBM
    DIR.fig = [DIR.figBase 'behavior' filesep];
    if ~exist(DIR.fig,'dir')
        mkdir(DIR.fig)
    end
    load([DIR.beh SUB.behFile{1} '.mat']);
    
    
    
    
    getBehavioralDataForBM
    getVtrials_IowaBM
    
    %% plot individual subject behavioral results
    
    subplot(2,1,1)
    hist(soa(vTrial{1}))
    title(['soa ' EXP.legendtxt{1}])
    
    subplot(2,1,2)
    hist(soa(vTrial{2}))
    title(['soa ' EXP.legendtxt{2}])
    
    savefilename = ([subID '_' EXP.cond '_soa']);
figureSave
% keyboard
    
    
    
%     %% store subject data
%     Beh(iSub).trialData = trialData;
%     for iVtrials = 1:length(vTrial)
%         Beh(iSub).vTrial{iVtrials} = vTrial{iVtrials};
%     end
%     
%     clear trialData vTrials
end


% keyboard