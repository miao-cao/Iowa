function combineSessions_IowaBM(subID,EXP,iChan)
subSpecs_IowaBM
%% 10 Mar 17
% combine sessions for ERP analysis    

if ~exist('subID','var')
    subID = '147';
end

%%
for iChan = SUB.chan
	val = ['li',num2str(iChan)];
    disp(['combine ' val ' ' datestr(now)])
    allERP = [];
    for iSession = SUB.vSession
        
        segChanDir = [DIR.rawData getfilenum(SUB.session(iSession),3) filesep 'segEachChan' filesep];
        filename   = [getfilenum(SUB.session(iSession),3) '_' val '_t(' SUB.ext ')_seg_lfp_' 'PPort' '.mat'];
        load([segChanDir filesep filename],'-mat',val);
        eval(['tmp = ' val ';' ])
        
        allERP = [allERP; tmp];
        
        eval(['clear ' val])
    end
    clear tmp;
    %%
    save([DIR.combine filesep subID '_' num2str(length(SUB.vSession)) '_sessions_' val '_t(' SUB.ext ').mat'],'allERP')
end
