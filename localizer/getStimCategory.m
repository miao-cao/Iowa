function [StimCategory legendtxt] = getStimCategory(subID,SUB,DIR)
switch subID
    case '153'
        StimCategory = 'ekman';
    case '154a'
        StimCategory = 'ekman';
    case '154b'
        StimCategory = 'ekman';
    case '154'
        StimCategory = 'ekman';        
    case '156'
        StimCategory = 'ekman';
    case '168'
        StimCategory = 'ekman';
        
        %     case '173'
        %         StimCategory = 'animal';
        %         %         input('StimCategory = ekman, favorite or animal','s');
    case '178'
        StimCategory = 'animal';
    case '180a'
        StimCategory = 'animal';
    case '180b'
        StimCategory = 'ekman';
        %     case '181'
        %         StimCategory = 'Unknown';
        
    case '186'
        StimCategory = 'ekman';
    case '232'
        StimCategory = 'ekman';
    case '242'
        StimCategory = 'ekman';
        
    otherwise
        
        
        if ~exist('iSession','var')
            iSession=1;
        end
%         S = getLocalizer_PatientInfo('subject',subID,'experimentname','localizer');
%         %         keyboard
%         vSession = 1:length(S.session);
        %%
        behFiles = dir([DIR.beh '*']);
        
        
        for iSession = 1:SUB.nSession
%             S = getLocalizer_PatientInfo('subject',subID,'experimentname','localizer');
            
            filename = [subID '-' getfilenum(SUB.session(iSession),3)];
            
            [~,evntIdx] =  grep({behFiles.name}, filename);
            evntIdx = find(evntIdx);
            for iBehFile = 1:length(evntIdx)
                clear iStimCategory stimInfo
                switch behFiles(evntIdx(iBehFile)).name(end-3:end)
                    case '.mat'
                        load([DIR.beh behFiles(evntIdx(iBehFile)).name])
                        if exist('iStimCategory','var')
                            if iStimCategory == 0
                                vStimCategory{iSession} = {'upright F','invert F','houses','tools','Mondrian'};%ekman
                                StimCategory{iSession} = 'ekman';
                            elseif iStimCategory == 1
                                vStimCategory{iSession} = {'Animals','Face','Landmarks','Vehicles','Flowers'};%animal
                                StimCategory{iSession} = 'animal';
                            elseif iStimCategory == 2 % only sub 173
                                vStimCategory{iSession} = {'animals','famous','landmarks','vehicles','flowers'};
                                StimCategory{iSession} = 'favorite';
                            elseif iStimCategory == 3 % only sub 173
                                vStimCategory{iSession} = {'scooby','oscooby','kitty','carebear','batman'};
                                StimCategory{iSession} = 'favorite3';
                            elseif iStimCategory == 4 % only sub 173
                                vStimCategory{iSession} = {'curious','ocurious','sonic','caillou','spiderman'};
                                StimCategory{iSession} = 'favorite2';
                            else
                                keyboard
                            end
                            
                            
                        elseif exist('stimInfo','var')
                            keyboard
                            for trialType = 1:trialTypes
                                if strfind(stimInfo{trialType}(1).name,'persons');
                                    vStimCategory{iSession,trialType} = 'Face';
                                elseif strfind(stimInfo{trialType}(1).name,'animals');
                                    vStimCategory{iSession,trialType} = 'Animals';
                                elseif strfind(stimInfo{trialType}(1).name,'landmarks');
                                    vStimCategory{iSession,trialType} = 'Landmarks';
                                elseif strfind(stimInfo{trialType}(1).name,'vehicles');
                                    vStimCategory{iSession,trialType} = 'Vehicles';
                                elseif strfind(stimInfo{trialType}(1).name,'flowers');
                                    vStimCategory{iSession,trialType} = 'Flowes';
                                else
                                    stimInfo{trialType}(1).name
                                    keyboard
                                end
                            end
                        else
                            keyboard
                        end
                        
                    otherwise
                end
            end
        end
end


switch StimCategory
    case 'ekman'
        legendtxt = {'upright F','invert F','houses','tools','Mondrian'};
    case 'animal'
        legendtxt = {'Animals','Persons','Landmards','Vehicles','Flowers'};
    case 'Unknown'
        legendtxt = {'1','2','3','4','5'};
end
