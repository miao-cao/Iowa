function plotDecode_TW_Iowa(sub2analyse,SPG,DEC,EXP,DIR,PLOT,arrayID)
% script that plots all decoding results. Both for single channels,
% multiple channels and across subjects.
%
% plots decoding results for eachTime, eachFreq, eachTimeEachFreq,
% multiTimeMultiFreq and a figure combining eachTime, eachFreq and
% eachTimeEachFreq
%
% INPUT:    
% sub2analyse: single subject ID or cell with multiple subject IDs
% SPG: structure with spectogram settings, see getSPGsettings_Iowa.m
% DEC: structure with decode settings, see getDecodeSettings_Iowa.m
% EXP: structure with experiment/dataset specific settings
% DIR: structure with all used directories
% PLOT: stucture with PLOT settings, if undefined, some are defined in this
% script
% arrayID: vector with channel numbers
%
% OUTPUT
% decode strategy specific figures
%
% NOTE
% This code is written in Matlab 2014b, it contains some features that
% won't work in earlier versions.


% check if single or multiple subjects
if iscell(sub2analyse)
    subID = sub2analyse{1};
    nSub = length(sub2analyse);
else
    subID = sub2analyse;
    nSub = 1;
end

% load dataset specific subject info
switch EXP.dataset
    case 'localizer'
        subSpecs_IowaLocalizer
    case 'CFS'
        subSpecs_IowaCFS
    case 'BM_4S'
        subSpecs_IowaBM
end

% select figure directory
if nSub>1
    DIR.figBase2use = [DIR.data 'multiSub' filesep 'figures'];
else
    DIR.figBase2use = DIR.figBase;
end

% set PLOT settings
% fill in the color scale you want to use. You can also provide one value
% (upper or lower) and make the other a NaN. The undefined cScale value will be
% determined based on the minimum/maximum values in the plot.
switch EXP.nCond
    case 2 
        if isempty(PLOT.YLIM)
            PLOT.YLIM = [0.3 1];
        end
        if isempty(PLOT.cScale)
            PLOT.cScale = [0.5 1];
            PLOT.cScale = [0.5 NaN];
        end
    case 5
        if isempty(PLOT.cScale)
            PLOT.YLIM = [0.1 0.8];
        end
end


chanIdx = getChannelLocation_Iowa(bCNT,SUB);
EXP.chanIdx = chanIdx;

DIR.decodeExtSearchlight = ['SL_t(' num2str(DEC.searchlightTimeWin(1)) '_' num2str(DEC.searchlightTimeWin(2)) ')_f(' num2str(DEC.searchlightFreqWin(1)) '_' num2str(DEC.searchlightFreqWin(2)) ')'];
DIR.decodeExtRandChan = ['rChanSel_' num2str(DEC.randChanPercentage) 'p_' num2str(DEC.randChanCrossVal) 'cV'];
    
% define figure directory
if DEC.searchlight && DEC.permute
    DIR.fig = [DIR.figBase2use filesep 'decode' filesep EXP.cond filesep DEC.dimension filesep DIR.decodeExtSearchlight '_perm' filesep];    
elseif DEC.searchlight && ~DEC.permute
    DIR.fig = [DIR.figBase2use filesep 'decode' filesep EXP.cond filesep DEC.dimension filesep DIR.decodeExtSearchlight filesep];   
elseif ~DEC.searchlight && DEC.permute
    DIR.fig = [DIR.figBase2use filesep 'decode' filesep EXP.cond filesep DEC.dimension filesep 'perm' filesep];   
else
    DIR.fig = [DIR.figBase2use filesep 'decode' filesep EXP.cond filesep DEC.dimension filesep];
end

[~, eachDec] = grep(DEC.allDimension,'each');
[~, multiDec] = grep(DEC.allDimension,'multi');

if multiDec(DEC.iDim2use) && DEC.randChanSelection
    DIR.fig = [DIR.fig DIR.decodeExtRandChan filesep];
end    
if ~exist(DIR.fig,'dir')
    mkdir(DIR.fig)
end

%% define conditions 

val = ['li' num2str(SUB.chan_bip(1))];
switch EXP.dataset
    case 'localizer'
        loadfilenameERP = [subID '_' num2str(length(SUB.vSession)) '_' SUB.stimCat{SUB.vSession(1)} '_sessions_' val '_t(' SUB.ext ')'];
        load([DIR.combine loadfilenameERP '.mat'])
        [~,~,EXP] = getSeparateConditions_IowaLocalizer(subID,[],allERP,EXP);
    case 'CFS'
        loadfilename = ['cleanTrials_' num2str(SUB.chan_bip(1)) '_' subID SUB.ext];
        load([DIR.clean '/' loadfilename '.mat'],'removedData');
        allERP{1} = squeeze(removedData(:,:,1));%interval 1
        allERP{2} = squeeze(removedData(:,:,2));%interval 2
        [~,~,EXP] = getSeparateConditions_IowaCFS(subID,[],allERP,EXP,SUB.chan_bip(1));
    case 'BM_4S'
        loadfilenameERP =  [subID '_' num2str(length(SUB.vSession)) '_sessions_' val '_t(' SUB.ext ')'];
        load([DIR.combine loadfilenameERP '.mat'])
        [~,~,EXP] = getSeparateConditions_IowaBM(subID,[],allERP,EXP);
end


%% collect necessary decoding results
switch DEC.dimension
    case {'eachElectrodeEachTime','eachElectrodeEachFreq','eachElectrodeEachTimeEachFreq','eachElectrodeCombinePlot'}

        % select several decoding results for combined plot
        switch DEC.dimension
            case 'eachElectrodeCombinePlot'
                [~, tmp1] = grep(DEC.allDimension,'Each');
                [~, tmp2] = grep(DEC.allDimension,'multi');
                
                decDim2decode       = find((tmp1 & ~tmp2));
                DEC.dimensionTmp    = DEC.iDim2use;
            otherwise
                decDim2decode       = DEC.iDim2use;
                DEC.dimensionTmp    = DEC.iDim2use;
        end
        
        for iTW = DEC.nTW
            PLOT.iTW = iTW;
            for itt = 1:length(DEC.allTimes2decode)
                for iff = 1:length(DEC.allFreq2decode)
                    
                    for iChan = arrayID
                        SUB.iChan = iChan;
                        val = ['li' num2str(iChan)];
                        SUB.val = val;
                        clear TEST DATA
                        [~,SUB] = getChannelLocation_Iowa(bCNT,SUB);

%                         DATA = struct([]);
                        for iDim = DEC.vDim
                            disp(['iChan: ' num2str(iChan) ', idim ' num2str(iDim)])
                            for iDecDim = decDim2decode;
                                DEC.iDim2use = iDecDim;
                                [DEC] = getDecodeSettings_Iowa(subID,DEC,SPG,[],EXP.dataset);
                                
                                getDecode_dimTimeFreq_Iowa
                                loadfilename = ['dTF_' subID '_' EXP.cond '_' val '_' DEC.saveCategory '_' DEC.ext];
                                try
                                    tmpDATA1(1,1,iDim,iDecDim) = load([DIR.decodeCheck loadfilename '.mat']);
                                catch
                                    disp([loadfilename ' .... doesn''t exist'])

                                end
                            end
                        end
                        DEC.iDim2use = DEC.dimensionTmp;
                        [DEC] = getDecodeSettings_Iowa(subID,DEC,SPG,[],EXP.dataset);

                        savefilename = ['dTF_' subID '_' EXP.cond '_' val '_' DEC.ext];
                        if isempty(tmpDATA1)
                            continue
                        end
                        PLOTALLDECODE(sub2analyse,SUB,EXP,SPG,DEC,DIR,PLOT,tmpDATA1,savefilename)
                    end
                end
            end
        end
    case {'multiElectrodeEachTime','multiElectrodeEachFreq','multiElectrodeEachTimeEachFreq',...
            'multiElectrodeMultiTimeMultiFreq',...
            'multiElectrodeCombinePlot'}
        
        % select several decoding results for combined plot
        switch DEC.dimension
            case 'multiElectrodeCombinePlot'
                [~, tmp1] = grep(DEC.allDimension,'multi');
                [~, tmp2] = grep(DEC.allDimension,'Each');
                
                decDim2decode       = find((tmp1+tmp2)>1);
                DEC.dimensionTmp    = DEC.iDim2use;
                
                originalDecDim = 'multiElectrodeCombinePlot';
            otherwise
                decDim2decode       = DEC.iDim2use;
                DEC.dimensionTmp    = DEC.iDim2use;
                
                originalDecDim = DEC.dimension;
        end
        
        for iTW = DEC.nTW
            PLOT.iTW = iTW;
            for itt = 1:length(DEC.allTimes2decode)
               
                if ~isfield(DEC,'allFreq2decode')
                    DEC.allFreq2decode = DEC.allFreq2decodePhase;
                end
                for iff = 1:length(DEC.allFreq2decode)
%                     DATA = struct([]);
                    clear DATA
                    subData = zeros(nSub,length(DEC.grid2decode),length(DEC.vDim),length(decDim2decode));
                    for iSub = 1:nSub
                        if iscell(sub2analyse)
                            subID = sub2analyse{iSub};
                        end
                        switch EXP.dataset
                            case 'localizer'
                                subSpecs_IowaLocalizer
                            case 'CFS'
                                subSpecs_IowaCFS
                            case 'BM_4S'
                                subSpecs_IowaBM
                        end

                        for iGrid2decode = 1:length(DEC.grid2decode)
                            DEC.iDim2use = DEC.dimensionTmp;
                            [DEC] = getDecodeSettings_Iowa(subID,DEC,SPG,[],EXP.dataset);
                            ChanIdx = getChannelLocation_Iowa(bCNT,SUB);
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
                            
                            if isempty(arrayID)
                                disp(['skipping ' subID ' ' DEC.grid2decode{iGrid2decode}])
                                continue
                            end
                            %%

                            for iStrips = 1:DEC.nStrips2decode
                                switch DEC.grid2decode{iGrid2decode}
                                    case 'allSeparate'
                                        labelID = ChanIdx.labels(iStrips).ID;
                                    otherwise
                                        labelID = 'notSep';
                                end
                                SUB.labelID = labelID;
                                
                                for iDim = DEC.vDim
                                    
                                    
                                    for iDecDim = decDim2decode;
                                        DEC.iDim2use = iDecDim;
                                        [DEC] = getDecodeSettings_Iowa(subID,DEC,SPG,[],EXP.dataset);
                                        
                                        switch originalDecDim
                                            case 'multiElectrodeCombinePlot'
                                                if strcmpi(DEC.dimension,'multiElectrodeEachTime')
                                                    
                                                    if isfield(DEC,'allFreq2decodePhase') && isfield(DEC,'allFreq2decodePower')
                                                        
                                                        switch DEC.allSaveCategory{iDim}
                                                            case 'phase'
                                                                DEC.allFreq2decode = DEC.allFreq2decodePhase;
                                                            case 'power'
                                                                DEC.allFreq2decode = DEC.allFreq2decodePower;
                                                                
                                                        end
                                                    end
                                                end
                                        end
                                        
                                        getDecode_dimTimeFreq_Iowa
                                        
                                        loadfilename = ['dTF_' subID '_' EXP.cond '_' DEC.saveCategory '_' DEC.ext];
                                        try
                                            tmpDATA1(iSub,iGrid2decode,iDim,iDecDim) = load([DIR.decodeCheck loadfilename '.mat']);
                                            subData(iSub,iGrid2decode,iDim,iDecDim) = 1;
                                        catch
                                            disp([loadfilename ' .... doesn''t exist'])
                                        end
                                    end
                                end
                            end
                        end
                    end
                    
                    sub2use = 0;
                    for iSub = 1:nSub
                        subID = sub2analyse{iSub};
                        if sum(sum(sum(squeeze(subData(iSub,:,:,:)))))>=1
                            sub2use = sub2use+1;
                            DATA(sub2use,:,:,:) = tmpDATA1(iSub,:,:,:);
                        else
                            [~,idx]=grep(EXP.subReadyForAnalysis,subID);
                            EXP.subIdx(idx) = [];
                            EXP.subReadyForAnalysis(idx) = [];
                        end
                    end
                    iDim=1;
                    getDecode_dimTimeFreq_Iowa
                    DEC.iDim2use = DEC.dimensionTmp;
                    [DEC] = getDecodeSettings_Iowa(subID,DEC,SPG,[],EXP.dataset);
                    
                    if nSub>1
                        savefilename = ['dTF_' EXP.cond '_' DEC.ext];
                    else
                        savefilename = ['dTF_' subID '_' EXP.cond '_' DEC.ext];
                    end
                    
                    if ~exist('DATA','var')
                        return
                    end
                    switch DEC.dimension
                        case {'multiElectrodeEachTime','multiElectrodeEachFreq','multiElectrodeEachTimeEachFreq','multiElectrodeCombinePlot'}
                            PLOTALLDECODE(sub2analyse,SUB,EXP,SPG,DEC,DIR,PLOT,DATA,savefilename)
                        case 'multiElectrodeMultiTimeMultiFreq'
                            tmpDATA(:,:,:,:,itt,iff) = DATA;
                    end
                    
                end
            end
            switch DEC.dimension
                case 'multiElectrodeMultiTimeMultiFreq'
                    PLOTALLDECODE(sub2analyse,SUB,EXP,SPG,DEC,DIR,PLOT,tmpDATA,savefilename)
            end
            
            
        end
end


function PLOTALLDECODE(sub2analyse,SUB,EXP,SPG,DEC,DIR,PLOT,DATA,savefilename)
% plot any decoding results

% check decode significance and exclude subjects.
if PLOT.onlySignificantSubs 
    disp('checking whether to exclude subjects')
    [DATA,EXP,DEC] = checkDecodeSignificance_TW_Iowa(sub2analyse,EXP,DEC,SPG,DATA);
end


switch DEC.dimension
    case {'eachElectrodeEachTime','multiElectrodeEachTime'}
        plotDecode_TW_Iowa_eachTime(SUB,EXP,SPG,DEC,DIR,PLOT,DATA,savefilename)
    case {'eachElectrodeEachFreq','multiElectrodeEachFreq'}
        plotDecode_TW_Iowa_eachFreq(SUB,EXP,SPG,DEC,DIR,PLOT,DATA,savefilename)
    case {'eachElectrodeEachTimeEachFreq','multiElectrodeEachTimeEachFreq'}
        plotDecode_TW_Iowa_eachTimeEachFreq(SUB,EXP,SPG,DEC,DIR,PLOT,DATA,savefilename)
    case 'multiElectrodeMultiTimeMultiFreq'
        plotDecode_TW_Iowa_multiTimeMultiFreq(SUB,EXP,SPG,DEC,DIR,PLOT,DATA,savefilename)
    case {'eachElectrodeCombinePlot','multiElectrodeCombinePlot'}
        plotDecode_TW_Iowa_eachTime_eachFreq_eachTimeEachFreq(SUB,EXP,SPG,DEC,DIR,PLOT,DATA,savefilename)
end