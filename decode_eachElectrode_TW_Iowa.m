function decode_eachElectrode_TW_Iowa(subID,iChan,DEC,SPG,EXP)

clear tmpSPG chan* tempChan
val = ['li' num2str(iChan)];

switch EXP.dataset
    case 'localizer'
        subSpecs_IowaLocalizer
    case 'CFS'
        subSpecs_IowaCFS
    case 'BM_4S'
        subSpecs_IowaBM
end

DIR.wrongfile = [DIR.base filesep 'wrongFile' filesep];
if ~exist(DIR.wrongfile,'dir')
    mkdir(DIR.wrongfile)
end
DEC.nCond = EXP.nCond;

%% check if file already exists
finishFile = zeros(DEC.nTW(length(DEC.nTW)),DEC.vDim(length(DEC.vDim)),length(DEC.allTimes2decode),length(DEC.allFreq2decode));
for iTW = DEC.nTW
    for iDim = DEC.vDim
        for itt = 1:length(DEC.allTimes2decode)
            for iff = 1:length(DEC.allFreq2decode)
                getDecode_dimTimeFreq_Iowa
                
                %                 switch DEC.saveCategory
                %                     case 'erp'
                savefilename{iTW,iDim,itt,iff} = [subID '_' EXP.cond '_' val '_' DEC.saveCategory '_' DEC.ext];
                %                             DEC.channels2decode '_rndmTr_('  num2str(DEC.randomTrialSelection) '_' num2str(DEC.nTrials2select) ...
                %                             ')_t(' num2str(DEC.times2decode(1)) '_' num2str(DEC.times2decode(2)) ')'...
                %                             '_dsERP(' num2str(DEC.downsampleERP) '_' num2str(DEC.downsampleRate) ')_TW(' num2str(SPG.TW(iTW))  ')'];
                %
                %                         savefilenameOLD{iTW,iDim,itt,iff}     = [subID '_' EXP.cond '_' val '_' DEC.saveCategory ...
                %                             DEC.channels2decode '_rndmTr_('  num2str(DEC.randomTrialSelection) '_' num2str(DEC.nTrials2select) ...
                %                             '_t(' num2str(DEC.times2decode(1)) '_' num2str(DEC.times2decode(2)) ')'...
                %                             '_dsERP(' num2str(DEC.downsampleERP) '_' num2str(DEC.downsampleRate) ')_TW(' num2str(SPG.TW(iTW))  ')'];
                %                     otherwise
                %                         savefilename{iTW,iDim,itt,iff} = [subID '_' EXP.cond '_' val '_' DEC.saveCategory ...
                %                             DEC.channels2decode '_rndmTr_('  num2str(DEC.randomTrialSelection) '_' num2str(DEC.nTrials2select) ...
                %                             ')_t(' num2str(DEC.times2decode(1)) '_' num2str(DEC.times2decode(2)) ')_f(' num2str(DEC.freq2decode(1)) '_' num2str(DEC.freq2decode(2)) ')'...
                %                             '_TW(' num2str(SPG.TW(iTW))  ')'];
                %
                %                         savefilenameOLD{iTW,iDim,itt,iff}     = [subID '_' EXP.cond '_' val '_' DEC.saveCategory ...
                %                             DEC.channels2decode '_rndmTr_('  num2str(DEC.randomTrialSelection) '_' num2str(DEC.nTrials2select) ...
                %                             '_t(' num2str(DEC.times2decode(1)) '_' num2str(DEC.times2decode(2)) ')_f(' num2str(DEC.freq2decode(1)) '_' num2str(DEC.freq2decode(2)) ')'...
                %                             '_TW(' num2str(SPG.TW(iTW))  ')'];
                %                 end
                if exist([DIR.decode 'dTF_' savefilename{iTW,iDim,itt,iff} '.mat' ],'file');
                    finishFile(iTW,iDim,itt,iff) = 1;
                    continue
                end
                
%                 if exist([DIR.decode 'dTF_' savefilenameOLD{iTW,iDim,itt,iff} '_' DEC.ext '.mat' ],'file');
                    
                    
%                     A = dir([DIR.decode 'dTF_' savefilenameOLD{iTW,iDim,itt,iff} '_' DEC.ext '.mat']);
%                     copyfile([DIR.decode A.name],[DIR.decode 'dTF_' savefilename{iTW,iDim,itt,iff} '_' DEC.ext '.mat'])
%                     movefile([DIR.decode A.name],DIR.wrongfile)
%                     if exist([DIR.decode 'dTF_' savefilename{iTW,iDim,itt,iff} '_' DEC.ext '.mat' ],'file');
%                         finishFile(iTW,iDim,itt,iff) = 1;
%                     end
                    
                    
                    %                     if (month(A(1).date)<=10 && (day(A(1).date)<=29))
                    %                         movefile([DIR.decode A.name],DIR.wrongfile)
                    %                         if exist([DIR.decode 'dTF_' savefilename{iTW,iDim,itt,iff} '_' DEC.ext '.mat' ],'file')
                    %                             keyboard
                    %                         end
                    %                     elseif (month(A(1).date)>=10 && (day(A(1).date)>26))
                    %                         copyfile([DIR.decode A.name],[DIR.decode 'dTF_' savefilename{iTW,iDim,itt,iff} '_' DEC.ext '.mat'])
                    %                         movefile([DIR.decode A.name],DIR.wrongfile)
                    %                         if exist([DIR.decode 'dTF_' savefilename{iTW,iDim,itt,iff} '_' DEC.ext '.mat' ],'file');
                    %                             finishFile(iTW,iDim,itt,iff) = 1;
                    %                         end
                    %                     end
%                 end
                
                %                         if strcmpi(DEC.saveCategory,'erp')
                %                             A = dir([DIR.decodeSPG filesep 'dTF_' savefilename{iTW,iTTW,iDim,itt,iff} '_' DEC.ext '.mat' ]);
                %                             if ~isempty(A)
                %                                 if ~month(A(1).date)>=6 && ~day(A(1).date)>=26
                %                                     movefile([DIR.decodeSPG A.name],DIR.wrongfile)
                %                                     if exist([DIR.decodeSPG 'dTF_' savefilename{iTW,iTTW,iDim,itt,iff} '_' DEC.ext '.mat' ],'file')
                %                                         keyboard
                %                                     end
                %                                 end
                %                             end
                %                         end
                
                %                 if exist([DIR.decode filesep 'dTF_' savefilename{iTW,iDim,itt,iff} '_' DEC.ext '.mat' ],'file')
                %                     disp([savefilename{iTW,iDim,itt,iff}])
                %                     finishFile(iTW,iDim,itt,iff)=1;
                %                     continue
                %                 end
            end
        end
    end
end

if sum(sum(finishFile(DEC.nTW,DEC.vDim,:,:))) == (length(DEC.nTW) * length(DEC.vDim) * length(DEC.allTimes2decode) * length(DEC.allFreq2decode))
    return
end

%%

switch EXP.dataset
    case 'localizer'
        loadfilenameERP = [subID '_' num2str(length(SUB.vSession)) '_' SUB.stimCat{SUB.vSession(1)} '_sessions_' val '_t(' SUB.ext ')'];
        load([DIR.combine loadfilenameERP '.mat'])
        [~,allERP,EXP] = getSeparateConditions_IowaLocalizer(subID,[],allERP,EXP);
    case 'CFS'
        loadfilename = ['cleanTrials_' num2str(iChan) '_' subID SUB.ext];
        load([DIR.clean '/' loadfilename '.mat'],'removedData');
        allERP{1} = squeeze(removedData(:,:,1));%interval 1
        allERP{2} = squeeze(removedData(:,:,2));%interval 2
        [~,allERP,EXP] = getSeparateConditions_IowaCFS(subID,[],allERP,EXP,iChan);
    case 'BM_4S'
        loadfilenameERP =  [subID '_' num2str(length(SUB.vSession)) '_sessions_' val '_t(' SUB.ext ')'];
        load([DIR.combine loadfilenameERP '.mat'])
        
        [~,allERP,EXP] = getSeparateConditions_IowaBM(subID,[],allERP,EXP);
        
end

for iTW = DEC.nTW
    clear tmpAllERP
    switch DEC.dimension
        %         case 'eachElectrodeEachTime'
        %             if sum(sum(squeeze(finishFile(iTW,:,:,:,:)))) == ((length(DEC.nTTW)-(iTW2use-1))*length(DEC.vDim))
        %                 continue
        %             end
        case 'eachElectrodeEachTimeEachFreq'
            if sum(sum(squeeze(finishFile(iTW,:,:,:)))) == (length(DEC.vDim))
                continue
            end
    end
    disp(['decoding TW ' num2str(SPG.TW(iTW))])
    
    %     try
    lastwarn('');
    warning('on','all')
    
    %% load SPG
    loadfilenameSPG = [subID '_' val '_TW_' num2str(length(SPG.TW)) '_SPG_' num2str(SPG.TW(iTW))];
    
    try
        load([DIR.SPG loadfilenameSPG '.mat'],['chan' num2str(iChan)]);
        eval(['tmpSPG = chan' num2str(iChan) ';']);
    catch
        [warnmsg, msgid] = lastwarn;
        if strcmp(msgid,'File may be corrupt')
            movefile([DIR.SPG loadfilenameSPG '.mat'],DIR.wrongfile)
            if exist([DIR.SPG loadfilenameSPG '.mat'],'file')
                keyboard
            end
        end
    end
    
    switch EXP.dataset
        case 'localizer'
            [tmpSPG,~,EXP] = getSeparateConditions_IowaLocalizer(subID,tmpSPG,[],EXP);
        case 'CFS'
            [tmpSPG,~,EXP] = getSeparateConditions_IowaCFS(subID,tmpSPG,[],EXP,iChan);
        case 'BM_4S'
            [tmpSPG,~,EXP] = getSeparateConditions_IowaBM(subID,tmpSPG,[],EXP);
    end
    
    for itt = 1:length(DEC.allTimes2decode)
        for iff = 1:length(DEC.allFreq2decode)
            getDecode_dimTimeFreq_Iowa
            
            [data, trialLabel, tt, freq, DEC,] = prepareDecode_eachElectrode_TW_Iowa(tmpSPG,allERP,SUB,SPG,DEC,EXP,iTW);
            for iDim = DEC.vDim
                getDecode_dimTimeFreq_Iowa
                decodeAll(DEC,data,trialLabel,savefilename{iTW,iDim,itt,iff},DIR.decode,tt,freq)

%                 decode(savefilename{iTW,iDim,itt,iff},data,trialLabel,DIR.decode,tt,freq,DEC,EXP.nCond)
            end
        end
    end
end
%     catch me
%     end

end
