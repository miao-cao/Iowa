% function [SPG,ERP,EXP] =  getSeparateConditionsIowaCFS(subID,tmpSPG,tmpERP,EXP,iChan)
function [SPG,ERP,EXP] = getSeparateConditions_IowaCFS(subID,tmpSPG,tmpERP,EXP,iChan)

subSpecs_IowaCFS
getBehavioralDataForIowaCFS
getVtrialsForDecodeCFS
EXP.nTrialsPerClass=[];
SPG = struct([]);
ERP = cell(size(vTrial));

iSPG=1;
iERP=1;
if isempty(tmpSPG)
    iSPG=0;
end
if isempty(tmpERP)
    iERP=0;
end

if iSPG
    FaceOnData.phase      = nan(size(tmpSPG(1).phase,1),    size(tmpSPG(1).phase,2),      size(tmpSPG(1).phase,3));
    FaceOnData.power      = nan(size(tmpSPG(1).power,1),    size(tmpSPG(1).power,2),      size(tmpSPG(1).power,3));
%     FaceOnData.fft   = nan(size(tmpSPG(1).fft,1), size(tmpSPG(1).fft,2),   size(tmpSPG(1).fft,3));
end

if iERP
    FaceOnData.erp   = nan(size(tmpERP{1},1), size(tmpERP{2},2));
end

FaceOffData = FaceOnData;

switch EXP.decodeInterval
    case 'first'
        if iSPG
            FaceOnData.phase      (:,:,StimPos==1)    = (tmpSPG(1).phase  (:,:,StimPos==1));
            FaceOffData.phase     (:,:,StimPos==2)    = (tmpSPG(1).phase  (:,:,StimPos==2));
            FaceOnData.power      (:,:,StimPos==1)    = (tmpSPG(1).logPower   (:,:,StimPos==1));
            FaceOffData.power     (:,:,StimPos==2)    = (tmpSPG(1).logPower   (:,:,StimPos==2));
%             FaceOnData.logPower   (:,:,StimPos==1)    = (tmpSPG(1).logPower(:,:,StimPos==1));
%             FaceOffData.logPower  (:,:,StimPos==2)    = (tmpSPG(1).logPower(:,:,StimPos==2));
%             FaceOnData.fft   (:,:,StimPos==1)    = (tmpSPG(1).fft(:,:,StimPos==1));
%             FaceOffData.fft  (:,:,StimPos==2)    = (tmpSPG(1).fft(:,:,StimPos==2));
        end
        
        if iERP
            FaceOnData.erp   (StimPos==1,:)    = (tmpERP{1}(StimPos==1,:));
            FaceOffData.erp  (StimPos==2,:)    = (tmpERP{1}(StimPos==2,:));
        end
    case 'second'
        if iSPG
            FaceOnData.phase      (:,:,StimPos==2)    = (tmpSPG(2).phase  (:,:,StimPos==2));
            FaceOffData.phase     (:,:,StimPos==1)    = (tmpSPG(2).phase  (:,:,StimPos==1));
            FaceOnData.power      (:,:,StimPos==2)    = (tmpSPG(2).logPower   (:,:,StimPos==2));
            FaceOffData.power     (:,:,StimPos==1)    = (tmpSPG(2).logPower   (:,:,StimPos==1));
%             FaceOnData.logPower   (:,:,StimPos==2)    = (tmpSPG(2).logPower(:,:,StimPos==2));
%             FaceOffData.logPower  (:,:,StimPos==1)    = (tmpSPG(2).logPower(:,:,StimPos==1));
%             FaceOnData.fft   (:,:,StimPos==2)    = (tmpSPG(2).fft(:,:,StimPos==2));
%             FaceOffData.fft  (:,:,StimPos==1)    = (tmpSPG(2).fft(:,:,StimPos==1));
        end
        if iERP
            FaceOnData.erp   (StimPos==2,:)    = (tmpERP{1}(StimPos==2,:));
            FaceOffData.erp  (StimPos==1,:)    = (tmpERP{1}(StimPos==1,:));
        end
    case 'all'
        if iSPG
            FaceOnData.phase      (:,:,StimPos==1)    = (tmpSPG(1).phase  (:,:,StimPos==1));
            FaceOffData.phase     (:,:,StimPos==2)    = (tmpSPG(1).phase  (:,:,StimPos==2));
            FaceOnData.phase      (:,:,StimPos==2)    = (tmpSPG(2).phase  (:,:,StimPos==2));
            FaceOffData.phase     (:,:,StimPos==1)    = (tmpSPG(2).phase  (:,:,StimPos==1));
            FaceOnData.power      (:,:,StimPos==1)    = (tmpSPG(1).logPower   (:,:,StimPos==1));
            FaceOffData.power     (:,:,StimPos==2)    = (tmpSPG(1).logPower   (:,:,StimPos==2));
            FaceOnData.power      (:,:,StimPos==2)    = (tmpSPG(2).logPower   (:,:,StimPos==2));
            FaceOffData.power     (:,:,StimPos==1)    = (tmpSPG(2).logPower   (:,:,StimPos==1));
%             FaceOnData.logPower   (:,:,StimPos==1)    = (tmpSPG(1).logPower(:,:,StimPos==1));
%             FaceOffData.logPower  (:,:,StimPos==2)    = (tmpSPG(1).logPower(:,:,StimPos==2));
%             FaceOnData.logPower   (:,:,StimPos==2)    = (tmpSPG(2).logPower(:,:,StimPos==2));
%             FaceOffData.logPower  (:,:,StimPos==1)    = (tmpSPG(2).logPower(:,:,StimPos==1));
%             FaceOnData.fft   (:,:,StimPos==1)    = (tmpSPG(1).fft(:,:,StimPos==1));
%             FaceOffData.fft  (:,:,StimPos==2)    = (tmpSPG(1).fft(:,:,StimPos==2));
%             FaceOnData.fft   (:,:,StimPos==2)    = (tmpSPG(2).fft(:,:,StimPos==2));
%             FaceOffData.fft  (:,:,StimPos==1)    = (tmpSPG(2).fft(:,:,StimPos==1));
        end
        
        if iERP
            FaceOnData.erp   (StimPos==1,:)    = (tmpERP{1}(StimPos==1,:));
            FaceOffData.erp  (StimPos==2,:)    = (tmpERP{1}(StimPos==2,:));
            FaceOnData.erp   (StimPos==2,:)    = (tmpERP{1}(StimPos==2,:));
            FaceOffData.erp  (StimPos==1,:)    = (tmpERP{1}(StimPos==1,:));
        end
end
%%
clear tmp
switch EXP.cond
    case {'on_off','cont1_onoff', 'cont2_onoff','cont3_onoff','cont3_onoff_hitt',...
            'HitFa','cont1_HitFa','cont2_HitFa','cont3_HitFa',...
            'MissCr','cont1_MissCr','cont2_MissCr','cont3_MissCr',...
            'vis1_off','vis2_off','vis3_off','vis4_off',... % 32-35
            'vis1cont1_off','vis2cont1_off','vis3cont1_off','vis4cont1_off',...
            'vis1cont2_off','vis2cont2_off','vis3cont2_off','vis4cont2_off',...
            'vis1cont3_off','vis2cont3_off','vis3cont3_off','vis4cont3_off',...
            }
        
        if iSPG
            SPG(1).phase     = (FaceOnData.phase   (:,:,vTrial{1}));
            SPG(2).phase     = (FaceOffData.phase  (:,:,vTrial{2}));
            SPG(1).power      = (FaceOnData.power    (:,:,vTrial{1}));
            SPG(2).power      = (FaceOffData.power   (:,:,vTrial{2}));
%             tmp(1).logPower   = (FaceOnData.logPower (:,:,vTrial{1}));
%             tmp(2).logPower   = (FaceOffData.logPower(:,:,vTrial{2}));
%             tmp(1).fft   = (FaceOnData.fft (:,:,vTrial{1}));
%             tmp(2).fft   = (FaceOffData.fft(:,:,vTrial{2}));
        end
        if iERP
            ERP{1}   = (FaceOnData.erp (vTrial{1},:));
            ERP{2}   = (FaceOffData.erp(vTrial{2},:));
        end
    case {'vis_H_vs_L','vis_1vs234','vis_12vs34','vis_123vs4',...
            'HitMiss','cont1_HitMiss','cont2_HitMiss','cont3_HitMiss',...
            'emotion','cont1_FearNeut','cont2_FearNeut','cont3_FearNeut',...
            'vis1_FearNeut','vis2_FearNeut','vis3_FearNeut','vis4_FearNeut',...
            'c1_vs_c2_at_v1','c1_vs_c3_at_v1','c2_vs_c3_at_v1',...  % 48 - 50
            'c1_vs_c2_at_v2','c1_vs_c3_at_v2','c2_vs_c3_at_v2',...  % 51 - 53
            'c1_vs_c2_at_v3','c1_vs_c3_at_v3','c2_vs_c3_at_v3',...  % 54 - 56
            'c1_vs_c2_at_v4','c1_vs_c3_at_v4','c2_vs_c3_at_v4',...  % 57 - 59
            'v1_vs_v2_at_c1','v1_vs_v3_at_c1','v1_vs_v4_at_c1','v2_vs_v3_at_c1','v2_vs_v4_at_c1','v3_vs_v4_at_c1',...  % 60 - 65
            'v1_vs_v2_at_c2','v1_vs_v3_at_c2','v1_vs_v4_at_c2','v2_vs_v3_at_c2','v2_vs_v4_at_c2','v3_vs_v4_at_c2',...  % 66 - 71
            'v1_vs_v2_at_c3','v1_vs_v3_at_c3','v1_vs_v4_at_c3','v2_vs_v3_at_c3','v2_vs_v4_at_c3','v3_vs_v4_at_c3',...  % 72 - 77
            'v1_vs_v234_at_c2','v12_vs_v34_at_c2','v123_vs_v4_at_c2','vis_H_vs_L_c2','high_low_visibility_at_c1_c2'}
        if iSPG
            SPG(1).phase     = (FaceOnData.phase   (:,:,vTrial{1}));
            SPG(2).phase     = (FaceOnData.phase   (:,:,vTrial{2}));
            SPG(1).power      = (FaceOnData.power    (:,:,vTrial{1}));
            SPG(2).power      = (FaceOnData.power    (:,:,vTrial{2}));
            %             tmp(1).logPower   = (FaceOnData.logPower (:,:,vTrial{1}));
            %             tmp(2).logPower   = (FaceOnData.logPower (:,:,vTrial{2}));
            %             tmp(1).fft   = (FaceOnData.fft (:,:,vTrial{1}));
            %             tmp(2).fft   = (FaceOnData.fft (:,:,vTrial{2}));
        end
        if iERP
            ERP{1}   = (FaceOnData.erp (vTrial{1},:));
            ERP{2}   = (FaceOnData.erp(vTrial{2},:));
        end
    case {'FaCr','cont1_FaCr','cont2_FaCr','cont3_FaCr'}
        if iSPG
            SPG(1).phase     = (FaceOffData.phase  (:,:,vTrial{1}));
            SPG(2).phase     = (FaceOffData.phase  (:,:,vTrial{2}));
            SPG(1).power      = (FaceOffData.power   (:,:,vTrial{1}));
            SPG(2).power      = (FaceOffData.power   (:,:,vTrial{2}));
            %             tmp(1).logPower   = (FaceOffData.logPower(:,:,vTrial{1}));
            %             tmp(2).logPower   = (FaceOffData.logPower(:,:,vTrial{2}));
            %             tmp(1).fft   = (FaceOffData.fft(:,:,vTrial{1}));
            %             tmp(2).fft   = (FaceOffData.fft(:,:,vTrial{2}));
        end
        if iERP
            ERP{1}   = (FaceOffData.erp (vTrial{1},:));
            ERP{2}   = (FaceOffData.erp(vTrial{2},:));
        end
    case 'allVisibility_allContrasts'
        for iCond = 1:length(vTrial)
            if iSPG
                SPG(iCond).phase     = (FaceOnData.phase   (:,:,vTrial{iCond}));
                SPG(iCond).power     = (FaceOnData.power   (:,:,vTrial{iCond}));
                %                 tmp(iCond).logPower     = (FaceOnData.logPower   (:,:,vTrial{iCond}));
                %                 tmp(iCond).fft     = (FaceOnData.fft   (:,:,vTrial{iCond}));
            end
            if iERP
                ERP{iCond}     = (FaceOnData.erp   (:,:,vTrial{iCond}));
            end
        end
    otherwise
        disp([ EXP.cond ' under construction'])
        keyboard
end

for iCond = 1:length(vTrial)
    if iSPG
        [~,~,trials2delete] = ind2sub(size(SPG(iCond).phase),find(isnan(SPG(iCond).phase)));
        
        SPG(iCond).ttPhase            = tmpSPG(1).ttPhase;
        SPG(iCond).ffPhase            = tmpSPG(1).ffPhase;
        SPG(iCond).phase     (:,:,unique(trials2delete)) = [];
        
        SPG(iCond).ttPower           = tmpSPG(1).ttPower;
        SPG(iCond).ffPower           = tmpSPG(1).ffPower;
        SPG(iCond).power      (:,:,unique(trials2delete)) = [];

%         tmp(iCond).logPower   (:,:,unique(trials2delete)) = [];
%         tmp(iCond).fft   (:,:,unique(trials2delete)) = [];
%         tmp(iCond).ttFft            = tmpSPG(1).ttFft;
%         tmp(iCond).ffFft            = tmpSPG(1).ffFft;
%         if EXP.LOGPOWER
%             disp('get logPower')
%             SPG(iCond).power = 10*log10(SPG(iCond).power);
%         end
    end
    
    
    
    if iERP
        [trials2delete,~] = ind2sub(size(ERP{iCond}),find(isnan(ERP{iCond})));
        ERP{iCond}   (unique(trials2delete),:) = [];
    end

end



for iCond = 1:EXP.nCond
    if isfield(tmpSPG,'power')
        EXP.nTrialsPerClass = [EXP.nTrialsPerClass size(SPG(iCond).power,3)];
    elseif ~isempty(tmpERP)
        EXP.nTrialsPerClass = [EXP.nTrialsPerClass size(ERP{iCond},1)];        
    end
end
