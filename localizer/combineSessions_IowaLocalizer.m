function combineSessions_IowaLocalizer(subID,EXP)
subSpecs_IowaLocalizer

% combine sessions for ERP analysis

if ~exist('StimCategory','var') % nargin < 2
    StimCategory = SUB.stimCat{SUB.vSession(1)};
end

for iChan = SUB.chan
    
    val = ['li',num2str(iChan)];
    disp([val ' : ' StimCategory ' : combining sessions : ' datestr(now) ' ' subID])
    savefilename = [subID '_' num2str(length(SUB.vSession)) '_' StimCategory '_sessions_' val '_t(' SUB.ext ').mat'];
%     if exist([DIR.combine filesep savefilename],'file')
%             continue
%     end
    allERP = cell(1,5);
    for iSession = SUB.vSession
        if ~strcmpi(SUB.stimCat{iSession},StimCategory)
            keyboard
        end
        
        segDataDir      = [DIR.rawData filesep getfilenum(SUB.session(iSession),3) filesep 'segmented' filesep];
        DIR.combine     = [DIR.sub filesep 'combine' filesep ];
        lfpFilename     = [getfilenum(SUB.session(iSession),3) '_' val '_t(' SUB.ext ')_seg_lfp_' SUB.alignOnset{iSession} '.mat'];
        if ~exist(DIR.combine,'dir')
            mkdir(DIR.combine)
        end
        
        load([segDataDir filesep lfpFilename],'-mat',val);
        eval(['tmp{iSession} = ' val ';' ])
        
        for iCategory = 1:length(tmp{iSession})
            allERP{iCategory} = [allERP{iCategory}; tmp{iSession}{iCategory}];
        end
        eval(['clear ' val])
    end
    clear tmp;
    %%
    save([DIR.combine filesep savefilename],'allERP')
end
