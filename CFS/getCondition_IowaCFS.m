EXP.allCond = {'on_off','cont1_onoff','cont2_onoff','cont3_onoff','vis_H_vs_L','emotion',... 1-6
    'HitMiss','FaCr','HitFa','MissCr',... 6-9+1
    'cont3_onoff_hitt',...
    'cont1_HitMiss','cont1_FaCr','cont1_HitFa','cont1_MissCr',... 10- 13+1
    'cont2_HitMiss','cont2_FaCr','cont2_HitFa','cont2_MissCr',... 14- 17+1
    'cont3_HitMiss','cont3_FaCr','cont3_HitFa','cont3_MissCr',... 18- 21    +1
    'cont1_FearNeut','cont2_FearNeut','cont3_FearNeut',... 22-24+1
    'vis_1vs234','vis_12vs34','vis_123vs4',... 25-27+1
    'vis1_FearNeut','vis2_FearNeut','vis3_FearNeut','vis4_FearNeut',... %28-31+1
    'vis1_off','vis2_off','vis3_off','vis4_off',... % 32-35+1
    'vis1cont1_off','vis2cont1_off','vis3cont1_off','vis4cont1_off',... % 36-39+1
    'vis1cont2_off','vis2cont2_off','vis3cont2_off','vis4cont2_off',... % 40 43+1
    'vis1cont3_off','vis2cont3_off','vis3cont3_off','vis4cont3_off',... % 44 47+1
    'c1_vs_c2_at_v1','c1_vs_c3_at_v1','c2_vs_c3_at_v1',...  % 48 - 50+1
    'c1_vs_c2_at_v2','c1_vs_c3_at_v2','c2_vs_c3_at_v2',...  % 51 - 53+1
    'c1_vs_c2_at_v3','c1_vs_c3_at_v3','c2_vs_c3_at_v3',...  % 54 - 56+1
    'c1_vs_c2_at_v4','c1_vs_c3_at_v4','c2_vs_c3_at_v4',...  % 57 - 59+1
    'v1_vs_v2_at_c1','v1_vs_v3_at_c1','v1_vs_v4_at_c1','v2_vs_v3_at_c1','v2_vs_v4_at_c1','v3_vs_v4_at_c1',...  % 60 - 65+1
    'v1_vs_v2_at_c2','v1_vs_v3_at_c2','v1_vs_v4_at_c2','v2_vs_v3_at_c2','v2_vs_v4_at_c2','v3_vs_v4_at_c2',...  % 66 - 71+1
    'v1_vs_v2_at_c3','v1_vs_v3_at_c3','v1_vs_v4_at_c3','v2_vs_v3_at_c3','v2_vs_v4_at_c3','v3_vs_v4_at_c3',...  % 72 - 77+1
    'v1_vs_v234_at_c2','v12_vs_v34_at_c2','v123_vs_v4_at_c2','vis_H_vs_L_c2','high_low_visibility_at_c1_c2',... % 78 - 80+1
    'allVisibility_allContrasts'...
};   

EXP.cond = EXP.allCond{EXP.condIdx};
disp([EXP.cond])

switch EXP.cond
    case 'allVisibility_allContrasts'
        EXP.nCond = 12;
    otherwise
        EXP.nCond = 2;
end