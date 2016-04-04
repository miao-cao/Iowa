function decode_allChan_TW_Iowa(subID,DEC,SPG,EXP)

switch EXP.dataset
    case 'localizer'
        subSpecs_IowaLocalizer
    case 'CFS'
        subSpecs_IowaCFS
    case 'BM'
        subSpecs_IowaBM
end

DIR.wrongfile = [DIR.base filesep 'wrongDecodeERP' filesep];
if ~exist(DIR.wrongfile,'dir')
    mkdir(DIR.wrongfile)
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
            

for iGrid2decode = 1:length(DEC.grid2decode)
    disp(['decoding ' DEC.grid2decode{iGrid2decode}]);
    %%
    ChanIdx = getChannelLocation_Iowa(bCNT,cntID);
    switch DEC.separateStrips
        case 0
            if strcmpi(subID,'154') % && ~isfield(EXP,'cond')
                % 154 does not have ventral for CFS, only 3 chan
                return
            end
            
            switch DEC.channels2decode
                case 'bipolar'
                    switch DEC.independentChanDir
                        case 'horizontal'
                            arrayID = ChanIdx.horizontal;
                        case 'vertical'
                            arrayID = ChanIdx.vertical;
                    end
                case 'unipolar'
                    arrayID = Channels2checkOriginal;
                case 'all'
                    error('makes no sense')
            end
            DEC.nStrips2decode=1;
            
        case 1
            %%
            switch DEC.grid2decode{iGrid2decode}
                case 'ventral'
                    switch DEC.channels2decode
                        case 'bipolar'
                            if DEC.independentChan
                                
                                switch DEC.independentChanDir
                                    case 'horizontal'
                                        arrayID = ChanIdx.ventralBipolarHor;
                                    case 'vertical'
                                        arrayID = ChanIdx.ventralBipolarVer;
                                end
                                if isempty(arrayID)
                                    switch DEC.independentChanDir
                                        case 'horizontal'
                                            arrayID = ChanIdx.ventralBipolarVer;
                                            DEC.independentChanDir2 = 'vertical';
                                        case 'vertical'
                                            arrayID = ChanIdx.ventralBipolarHor;
                                            DEC.independentChanDir2 = 'horizontal';
                                    end
                                end
                            else
                                arrayID = ChanIdx.ventralBipolar;
                            end
                        case 'unipolar'
                            arrayID = ChanIdx.ventral;
                    end
                    DEC.nStrips2decode=1;
                case 'temporal'
                    switch DEC.channels2decode
                        case 'bipolar'
                            if DEC.independentChan
                                switch DEC.independentChanDir
                                    case 'horizontal'
                                        arrayID = ChanIdx.tempBipolarHor;
                                    case 'vertical'
                                        arrayID = ChanIdx.tempBipolarVer;
                                end
                                if isempty(arrayID)
                                    switch DEC.independentChanDir
                                        case 'horizontal'
                                            arrayID = ChanIdx.tempBipolarVer;
                                            DEC.independentChanDir2 = 'vertical';
                                        case 'vertical'
                                            arrayID = ChanIdx.tempBipolarHor;
                                            DEC.independentChanDir2 = 'horizontal';
                                    end
                                    
                                end
                            else
                                arrayID = ChanIdx.tempBipolar;
                            end
                            
                        case 'unipolar'
                            arrayID = ChanIdx.temp;
                    end
                    
                    DEC.nStrips2decode=1;
                case 'none'
                    switch DEC.channels2decode
                        case 'bipolar'
                            arrayID = ChanIdx.noneBipolar;
                        case 'unipolar'
                            arrayID = ChanIdx.none;
                    end
                    DEC.nStrips2decode=1;
                case 'allSeparate'
                    DEC.nStrips2decode=length(ChanIdx.labels);
                    
                otherwise
                    DEC.nStrips2decode=1;
            end
            
            % when decoding grids, only use channels that have same number
            % of trials
    end
    %%
    for iStrips = (DEC.nStrips2decode):-1:1
        %         try
        switch DEC.grid2decode{iGrid2decode}
            case 'allSeparate'
                switch DEC.channels2decode
                    case 'bipolar'
                        arrayID = ChanIdx.labels(iStrips).bipolar;
                    case 'unipolar'
                        arrayID = ChanIdx.labels(iStrips).unipolar;
                end
                labelID = ChanIdx.labels(iStrips).ID;
            otherwise
                labelID = 'notSep';
        end
        
        switch subID
            case '154'
                switch DEC.grid2decode{iGrid2decode}
                    case 'temporal'
                        switch dataset
                            case 'CFS'
                                if ~(sum(ismember(arrayID,find(bCNT.sharedSessions))) == 0) && (sum(ismember(arrayID,find(bCNT.sharedSessions))) ~= length(arrayID))
                                    arrayID = arrayID(ismember(arrayID,find(bCNT.sharedSessions)));
                                end
                        end
                    case 'ventral'
                        if isfield(EXP,'cond')
                            
                            switch dataset
                                case 'CFS'
                                    if ~(sum(ismember(arrayID,find(bCNT.sharedSessions))) == 0) && (sum(ismember(arrayID,find(bCNT.sharedSessions))) ~= length(arrayID))
                                        arrayID(1:3) = []; %154a and 154b only share 3 channels in the ventral cortex. Here we use just the channels that aren't shared
                                    end
                                otherwise
                            end
                        else
                            continue
                        end
                        %                         case 'shared'
                        %                             arrayID = find(bCNT.sharedSessions);
                end
        end
        
        %% check if file already exists
        finishFile = zeros(DEC.nTW(length(DEC.nTW)),DEC.nTTW(length(DEC.nTTW)),DEC.vDim(length(DEC.vDim)),length(DEC.times2decodeAll),length(DEC.freq2decodeAllPower));
        
        for iTW = DEC.nTW
            if ~DEC.movingWindowSizes2use(iTW), continue, end
            switch DEC.dimension
                case 'allElectrodeEachTime'
                    nTTW2use = DEC.nTTW;
                    %                         nTTW2use = iTW;
                case {'allElectrodeEachFreq','allElectrodeEachTimeEachFreq'}
                    nTTW2use = iTW;
            end
            for iTTW = nTTW2use
                if iTTW < iTW, continue, end
                %                 DEC.vDim2use = DEC.vDim;
                for iDim = DEC.vDim
                    getDecode_dimTimeFreq_Iowa
                    
                    switch DEC.saveCategory
                        case 'phase'
                            nFreq2test = length(DEC.freq2decodeAllPhase);
                        case {'power','logPower'}
                            nFreq2test = length(DEC.freq2decodeAllPower);
                        case 'logPowerAndPhase'
                            nFreq2test = length(DEC.freq2decodeAllPhase)*length(DEC.freq2decodeAllPower);
                        otherwise
                            nFreq2test = 1;
                    end
                    
                    
                    for itt = 1:length(DEC.times2decodeAll)
                        for iff = 1:nFreq2test
                            getDecode_dimTimeFreq_Iowa
                            getDecodeDir_Iowa
                            DEC.nTimeWindow = SPG.TW(iTTW)/SPG.TW(iTW);
                            switch dataset
                                case 'localizer'
                                    savefilenameOld{iTW,iTTW,iDim,itt,iff} = [subID '_' DEC.decodeSPG '_' EXP.cond '_' DEC.saveCategory '_'...
                                        DEC.channels2decode '_randTrials_'  num2str(DEC.randomTrialSelection) '_nRandTrials_' num2str(DEC.nTrials2select) '_' 'sepGrid_' num2str(DEC.separateStrips) '_' DEC.grid2decode{iGrid2decode} '_label_' labelID  '_indChan(' num2str(DEC.independentChan) '):' DEC.independentChanDir ...
                                        '_TW=' num2str(SPG.TW(iTW)) '_TTW=' num2str(SPG.TW(iTTW)) '_nTW=' num2str(DEC.nTimeWindow) ];
                                    savefilename{iTW,iTTW,iDim,itt,iff} = [subID '_' DEC.decodeSPG '_' EXP.cond '_' DEC.saveCategory '_'...
                                        DEC.channels2decode '_randTrials_'  num2str(DEC.randomTrialSelection) '_nRandTrials_' num2str(DEC.nTrials2select) '_' 'sepGrid_' num2str(DEC.separateStrips) '_' DEC.grid2decode{iGrid2decode} '_label_' labelID  '_indChan(' num2str(DEC.independentChan) '):' DEC.independentChanDir ...
                                        '_TW=' num2str(SPG.TW(iTW)) '_TTW=' num2str(SPG.TW(iTTW)) '_nTW=' num2str(DEC.nTimeWindow) '_times(' num2str(DEC.times2decode(1)) '_' num2str(DEC.times2decode(2)) ')'];
                                case 'CFS'
                                    savefilenameOld{iTW,iTTW,iDim,itt,iff} = [subID '_' DEC.decodeSPG '_' EXP.cond '_' DEC.saveCategory '_'...
                                        DEC.channels2decode '_randTrials_'  num2str(DEC.randomTrialSelection) '_nRandTrials_' num2str(DEC.nTrials2select) '_' 'sepGrid_' num2str(DEC.separateStrips) '_' DEC.grid2decode{iGrid2decode} '_label_' labelID  '_indChan(' num2str(DEC.independentChan) '):' DEC.independentChanDir ...
                                        '_TW=' num2str(SPG.TW(iTW)) '_TTW=' num2str(SPG.TW(iTTW)) '_nTW=' num2str(DEC.nTimeWindow) ];
                                    
                                    savefilename{iTW,iTTW,iDim,itt,iff} = [subID '_' DEC.decodeSPG '_' EXP.cond '_' DEC.saveCategory '_'...
                                        DEC.channels2decode '_randTrials_'  num2str(DEC.randomTrialSelection) '_nRandTrials_' num2str(DEC.nTrials2select) '_' 'sepGrid_' num2str(DEC.separateStrips) '_' DEC.grid2decode{iGrid2decode} '_label_' labelID  '_indChan(' num2str(DEC.independentChan) '):' DEC.independentChanDir ...
                                        '_TW=' num2str(SPG.TW(iTW)) '_TTW=' num2str(SPG.TW(iTTW)) '_nTW=' num2str(DEC.nTimeWindow) '_times(' num2str(DEC.times2decode(1)) '_' num2str(DEC.times2decode(2)) ')'];
                                    
                                    if strcmpi(DEC.saveCategory,'erp')
                                        A = dir([DIR.decode 'dTF_' savefilename{iTW,iTTW,iDim,itt,iff} '_' DEC.ext '.mat']);
                                        if ~isempty(A)
                                            if ~month(A(1).date)>=6 && ~day(A(1).date)>=26
                                                movefile([DIR.decode A.name],DIR.wrongfile)
                                                if exist([DIR.decode 'dTF_' savefilename{iTW,iTTW,iDim,itt,iff} '_' DEC.ext '.mat' ],'file')
                                                    keyboard
                                                end
                                            end
                                        end
                                    end
                                    
                                case 'BM'
                                    savefilenameOld{iTW,iTTW,iDim,itt,iff} = [subID '_' DEC.decode '_' EXP.cond '_' DEC.saveCategory '_'...
                                        DEC.channels2decode '_randTrials_'  num2str(DEC.randomTrialSelection) '_nRandTrials_' num2str(DEC.nTrials2select) '_' 'sepGrid_' num2str(DEC.separateStrips) '_' DEC.grid2decode{iGrid2decode} '_label_' labelID  '_indChan(' num2str(DEC.independentChan) '):' DEC.independentChanDir ...
                                        '_TW=' num2str(SPG.TW(iTW)) '_TTW=' num2str(SPG.TW(iTTW)) '_nTW=' num2str(DEC.nTimeWindow) ];
                                    savefilename{iTW,iTTW,iDim,itt,iff} = [subID '_' DEC.decode '_' EXP.cond '_' DEC.saveCategory '_'...
                                        DEC.channels2decode '_randTrials_'  num2str(DEC.randomTrialSelection) '_nRandTrials_' num2str(DEC.nTrials2select) '_' 'sepGrid_' num2str(DEC.separateStrips) '_' DEC.grid2decode{iGrid2decode} '_label_' labelID  '_indChan(' num2str(DEC.independentChan) '):' DEC.independentChanDir ...
                                        '_TW=' num2str(SPG.TW(iTW)) '_TTW=' num2str(SPG.TW(iTTW)) '_nTW=' num2str(DEC.nTimeWindow) '_times(' num2str(DEC.times2decode(1)) '_' num2str(DEC.times2decode(2)) ')'];
                            end
                            
                            
                            
                            
                            if exist([DIR.decode 'dTF_' savefilenameOld{iTW,iTTW,iDim,itt,iff} '_' DEC.ext '.mat' ],'file'), disp(['OLD ' savefilenameOld{iTW,iTTW,iDim,itt,iff}]),
                                
                                %                                 continue
                                %                                 elseif exist([DIR.decode 'dTF_' savefilenameOld{iDim} '_' DEC.ext '.mat' ],'file')
                                copyfile([DIR.decode 'dTF_' savefilenameOld{iTW,iTTW,iDim,itt,iff} '_' DEC.ext '.mat' ],[DIR.decode 'dTF_' savefilename{iTW,iTTW,iDim,itt,iff} '_' DEC.ext '.mat' ]);
                                %                                 DEC.vDim2use(DEC.vDim==iDim) = 999;
                                finishFile(iTW,iTTW,iDim,itt,iff) = 1;
                                if exist([DIR.decode 'dTF_' savefilename{iTW,iTTW,iDim,itt,iff} '_' DEC.ext '.mat' ],'file');
                                    finishFile(iTW,iTTW,iDim,itt,iff) = 1;

                                    delete([DIR.decode 'dTF_' savefilenameOld{iTW,iTTW,iDim,itt,iff} '_' DEC.ext '.mat' ]);
                                    continue
                                end
                                %
                                %                         elseif exist([DIR.decodeSPGOLD filesep 'dTF_' savefilename{iTW,iTTW,iDim} '_' DEC.ext '.mat' ],'file')
                                %                             disp(['old ' savefilename{iTW,iTTW,iDim}])
                                %
                                %                             copyfile([DIR.decodeSPGOLD 'dTF_' savefilename{iTW,iTTW,iDim} '_' DEC.ext '.mat' ],[DIR.decode 'dTF_' savefilename{iTW,iTTW,iDim} '_' DEC.ext '.mat' ]);
                                %                             finishFile(iTW,iTTW,iDim) = 1;
                                %                             if exist([DIR.decode 'dTF_' savefilename{iTW,iTTW,iDim} '_' DEC.ext '.mat' ],'file');
                                %                                 delete([DIR.decodeSPGOLD 'dTF_' savefilename{iTW,iTTW,iDim} '_' DEC.ext '.mat' ]);
                                %                                 continue
                                %                             end
                            elseif exist([DIR.decode 'dTF_' savefilename{iTW,iTTW,iDim,itt,iff} '_' DEC.ext '.mat' ],'file');
                                finishFile(iTW,iTTW,iDim,itt,iff) = 1;
                                %                         DEC.vDim2use(DEC.vDim==iDim) = 999;
                                %                        continue
                            end
                            
                            if strcmpi(DEC.saveCategory,'logPower')
                                A = dir([DIR.decode 'dTF_' savefilename{iTW,iTTW,iDim,itt,iff} '_' DEC.ext '.mat']);
                                if ~isempty(A)
                                    if (month(A(1).date)<=7 && ~(day(A(1).date)>=24)) || (day(A(1).date)==24 && hour(A(1).date)<16)
                                        movefile([DIR.decode A.name],DIR.wrongfile)
                                        if exist([DIR.decode 'dTF_' savefilename{iTW,iTTW,iDim,itt,iff} '_' DEC.ext '.mat' ],'file')
                                            keyboard
                                        end
                                    end
                                end
                            end
                            
                        end
                    end
                end
            end
        end
        
        %% skip grid/strip if already exists
        switch DEC.dimension
            case 'allElectrodeEachTime'
                %                 if sum(sum(sum(finishFile(DEC.nTW,DEC.nTTW,DEC.vDim)))) == ((length(DEC.nTW)*length(DEC.nTTW)*length(DEC.vDim))-factorial(length(DEC.nTW)))
                if sum(sum(sum(finishFile(DEC.nTW,DEC.nTTW,DEC.vDim,:,:)))) == (factorial(length(DEC.nTW)) * length(DEC.vDim)) * length(DEC.times2decodeAll) * length(DEC.freq2decodeAllPower)
                    continue
                end
            case {'allElectrodeEachTimeEachFreq','allElectrodeEachFreq'}
                if sum(sum(sum(finishFile(DEC.nTW,DEC.nTTW,DEC.vDim,:,:)))) == (length(DEC.nTW)*length(DEC.vDim)) * length(DEC.times2decodeAll) * length(DEC.freq2decodeAllPower)
                    continue
                end
        end
        
        %% decode
        iTW2use=0;
        for iTW = DEC.nTW
            if ~DEC.movingWindowSizes2use(iTW), continue, end
            
            iTW2use=iTW2use+1;
            switch DEC.dimension
                case 'allElectrodeEachTime'
                    if sum(sum(sum(squeeze(finishFile(iTW,:,:,:,:))))) == ((length(DEC.nTTW)-(iTW2use-1))*length(DEC.vDim)) * length(DEC.times2decodeAll) * length(DEC.freq2decodeAllPower)
                        continue
                    end
                case {'allElectrodeEachTimeEachFreq','allElectrodeEachFreq'}
                    if sum(sum(squeeze(finishFile(iTW,iTW,:,:,:)))) == (length(DEC.vDim)) * length(DEC.times2decodeAll) * length(DEC.freq2decodeAllPower)
                        continue
                    end
            end
            
            disp(num2str(SPG.TW(iTW)))
            switch DEC.dimension
                case 'allElectrodeEachTime'
                    nTTW2use = DEC.nTTW;
                    %                         nTTW2use = iTW;
                case {'allElectrodeEachTimeEachFreq','allElectrodeEachFreq'}
                    nTTW2use = iTW;
            end
            clear allTmpChan
            iChan2save = 0;
            for iChan = arrayID
                iChan2save = iChan2save+1;
                disp(['loading chan ' num2str(iChan)]);
                clear tmpSPG allERP chan* tempChan
                
                val = ['li' num2str(iChan)];
                
                switch dataset
                    case 'localizer'
                        
                        loadfilenameERP = [subID '_' num2str(nSession) '_' StimCategory '_sessions_' val ':t_' ext];
                        load([DIR.combine loadfilenameERP '.mat'])
                        [~,~,~,allERP] = getSeparateConditionsIowaFaceLocalizer(subID,[],EXP,allERP);
                        
                        loadfilenameSPG = [subID '_' val '_TW_' num2str(length(SPG.TW)) '_SPG_' num2str(SPG.TW(iTW)) '_' DEC.decode];
                        load([DIR.SPG loadfilenameSPG '.mat'],['chan' num2str(iChan)]);
                        eval(['tmpSPG = chan' num2str(iChan) ';']);
                        if length(tmpSPG) == iTW
                            tmpSPG = tmpSPG(iTW).SPG;
                        end
                        [tmpSPG,trialTypes,~,~] = getSeparateConditionsIowaFaceLocalizer(subID,tmpSPG,EXP,[]);
                        
                        allTmpChan(iChan2save).allERP = allERP;
                        allTmpChan(iChan2save).tmpSPG = tmpSPG;
                    case 'CFS'
                        loadfilename = ['cleanTrials_' num2str(iChan) '_' subID ext];
                        load([DIR.clean '/' loadfilename '.mat'],'removedData');
                        
                        allERP{1} = squeeze(removedData(:,:,1));%interval 1
                        allERP{2} = squeeze(removedData(:,:,2));%interval 2
                        loadfilenameSPG = [subID '_' val '_TW_' num2str(length(SPG.TW)) '_SPG_' num2str(SPG.TW(iTW)) '_' DEC.decodeSPG];
                        load([DIR.SPG loadfilenameSPG '.mat']);
                        
                        eval(['tmpSPG = chan' num2str(iChan) ';']);
                        
                        getSeparateConditionsIowaCFS
                        
                        for iCond = 1:length(tmpSPG)
                            allTmpChan(iChan2save).allERP{iCond} = tmpSPG(iCond).erp;
                        end
                        allTmpChan(iChan2save).tmpSPG = tmpSPG;
                    case 'BM'
                        loadfilenameERP =  [subID '_' num2str(length(SUB.session)) '_sessions_' val ':t_' ext];
                        load([DIR.combine loadfilenameERP '.mat'])
                        [~,~,~,allERP] = getSeparateConditions_IowaBM(subID,[],EXP,allERP);
                        
                        loadfilenameSPG = [subID '_' val '_TW_' num2str(length(SPG.TW)) '_SPG_' num2str(SPG.TW(iTW)) '_' DEC.decode];
                        load([DIR.SPG loadfilenameSPG '.mat'],['chan' num2str(iChan)]);
                        eval(['tmpSPG = chan' num2str(iChan) ';']);
                        [tmpSPG,trialTypes,legendtxt, condERP] = getSeparateConditions_IowaBM(subID,tmpSPG,EXP,[]);
                        allTmpChan(iChan2save).allERP = allERP;
                        allTmpChan(iChan2save).tmpSPG = tmpSPG;

                end
            end
            
            for iTTW = nTTW2use
                if iTTW < iTW, continue, end

                for itt = 1:length(DEC.times2decodeAll)
                    disp(['iTime=' num2str(itt)])
                    for iff = 1:length(DEC.freq2decodeAllPower)
                        disp(['iFreq=' num2str(iff)])
                        getDecode_dimTimeFreq_Iowa
                        
                        if sum(squeeze(finishFile(iTW,iTTW,DEC.vDim,itt,iff))) == length(DEC.vDim)
                            continue
                        end
                        
                        
                        clear tmpData
                        for iChan = 1:length(allTmpChan)
                            clear tmpSPG allERP
                            disp(['prepare chan ' num2str(iChan)])
                            tmpSPG = allTmpChan(iChan).tmpSPG;
                            allERP = allTmpChan(iChan).allERP;
                            [data trialLabel times2downsample freq DEC] = prepareDecode_eachElectrodeEachTime_TW_Iowa(tmpSPG,allERP,SPG,DEC,fs,tRange,iTW,iTTW,trialTypes);
                            
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
                            switch DEC.multipleTimeWindow
                                case 1
                                    tmpData.phaseAllChan(iChan,:,:,:,:)        = data.phase;
                                    tmpData.powerAllChan(iChan,:,:,:,:)        = data.power;
                                    tmpData.logPowerAllChan(iChan,:,:,:,:)     = data.logPower;
                                    tmpData.logPowerPlus1AllChan(iChan,:,:,:,:) = data.logPowerPlus1;
                                    tmpData.fftAllChan(iChan,:,:,:,:)          = data.fft;
                                    tmpData.erpAllChan(iChan,:,:,:,:)          = data.erp;
                                case 0
                                    tmpData.phaseAllChan(iChan,:,:,:)          = data.phase;
                                    tmpData.powerAllChan(iChan,:,:,:)          = data.power;
                                    tmpData.logPowerAllChan(iChan,:,:,:)       = data.logPower;
                                    tmpData.logPowerPlus1AllChan(iChan,:,:,:)  = data.logPowerPlus1;
                                    tmpData.fftAllChan(iChan,:,:,:)            = data.fft;
                                    tmpData.erpAllChan(iChan,:,:,:)            = data.erp;
                            end
                            
                            %                             end
                            clear data
                        end
                        
                        allData.phase          = tmpData.phaseAllChan;
                        allData.power          = tmpData.powerAllChan;
                        allData.logPower       = tmpData.logPowerAllChan;
                        allData.logPowerPlus1  = tmpData.logPowerPlus1AllChan;
                        allData.fft            = tmpData.fftAllChan;
                        allData.erp            = tmpData.erpAllChan;
                        
                        if DEC.randomTrialSelection
                            trialLabel = tmpTrialLabel;
                        end
                        
                        clear tmpData
                        for iDim = DEC.vDim
                            getDecode_dimTimeFreq_Iowa
                            getDecodeDir_Iowa
                            clear data
                            switch DEC.saveCategory
                                case 'phase'
                                    data.phase = allData.phase;
                                case 'power'
                                    data.power = allData.power;
                                case 'logPower'
                                    data.logPower = allData.logPower;
                                case 'logPowerPlus1'
                                    data.logPowerPlus1 = allData.logPowerPlus1;
                                case 'fft'
                                    data.fft = allData.fft;
                                case 'erp'
                                    data.erp = allData.erp;
                                case 'powerAndPhase'
                                    data.phase = allData.phase;
                                    data.power = allData.power;
                                case 'logPowerAndPhase'
                                    data.phase = allData.phase;
                                    data.logPower = allData.logPower;
                                case 'logPowerPlus1AndPhase'
                                    data.phase = allData.phase;
                                    data.logPowerPlus1 = allData.logPowerPlus1;
                                otherwise
                                    data = allData;
                            end
                            DEC.nTimeWindow = SPG.TW(iTTW)/SPG.TW(iTW);
                                                        
                            decode(savefilename{iTW,iTTW,iDim,itt,iff},data,trialLabel,DIR.decode,times2downsample,freq,DEC,trialTypes)
                        end
                        %                     catch me
                        %                     end
                    end
                end
                %             end
            end
        end
    end
    
    
end
end

