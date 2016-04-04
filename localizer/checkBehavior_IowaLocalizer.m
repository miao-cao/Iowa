function checkBehavior_IowaLocalizer(EXP)
% displays the behavioral performance of individual and multiple subjects.
% if multiple subjects, statistical analyses (ttest) are performed.
%
% Loads behavioral data created by prepareSegmentWithBehavior


nSub = numel(EXP.subReadyForAnalyses);

aPrime = NaN(nSub,4);

for iSub = 1:nSub
    subID = EXP.subReadyForAnalyses{iSub};
    subSpecs_IowaLocalizer

    for iSession = 1:SUB.nSession
        filename = [subID '-' getfilenum(SUB.session(iSession),3)];
        BEH(iSub,iSession) = load([DIR.beh filesep filename]);
        
        Aprime(iSub,iSession) = BEH(iSub,iSession).behEvnt.Aprime;
        
    end
    
    disp(['mean A''' ' across ' num2str(SUB.nSession) ' sessions, for subject ' subID ' = ' num2str(nanmean(Aprime(iSub,:))) ', std = ' num2str(nanstd(Aprime(iSub,:)))]);
    
    
end

if nSub>1
    
   [H, p] = ttest(nanmean(Aprime,2),0.5);
   
   disp(['mean A''' ' across subjects: ' EXP.subReadyForAnalyses{:} ', is ' num2str(namean(nanmean(Aprime,2),1)) ''])
   disp(['A''' ' is significantly different from chance level ' num2str(H) ' with p-value ' num2str(p)])
   
end
