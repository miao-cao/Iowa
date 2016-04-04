function decode_multiElectrode_TW_Iowa(subID,DEC,SPG,EXP)

switch EXP.dataset
    case 'localizer'
        subSpecs_IowaLocalizer
    case 'CFS'
        subSpecs_IowaCFS
    case 'BM_4S'
        subSpecs_IowaBM
end

%             loadfilenameERP =  [subID '_' num2str(length(SUB.session)) '_sessions_' 'li1' ':t_' ext];
%             load([DIR.combine loadfilenameERP '.mat'])
%             [~,~,~,allERP] = getSeparateConditions_IowaBM(subID,[],EXP,allERP);
%

%             trials2use = [];
%             if DEC.randomTrialSelection
%                 tmpTrialLabel = [];
%                 for iCat = 1:length(allERP)
%                     randTrials2use = randsample(1:size(allERP{iCat},1),DEC.nTrials2select);
%                     if iCat>1
%                         randTrials2use = randTrials2use + size(allERP{iCat-1},1);
%                     end
%                     trials2use=[trials2use randTrials2use];
%                     tmpTrialLabel = [tmpTrialLabel; ones(DEC.nTrials2select,1) * iCat];
%                 end
%             else
%                 for iCat = 1:length(allERP)
%                     randTrials2use = 1:size(allERP{iCat},1);
%                     if iCat>1
%                         randTrials2use = randTrials2use + size(allERP{iCat-1},1);
%                     end
%                     trials2use=[trials2use randTrials2use];
%                 end
%             end
%

DEC.nCond = EXP.nCond;
for iGrid2decode = 1:length(DEC.grid2decode)
    disp(['decoding ' DEC.grid2decode{iGrid2decode}]);
    %%
    ChanIdx = getChannelLocation_Iowa(bCNT,SUB);
    switch DEC.separateStrips
        case 0
        case 1
            %%
            switch DEC.grid2decode{iGrid2decode}
                case 'ventral'
                    arrayID = ChanIdx.ventralBipolar;
                    DEC.nStrips2decode=1;
                case 'temporal'
                    arrayID = ChanIdx.tempBipolar;
                    DEC.nStrips2decode=1;
                case 'frontal'
                    arrayID = ChanIdx.frontalBipolar;
                    DEC.nStrips2decode=1;
                case 'parietal'
                    arrayID = ChanIdx.parietalBipolar;
                    DEC.nStrips2decode=1;
                case 'none'
                    arrayID = ChanIdx.noneBipolar;
                    DEC.nStrips2decode=1;
                case 'allSeparate'
                    DEC.nStrips2decode=length(ChanIdx.labels);
                otherwise
                    DEC.nStrips2decode=1;
            end
    end
    
    if isempty(arrayID)
        disp(['skipping ' DEC.grid2decode{iGrid2decode}])
        continue
    end
    %%
    for iStrips = 1:DEC.nStrips2decode
        %         try
        switch DEC.grid2decode{iGrid2decode}
            case 'allSeparate'
                arrayID = ChanIdx.labels(iStrips).bipolar;
                labelID = ChanIdx.labels(iStrips).ID;
            otherwise
                labelID = 'notSep';
        end
        
        switch subID
            case '154'
                switch EXP.dataset
                    case {'CFS','localizer'}
                        switch DEC.grid2decode{iGrid2decode}
                            case 'temporal'
                                if ~(sum(ismember(arrayID,find(bCNT.sharedSessions))) == 0) && (sum(ismember(arrayID,find(bCNT.sharedSessions))) ~= length(arrayID))
                                    arrayID = arrayID(ismember(arrayID,find(bCNT.sharedSessions)));
                                end
                            case 'ventral'
                                if ~(sum(ismember(arrayID,find(bCNT.sharedSessions))) == 0) && (sum(ismember(arrayID,find(bCNT.sharedSessions))) ~= length(arrayID))
                                    arrayID(1:3) = []; %154a and 154b only share 3 channels in the ventral cortex. Here we use just the channels that aren't shared
                                end
                        end
                    otherwise
                end
        end
        
        %% check if file already exists
        finishFile = zeros(DEC.nTW(length(DEC.nTW)),DEC.vDim(length(DEC.vDim)),length(DEC.allTimes2decode),length(DEC.allFreq2decode));
        
        for iTW = DEC.nTW
            for iDim = DEC.vDim
                getDecode_dimTimeFreq_Iowa
                
%                 switch DEC.saveCategory
%                     case 'erp'
%                         nFreq2test = 1;
%                     case {'phase','power'}
%                         nFreq2test = length(DEC.allFreq2decode);
%                 end
                
                
                for itt = 1:length(DEC.allTimes2decode)
                    for iff = 1:length(DEC.allFreq2decode)
                        getDecode_dimTimeFreq_Iowa
                        savefilename{iTW,iDim,itt,iff} = [subID '_' EXP.cond '_' DEC.saveCategory '_' DEC.ext];
                        
                        
                        switch EXP.dataset
                            case 'CFS'
                                savefilenameOLD{iTW,iDim,itt,iff} = [subID '_' 'high_low_visibility' '_' DEC.saveCategory '_' DEC.ext];
                                
                                if exist([DIR.decode 'dTF_' savefilenameOLD{iTW,iDim,itt,iff} '.mat'],'file')
                                    movefile([DIR.decode 'dTF_' savefilenameOLD{iTW,iDim,itt,iff} '.mat'],[DIR.decode 'dTF_' savefilename{iTW,iDim,itt,iff} '.mat'])
                                end
                                savefilenameOLD{iTW,iDim,itt,iff} = [subID '_' 'high_low_visibility_at_c2' '_' DEC.saveCategory '_' DEC.ext];
                                
                                if exist([DIR.decode 'dTF_' savefilenameOLD{iTW,iDim,itt,iff} '.mat'],'file')
                                    movefile([DIR.decode 'dTF_' savefilenameOLD{iTW,iDim,itt,iff} '.mat'],[DIR.decode 'dTF_' savefilename{iTW,iDim,itt,iff} '.mat'])
                                end
                                
                        end
                        switch EXP.dataset
                            case 'BM_4S'
                                savefilenameOLD{iTW,iDim,itt,iff} = [subID '_' 'hitVsMiss_locAndEmo_100ms' '_' DEC.saveCategory '_' DEC.ext];
                                
                                if exist([DIR.decode 'dTF_' savefilenameOLD{iTW,iDim,itt,iff} '.mat'],'file')
                                    movefile([DIR.decode 'dTF_' savefilenameOLD{iTW,iDim,itt,iff} '.mat'],[DIR.decode 'dTF_' savefilename{iTW,iDim,itt,iff} '.mat'])
                                end
                                
                                savefilenameOLD{iTW,iDim,itt,iff} = [subID '_' 'short(1)VsLong(2)_ipsiLat' '_' DEC.saveCategory '_' DEC.ext];
                                
                                if exist([DIR.decode 'dTF_' savefilenameOLD{iTW,iDim,itt,iff} '.mat'],'file')
                                    movefile([DIR.decode 'dTF_' savefilenameOLD{iTW,iDim,itt,iff} '.mat'],[DIR.decode 'dTF_' savefilename{iTW,iDim,itt,iff} '.mat'])
                                end
                                
                                savefilenameOLD{iTW,iDim,itt,iff} = [subID '_' 'short(1)VsLong(2)_contraLat' '_' DEC.saveCategory '_' DEC.ext];
                                
                                if exist([DIR.decode 'dTF_' savefilenameOLD{iTW,iDim,itt,iff} '.mat'],'file')
                                    movefile([DIR.decode 'dTF_' savefilenameOLD{iTW,iDim,itt,iff} '.mat'],[DIR.decode 'dTF_' savefilename{iTW,iDim,itt,iff} '.mat'])
                                end
                                
                                savefilenameOLD{iTW,iDim,itt,iff} = [subID '_' 'hitVsMiss_short' '_' DEC.saveCategory '_' DEC.ext];
                                
                                if exist([DIR.decode 'dTF_' savefilenameOLD{iTW,iDim,itt,iff} '.mat'],'file')
                                    movefile([DIR.decode 'dTF_' savefilenameOLD{iTW,iDim,itt,iff} '.mat'],[DIR.decode 'dTF_' savefilename{iTW,iDim,itt,iff} '.mat'])
                                end
                                savefilenameOLD{iTW,iDim,itt,iff} = [subID '_' 'short(1)VsLong(2)' '_' DEC.saveCategory '_' DEC.ext];
                                
                                if exist([DIR.decode 'dTF_' savefilenameOLD{iTW,iDim,itt,iff} '.mat'],'file')
                                    movefile([DIR.decode 'dTF_' savefilenameOLD{iTW,iDim,itt,iff} '.mat'],[DIR.decode 'dTF_' savefilename{iTW,iDim,itt,iff} '.mat'])
                                end
                                savefilenameOLD{iTW,iDim,itt,iff} = [subID '_' 'short(1)VsLong(3)' '_' DEC.saveCategory '_' DEC.ext];
                                
                                if exist([DIR.decode 'dTF_' savefilenameOLD{iTW,iDim,itt,iff} '.mat'],'file')
                                    movefile([DIR.decode 'dTF_' savefilenameOLD{iTW,iDim,itt,iff} '.mat'],[DIR.decode 'dTF_' savefilename{iTW,iDim,itt,iff} '.mat'])
                                end
                        end
                        %                         switch DEC.saveCategory
                        %                             case 'erp'
                        %                                 savefilename{iTW,iDim,itt,iff} = [subID '_' EXP.cond '_' DEC.saveCategory '_' ...
                        %                                     DEC.channels2decode '_rndmTr_('  num2str(DEC.randomTrialSelection) '_' num2str(DEC.nTrials2select) ')_' 'sepGrid(' num2str(DEC.separateStrips) '_' DEC.grid2decode{iGrid2decode} '_' labelID ')'  ...
                        %                                     '_t(' num2str(DEC.times2decode(1)) '_' num2str(DEC.times2decode(2)) ')_dsERP(' num2str(DEC.downsampleERP) '_' num2str(DEC.downsampleRate) ')_TW(' num2str(SPG.TW(iTW))  ')'];
                        %
                        %                                 savefilenameOLD{iTW,iDim,itt,iff} = [subID '_' EXP.cond '_' DEC.saveCategory '_' ...
                        %                                     DEC.channels2decode '_rndmTr_'  num2str(DEC.randomTrialSelection) '_nRndmTr_' num2str(DEC.nTrials2select) '_' 'sepGrid_' num2str(DEC.separateStrips) '_' DEC.grid2decode{iGrid2decode} '_' labelID  ...
                        %                                     '_t(' num2str(DEC.times2decode(1)) '_' num2str(DEC.times2decode(2)) ')_f(' num2str(DEC.freq2decode(1)) '_' num2str(DEC.freq2decode(2)) ')_TW(' num2str(SPG.TW(iTW))  ')'];
                        %                             otherwise
                        %                                 savefilename{iTW,iDim,itt,iff} = [subID '_' EXP.cond '_' DEC.saveCategory '_' ...
                        %                                     DEC.channels2decode '_rndmTr_('  num2str(DEC.randomTrialSelection) '_' num2str(DEC.nTrials2select) ')_' 'sepGrid(' num2str(DEC.separateStrips) '_' DEC.grid2decode{iGrid2decode} '_' labelID ')'  ...
                        %                                     '_t(' num2str(DEC.times2decode(1)) '_' num2str(DEC.times2decode(2)) ')_f(' num2str(DEC.freq2decode(1)) '_' num2str(DEC.freq2decode(2)) ')_TW(' num2str(SPG.TW(iTW))  ')'];
                        %
                        %                                 savefilenameOLD{iTW,iDim,itt,iff} = [subID '_' EXP.cond '_' DEC.saveCategory '_' ...
                        %                                     DEC.channels2decode '_rndmTr_'  num2str(DEC.randomTrialSelection) '_nRndmTr_' num2str(DEC.nTrials2select) '_' 'sepGrid_' num2str(DEC.separateStrips) '_' DEC.grid2decode{iGrid2decode} '_' labelID  ...
                        %                                     '_t(' num2str(DEC.times2decode(1)) '_' num2str(DEC.times2decode(2)) ')_f(' num2str(DEC.freq2decode(1)) '_' num2str(DEC.freq2decode(2)) ')_TW(' num2str(SPG.TW(iTW))  ')'];
                        %                         end
                        if exist([DIR.decode 'dTF_' savefilename{iTW,iDim,itt,iff} '.mat' ],'file');
                            finishFile(iTW,iDim,itt,iff) = 1;
                        end
                        
                        %                         if exist([DIR.decode 'dTF_' savefilenameOLD{iTW,iDim,itt,iff} '_' DEC.extOld '.mat' ],'file');
                        %                             A = dir([DIR.decode 'dTF_' savefilenameOLD{iTW,iDim,itt,iff} '_' DEC.extOld '.mat']);
                        %                             if (month(A(1).date)<=10 && (day(A(1).date)<=29))
                        %                                 movefile([DIR.decode A.name],DIR.wrongfile)
                        %                                 if exist([DIR.decode 'dTF_' savefilename{iTW,iDim,itt,iff} '_' DEC.ext '.mat' ],'file')
                        %                                     keyboard
                        %                                 end
                        %                             elseif (month(A(1).date)>=10 && (day(A(1).date)>29))
                        %                                 copyfile([DIR.decode A.name],[DIR.decode 'dTF_' savefilename{iTW,iDim,itt,iff} '_' DEC.ext '.mat'])
                        %                                 movefile([DIR.decode A.name],DIR.wrongfile)
                        %                                 if exist([DIR.decode 'dTF_' savefilename{iTW,iDim,itt,iff} '_' DEC.ext '.mat' ],'file');
                        %                                     finishFile(iTW,iDim,itt,iff) = 1;
                        %                                 end
                        %                             end
                        %                         end
                        %
                    end
                end
            end
        end
        
        %% skip grid/strip if already exists
        if sum(sum(sum(finishFile(DEC.nTW,DEC.vDim,:,:)))) == (length(DEC.nTW)*length(DEC.vDim) * length(DEC.allTimes2decode) * length(DEC.allFreq2decode))
            continue
        end
        
        %% decode
        for iTW = DEC.nTW
            if sum(sum(squeeze(finishFile(iTW,:,:,:)))) == (length(DEC.vDim)) * length(DEC.allTimes2decode) * length(DEC.allFreq2decode)
                continue
            end
            
            clear allTmpChan
            allTmpChan = struct([]);
            iChan2save = 0;
            for iChan = arrayID
                iChan2save = iChan2save+1;
                disp(['loading chan ' num2str(iChan)]);
                clear tmpSPG allERP chan* tempChan
                
                val = ['li' num2str(iChan)];
                
                switch EXP.dataset
                    case 'localizer'
                        
                        loadfilenameERP = [subID '_' num2str(length(SUB.vSession)) '_' SUB.stimCat{SUB.vSession(1)} '_sessions_' val '_t(' SUB.ext ')'];
                        load([DIR.combine loadfilenameERP '.mat'])
                        
                        loadfilenameSPG = [subID '_' val '_TW_' num2str(length(SPG.TW)) '_SPG_' num2str(SPG.TW(iTW))];
                        load([DIR.SPG loadfilenameSPG '.mat'],['chan' num2str(iChan)]);
                        eval(['tmpSPG = chan' num2str(iChan) ';']);
                        
                        [allTmpChan(iChan2save).tmpSPG,allTmpChan(iChan2save).allERP,EXP] = getSeparateConditions_IowaLocalizer(subID,tmpSPG,allERP,EXP);
                        
                    case 'CFS'
                        loadfilename = ['cleanTrials_' num2str(iChan) '_' subID SUB.ext];
                        load([DIR.clean '/' loadfilename '.mat'],'removedData');
                        
                        allERP{1} = squeeze(removedData(:,:,1));%interval 1
                        allERP{2} = squeeze(removedData(:,:,2));%interval 2
                        loadfilenameSPG = [subID '_' val '_TW_' num2str(length(SPG.TW)) '_SPG_' num2str(SPG.TW(iTW)) ];
                        load([DIR.SPG loadfilenameSPG '.mat']);
                        
                        eval(['tmpSPG = chan' num2str(iChan) ';']);
                        
                        [allTmpChan(iChan2save).tmpSPG,allTmpChan(iChan2save).allERP,EXP] = getSeparateConditions_IowaCFS(subID,tmpSPG,allERP,EXP,iChan);
                        
                    case 'BM_4S'
                        loadfilenameERP =  [subID '_' num2str(length(SUB.vSession)) '_sessions_' val '_t(' SUB.ext ')'];
                        load([DIR.combine loadfilenameERP '.mat'])
                        
                        loadfilenameSPG = [subID '_' val '_TW_' num2str(length(SPG.TW)) '_SPG_' num2str(SPG.TW(iTW)) ];
                        load([DIR.SPG loadfilenameSPG '.mat'],['chan' num2str(iChan)]);
                        eval(['tmpSPG = chan' num2str(iChan) ';']);
                        [allTmpChan(iChan2save).tmpSPG,allTmpChan(iChan2save).allERP,EXP] = getSeparateConditions_IowaBM(subID,tmpSPG,allERP,EXP);
                        
                end
                
                for iCategory = 1:EXP.nCond
                    nTrialPerClass(iCategory) = size(allTmpChan(iChan2save).allERP{iCategory},1);
                end
                if min(nTrialPerClass)<4
                    warning('not enought trials')
                    return
                end

            end
            
            
            for itt = 1:length(DEC.allTimes2decode)
                disp(['iTime=' num2str(itt)])
                for iff = 1:length(DEC.allFreq2decode)
                    disp(['iFreq=' num2str(iff)])
                    getDecode_dimTimeFreq_Iowa
                    
                    if sum(squeeze(finishFile(iTW,DEC.vDim,itt,iff))) == length(DEC.vDim)
                        continue
                    end
                    
                    
                    clear tmpData allData
                    for iChan = 1:length(allTmpChan)
                        clear tmpSPG allERP
                        disp(['prepare chan ' num2str(iChan)])
                        tmpSPG = allTmpChan(iChan).tmpSPG;
                        allERP = allTmpChan(iChan).allERP;
                        [data trialLabel times2downsample freq DEC] = prepareDecode_eachElectrode_TW_Iowa(tmpSPG,allERP,SUB,SPG,DEC,EXP,iTW);
                        %%
                        %                             if DEC.randomTrialSelection
                        %                                 switch DEC.multipleTimeWindow
                        %                                     case 1
                        %                                         tmpData.phaseAllChan(iChan2save,:,:,:,:)        = data.phase(:,:,:,trials2use);
                        %                                         tmpData.powerAllChan(iChan2save,:,:,:,:)        = data.power(:,:,:,trials2use);
                        %                                         tmpData.logPowerAllChan(iChan2save,:,:,:,:)     = data.logPower(:,:,:,trials2use);
                        %                                         tmpData.logPowerPlus1AllChan(iChan2save,:,:,:,:) = data.logPowerPlus1(:,:,:,trials2use);
                        %                                         tmpData.fftAllChan(iChan2save,:,:,:,:)          = data.fft(:,:,:,trials2use);
                        %                                         tmpData.erpAllChan(iChan2save,:,:,:,:)          = data.erp(:,:,:,trials2use);
                        %                                     case 0
                        %                                         tmpData.phaseAllChan(iChan2save,:,:,:)          = data.phase(:,:,trials2use);
                        %                                         tmpData.powerAllChan(iChan2save,:,:,:)          = data.power(:,:,trials2use);
                        %                                         tmpData.logPowerAllChan(iChan2save,:,:,:)       = data.logPower(:,:,trials2use);
                        %                                         tmpData.logPowerPlus1AllChan(iChan2save,:,:,:)  = data.logPowerPlus1(:,:,trials2use);
                        %                                         tmpData.fftAllChan(iChan2save,:,:,:)            = data.fft(:,:,trials2use);
                        %                                         tmpData.erpAllChan(iChan2save,:,:,:)            = data.erp(:,:,trials2use);
                        %                                 end
                        %                             else
                        allData.phase(iChan,:,:,:)          = data.phase;
                        allData.power(iChan,:,:,:)          = data.power;
                        allData.erp(iChan,:,:,:)            = data.erp;
                        
                        allData.powerNorm(iChan,:,:,:)            = data.powerNorm;
                        
                        %                             end
                        clear data
                    end
                    
                    for iDim = DEC.vDim
                        getDecode_dimTimeFreq_Iowa
                        clear data
                        switch DEC.saveCategory
                            case 'phase'
                                data.phase = allData.phase;
                            case 'power'
                                data.power = allData.power;
                            case 'powerNorm'
                                data.powerNorm = allData.powerNorm;
                            case 'erp'
                                data.erp = allData.erp;
                            otherwise
                                data = allData;
                        end
                        
%                         decode(savefilename{iTW,iDim,itt,iff},data,trialLabel,DIR.decode,times2downsample,freq,DEC,EXP.nCond)
                        decodeAll(DEC,data,trialLabel,savefilename{iTW,iDim,itt,iff},DIR.decode,times2downsample,freq)
                    end
                end
            end
        end
    end
end


end

