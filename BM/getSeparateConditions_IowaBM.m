function [finalSPG,finalERP,EXP] = getSeparateConditions_IowaBM(subID,tmpSPG,tmpERP,EXP)
subSpecs_IowaBM
% EXP.LOGPOWER = 1;

getBehavioralDataForBM
getVtrials_IowaBM

finalSPG = struct([]);
finalERP = cell(1,EXP.nClass);

if ~isempty(tmpSPG)
    for iClass = 1:EXP.nClass
        finalSPG(iClass).ttPhase     = tmpSPG(1).ttPhase;
        finalSPG(iClass).ttPower     = tmpSPG(1).ttPower;
%         finalSPG(iClass).ttLogPower  = tmpSPG(1).ttPower;
%         finalSPG(iClass).ttFft       = tmpSPG(1).ttFft;
        finalSPG(iClass).ffPhase     = tmpSPG(1).ffPhase;
        finalSPG(iClass).ffPower     = tmpSPG(1).ffPower;
%         finalSPG(iClass).ffFft       = tmpSPG(1).ffFft;
        finalSPG(iClass).phase       = tmpSPG(1).phase(:,:,vTrial{iClass});
        finalSPG(iClass).power       = tmpSPG(1).logPower(:,:,vTrial{iClass});
%         finalSPG(iClass).fft         = tmpSPG(1).fft(:,:,vTrial{iClass});
    end
end

if ~isempty(tmpERP)
    for iClass = 1:EXP.nClass
        finalERP{iClass} = tmpERP(vTrial{iClass},:);
    end
end

