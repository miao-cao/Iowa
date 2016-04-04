function combineSessionChan(subID,EXP)
% combines sessions for subject with different channel locations across
% sessions

switch subID
    case {'154a','154b'}
        
        switch EXP.dataset
            case 'localizer'
                subID = '154a';
                subSpecs_IowaLocalizer
                DIR.combineOld{1} = DIR.combine;
                nSes1 = length(SUB.session);
                labels.sub154a = bCNT.label;
                
                subID = '154b';
                subSpecs_IowaLocalizer
                DIR.combineOld{2} = DIR.combine;
                nSes2 = length(SUB.session);
                labels.sub154b = bCNT.label;

                DIR.combineAll = [DIR.data filesep '154' filesep 'combine' filesep];

            case 'CFS'
                subID = '154a';
                subSpecs_IowaCFS
                DIR.combineOld{1} = DIR.clean;
                labels.sub154a = bCNT.label;
                nSes1 = SUB.nSession;
                
                subID = '154b';
                subSpecs_IowaCFS
                DIR.combineOld{2} = DIR.clean;
                labels.sub154b = bCNT.label;
                nSes2 = SUB.nSession;
                
                clear nRemovedTrials nTrialsAfterRemove removedCorrResp removedStimCont removedStimID removedStimPos removedStimType removedVisibility
                
                DIR.combineAll = [DIR.data filesep '154' filesep 'cleanTrials' filesep];
        end
        if ~exist(DIR.combineAll,'dir')
            mkdir(DIR.combineAll)
        end
        
        if ~exist([DIR.map filesep 'bcntInfo_154_combined.mat'],'file')
            getCorrespondingChannels_Iowa(subID);
        else
            load([DIR.map filesep 'bcntInfo_154_combined.mat'],'bCNT')
        end
        
        
        for iChan = 1:length(bCNT.label) 
            if strncmpi(bCNT.label{iChan},'Not',3), continue, end
            disp(['combining channels, ' num2str(iChan)])
            clear val loadfilename newVal savefilename allERP tmp combineAllERP oldChan
            switch EXP.dataset
                case 'localizer'
                    newVal = ['li',num2str(iChan)];
                    savefilename = ['154' '_' num2str(nSes1+nSes2) '_' SUB.stimCat{SUB.vSession(1)} '_sessions_' newVal '_t(' SUB.ext ').mat'];
                case 'CFS'
                    newVal = [num2str(iChan)];
                    savefilename = ['cleanTrials' '_' newVal '_' '154' SUB.ext '.mat'];
            end
            
            if ~isempty(find(strcmpi(bCNT.label{iChan},labels.sub154a))) && ~isempty(find(strcmpi(bCNT.label{iChan},labels.sub154b)))
                oldChan(1) = find(strcmpi(bCNT.label{iChan},labels.sub154a));
                oldChan(2) = find(strcmpi(bCNT.label{iChan},labels.sub154b));
                
                
                switch EXP.dataset
                    case 'localizer'
%                         if exist([DIR.combineAll filesep savefilename],'file'), continue, end
                        val{1} = ['li',num2str(oldChan(1))];
                        val{2} = ['li',num2str(oldChan(2))];
                        
                        loadfilename{1} = ['154a' '_' num2str(nSes1) '_' SUB.stimCat{SUB.vSession(1)} '_sessions_' val{1} '_t(' SUB.ext ').mat'];
                        loadfilename{2} = ['154b' '_' num2str(nSes2) '_' SUB.stimCat{SUB.vSession(1)} '_sessions_' val{2} '_t(' SUB.ext ').mat'];
                        load([DIR.combineOld{1} filesep loadfilename{1}],'-mat');
                        tmp(1).allERP = allERP;
                        
                        load([DIR.combineOld{2} filesep loadfilename{2}],'-mat');
                        tmp(2).allERP = allERP;
                        
                        for iCategory = 1:length(allERP)
                            combineAllERP{iCategory} = [tmp(1).allERP{iCategory}; tmp(2).allERP{iCategory}];
                        end
                        allERP = combineAllERP;
                        
                    case 'CFS'
                        CFSCHAN(iChan) = 3;
                        if exist([DIR.combineAll filesep savefilename],'file'), continue, end

                        val{1} = [num2str(oldChan(1))];
                        val{2} = [num2str(oldChan(2))];
                        
                        loadfilename{1} = ['cleanTrials' '_' val{1} '_' '154a' SUB.ext '.mat'];
                        loadfilename{2} = ['cleanTrials' '_' val{2} '_' '154b' SUB.ext '.mat'];
                        try
                            load([DIR.combineOld{1} filesep loadfilename{1}],'-mat');
                            tmp(1).removedData = removedData;
                            
                            load([DIR.combineOld{2} filesep loadfilename{2}],'-mat');
                            tmp(2).removedData = removedData;
                        catch
                            disp(labels.sub154a{oldChan(1)})
                            disp(labels.sub154b{oldChan(2)})
%                             keyboard
                            continue
                        end
                        clear removedData
                        
                        removedData = cat(1,tmp(1).removedData, tmp(2).removedData);
                        
                        %                         nRemovedTrials      = tmp(3).nRemovedTrials;
                        %                         nTrialsAfterRemove  = tmp(3).nTrialsAfterRemove;
                        %                         removedCorrResp     = tmp(3).removedCorrResp;
                        %                         removedStimCont     = tmp(3).removedStimCont;
                        %                         removedStimID       = tmp(3).removedStimID;
                        %                         removedStimPos      = tmp(3).removedStimPos;
                        %                         removedStimType     = tmp(3).removedStimType;
                        %                         removedVisibility   = tmp(3).removedVisibility;
                        %
                        %                         save([DIR.combineAll filesep savefilename],'removedData','nRemovedTrials','nTrialsAfterRemove','removedCorrResp','removedStimCont','removedStimID','removedStimPos','removedStimType','removedVisibility')
                        
                end
                
            elseif ~isempty(find(strcmpi(bCNT.label{iChan},labels.sub154a))) && isempty(find(strcmpi(bCNT.label{iChan},labels.sub154b)))
                oldChan(1) = find(strcmpi(bCNT.label{iChan},labels.sub154a));
                oldChan(2) = 0;
                switch EXP.dataset
                    case 'localiser'
                        val{1} = ['li',num2str(oldChan(1))];
                        loadfilename{1} = ['154a' '_' num2str(nSes1) '_' SUB.stimCat{SUB.vSession(1)} '_sessions_' val{1} '_t(' SUB.ext ').mat'];
                        load([DIR.combineOld{1} filesep loadfilename{1}],'-mat');
                    case 'CFS'
                        CFSCHAN(iChan) = 1;
                        if exist([DIR.combineAll filesep savefilename],'file'), continue, end

                        val{1} = [num2str(oldChan(1))];
                        loadfilename{1} = ['cleanTrials' '_' val{1} '_' '154a' SUB.ext '.mat'];
                        try
                            load([DIR.combineOld{1} filesep loadfilename{1}],'-mat');
                        catch
                            disp(labels.sub154a{oldChan(1)})
                            keyboard
                            continue
                        end
                        
                        
                        %                         nRemovedTrials      = tmp(1).nRemovedTrials;
                        %                         nTrialsAfterRemove  = tmp(1).nTrialsAfterRemove;
                        %                         removedCorrResp     = tmp(1).removedCorrResp;
                        %                         removedStimCont     = tmp(1).removedStimCont;
                        %                         removedStimID       = tmp(1).removedStimID;
                        %                         removedStimPos      = tmp(1).removedStimPos;
                        %                         removedStimType     = tmp(1).removedStimType;
                        %                         removedVisibility   = tmp(1).removedVisibility;
                        %
                        %                         save([DIR.combineAll filesep savefilename],'removedData','nRemovedTrials','nTrialsAfterRemove','removedCorrResp','removedStimCont','removedStimID','removedStimPos','removedStimType','removedVisibility')
                        
                end
            elseif isempty(find(strcmpi(bCNT.label{iChan},labels.sub154a))) && ~isempty(find(strcmpi(bCNT.label{iChan},labels.sub154b)))
                oldChan(1) = 0;
                oldChan(2) = find(strcmpi(bCNT.label{iChan},labels.sub154b));
                switch EXP.dataset
                    case 'localiser'
                        val{2} = ['li',num2str(oldChan(2))];
                        loadfilename{2} = ['154b' '_' num2str(nSes2) '_' SUB.stimCat{SUB.vSession(1)} '_sessions_' val{2} '_t(' SUB.ext ').mat'];
                        load([DIR.combineOld{2} filesep loadfilename{2}],'-mat');
                    case 'CFS'
                        CFSCHAN(iChan) = 2;
                        if exist([DIR.combineAll filesep savefilename],'file'), continue, end

                        val{2} = [num2str(oldChan(2))];
                        loadfilename{2} = ['cleanTrials' '_' val{2} '_' '154b' SUB.ext '.mat'];
                        try
                            load([DIR.combineOld{2} filesep loadfilename{2}],'-mat');
                        catch
                            disp(labels.sub154b{oldChan(2)})
                            keyboard
                            continue
                        end
                        
                        %                         nRemovedTrials      = tmp(2).nRemovedTrials;
                        %                         nTrialsAfterRemove  = tmp(2).nTrialsAfterRemove;
                        %                         removedCorrResp     = tmp(2).removedCorrResp;
                        %                         removedStimCont     = tmp(2).removedStimCont;
                        %                         removedStimID       = tmp(2).removedStimID;
                        %                         removedStimPos      = tmp(2).removedStimPos;
                        %                         removedStimType     = tmp(2).removedStimType;
                        %                         removedVisibility   = tmp(2).removedVisibility;
                        %
                        %                         save([DIR.combineAll filesep savefilename],'removedData','nRemovedTrials','nTrialsAfterRemove','removedCorrResp','removedStimCont','removedStimID','removedStimPos','removedStimType','removedVisibility')
                        
                end
            else
                keyboard
            end
            
            
            %%
            switch EXP.dataset
                case 'localiser'
                    save([DIR.combineAll filesep savefilename],'allERP')
                case 'CFS'
                    save([DIR.combineAll filesep savefilename],'removedData')
            end
        end
        
        switch EXP.dataset
            case 'CFS'
                
                %create cleanTrials file
                load([DIR.combineOld{1} filesep 'cleanTrials_154a' SUB.ext '.mat'])
                tmp(1).nRemovedTrials      = nRemovedTrials;
                tmp(1).nTrialsAfterRemove  = nTrialsAfterRemove;
                tmp(1).removedCorrResp     = removedCorrResp;
                tmp(1).removedStimCont     = removedStimCont;
                tmp(1).removedStimID       = removedStimID;
                tmp(1).removedStimPos      = removedStimPos;
                tmp(1).removedStimType     = removedStimType;
                tmp(1).removedVisibility   = removedVisibility;
                %         tmp.vRemovedTrials      = vRemovedTrials;
                clear nRemovedTrials nTrialsAfterRemove removedCorrResp removedStimCont removedStimID removedStimPos removedStimType removedVisibility
                
                load([DIR.combineOld{2} filesep 'cleanTrials_154b' SUB.ext '.mat'])
                tmp(2).nRemovedTrials      = nRemovedTrials;
                tmp(2).nTrialsAfterRemove  = nTrialsAfterRemove;
                tmp(2).removedCorrResp     = removedCorrResp;
                tmp(2).removedStimCont     = removedStimCont;
                tmp(2).removedStimID       = removedStimID;
                tmp(2).removedStimPos      = removedStimPos;
                tmp(2).removedStimType     = removedStimType;
                tmp(2).removedVisibility   = removedVisibility;
                
                clear nRemovedTrials nTrialsAfterRemove removedCorrResp removedStimCont removedStimID removedStimPos removedStimType removedVisibility
                
                tmp(3).nRemovedTrials      = [tmp(1).nRemovedTrials +     tmp(2).nRemovedTrials];
                tmp(3).nTrialsAfterRemove  = [tmp(1).nTrialsAfterRemove + tmp(2).nTrialsAfterRemove];
                tmp(3).removedCorrResp     = [tmp(1).removedCorrResp      tmp(2).removedCorrResp];
                tmp(3).removedStimCont     = [tmp(1).removedStimCont      tmp(2).removedStimCont];
                tmp(3).removedStimID       = [tmp(1).removedStimID        tmp(2).removedStimID];
                tmp(3).removedStimPos      = [tmp(1).removedStimPos       tmp(2).removedStimPos];
                tmp(3).removedStimType     = [tmp(1).removedStimType      tmp(2).removedStimType];
                tmp(3).removedVisibility   = [tmp(1).removedVisibility    tmp(2).removedVisibility];
                %         tmp.vRemovedTrials{1}   = vRemovedTrials;
                
                
                savefilename = ['cleanTrials_154' SUB.ext '.mat'];
                save([DIR.combineAll savefilename],'CFSCHAN','tmp')
                
        end
        
    otherwise
        return
end


