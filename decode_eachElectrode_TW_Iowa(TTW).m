function decode_eachElectrode_TW_Iowa(subID,iChan,DP,C,SPG,EXP,DIR)
DIR.wrongfile = [DIR.base filesep 'wrongFile' filesep];
if ~exist(DIR.wrongfile,'dir')
    mkdir(DIR.wrongfile)
end

clear tmpSPG chan* tempChan
val = ['li' num2str(iChan)];

switch EXP.dataset
    case 'localizer'
        subSpecs_IowaLocalizer
    case 'CFS'
        subSpecs_IowaCFS
    case 'BM'
        subSpecs_IowaBM        
end

%% check if file already exists
finishFile = zeros(DP.nTW(length(DP.nTW)),DP.nTTW(length(DP.nTTW)),DP.vDim(length(DP.vDim)),length(DP.times2decodeAll),length(DP.freq2decodeAllPower));
for iTW = DP.nTW
    
    switch DP.dimension
        case 'eachElectrodeEachTime'
            nTTW2use = DP.nTTW;
        case {'eachElectrodeEachTimeEachFreq','eachElectrodeEachFreq'}
            nTTW2use = iTW;
    end
    
    for iTTW = nTTW2use
        if iTTW < iTW, continue, end
        
        for iDim = DP.vDim
            for itt = 1:length(DP.times2decodeAll)
                for iff = 1:length(DP.freq2decodeAllPower)
                    getDecodeDimension_TW_Iowa
                    DP.nTimeWindow = SPG.TW(iTTW)/SPG.TW(iTW);
                    
                    
                    switch dataset
                        case 'localizer'
                            savefilenameOld{iTW,iTTW,iDim,itt,iff}  = [subID '_' val '_' DP.decodeSPG '_' EXP.cond '_' DP.saveCategory '_TW=' num2str(SPG.TW(iTW)) '_TTW=' num2str(SPG.TW(iTTW)) '_nTW=' num2str(DP.nTimeWindow) ];
                            savefilename{iTW,iTTW,iDim,itt,iff}     = [subID '_' val '_' DP.decodeSPG '_' EXP.cond '_' DP.saveCategory '_TW=' num2str(SPG.TW(iTW)) '_TTW=' num2str(SPG.TW(iTTW)) '_nTW=' num2str(DP.nTimeWindow) '_times(' num2str(DP.times2decode(1)) '_' num2str(DP.times2decode(2)) ')'];
                        case 'CFS'
                            savefilenameOld{iTW,iTTW,iDim,itt,iff}  = [subID '_' val '_' DP.decodeSPG '_' EXP.decodeType '_' DP.saveCategory '_TW=' num2str(SPG.TW(iTW)) '_TTW=' num2str(SPG.TW(iTTW)) '_nTW=' num2str(DP.nTimeWindow) ];
                            savefilename{iTW,iTTW,iDim,itt,iff}     = [subID '_' val '_' DP.decodeSPG '_' EXP.decodeType '_' DP.saveCategory '_TW=' num2str(SPG.TW(iTW)) '_TTW=' num2str(SPG.TW(iTTW)) '_nTW=' num2str(DP.nTimeWindow) '_times(' num2str(DP.times2decode(1)) '_' num2str(DP.times2decode(2)) ')'];
                            
                            
                            if strcmpi(DP.saveCategory,'erp')
                                A = dir([DIR.decodeSPG filesep 'dTF_' savefilename{iTW,iTTW,iDim,itt,iff} '_' DP.ext '.mat' ]);
                                if ~isempty(A)
                                    if ~month(A(1).date)>=6 && ~day(A(1).date)>=26
                                        movefile([DIR.decodeSPG A.name],DIR.wrongfile)
                                        if exist([DIR.decodeSPG 'dTF_' savefilename{iTW,iTTW,iDim,itt,iff} '_' DP.ext '.mat' ],'file')
                                            keyboard
                                        end
                                    end
                                end
                            end
                    end
                    
                    if strcmpi(DP.saveCategory,'logPower')
                        A = dir([DIR.decodeSPG 'dTF_' savefilename{iTW,iTTW,iDim,itt,iff} '_' DP.ext '.mat']);
                        if ~isempty(A)
                            if (month(A(1).date)<=7 && ~(day(A(1).date)>=24)) || (day(A(1).date)==24 && hour(A(1).date)<12)
                                movefile([DIR.decodeSPG A.name],DIR.wrongfile)
                                if exist([DIR.decodeSPG 'dTF_' savefilename{iTW,iTTW,iDim,itt,iff} '_' DP.ext '.mat' ],'file')
                                    keyboard
                                end
                            end
                        end
                    end
                    
                    
                    
                    if exist([DIR.decodeSPG filesep 'dTF_' savefilenameOld{iTW,iTTW,iDim,itt,iff} '_' DP.ext '.mat' ],'file')
                        disp(['OLD ' savefilenameOld{iTW,iTTW,iDim,itt,iff}])
%                         finishFile(iTW,iTTW,iDim,iff)=1;
%                         continue
                        %             elseif exist([DIR.decodeSPGOLD filesep 'dTF_' savefilename{iTW,iTTW,iDim} '_' DP.ext '.mat' ],'file')
                        %                 disp(['old ' savefilename{iTW,iTTW,iDim}])
                        %
                        copyfile([DIR.decodeSPG 'dTF_' savefilenameOld{iTW,iTTW,iDim,itt,iff} '_' DP.ext '.mat' ],[DIR.decodeSPG 'dTF_' savefilename{iTW,iTTW,iDim,itt,iff} '_' DP.ext '.mat' ]);
                        finishFile(iTW,iTTW,iDim,itt,iff)=1;
                        if exist([DIR.decodeSPG 'dTF_' savefilename{iTW,iTTW,iDim,itt,iff} '_' DP.ext '.mat' ],'file');
                            delete([DIR.decodeSPG 'dTF_' savefilenameOld{iTW,iTTW,iDim,itt,iff} '_' DP.ext '.mat' ]);
                            continue
                        end
                    elseif exist([DIR.decodeSPG filesep 'dTF_' savefilename{iTW,iTTW,iDim,itt,iff} '_' DP.ext '.mat' ],'file')
                        disp([savefilename{iTW,iTTW,iDim,itt,iff}])
                        finishFile(iTW,iTTW,iDim,itt,iff)=1;
                        %             disp('else')
                        %                 finishFile(iTW,iTTW,iDim)=1;
                        continue
                    end
                end
            end
        end
    end
end

switch DP.dimension
    case 'eachElectrodeEachTime'
        %         if sum(sum(sum(finishFile(DP.nTW,DP.nTTW,DP.vDim)))) == ((length(DP.nTW)*length(DP.nTTW)*length(DP.vDim))-factorial(length(DP.nTW)))
        if sum(sum(sum(finishFile(DP.nTW,DP.nTTW,DP.vDim,:,:)))) == (factorial(length(DP.nTW)) * length(DP.vDim)) * length(DP.times2decodeAll) * length(DP.freq2decodeAllPower)
            return
        end
    case {'eachElectrodeEachFreq','eachElectrodeEachTimeEachFreq'}
        if sum(sum(sum(finishFile(DP.nTW,DP.nTTW,DP.vDim,:,:)))) == (length(DP.nTW) * length(DP.vDim)) * length(DP.times2decodeAll) * length(DP.freq2decodeAllPower)
            return
        end
end
% finishFile = zeros(DP.nTW(length(DP.nTW)),DP.nTTW(length(DP.nTTW)),DP.vDim(length(DP.vDim)));

%%

switch dataset
    case 'localizer'
        loadfilenameERP = [subID '_' num2str(nSession) '_' StimCategory '_sessions_' val ':t_' ext];
        load([DIR.combine loadfilenameERP '.mat'])
        [~,~,~,allERP] = getSeparateConditionsIowaFaceLocalizer(subID,[],EXP,allERP);
    case 'CFS'
        loadfilename = ['cleanTrials_' num2str(iChan) '_' subID ext];
        load([DIR.clean '/' loadfilename '.mat'],'removedData');
        
        allERP{1} = squeeze(removedData(:,:,1));%interval 1
        allERP{2} = squeeze(removedData(:,:,2));%interval 2
end
iTW2use=0;
for iTW = DP.nTW
    if ~DP.movingWindowSizes2use(iTW), continue, end
    iTW2use=iTW2use+1;
    clear tmpAllERP
    switch DP.dimension
        case 'eachElectrodeEachTime'
            if sum(sum(squeeze(finishFile(iTW,:,:,:,:)))) == ((length(DP.nTTW)-(iTW2use-1))*length(DP.vDim))
                continue
            end
        case 'eachElectrodeEachTimeEachFreq'
            if sum(sum(squeeze(finishFile(iTW,iTW,:,:,:)))) == (length(DP.vDim))
                continue
            end
    end
    disp(num2str(SPG.TW(iTW)))
    
    %     try
    lastwarn('');
    warning('on','all')
    
    switch dataset
        case 'localizer'
            loadfilenameSPG = [subID '_' val '_TW_' num2str(length(SPG.TW)) '_SPG_' num2str(SPG.TW(iTW)) '_' DP.decodeSPG];
            try
                load([DIR.SPG loadfilenameSPG '.mat'],['chan' num2str(iChan)]);
            catch
                [warnmsg, msgid] = lastwarn;
%                 keyboard
                if strcmp(msgid,'File may be corrupt')
                    movefile([DIR.SPG loadfilenameSPG '.mat'],DIR.wrongfile)
                    if exist([DIR.SPG loadfilenameSPG '.mat'],'file')
                        keyboard
                    end
                    
                end
                
            end

                eval(['tmpSPG = chan' num2str(iChan) ';']);
                if length(tmpSPG) == iTW
                    tmpSPG = tmpSPG(iTW).SPG;
                end
                tmpAllERP = allERP;
                [tmpSPG,trialTypes,~,~] = getSeparateConditionsIowaFaceLocalizer(subID,tmpSPG,EXP,[]);
            case 'CFS'
                loadfilenameSPG = [subID '_' val '_TW_' num2str(length(SPG.TW)) '_SPG_' num2str(SPG.TW(iTW)) '_' DP.decodeSPG];
                load([DIR.SPG loadfilenameSPG '.mat']);
                eval(['tmpSPG = chan' num2str(iChan) ';']);
                if length(tmpSPG) == iTW
                    tmpSPG = tmpSPG(iTW).SPG;
                end
                
                getSeparateConditionsIowaCFS
                for iCond = 1:length(tmpSPG)
                    tmpAllERP{iCond} = tmpSPG(iCond).erp;
                end
                
        end
        
        switch DP.dimension
            case 'eachElectrodeEachTime'
                nTTW2use = DP.nTTW;
            case 'eachElectrodeEachTimeEachFreq'
                nTTW2use = iTW;
        end
        for iTTW = nTTW2use
            if iTTW < iTW, continue, end
            for itt = 1:length(DP.times2decodeAll)
                for iff = 1:length(DP.freq2decodeAllPower)
                    getDecodeDimension_TW_Iowa
                    
                    %                 switch DP.dimension
                    %                     case {'eachElectrodeEachTime','eachElectrodeEachTimeEachFreq'}
                    [data tmpTrialLabel times2downsample freq DP] = prepareDecode_eachElectrodeEachTime_TW_Iowa(tmpSPG,tmpAllERP,SPG,DP,fs,tRange,iTW,iTTW,trialTypes);
                    %                 end
                    %
                    for iDim = DP.vDim
                        getDecodeDimension_TW_Iowa
                        DP.nTimeWindow = SPG.TW(iTTW)/SPG.TW(iTW);
                        decode(savefilename{iTW,iTTW,iDim,itt,iff},data,tmpTrialLabel,DIR.decodeSPG,times2downsample,freq,DP,C,trialTypes)
                    end
                end
            end
        end
        %     catch me
        %     end
        
end
