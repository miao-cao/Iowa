function [data, trialLabel, tt, ff, DEC] = prepareDecode_eachElectrode_TW_Iowa(tmpSPG,allERP,SUB,SPG,DEC,EXP,iTW)
% prepare data for decoding. Select right time windows, frequencies, etc.
% clear data

trialLabel = [];

%
%% set time and freq variables
%

ff      = tmpSPG(1).ffPower;
tmpTT   = tmpSPG(1).ttPhase-abs(SUB.tRange(1));

timeERP = SUB.tRange(1):1/SUB.fs:SUB.tRange(2);

[~,ttIdx(1)] = min(abs(DEC.times2decode(1)-tmpTT));
[~,ttIdx(2)] = min(abs(DEC.times2decode(2)-tmpTT));  
tt = tmpTT(ttIdx(1):ttIdx(2));

for itt = 1:length(tt)
    [~,ttERPidx(itt)] = min(abs(tt(itt)-timeERP));
end
% [~,times2computeSPG,times2downsampleIdx,times2downsample,ttERPidx] = getTimeIdxTW(SPG,DEC,SUB.tRange,SUB.fs);

ff2testIdx = intersect(find(ff>DEC.freq2decode(1)),find(ff<DEC.freq2decode(2)));
ff2test(1) = ff2testIdx(1);
ff2test(2) = ff2testIdx(end);

ff = ff(ff2testIdx(1):ff2testIdx(end));
%%
data.phase          = [];
data.power          = [];
data.erp            = [];

for trialType = 1:EXP.nCond
    data.phase          = cat(3, data.phase,        tmpSPG(trialType).phase(ttIdx(1):ttIdx(2),ff2test(1):ff2test(2),:)); 
    data.power          = cat(3, data.power,        tmpSPG(trialType).power(ttIdx(1):ttIdx(2),ff2test(1):ff2test(2),:));
    data.erp            = cat(2, data.erp,          allERP{trialType}');
    
    trialLabel = [trialLabel; (ones(size(tmpSPG(trialType).phase,3),1)*trialType)];
end

%%
% switch DEC.saveCategory
%     case 'powerNorm'
        disp('normalising power spectrum')
        for iFreq = 1:length(ff)
            for iTrial = 1:size(data.power,3)
                tmpData(:,iFreq,iTrial) = data.power(:,iFreq,iTrial) - mean(data.power(:,iFreq,iTrial));
            end
        end
        
        data.powerNorm = tmpData;
        
        clear tmpData
% end
%%

TW = SPG.TW(iTW);
movingwinERP = (1:TW) - TW/2;

if ~isempty(find(strcmpi(DEC.allSaveCategory,'erp')))
    tmpERP = nan(length(tt),length(movingwinERP),size(data.erp,2));
    for iTime = 1:length(tt)
        tmpERP(iTime,:,:)        = squeeze(data.erp(ttERPidx(iTime)+movingwinERP,:));
    end
    data.erp = tmpERP;
end

%% Downsample ERP

if DEC.downsampleERP
    data.erp = data.erp(:,1:DEC.downsampleRate:end,:);  
end

