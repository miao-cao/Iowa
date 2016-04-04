EXP.allCond = {'missVsCatch','HvsM_50ms','hitVsMiss_short_left','hitVsMiss_short_right',... %1-4
    'S(1)L(2)','S(1)L(3)',... % 5-6
    'short(1)VsLong(2)_left','short(1)VsLong(2)_right',... %7-8
    'S(1)L(2)_ipsi','S(1)L(2)_contra',...%9-10
    'HM_LE_100ms','hitVsMiss_locAndEmo_100ms_contra',...%11-12
    'belowDetMissvsCatch',... % 13
    'belowDetVsCatch','belowDiscVsCatch','aboveDiscVsCatch',... % 14-16
    'LocHitVsMiss_belowDet','LocHitVsMiss_belowDisc','LocHitVsMiss_aboveDisc',... % 17-19
    'EmoHitVsMiss_belowDet','EmoHitVsMiss_belowDisc','EmoHitVsMiss_aboveDisc',... % 20-22
    'belowDetVsBelowDisc','belowDetVsAboveDisc','belowDiscVsAboveDisc',... % 23-25
    'FearNeut','FearHappy','HappyNeut',... % 26-28
    'CorrFearNeut','CorrFearHappy','CorrHappyNeut',... % 29-31
    'WrongFearNeut','WrongFearHappy','WrongHappyNeut',... % 32-34 
    'CorrWrongFear','CorrWrongHappy','CorrWrongNeut',... % 35-37
    'expression'...%38
    'shortVsLongLeft','shortVsLongRight','shortVsLongLeftRight',...%39-41
    'HM_LE_strat','HM_LE_strat_contra','HM_L_strat_contra','HL_vis_contra','HL_vis','HL_vis_ext','HitMiss_DetDiscr','HitMiss_Det','HitMiss_Det_nDiscr','HitMiss_nDet_Discr','HL_vis_detDiscr'};%42-45


EXP.cond = EXP.allCond{EXP.condIdx};

switch EXP.cond
    case {'expression','HL_vis_detDiscr'}
        EXP.nCond = 3;
    case 'shortVsLongLeftRight'
        EXP.nCond = 4;
    otherwise 
        EXP.nCond = 2;
end
