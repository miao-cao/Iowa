% switch subID
%     case {'145'}
%         disp('under construction -- need log file : skip 145')
%         return
%     case {'146'}
%         disp('under construction -- need log file : skip 146')
%         return
%     case {'147'}
%         exp = 'cfs_prelim';
%     otherwise
%         exp = 'cfs';
% end
% 
% % S = getCFS_PatientInfo('subject',subID,'experimentname',exp);
% % nSession = length(S.session);

%% load behavioral data
loadfilename = ['cleanTrials_' subID  SUB.ext '.mat'];

switch subID
    case '154'
        load([DIR.clean loadfilename],'CFSCHAN','tmp')
        

        StimPos     = tmp(CFSCHAN(iChan)).removedStimPos;
        StimCont    = tmp(CFSCHAN(iChan)).removedStimCont;
        CorrResp    = tmp(CFSCHAN(iChan)).removedCorrResp;
        Visibility  = tmp(CFSCHAN(iChan)).removedVisibility;
        StimType    = tmp(CFSCHAN(iChan)).removedStimType;
        StimID      = tmp(CFSCHAN(iChan)).removedStimID;

    otherwise
        load([DIR.clean '/' loadfilename],'removedStimPos','removedStimCont',...
            'removedCorrResp','removedVisibility',...
            'removedStimType','removedStimID','nTrialsAfterRemove')
        
        StimPos     = removedStimPos;
        StimCont    = removedStimCont;
        CorrResp    = removedCorrResp;
        Visibility  = removedVisibility;
        StimType    = removedStimType;
        StimID      = removedStimID;
end
clear removedCorrResp removedStimCont removedStimPos removedVisibility
clear removedStimType removedStimID 
