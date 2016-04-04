function [SPG,ERP,EXP] = getSeparateConditions_IowaLocalizer(subID,tmpSPG,tmpERP,EXP)
subSpecs_IowaLocalizer
EXP.nTrialsPerClass = [];
% ekman                {'upright F','invert F','houses','tools','Mondrian'};
% animal               {'Animals','Persons','Landmards','Vehcles','Flowers'};
switch EXP.cond
    case 'allSeparate'
        EXP.legendtxt = {'upright F','invert F','houses','tools','Mondrian'};
        EXP.nCond = 5;
        SPG = tmpSPG;
        ERP = tmpERP;
        return
    case 'faceVsNonFace';
        EXP.nCond = 2;
        EXP.legendtxt = {'upright F','Non-Face'};
        switch SUB.stimCat{SUB.vSession(1)}
            case 'ekman'
                conditions{1} = 1;
            case 'animal'
                conditions{1} = 2;
            otherwise
                error('unknown SUB.stimCat{SUB.vSession(1)}')
        end
        conditions{2} = [3 4 5];
    case 'faceVsHouse';
        EXP.nCond = 2;
        EXP.legendtxt = {'upright F','House'};
        switch SUB.stimCat{SUB.vSession(1)}
            case 'ekman'
                conditions{1} = 1;
                conditions{2} = [3];
            case 'animal'
                conditions{1} = 2;
                conditions{2} = [3];
            otherwise
                error('unknown SUB.stimCat{SUB.vSession(1)}')
        end
    case 'faceVsVeh';
        EXP.nCond = 2;
        EXP.legendtxt = {'upright F','Vehicle'};
        switch SUB.stimCat{SUB.vSession(1)}
            case 'ekman'
                error
            case 'animal'
                conditions{1} = 2;
                conditions{2} = [4];
            otherwise
                error('unknown SUB.stimCat{SUB.vSession(1)}')
        end
    case 'faceVsMondrian';
        EXP.nCond = 2;
        EXP.legendtxt = {'upright F','Mondrian'};
        switch SUB.stimCat{SUB.vSession(1)}
            case 'ekman'
                conditions{1} = 1;
                conditions{2} = [5];
            case 'animal'
                disp('no Mondrian condition!, break')
                SPG = [];
                return
            otherwise
                error('unknown SUB.stimCat{SUB.vSession(1)}')  
        end
    otherwise
        error
end
SPG = struct([]);
ERP = cell(1,EXP.nCond);

if ~isempty(tmpSPG)
    for trialType = 1:EXP.nCond
        if isfield(tmpSPG,'power')
            SPG(trialType).ttPhase       = tmpSPG(1).ttPhase;
            SPG(trialType).ttPower       = tmpSPG(1).ttPower;
            SPG(trialType).ttLogPower    = tmpSPG(1).ttPower;
%             SPG(trialType).ttFft         = tmpSPG(1).ttFft;
            SPG(trialType).ffPhase       = tmpSPG(1).ffPhase;
            SPG(trialType).ffPower       = tmpSPG(1).ffPower;
%             SPG(trialType).ffFft         = tmpSPG(1).ffFft;
        elseif isfield(tmpSPG,'MI')
            SPG(trialType).tt       = tmpSPG(conditions{1}).tt;
            SPG(trialType).ffPhase  = tmpSPG(conditions{1}).ffPhase;
            SPG(trialType).ffPower  = tmpSPG(conditions{1}).ffPower;
        end
    end
    
    if isfield(tmpSPG,'power')
        SPG(1).phase    = tmpSPG(conditions{1}).phase;        
        SPG(1).power    = tmpSPG(conditions{1}).logPower;
    end
end

if ~isempty(tmpERP)
    ERP = cell(1,EXP.nCond);
    ERP{1}      = tmpERP{conditions{1}};
end

for iCond = 1:length(conditions{2})
    if ~isempty(tmpSPG)
        
        if isfield(tmpSPG,'power')
            SPG(2).phase    = cat(3,SPG(2).phase,   tmpSPG(conditions{2}(iCond)).phase);
            SPG(2).power    = cat(3,SPG(2).power,   tmpSPG(conditions{2}(iCond)).logPower);
        end
    end
    if ~isempty(tmpERP)
        ERP{2} = cat(1,ERP{2},tmpERP{conditions{2}(iCond)});
    end
    
end

for iCond = 1:EXP.nCond
    if isfield(tmpSPG,'power')
        EXP.nTrialsPerClass = [EXP.nTrialsPerClass size(SPG(iCond).power,3)];
    elseif ~isempty(tmpERP)
        EXP.nTrialsPerClass = [EXP.nTrialsPerClass size(ERP{iCond},1)];        
    end
end
%
% switch SUB.stimCat{SUB.vSession(1)}
%     case 'ekman'
%         EXP.legendtxt = {'upright F','invert F','houses','tools','Mondrian'};
%     case 'animal'
%         EXP.legendtxt = {'Animals','Persons','Landmards','Vehcles','Flowers'};
% end
% 
