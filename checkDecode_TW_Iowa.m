function checkDecode_TW_Iowa(subID,SPG,DEC,EXP,DIR)

switch EXP.dataset
    case 'localizer'
        subSpecs_IowaLocalizer
    case 'CFS'
        subSpecs_IowaCFS
    case 'BM_4S'
        subSpecs_IowaBM
end

DIR.wrongfile = [DIR.base filesep 'wrongDecode' filesep];
if ~exist(DIR.wrongfile,'dir')
    mkdir(DIR.wrongfile)
end

PLOT.visible = 'off';

switch DEC.dimension
    case {'eachElectrodeEachTime','eachElectrodeEachFreq','eachElectrodeEachTimeEachFreq','eachElectrodeMultiTimeMultiFreq'}
        for iChan = arrayID
            val = ['li' num2str(iChan)];
            for iTW = DEC.nTW%:length(SPG.TW)
                for iDim = DEC.vDim
                    disp(['iChan: ' num2str(iChan) ', idim ' num2str(iDim)])
                    for itt = 1:length(DEC.allTimes2decode)
                        for iff = 1:length(DEC.allFreq2decode)
                            getDecode_dimTimeFreq_Iowa
                            
                            loadfilename    = ['dTF_' subID '_' EXP.cond '_' val '_' DEC.saveCategory '_' DEC.ext];
                            savefilename            = [loadfilename];
%                           savefilenameOld         = [loadfilenameOld];
                            if exist([DIR.decodeCheck filesep savefilename '.mat'],'file'), continue, end
%                             if exist([DIR.decodeCheck filesep savefilenameOld '.mat'],'file'),
%                                 movefile([DIR.decode savefilenameOld '.mat'],DIR.wrongfile)
%                                 continue,
%                             end
                            
                            checkDecodeStats_TW_Iowa(loadfilename, savefilename, DEC, SPG, DIR)
                        end
                    end
                end
            end
        end
        
    case {'multiElectrodeEachTime','multiElectrodeEachFreq','multiElectrodeEachTimeEachFreq','multiElectrodeMultiTimeMultiFreq'}
        for iGrid2decode = 1:DEC.nGrids2decode
            ChanIdx = getChannelLocation_Iowa(bCNT,SUB);
            
            switch DEC.grid2decode{iGrid2decode}
                case {'ventral','temporal','frontal','parietal','none','all'}
                    DEC.nStrips2decode=1;
                case 'allSeparate'
                    DEC.nStrips2decode=length(ChanIdx.labels);
                    
            end
            
            for iStrips = 1:DEC.nStrips2decode
                switch DEC.grid2decode{iGrid2decode}
                    case 'allSeparate'
                        labelID = ChanIdx.labels(iStrips).ID;
                    otherwise
                        labelID = 'notSep';
                end
                for iTW = DEC.nTW%:length(SPG.TW)
                    
                    for iDim = DEC.vDim
                        for itt = 1:length(DEC.allTimes2decode)
                            for iff = 1:length(DEC.allFreq2decode)
                                getDecode_dimTimeFreq_Iowa
                                
                                loadfilename    = ['dTF_' subID '_' EXP.cond '_' DEC.saveCategory '_' DEC.ext];
                                
                                savefilename        = [loadfilename];
%                                 savefilenameOld        = [loadfilenameOld '_' DEC.extOld];
%                                 
%                                 if exist([DIR.decodeCheck filesep savefilenameOld '.mat'],'file')
%                                     movefile([DIR.decodeCheck filesep savefilenameOld '.mat'],DIR.wrongfile)
%                                 end
                                
                                checkDecodeStats_TW_Iowa(loadfilename, savefilename, DEC, SPG, DIR)
                                
                            end
                        end
                    end
                end
            end
        end
end


%% load in the data
function checkDecodeStats_TW_Iowa(loadfilename, savefilename, DEC, SPG, DIR)

if ~exist([DIR.decode loadfilename '.mat'],'file')
    disp([loadfilename ' doesn''t exist'])
    return
end
pCorr = struct([]);
lastwarn('');
warning('on','all')

try
    checkD = load([DIR.decode loadfilename '.mat' ]);
catch
    [warnmsg, msgid] = lastwarn;
    if strcmp(msgid,'File may be corrupt')
        movefile([DIR.decode loadfilename '.mat'],DIR.wrongfile)
        if exist([DIR.decode savefilename],'file')
            keyboard
        end
    end
end

freq = checkD.freq;
tt = checkD.times2downsample;

try
    warnings.warnmsg  = checkD.DEC.warnmsg;
    warnings.msgid    = checkD.DEC.msgid;
    checkD.DEC = rmfield(checkD.DEC,'warnmsg');
    checkD.DEC = rmfield(checkD.DEC,'msgid');
    
catch me
    warnings.warnmsg  = 'NA';
    warnings.msgid    = 'NA';
end


%% sanity check
if 0
    figure(1),clf
    plot(times2downsample,zmcorrTest,'r');
    hold on;
    plot(times2downsample,zmcorrTrain);
    xlabel('t');
    ylabel('a''');
    
    figure(2),clf
    plot(times2downsample,zmcorrTestPerm,'r');
    hold on;
    plot(times2downsample,zmcorrTrainPerm);
    xlabel('t');
    ylabel('a''');
end

switch DEC.dimension
    case {'eachElectrodeEachTime','multiElectrodeEachTime','eachElectrodeEachFreq','multiElectrodeEachFreq'}
        pMeanTestCorr.TF     = squeeze(mean(checkD.R.zmcorrTest,2));
        pMeanTrainCorr.TF    = squeeze(mean(checkD.R.zmcorrTrain,2));
        if DEC.permute
            pMeanTestCorrPerm.TF     = squeeze(mean(checkD.Rperm.zmcorrTest,2));
            pMeanTrainCorrPerm.TF    = squeeze(mean(checkD.Rperm.zmcorrTrain,2));
        end
    case {'eachElectrodeEachTimeEachFreq','multiElectrodeEachTimeEachFreq'}
        pMeanTestCorr.TF     = squeeze(mean(checkD.R.zmcorrTest,3));
        pMeanTrainCorr.TF    = squeeze(mean(checkD.R.zmcorrTrain,3));
        if DEC.permute
            pMeanTestCorrPerm.TF     = squeeze(mean(checkD.Rperm.zmcorrTest,3));
            pMeanTrainCorrPerm.TF    = squeeze(mean(checkD.Rperm.zmcorrTrain,3));
        end
    case {'multiElectrodeMultiTimeMultiFreq','eachElectrodeMultiTimeMultiFreq'}
        pMeanTestCorr.TF     = checkD.R.zmcorrTest;
        pMeanTrainCorr.TF    = checkD.R.zmcorrTrain;
        if DEC.permute
            pMeanTestCorrPerm.TF     = squeeze(mean(checkD.Rperm.zmcorrTest,2));
            pMeanTrainCorrPerm.TF    = squeeze(mean(checkD.Rperm.zmcorrTrain,2));
        end
        
end




%% statistical test
%% hist pReal against pPerm (percentile score)
if DEC.statsCheckDecode
    %     for iDim = DEC.vDim
    
    if DEC.permute;
        switch DEC.dimension
            case {'eachElectrodeEachTime','multiElectrodeEachTime'}
                for iTime = 1:length(tt)
                    pPerm2test = sort([squeeze(pMeanTestCorrPerm.TF(iTime,:)) squeeze(pMeanTestCorr.TF(iTime))])';
                    [observedIdx,~] = find(pPerm2test==squeeze(pMeanTestCorr.TF(iTime)));
                    pDecode(iTime) = 1-mean(observedIdx)/length(pPerm2test);
                    %                 keyboard
                    %% sanity check
                    if 0
                        figure(1000),clf
%                         set(gcf,'visible',PLOT.visible)
                        histfit(pPerm2test)
                        hold on
                        [confidence] = prctile(pPerm2test,[2.5 97.5]);
                        hold on
                        plot(confidence(1)*[1 1],ylim,'--g','lineWidth',2)
                        plot(confidence(2)*[1 1],ylim,'--g','lineWidth',2)
                        
                        plot(pMeanTestCorr.TF(iTime)*[1 1],ylim,'r','lineWidth',2)
                        hold off
                    end
                end
                FDRCorr2use = FDR(squeeze(pDecode),DEC.FDR/2);
                if ~isempty(FDRCorr2use)
                    FDRperm = FDRCorr2use;
                else
                    FDRperm = NaN;
                end
                pCorr(1).pCorr = find(squeeze(pDecode) <= FDRperm);
            case {'eachElectrodeEachFreq','multiElectrodeEachFreq'}
                for iFreq = 1:length(freq)
                    pPerm2test = sort([squeeze(pMeanTestCorrPerm.TF(iFreq,:)) squeeze(pMeanTestCorr.TF(iFreq))])';
                    [observedIdx,~] = find(pPerm2test==squeeze(pMeanTestCorr.TF(iFreq)));
                    pDecode(iFreq) = 1-mean(observedIdx)/length(pPerm2test);
                    %                 keyboard
                end
                FDRCorr2use = FDR(squeeze(pDecode),DEC.FDR/2);
                if ~isempty(FDRCorr2use)
                    FDRperm = FDRCorr2use;
                else
                    FDRperm = NaN;
                end
                pCorr(1).pCorr = find(squeeze(pDecode) <= FDRperm);
            case {'eachElectrodeEachTimeEachFreq','multiElectrodeEachTimeEachFreq'}
                for iTime = 1:length(tt)
                    for iFreq = 1:length(freq)
                        pPerm2test = sort([squeeze(pMeanTestCorrPerm.TF(iTime,iFreq,:))' squeeze(pMeanTestCorr.TF(iTime,iFreq))])';
                        [observedIdx,~] = find(pPerm2test==squeeze(pMeanTestCorr.TF(iTime,iFreq)));
                        pDecode(iTime,iFreq) = 1-mean(observedIdx)/length(pPerm2test);
                        %                 keyboard
                    end
                end
                FDRCorr2use = FDR(squeeze(pDecode),DEC.FDR/2);
                if ~isempty(FDRCorr2use)
                    FDRperm = FDRCorr2use;
                else
                    FDRperm = NaN;
                end
                pCorr(1).pCorr = find(squeeze(pDecode) <= FDRperm);
            case {'eachElectrodeMultiTimeMultiFreq','multiElectrodeMultiTimeMultiFreq'}
                pPerm2test = sort([squeeze(pMeanTestCorrPerm.TF)' squeeze(pMeanTestCorr.TF)])';
                [observedIdx,~] = find(pPerm2test==squeeze(pMeanTestCorr.TF));
                pDecode = 1-mean(observedIdx)/length(pPerm2test);
                        %                 keyboard
                FDRCorr2use = FDR(squeeze(pDecode),DEC.FDR/2);
                if ~isempty(FDRCorr2use)
                    FDRperm = FDRCorr2use;
                else
                    FDRperm = NaN;
                end
                pCorr(1).pCorr = find(squeeze(pDecode) <= FDRperm);

        end
    else
        if 0
            for iTime = 1:length(times2downsample)
                [h(iTW,iTTW,iTime) pDecode(iTW,iTTW,iTime)] = ttest(squeeze(pMeanTestCorr.TF(iTime)),1/trialTypes);
                
            end
            FDRCorr2use = FDR(squeeze(pDecode(iTW,iTTW,:)),DEC.FDR);
            
            if ~isempty(FDRCorr2use)
                FDRperm = FDRCorr2use;
            else
                FDRperm = NaN;
            end
            pCorr.pCorr = find(squeeze(pDecode(iTW,iTTW,:)) <= FDRperm);
        end
    end
    
else
    pCorr = [];
end

try
    if DEC.permute
        save([DIR.decodeCheck savefilename '.mat'],'pMeanTestCorr','pMeanTestCorrPerm','pMeanTrainCorr','pMeanTrainCorrPerm','pCorr','FDRperm','tt','freq','DEC','warnings')
    else
        save([DIR.decodeCheck savefilename '.mat'],'pMeanTestCorr','pMeanTrainCorr','pCorr','tt','freq','DEC','warnings')
    end
catch me
    disp(['could not save ' savefilename])
end
% end

if isdir('/gpfs/M2Home/projects/Monash052/jochem/')
    copyToKani(DIR.decodeCheck,[savefilename '.mat'])
end

if isdir('/gpfs/M1Scratch/Monash052/')
    copyToKani_M2(DIR.decodeCheck,[savefilename '.mat'])
end

%%

