function [DATA, EXP, DEC] = checkDecodeSignificance_TW_Iowa(sub2analyse,EXP,DEC,SPG,DATA)
% check if there are any significant dimensions (phase, power, erp) per
% subject.


%% based on which decode dimension, time and freq window do you want to exclude subjects?
decodeDim2check = 'multiElectrodeMultiTimeMultiFreq';
decodeTime2check = [0 0.5];
decodeFreq2check = [1 200];
DEC.sub2del = [];


%% only when permutations are performed.
if ~DEC.permute
    warning(['Without permutations no significance check (and exclusion of subjects) possible. ',...
        'Select DEC.permute=1 in getDecodeSettings'])
    DEC.excludeSub = 0;
    return
end

[nSub, nGrid, nDim, nDimDecode] = size(DATA);
[~,decIdx] = (grep(DEC.allDimension,decodeDim2check));

if ~(nSub>1)
    disp('only one subject? no point in excluding subjects')
    DEC.excludeSub = 0;
    return
end

%% get time and frequency points, used in getDecodeDimTimeFreq

c = cellfun(@(x)(ismember(decodeTime2check,x)),DEC.allTimes2decode,'UniformOutput',false);
[dT,~] = find(reshape([c{:}],numel(decodeTime2check),[])');

c = cellfun(@(x)(ismember(decodeFreq2check,x)),DEC.allFreq2decode,'UniformOutput',false);
[dF,~] = find(reshape([c{:}],numel(decodeFreq2check),[])');

if isempty(dT) || isempty(dF)
    warning('not excluding subjects, time and frequency windows dont match')
    DEC.excludeSub = 0;
    return
end

for iTmpT = 1:length(DEC.allTimes2decode)
    if sum(DEC.allTimes2decode{iTmpT} == decodeTime2check)==2
        itt = iTmpT;
        break
    end
end
for iTmpF = 1:length(DEC.allFreq2decode)
    if sum(DEC.allFreq2decode{iTmpF} == decodeFreq2check)==2
        iff = iTmpF;
        break
    end
end

%%


for iTW = DEC.nTW
    PLOT.iTW = iTW;
    clear tmpDATA
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
                    
                    for iDecDim = find(decIdx);
                        DEC.iDim2use = iDecDim;
                        [DEC] = getDecodeSettings_Iowa(subID,DEC,SPG,[],EXP.dataset);
                        
                        getDecode_dimTimeFreq_Iowa
                        
                        loadfilename = ['dTF_' subID '_' EXP.cond '_' DEC.saveCategory '_' DEC.ext];
                        
                        try
                            tmpDATA(iSub,iGrid2decode,iDim,iDecDim) = load([DIR.decodeCheck loadfilename '.mat']);
                        catch
                            disp([loadfilename ' .... doesn''t exist'])
                        end
                    end
                end
            end
        end
    end
    
%     PCORR2USE = zeros(nSub,nGrid,DEC.vDim(end));
    sub2keep = zeros(1,nSub);
    
    for iSub = 1:nSub
        for iGrid2decode = 1:nGrid
            for iDim = DEC.vDim
                if ~isempty(tmpDATA(iSub,iGrid2decode,iDim,decIdx).pMeanTestCorr)
                    if ~isempty(tmpDATA(iSub,iGrid2decode,iDim,decIdx).pCorr.pCorr)
                        sub2keep(iSub)     = 1;
                    end
                end
            end
        end
        
        
    end
    
    if sum(sub2keep)~=nSub
        DEC.sub2del = ~sub2keep;
        disp(['deleting sub ' sub2analyse{DEC.sub2del} ' from analysis'])
    else
        DEC.sub2del = [];
        disp('not excluding subjects')
    end
    
    switch DEC.dimension
        case 'multiElectrodeMultiTimeMultiFreq'
            DATA = DATA(find(sub2keep),:,:,:,:,:);
        otherwise
            DATA = DATA(find(sub2keep),:,:,:);
    end
    EXP.subIdx(find(DEC.sub2del)) = [];
    DEC.excludeSub = 1;

end


