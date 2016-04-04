switch EXP.cond
    case 'on_off'
        EXP.nCond = 2;
        vTrial{1} = StimCont>=1;% contrast = 1
        vTrial{2} = vTrial{1};
        EXP.legendtxt = {'on','off'};        
    case 'cont1_onoff'
        EXP.nCond = 2;
        vTrial{1} = StimCont==1;% contrast = 1
        vTrial{2} = vTrial{1};
        EXP.legendtxt = {'on','off'};
    case 'cont2_onoff'
        EXP.nCond = 2;
        vTrial{1} = StimCont==2;% contrast = 2
        vTrial{2} = vTrial{1};
        EXP.legendtxt = {'on','off'};
    case 'cont3_onoff'
        EXP.nCond = 2;
        vTrial{1} = StimCont==3;% contrast = 3
        vTrial{2} = vTrial{1};
        EXP.legendtxt = {'on','off'};
    case 'cont3_onoff_hitt'
        EXP.nCond = 2;
        vTrial{1} = StimCont==3 & CorrResp==1;% contrast = 3, correct responses
        vTrial{2} = vTrial{1};
        EXP.legendtxt = {'onHitt','offHitt'};
    case 'vis_H_vs_L' % threshold conscious
        %sub154
%         stimCont =
%         0.1250    0.2500    0.5000
%         0.2500    0.5000    1.0000
%         0.1250    0.2500    0.5000
        
        %
        EXP.nCond = 2;
        hc = histc(Visibility,1:4);
        hc_diff(1) = abs(hc(1)-sum(hc(2:4)));
        hc_diff(2) = abs(sum(hc(1:2))-sum(hc(3:4)));
        hc_diff(3) = abs(sum(hc(1:3))-hc(4));
        [tmp,pos_division] = min(hc_diff);
        if length(pos_division) > 1
            disp('under construction : equal number of trials for division scheme')
            keyboard
        end
        clear tmp
        switch pos_division
            case 1
                vTrial{1} = Visibility==1;
                vTrial{2} = Visibility>1;
                disp('v1 vs v234')
                EXP.legendtxt = {'vLow(1)','vHigh(234)'};
            case 2
                vTrial{1} = Visibility<=2;
                vTrial{2} = Visibility>2;
                disp('v12 vs v34')
                EXP.legendtxt = {'vLow(12)','vHigh(34)'};
            case 3
                vTrial{1} = Visibility<4;
                vTrial{2} = Visibility==4;
                disp('v123 vs v4')
                EXP.legendtxt = {'vLow(123)','vHigh(4)'};
            otherwise
                disp('error')
                keyboard
        end
    case 'emotion'
        EXP.nCond = 2;
        vTrial{1} = StimType==1;% fear
        vTrial{2} = StimType==2;% neut
    case 'HitMiss'
        EXP.nCond = 2;
        vTrial{1} = CorrResp==1;% Hit
        vTrial{2} = CorrResp==2;% Miss
    case 'FaCr'
        EXP.nCond = 2;
        vTrial{1} = CorrResp==2;% Fa
        vTrial{2} = CorrResp==1;% Cr
    case 'HitFa'
        EXP.nCond = 2;
        vTrial{1} = CorrResp==1; % Hit
        vTrial{2} = CorrResp==2; % FA
    case 'MissCr'
        EXP.nCond = 2;
        vTrial{1} = CorrResp==2; % Miss
        vTrial{2} = CorrResp==1; % Cr
    case 'cont1_HitMiss'
        EXP.nCond = 2;
        vTrial{1} = CorrResp==1&StimCont==1;% Hit
        vTrial{2} = CorrResp==2&StimCont==1;% Miss
    case 'cont1_FaCr'
        EXP.nCond = 2;
        vTrial{1} = CorrResp==2&StimCont==1;% Fa
        vTrial{2} = CorrResp==1&StimCont==1;% Cr
    case 'cont1_HitFa'
        EXP.nCond = 2;
        vTrial{1} = CorrResp==1&StimCont==1; % Hit
        vTrial{2} = CorrResp==2&StimCont==1; % FA
    case 'cont1_MissCr'
        EXP.nCond = 2;
        vTrial{1} = CorrResp==2&StimCont==1; % Miss
        vTrial{2} = CorrResp==1&StimCont==1; % Cr
    case 'cont2_HitMiss'
        EXP.nCond = 2;
        vTrial{1} = CorrResp==1&StimCont==2;% Hit
        vTrial{2} = CorrResp==2&StimCont==2;% Miss
    case 'cont2_FaCr'
        EXP.nCond = 2;
        vTrial{1} = CorrResp==2&StimCont==2;% Fa
        vTrial{2} = CorrResp==1&StimCont==2;% Cr
    case 'cont2_HitFa'
        EXP.nCond = 2;
        vTrial{1} = CorrResp==1&StimCont==2; % Hit
        vTrial{2} = CorrResp==2&StimCont==2; % FA
    case 'cont2_MissCr' % ,... 14- 17
        EXP.nCond = 2;
        vTrial{1} = CorrResp==2&StimCont==2; % Miss
        vTrial{2} = CorrResp==1&StimCont==2; % Cr
    case 'cont3_HitMiss' % face present, corr vs wrong
        EXP.nCond = 2;
        vTrial{1} = CorrResp==1&StimCont==3;% Hit
        vTrial{2} = CorrResp==2&StimCont==3;% Miss
    case 'cont3_FaCr'% face absent, corr vs wrong
        EXP.nCond = 2;
        vTrial{1} = CorrResp==2&StimCont==3;% Fa
        vTrial{2} = CorrResp==1&StimCont==3;% Cr
    case 'cont3_HitFa'% responded, corr vs wrong
        EXP.nCond = 2;
        vTrial{1} = CorrResp==1&StimCont==3; % Hit
        vTrial{2} = CorrResp==2&StimCont==3; % FA
    case 'cont3_MissCr'% not respnoded, corr vs wrong
        EXP.nCond = 2;
        vTrial{1} = CorrResp==2&StimCont==3; % Miss
        vTrial{2} = CorrResp==1&StimCont==3; % Cr
    case 'cont1_FearNeut'%
        EXP.nCond = 2;
        vTrial{1} = StimType==1&StimCont==1; % Miss
        vTrial{2} = StimType==2&StimCont==1; % Cr
    case 'cont2_FearNeut'%
        EXP.nCond = 2;
        vTrial{1} = StimType==1&StimCont==2; % Miss
        vTrial{2} = StimType==2&StimCont==2; % Cr
    case 'cont3_FearNeut'%
        EXP.nCond = 2;
        vTrial{1} = StimType==1&StimCont==3; % Miss
        vTrial{2} = StimType==2&StimCont==3; % Cr
    case 'vis_1vs234'
        EXP.nCond = 2;
        vTrial{1} = Visibility==1;
        vTrial{2} = Visibility>1;
        EXP.legendtxt = {'vis1','vis234'};
    case 'vis_12vs34'
        EXP.nCond = 2;
        vTrial{1} = Visibility<=2;
        vTrial{2} = Visibility>2;
        EXP.legendtxt = {'vis12','vis34'};

    case 'vis_123vs4'
        EXP.nCond = 2;
        vTrial{1} = Visibility<4;
        vTrial{2} = Visibility==4;
        EXP.legendtxt = {'vis123','vis4'};
    case 'vis1_FearNeut'
        EXP.nCond = 2;
        vTrial{1} = Visibility==1&StimType==1;
        vTrial{2} = Visibility==1&StimType==2;
    case 'vis2_FearNeut'
        EXP.nCond = 2;
        vTrial{1} = Visibility==2&StimType==1;
        vTrial{2} = Visibility==2&StimType==2;
    case 'vis3_FearNeut'
        EXP.nCond = 2;
        vTrial{1} = Visibility==3&StimType==1;
        vTrial{2} = Visibility==3&StimType==2;
    case 'vis4_FearNeut'
        EXP.nCond = 2;
        vTrial{1} = Visibility==4&StimType==1;
        vTrial{2} = Visibility==4&StimType==2;
    case 'vis1_off'
        EXP.nCond = 2;
        vTrial{1} = Visibility==1;
        vTrial{2} = Visibility>0;
    case 'vis2_off'
        EXP.nCond = 2;
        vTrial{1} = Visibility==2;
        vTrial{2} = Visibility>0;
    case 'vis3_off'
        EXP.nCond = 2;
        vTrial{1} = Visibility==3;
        vTrial{2} = Visibility>0;
    case 'vis4_off'
        EXP.nCond = 2;
        vTrial{1} = Visibility==4;
        vTrial{2} = Visibility>0;
    case 'vis1cont1_off'
        EXP.nCond = 2;
        vTrial{1} = Visibility==1 & StimCont == 1;
        vTrial{2} = Visibility>0;
    case 'vis2cont1_off'
        EXP.nCond = 2;
        vTrial{1} = Visibility==2 & StimCont == 1;
        vTrial{2} = Visibility>0;
    case 'vis3cont1_off'
        EXP.nCond = 2;
        vTrial{1} = Visibility==3 & StimCont == 1;
        vTrial{2} = Visibility>0;
    case 'vis4cont1_off'
        EXP.nCond = 2;
        vTrial{1} = Visibility==4 & StimCont == 1;
        vTrial{2} = Visibility>0;
    case 'vis1cont2_off'
        EXP.nCond = 2;
        vTrial{1} = Visibility==1 & StimCont == 2;
        vTrial{2} = Visibility>0;
    case 'vis2cont2_off'
        EXP.nCond = 2;
        vTrial{1} = Visibility==2 & StimCont == 2;
        vTrial{2} = Visibility>0;
    case 'vis3cont2_off'
        EXP.nCond = 2;
        vTrial{1} = Visibility==3 & StimCont == 2;
        vTrial{2} = Visibility>0;
    case 'vis4cont2_off'
        EXP.nCond = 2;
        vTrial{1} = Visibility==4 & StimCont == 2;
        vTrial{2} = Visibility>0;
    case 'vis1cont3_off'
        EXP.nCond = 2;
        vTrial{1} = Visibility==1 & StimCont == 3;
        vTrial{2} = Visibility>0;
    case 'vis2cont3_off'
        EXP.nCond = 2;
        vTrial{1} = Visibility==2 & StimCont == 3;
        vTrial{2} = Visibility>0;
    case 'vis3cont3_off'
        EXP.nCond = 2;
        vTrial{1} = Visibility==3 & StimCont == 3;
        vTrial{2} = Visibility>0;
    case 'vis4cont3_off'
        EXP.nCond = 2;
        vTrial{1} = Visibility==4 & StimCont == 3;
        vTrial{2} = Visibility>0;
        
        
    case 'c1_vs_c2_at_v1'
        EXP.nCond = 2;
        vTrial{1} = StimCont==1 & Visibility == 1;
        vTrial{2} = StimCont==2 & Visibility == 1;
    case 'c1_vs_c3_at_v1'
        EXP.nCond = 2;
        vTrial{1} = StimCont==1 & Visibility == 1;
        vTrial{2} = StimCont==3 & Visibility == 1;
    case 'c2_vs_c3_at_v1'
        EXP.nCond = 2;
        vTrial{1} = StimCont==2 & Visibility == 1;
        vTrial{2} = StimCont==3 & Visibility == 1;
    case 'c1_vs_c2_at_v2'
        EXP.nCond = 2;
        vTrial{1} = StimCont==1 & Visibility == 2;
        vTrial{2} = StimCont==2 & Visibility == 2;
    case 'c1_vs_c3_at_v2'
        EXP.nCond = 2;
        vTrial{1} = StimCont==1 & Visibility == 2;
        vTrial{2} = StimCont==3 & Visibility == 2;
    case 'c2_vs_c3_at_v2'
        EXP.nCond = 2;
        vTrial{1} = StimCont==2 & Visibility == 2;
        vTrial{2} = StimCont==3 & Visibility == 2;
    case 'c1_vs_c2_at_v3'
        EXP.nCond = 2;
        vTrial{1} = StimCont==1 & Visibility == 3;
        vTrial{2} = StimCont==2 & Visibility == 3;
    case 'c1_vs_c3_at_v3'
        EXP.nCond = 2;
        vTrial{1} = StimCont==1 & Visibility == 3;
        vTrial{2} = StimCont==3 & Visibility == 3;
    case 'c2_vs_c3_at_v3'
        EXP.nCond = 2;
        vTrial{1} = StimCont==2 & Visibility == 3;
        vTrial{2} = StimCont==3 & Visibility == 3;
    case 'c1_vs_c2_at_v4'
        EXP.nCond = 2;
        vTrial{1} = StimCont==1 & Visibility == 4;
        vTrial{2} = StimCont==2 & Visibility == 4;
    case 'c1_vs_c3_at_v4'
        EXP.nCond = 2;
        vTrial{1} = StimCont==1 & Visibility == 4;
        vTrial{2} = StimCont==3 & Visibility == 4;
    case 'c2_vs_c3_at_v4'
        EXP.nCond = 2;
        vTrial{1} = StimCont==2 & Visibility == 4;
        vTrial{2} = StimCont==3 & Visibility == 4;
        
        
    case 'v1_vs_v2_at_c1'
        EXP.nCond = 2;
        vTrial{1} = Visibility==1 & StimCont == 1;
        vTrial{2} = Visibility==2 & StimCont == 1;
    case 'v1_vs_v3_at_c1'
        EXP.nCond = 2;
        vTrial{1} = Visibility==1 & StimCont == 1;
        vTrial{2} = Visibility==3 & StimCont == 1;
    case 'v1_vs_v4_at_c1'
        EXP.nCond = 2;
        vTrial{1} = Visibility==1 & StimCont == 1;
        vTrial{2} = Visibility==4 & StimCont == 1;
    case 'v2_vs_v3_at_c1'
        EXP.nCond = 2;
        vTrial{1} = Visibility==2 & StimCont == 1;
        vTrial{2} = Visibility==3 & StimCont == 1;
    case 'v2_vs_v4_at_c1'
        EXP.nCond = 2;
        vTrial{1} = Visibility==2 & StimCont == 1;
        vTrial{2} = Visibility==4 & StimCont == 1;
    case 'v3_vs_v4_at_c1'
        EXP.nCond = 2;
        vTrial{1} = Visibility==3 & StimCont == 1;
        vTrial{2} = Visibility==4 & StimCont == 1;
        
    case 'v1_vs_v2_at_c2'
        EXP.nCond = 2;
        vTrial{1} = Visibility==1 & StimCont == 2;
        vTrial{2} = Visibility==2 & StimCont == 2;
    case 'v1_vs_v3_at_c2'
        EXP.nCond = 2;
        vTrial{1} = Visibility==1 & StimCont == 2;
        vTrial{2} = Visibility==3 & StimCont == 2;
    case 'v1_vs_v4_at_c2'
        EXP.nCond = 2;
        vTrial{1} = Visibility==1 & StimCont == 2;
        vTrial{2} = Visibility==4 & StimCont == 2;
        EXP.legendtxt = {'v1_at_c2','v4_at_c2'};
    case 'v2_vs_v3_at_c2'
        EXP.nCond = 2;
        vTrial{1} = Visibility==2 & StimCont == 2;
        vTrial{2} = Visibility==3 & StimCont == 2;
    case 'v2_vs_v4_at_c2'
        EXP.nCond = 2;
        vTrial{1} = Visibility==2 & StimCont == 2;
        vTrial{2} = Visibility==4 & StimCont == 2;
    case 'v3_vs_v4_at_c2'
        EXP.nCond = 2;
        vTrial{1} = Visibility==3 & StimCont == 2;
        vTrial{2} = Visibility==4 & StimCont == 2;
        
    case 'v1_vs_v2_at_c3'
        EXP.nCond = 2;
        vTrial{1} = Visibility==1 & StimCont == 3;
        vTrial{2} = Visibility==2 & StimCont == 3;
    case 'v1_vs_v3_at_c3'
        EXP.nCond = 2;
        vTrial{1} = Visibility==1 & StimCont == 3;
        vTrial{2} = Visibility==3 & StimCont == 3;
    case 'v1_vs_v4_at_c3'
        EXP.nCond = 2;
        vTrial{1} = Visibility==1 & StimCont == 3;
        vTrial{2} = Visibility==4 & StimCont == 3;
    case 'v2_vs_v3_at_c3'
        EXP.nCond = 2;
        vTrial{1} = Visibility==2 & StimCont == 3;
        vTrial{2} = Visibility==3 & StimCont == 3;
    case 'v2_vs_v4_at_c3'
        EXP.nCond = 2;
        vTrial{1} = Visibility==2 & StimCont == 3;
        vTrial{2} = Visibility==4 & StimCont == 3;
    case 'v3_vs_v4_at_c3'
        EXP.nCond = 2;
        vTrial{1} = Visibility==3 & StimCont == 3;
        vTrial{2} = Visibility==4 & StimCont == 3;
    case 'v1_vs_v234_at_c2'
        EXP.nCond = 2;
        vTrial{1} = Visibility==1 & StimCont == 2; 
        vTrial{2} = Visibility>=2 & StimCont == 2;
        EXP.legendtxt = {'vis1_at_c2','vis234_at_c2'};
    case 'v12_vs_v34_at_c2'
        EXP.nCond = 2;
        vTrial{1} = Visibility<=2 & StimCont == 2; 
        vTrial{2} = Visibility>2 & StimCont == 2;
        EXP.legendtxt = {'vis12_at_c2','vis34_at_c2'};
    case 'v123_vs_v4_at_c2'
        EXP.nCond = 2;
        vTrial{1} = Visibility<=3 & StimCont == 2; 
        vTrial{2} = Visibility==4 & StimCont == 2;
        EXP.legendtxt = {'vis123_at_c2','vis4_at_c2'};
    case 'vis_H_vs_L_c2' % threshold conscious
        EXP.nCond = 2;
        hc = histc(Visibility,1:4);
        hc_diff(1) = abs(hc(1)-sum(hc(2:4)));
        hc_diff(2) = abs(sum(hc(1:2))-sum(hc(3:4)));
        hc_diff(3) = abs(sum(hc(1:3))-hc(4));
        [tmp,pos_division] = min(hc_diff);
        if length(pos_division) > 1
            disp('under construction : equal number of trials for division scheme')
            keyboard
        end
        clear tmp
        switch pos_division
            case 1
                vTrial{1} = Visibility==1 & StimCont == 2; 
                vTrial{2} = Visibility>1 & StimCont == 2; 
                disp('v1 vs v234 at c2')
                EXP.legendtxt = {'vLow(1)_c2','vHigh(234)_c2'};
            case 2
                vTrial{1} = Visibility<=2 & StimCont == 2; 
                vTrial{2} = Visibility>2 & StimCont == 2; 
                disp('v12 vs v34 at c2')
                EXP.legendtxt = {'vLow(12)_c2','vHigh(34)_c2'};
            case 3
                vTrial{1} = Visibility<4 & StimCont == 2; 
                vTrial{2} = Visibility==4 & StimCont == 2; 
                disp('v123 vs v4at c2')
                EXP.legendtxt = {'vLow(123)_c2','vHigh(4)_c2'};
            otherwise
                disp('error')
                keyboard
        end
    case 'high_low_visibility_at_c1_c2' % threshold conscious
        EXP.nCond = 2;
        hc = histc(Visibility,1:4);
        hc_diff(1) = abs(hc(1)-sum(hc(2:4)));
        hc_diff(2) = abs(sum(hc(1:2))-sum(hc(3:4)));
        hc_diff(3) = abs(sum(hc(1:3))-hc(4));
        [tmp,pos_division] = min(hc_diff);
        if length(pos_division) > 1
            disp('under construction : equal number of trials for division scheme')
            keyboard
        end
        clear tmp
        switch pos_division
            case 1
                vTrial{1} = Visibility==1 & (StimCont == 1 | StimCont == 2); 
                vTrial{2} = Visibility>1 & (StimCont == 1 | StimCont == 2); 
                disp('v1 vs v234 at c1_2')
                EXP.legendtxt = {'vLow(1)_c1_c2','vHigh(234)_c1_c2'};
            case 2
                vTrial{1} = Visibility<=2 & (StimCont == 1 | StimCont == 2); 
                vTrial{2} = Visibility>2 & (StimCont == 1 | StimCont == 2); 
                disp('v12 vs v34 at c1_2')
                EXP.legendtxt = {'vLow(12)_c1_c2','vHigh(34)_c1_c2'};
            case 3
                vTrial{1} = Visibility<4 & (StimCont == 1 | StimCont == 2); 
                vTrial{2} = Visibility==4 & (StimCont == 1 | StimCont == 2); 
                disp('v123 vs v4at c1_2')
                EXP.legendtxt = {'vLow(123)_c1_c2','vHigh(4)_c1_c2'};
            otherwise
                disp('error')
                keyboard
        end

    case 'allVisibility_allContrasts'
        EXP.nCond = 12;
        vTrial{1} = Visibility==1 & StimCont == 1;
        vTrial{2} = Visibility==1 & StimCont == 2;
        vTrial{3} = Visibility==1 & StimCont == 3;
        vTrial{4} = Visibility==2 & StimCont == 1;
        vTrial{5} = Visibility==2 & StimCont == 2;
        vTrial{6} = Visibility==2 & StimCont == 3;
        vTrial{7} = Visibility==3 & StimCont == 1;
        vTrial{8} = Visibility==3 & StimCont == 2;
        vTrial{9} = Visibility==3 & StimCont == 3;
        vTrial{10} = Visibility==4 & StimCont == 1;
        vTrial{11} = Visibility==4 & StimCont == 2;
        vTrial{12} = Visibility==4 & StimCont == 3;
        EXP.legendtxt = {'V1_C1','V1_C2','V1_C3','V2_C1','V2_C2','V2_C3','V3_C1','V3_C2','V3_C3','V4_C1','V4_C2','V4_C3',};
    otherwise
        disp([ Job.decodeType ' under construction'])
        keyboard
end


% switch EXP.decodeInterval
%     case 'first'
%         vTrial{1} = vTrial{1}==1 & StimPos==1;
%         vTrial{2} = vTrial{2}==1 & StimPos==1;
%         
%     case 'second'
%         vTrial{1} = vTrial{1}==1 & StimPos==2;
%         vTrial{2} = vTrial{2}==1 & StimPos==2;
%     case 'all'
% end


%%
for iClass = 1:EXP.nCond
    nTrialsPerClass(iClass) = sum(vTrial{iClass});
end
disp(['nTrialsPerClass = ' num2str(nTrialsPerClass)])

