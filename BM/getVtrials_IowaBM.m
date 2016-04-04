
trialsLeft  = ((trialData.location==1) | (trialData.location==3));
trialsRight = ((trialData.location==2) | (trialData.location==4));
stepSizeStrat = 50;
stepWindow = [0 250];
allSteps = stepWindow(1):stepSizeStrat:stepWindow(2);

switch EXP.cond
    case 'missVsCatch' % (1) % unconscious effects 
        EXP.nClass = 2;
        vTrial{1} = find( detectHit==0 & stimnum ~= 0 );% miss
        vTrial{2} = find( stimnum == 0 );% catch
        EXP.legendtxt = {'miss', 'catch'};
    case 'HvsM_50ms' % (2)% threshold conscious
        EXP.nClass = 2;
        vTrial{1} = find(detectHit==1 & stimnum ~= 0 & soa < 50 );%hit
        vTrial{2} = find(detectHit==0 & stimnum ~= 0 & soa < 50 );% miss
        EXP.legendtxt = {'hit_short', 'miss_short'};
    case 'hitVsMiss_short_left' % (3) % threshold conscious
        EXP.nClass = 2;
        vTrial{1} = find(detectHit==1 & stimnum ~= 0 & soa < 50 & ((trialData.location==1) | (trialData.location==3)));%hit
        vTrial{2} = find(detectHit==0 & stimnum ~= 0 & soa < 50 & ((trialData.location==1) | (trialData.location==3)));% miss
        EXP.legendtxt = {'hit_short_left', 'miss_short_left'};
    case 'hitVsMiss_short_right' % (4)% threshold conscious
        EXP.nClass = 2;
        vTrial{1} = find(detectHit==1 & stimnum ~= 0 & soa < 50 & ((trialData.location==2) | (trialData.location==4)));%hit
        vTrial{2} = find(detectHit==0 & stimnum ~= 0 & soa < 50 & ((trialData.location==2) | (trialData.location==4)));% miss
        EXP.legendtxt = {'hit_short_right', 'miss_short_right'};
    case 'S(1)L(2)' % % (5)sanity check
        EXP.nClass = 2;
        vTrial{1} = vTrialSOA{1};
        vTrial{2} = vTrialSOA{2};
        EXP.legendtxt = {'short(1)', 'long(2)'};
    case 'S(1)L(3)' % % (6) sanity check
        EXP.nClass = 2;
        vTrial{1} = vTrialSOA{1};
        vTrial{2} = vTrialSOA{3};
        EXP.legendtxt = {'short(1)', 'long(3)'};
    case 'S(1)L(2)_L' % % (7) sanity check
        EXP.nClass = 2;
        vTrial{1} = intersect(vTrialSOA{1}, trialsLeft);%;
        vTrial{2} = intersect(vTrialSOA{2}, trialsLeft);%;
        EXP.legendtxt = {'short(1)_left', 'long(2)_left'};
    case 'S(1)L(2)_R' % (8)  % sanity check
        EXP.nClass = 2;
        vTrial{1} = intersect(vTrialSOA{1}, trialsRight);%;
        vTrial{2} = intersect(vTrialSOA{2}, trialsRight);%;
        EXP.legendtxt = {'short(1)_right', 'long(2)_right'};
    case 'S(1)L(2)_ipsi'% (9)  % sanity check
        EXP.nClass = 2;
        switch SUB.seizureFocus
            case 'L'
                vTrial{1} = intersect(vTrialSOA{1}, trialsLeft);%;
                vTrial{2} = intersect(vTrialSOA{2}, trialsLeft);%;
            case 'R'
                vTrial{1} = intersect(vTrialSOA{1}, trialsRight);%;
                vTrial{2} = intersect(vTrialSOA{2}, trialsRight);%;
        end
        EXP.legendtxt = {'short(1)_ipsiLat', 'long(2)_ipsiLat'};
    case 'S(1)L(2)_contra'% (10)  % sanity check
        EXP.nClass = 2;
        switch SUB.seizureFocus
            case 'R'
                vTrial{1} = intersect(vTrialSOA{1}, trialsLeft);%;
                vTrial{2} = intersect(vTrialSOA{2}, trialsLeft);%;
            case 'L'
                vTrial{1} = intersect(vTrialSOA{1}, trialsRight);%;
                vTrial{2} = intersect(vTrialSOA{2}, trialsRight);%;
        end
        EXP.legendtxt = {'short(1)_contraLat', 'long(2)_contraLat'};
    case 'HM_LE_100ms' % (11)
        EXP.nClass = 2;
        trialSOA = (0<= soa & soa <100);
        vTrial{1} = find(detectHit==1 & discrimHit==1 & stimnum ~= 0 & trialSOA==1);
        vTrial{2} = find(detectHit==0 & discrimHit==0 & stimnum ~= 0 & trialSOA==1);
        EXP.legendtxt = {'hitLocEmo_100ms', 'missLocEmo_100ms'};
    case 'hitVsMiss_locAndEmo_100ms_contra' % (12) 
        EXP.nClass = 2;
        trialSOA = (0<= soa & soa <100);
        hitMiss{1} = find(detectHit==1 & discrimHit==1 & stimnum ~= 0 & trialSOA==1);
        hitMiss{2} = find(detectHit==0 & discrimHit==0 & stimnum ~= 0 & trialSOA==1);
        switch SUB.seizureFocus
            case 'R'
                vTrial{1} = intersect(hitMiss{1}, trialsLeft);%;
                vTrial{2} = intersect(hitMiss{2}, trialsLeft);%;
            case 'L'
                vTrial{1} = intersect(hitMiss{1}, trialsRight);%;
                vTrial{2} = intersect(hitMiss{2}, trialsRight);%;
        end
        EXP.legendtxt = {'hitLocEmo_100ms_contra', 'missLocEmo_100ms_contra'};
    case 'belowDetMissvsCatch' % (13) 
        EXP.nClass = 2;
        vTrial{1} = find ( detectHit==0 & stimnum ~= 0 & soa <= mmDetectThres ); % below threshold miss
        vTrial{2} = find ( stimnum == 0 ); % catch
        EXP.legendtxt = {'belowDet_miss', 'belowDet_catch'};
    case 'belowDetVsCatch' % (14) 
        EXP.nClass = 2;
        vTrial{1} = find ( stimnum ~= 0 & soa <= mmDetectThres ); % below threshold all trials
        vTrial{2} = find ( stimnum == 0 ); % catch
        EXP.legendtxt = {'belowDet', 'catch'};
    case 'belowDiscVsCatch' % (15) 
        EXP.nClass = 2;
        vTrial{1} = find ( stimnum ~= 0 & mmDetectThres < soa & ...
            soa < mmDiscrimThres ); % below threshold all trials
        vTrial{2} = find ( stimnum == 0 ); % catch
        EXP.legendtxt = {'belowDisc', 'catch'};
    case 'aboveDiscVsCatch' % (16) 
        EXP.nClass = 2;
        vTrial{1} = find ( stimnum ~= 0 & mmDiscrimThres <= soa ); % below threshold all trials
        vTrial{2} = find ( stimnum == 0 ); % catch
        EXP.legendtxt = {'aboveDisc', 'catch'};
    case 'LocHitVsMiss_belowDet' % (17) 
        EXP.nClass = 2;
        vTrial{1} = find ( detectHit==1 & stimnum ~= 0 & soa <= mmDetectThres ); % Loc HIT below det threshold
        vTrial{2} = find ( detectHit==0 & stimnum ~= 0 & soa <= mmDetectThres ); % Loc MIss below det threshold
        EXP.legendtxt = {'LocHit_belowDet', 'LocMiss_belowDet'};
    case 'LocHitVsMiss_belowDisc' % (18) 
        EXP.nClass = 2;
        vTrial{1} = find ( detectHit==1 & stimnum ~= 0 & mmDetectThres < soa & soa < mmDiscrimThres ); % Loc HIT below disc threshold
        vTrial{2} = find ( detectHit==0 & stimnum ~= 0 & mmDetectThres < soa & soa < mmDiscrimThres ); % Loc MIss below disc threshold
        EXP.legendtxt = {'LocHit_belowDisc', 'LocMiss_belowDisc'};
    case 'LocHitVsMiss_aboveDisc' % (19) 
        EXP.nClass = 2;
        vTrial{1} = find ( detectHit==1 & stimnum ~= 0 & soa >= mmDiscrimThres ); % Loc HIT above disc threshold
        vTrial{2} = find ( detectHit==0 & stimnum ~= 0 & soa >= mmDiscrimThres ); % Loc MIss above disc threshold
        EXP.legendtxt = {'LocHit_aboveDisc', 'LocMiss_aboveDisc'};
    case 'EmoHitVsMiss_belowDet' % (20) 
        EXP.nClass = 2;
        vTrial{1} = find ( discrimHit==1 & stimnum ~= 0 & soa <= mmDetectThres ); % Loc HIT below det threshold
        vTrial{2} = find ( discrimHit==0 & stimnum ~= 0 & soa <= mmDetectThres ); % Loc MIss below det threshold
        EXP.legendtxt = {'EmoHit_belowDet', 'EmoMiss_belowDet'};
    case 'EmoHitVsMiss_belowDisc' % (21)
        EXP.nClass = 2;
        vTrial{1} = find ( discrimHit==1 & stimnum ~= 0 & mmDetectThres < soa & soa < mmDiscrimThres ); % Loc HIT below disc threshold
        vTrial{2} = find ( discrimHit==0 & stimnum ~= 0 & mmDetectThres < soa & soa < mmDiscrimThres ); % Loc MIss below disc threshold
        EXP.legendtxt = {'EmoHit_belowDisc', 'EmoMiss_belowDisc'};
    case 'EmoHitVsMiss_aboveDisc' % (22)
        EXP.nClass = 2;
        vTrial{1} = find ( discrimHit==1 & stimnum ~= 0 & soa >= mmDiscrimThres ); % Loc HIT above disc threshold
        vTrial{2} = find ( discrimHit==0 & stimnum ~= 0 & soa >= mmDiscrimThres ); % Loc MIss above disc threshold
        EXP.legendtxt = {'EmoHit_aboveDisc', 'EmoMiss_aboveDisc'};
    case 'belowDetVsBelowDisc' % (23)
        EXP.nClass = 2;
        vTrial{1} = find ( stimnum ~= 0 & soa <= mmDetectThres ); % below detect threshold
        vTrial{2} = find ( stimnum ~= 0 & soa > mmDetectThres & soa < mmDiscrimThres ); % below disc threshold
        EXP.legendtxt = {'belowDet', 'belowDisc'};
    case 'belowDetVsAboveDisc' % (24)
        EXP.nClass = 2;
        vTrial{1} = find ( stimnum ~= 0 & soa <= mmDetectThres ); % below detect threshold
        vTrial{2} = find ( stimnum ~= 0 & soa >= mmDiscrimThres ); % above disc threshold
        EXP.legendtxt = {'belowDet',  'aboveDisc'};
    case 'belowDiscVsAboveDisc'% (25)
        EXP.nClass = 2;
        vTrial{1} = find ( stimnum ~= 0 & soa > mmDetectThres & soa < mmDiscrimThres ); % below disc threshold
        vTrial{2} = find ( stimnum ~= 0 & soa >= mmDiscrimThres ); % above disc threshold
        EXP.legendtxt = {'belowDisc', 'aboveDisc'};
    case 'FearNeut' % % (26)
        EXP.nClass = 2;
        vTrial{1} = find(expression==3) ;% fear
        vTrial{2} = find(expression==2) ;% neut
        EXP.legendtxt = {'Fear', 'Neut'};
    case 'FearHappy' % % (27)
        EXP.nClass = 2;
        vTrial{1} = find(expression==3) ;% fear
        vTrial{2} = find(expression==1) ;% happy
        EXP.legendtxt = {'Fear', 'Happy'};
    case 'HappyNeut' % % (28)
        EXP.nClass = 2;
        vTrial{1} = find(expression==1) ;% happy
        vTrial{2} = find(expression==2) ;% neut
        EXP.legendtxt = {'Happy', 'Neut'};
    case 'CorrFearNeut' %% (29)
        EXP.nClass = 2;
        vTrial{1} = find(expression==3 & discrimHit == 1) ;% fear
        vTrial{2} = find(expression==2 & discrimHit == 1) ;% neut
        EXP.legendtxt = {'CorrFear', 'CorrNeut'};
    case 'CorrFearHappy' %% (30)
        EXP.nClass = 2;
        vTrial{1} = find(expression==3 & discrimHit == 1) ;% fear
        vTrial{2} = find(expression==1 & discrimHit == 1) ;% happy
        EXP.legendtxt = {'CorrFear', 'CorrHappy'};
    case 'CorrHappyNeut' %% (31)
        EXP.nClass = 2;
        vTrial{1} = find(expression==1 & discrimHit == 1) ;% happy
        vTrial{2} = find(expression==2 & discrimHit == 1) ;% neut
        EXP.legendtxt = {'CorrHappy', 'CorrNeut'};
    case 'WrongFearNeut' %% (32)
        EXP.nClass = 2;
        vTrial{1} = find(expression==3 & discrimHit == 0) ;% fear
        vTrial{2} = find(expression==2 & discrimHit == 0) ;% neut
        EXP.legendtxt = {'WrongFear', 'WrongNeut'};
    case 'WrongFearHappy' %% (33)
        EXP.nClass = 2;
        vTrial{1} = find(expression==3 & discrimHit == 0) ;% fear
        vTrial{2} = find(expression==1 & discrimHit == 0) ;% happy
        EXP.legendtxt = {'WrongFear', 'WrongHappy'};
    case 'WrongHappyNeut' %% (34)
        EXP.nClass = 2;
        vTrial{1} = find(expression==1 & discrimHit == 0) ;% happy
        vTrial{2} = find(expression==2 & discrimHit == 0) ;% neut
        EXP.legendtxt = {'WrongHappy', 'WrongNeut'};
    case 'CorrWrongFear' %% (35)
        EXP.nClass = 2;
        vTrial{1} = find(expression==3 & discrimHit == 1) ;% fear
        vTrial{2} = find(expression==3 & discrimHit == 0) ;% fear
        EXP.legendtxt = {'CorrFear', 'WrongFear'};
    case 'CorrWrongHappy' %% (36)
        EXP.nClass = 2;
        vTrial{1} = find(expression==1 & discrimHit == 1) ;% happy
        vTrial{2} = find(expression==1 & discrimHit == 0) ;% happy
        EXP.legendtxt = {'CorrHappy', 'WrongHappy'};
    case 'CorrWrongNeut' %% (37)
        EXP.nClass = 2;
        vTrial{1} = find(expression==2 & discrimHit == 1) ;% neut
        vTrial{2} = find(expression==2 & discrimHit == 0) ;% neut
        EXP.legendtxt = {'CorrNeut', 'WrongNeut'};
    case 'expression' %% (38)
        EXP.nClass = 3;
        for iClass= 1:EXP.nClass
            vTrial{iClass} = find(expression==iClass);
        end
        EXP.legendtxt = {'Happy', 'Neut', 'Fear'};
    case 'HM_LE_strat'% (39)
        % trials equally distributed over left and right side of screen?
        EXP.nClass = 2;
        hitMiss{1} = (detectHit==1 & discrimHit==1 & stimnum ~= 0);
        hitMiss{2} = (detectHit==0 & discrimHit==0 & stimnum ~= 0);
        %         hitMiss{1} = (detectHit==1 & stimnum ~= 0);
        %         hitMiss{2} = (detectHit==0 & stimnum ~= 0);
        
        vTrial = cell(1,2);
        for iStep = 1:length(allSteps)-1
            trialSOA = (allSteps(iStep)<= soa & soa <allSteps(iStep+1));
            
            if 0
                switch SUB.seizureFocus
                    case 'R'
                        tmp_vTrial{1} = find(trialSOA & hitMiss{1} & trialsLeft);
                        tmp_vTrial{2} = find(trialSOA & hitMiss{2} & trialsLeft);
                    case 'L'
                        tmp_vTrial{1} = find(trialSOA & hitMiss{1} & trialsRight);
                        tmp_vTrial{2} = find(trialSOA & hitMiss{2} & trialsRight);
                end
                [minTrials]=min([length(tmp_vTrial{1}) length(tmp_vTrial{2})]);
                
                tmp3_vTrial{1} = sort(randsample(tmp_vTrial{1},minTrials))';
                tmp3_vTrial{2} = sort(randsample(tmp_vTrial{2},minTrials))';
            else
                tmp_vTrial{1,1} = find(trialSOA & hitMiss{1} & trialsLeft);
                tmp_vTrial{1,2} = find(trialSOA & hitMiss{1} & trialsRight);
                tmp_vTrial{2,1} = find(trialSOA & hitMiss{2} & trialsLeft);
                tmp_vTrial{2,2} = find(trialSOA & hitMiss{2} & trialsRight);
                
                [minTrials]=min([length(tmp_vTrial{1,1}) length(tmp_vTrial{1,2}) length(tmp_vTrial{2,1}) length(tmp_vTrial{2,2})]);
                
                tmp3_vTrial{1} = sort([randsample(tmp_vTrial{1,1},minTrials)', randsample(tmp_vTrial{1,2},minTrials)']);
                tmp3_vTrial{2} = sort([randsample(tmp_vTrial{2,1},minTrials)', randsample(tmp_vTrial{2,2},minTrials)']);
            end
            
            vTrial{1} = sort([vTrial{1} tmp3_vTrial{1}]);
            vTrial{2} = sort([vTrial{2} tmp3_vTrial{2}]);
        end
        
        EXP.legendtxt = {'strat_Hit_LE', 'strat_Miss_LE'};
    case 'HM_LE_strat_contra' % (40
        % trials equally distributed over left and right side of screen?
        EXP.nClass = 2;
        hitMiss{1} = (detectHit==1 & discrimHit==1 & stimnum ~= 0);
        hitMiss{2} = (detectHit==0 & discrimHit==0 & stimnum ~= 0);
        %         hitMiss{1} = (detectHit==1 & stimnum ~= 0);
        %         hitMiss{2} = (detectHit==0 & stimnum ~= 0);
        
        vTrial = cell(1,2);
        for iStep = 1:length(allSteps)-1
            trialSOA = (allSteps(iStep)<= soa & soa <allSteps(iStep+1));
            
            if 1
                switch SUB.seizureFocus
                    case 'R'
                        tmp_vTrial{1} = find(trialSOA & hitMiss{1} & trialsLeft);
                        tmp_vTrial{2} = find(trialSOA & hitMiss{2} & trialsLeft);
                    case 'L'
                        tmp_vTrial{1} = find(trialSOA & hitMiss{1} & trialsRight);
                        tmp_vTrial{2} = find(trialSOA & hitMiss{2} & trialsRight);
                end
                [minTrials]=min([length(tmp_vTrial{1}) length(tmp_vTrial{2})]);
                
                tmp3_vTrial{1} = sort(randsample(tmp_vTrial{1},minTrials))';
                tmp3_vTrial{2} = sort(randsample(tmp_vTrial{2},minTrials))';
            else
                tmp_vTrial{1,1} = find(trialSOA & hitMiss{1} & trialsLeft);
                tmp_vTrial{1,2} = find(trialSOA & hitMiss{1} & trialsRight);
                tmp_vTrial{2,1} = find(trialSOA & hitMiss{2} & trialsLeft);
                tmp_vTrial{2,2} = find(trialSOA & hitMiss{2} & trialsRight);
                
                [minTrials]=min([length(tmp_vTrial{1,1}) length(tmp_vTrial{1,2}) length(tmp_vTrial{2,1}) length(tmp_vTrial{2,2})]);
                
                tmp3_vTrial{1} = sort([randsample(tmp_vTrial{1,1},minTrials)', randsample(tmp_vTrial{1,2},minTrials)']);
                tmp3_vTrial{2} = sort([randsample(tmp_vTrial{2,1},minTrials)', randsample(tmp_vTrial{2,2},minTrials)']);
            end
            
            vTrial{1} = sort([vTrial{1} tmp3_vTrial{1}]);
            vTrial{2} = sort([vTrial{2} tmp3_vTrial{2}]);
        end
        
        EXP.legendtxt = {'strat_Hit_LE_contra', 'strat_Miss_LE_contra'};
    case 'HM_L_strat_contra' % (41)
        % trials equally distributed over left and right side of screen?
        EXP.nClass = 2;
        %         hitMiss{1} = (detectHit==1 & discrimHit==1 & stimnum ~= 0);
        %         hitMiss{2} = (detectHit==0 & discrimHit==0 & stimnum ~= 0);
        hitMiss{1} = (detectHit==1 & stimnum ~= 0);
        hitMiss{2} = (detectHit==0 & stimnum ~= 0);
        
        vTrial = cell(1,2);
        for iStep = 1:length(allSteps)-1
            trialSOA = (allSteps(iStep)<= soa & soa <allSteps(iStep+1));
            
            if 1
                switch SUB.seizureFocus
                    case 'R'
                        tmp_vTrial{1} = find(trialSOA & hitMiss{1} & trialsLeft);
                        tmp_vTrial{2} = find(trialSOA & hitMiss{2} & trialsLeft);
                    case 'L'
                        tmp_vTrial{1} = find(trialSOA & hitMiss{1} & trialsRight);
                        tmp_vTrial{2} = find(trialSOA & hitMiss{2} & trialsRight);
                end
                [minTrials]=min([length(tmp_vTrial{1}) length(tmp_vTrial{2})]);
                
                tmp3_vTrial{1} = sort(randsample(tmp_vTrial{1},minTrials))';
                tmp3_vTrial{2} = sort(randsample(tmp_vTrial{2},minTrials))';
            else
                tmp_vTrial{1,1} = find(trialSOA & hitMiss{1} & trialsLeft);
                tmp_vTrial{1,2} = find(trialSOA & hitMiss{1} & trialsRight);
                tmp_vTrial{2,1} = find(trialSOA & hitMiss{2} & trialsLeft);
                tmp_vTrial{2,2} = find(trialSOA & hitMiss{2} & trialsRight);
                
                [minTrials]=min([length(tmp_vTrial{1,1}) length(tmp_vTrial{1,2}) length(tmp_vTrial{2,1}) length(tmp_vTrial{2,2})]);
                
                tmp3_vTrial{1} = sort([randsample(tmp_vTrial{1,1},minTrials)', randsample(tmp_vTrial{1,2},minTrials)']);
                tmp3_vTrial{2} = sort([randsample(tmp_vTrial{2,1},minTrials)', randsample(tmp_vTrial{2,2},minTrials)']);
            end
            
            vTrial{1} = sort([vTrial{1} tmp3_vTrial{1}]);
            vTrial{2} = sort([vTrial{2} tmp3_vTrial{2}]);
        end
        
        EXP.legendtxt = {'strat_Hit_L_contra', 'strat_Miss_L_contra'};
        
    case 'HL_vis_contra'% (45)
        EXP.nClass = 2;
        switch SUB.seizureFocus
            case 'R'
                vTrial{1} = find(soa>100 & detectHit & discrimHit & trialsLeft);
                vTrial{2} = find(soa<=100 & ~detectHit & trialsLeft);
            case 'L'
                vTrial{1} = find(soa>100 & detectHit & discrimHit & trialsRight);
                vTrial{2} = find(soa<=100 & ~detectHit & trialsRight);
        end
        EXP.legendtxt = {'highVis_contra', 'invis_contra'};
        
    case 'HL_vis'% (46)
        EXP.nClass = 2;
        vTrial{1} = find(soa>100 & detectHit & discrimHit);
        vTrial{2} = find(soa<=100 & ~detectHit);
        EXP.legendtxt = {'highVis', 'invis'};
    case 'HL_vis_ext'% (47)
        EXP.nClass = 2;
        vTrial{1} = find(soa>100 & detectHit & discrimHit & stimnum ~= 0);
        vTrial{2} = find(soa<=100 & ~detectHit & ~discrimHit & stimnum ~= 0);
        EXP.legendtxt = {'highVis', 'invis'};
    case 'HitMiss_DetDiscr'% (48)
        EXP.nClass = 2;
        vTrial{1} = find(detectHit & discrimHit & stimnum ~= 0);
        vTrial{2} = find(~detectHit & ~discrimHit & stimnum ~= 0);
        EXP.legendtxt = {'highVis', 'inVis'};
    case 'HitMiss_Det'% (49)
        EXP.nClass = 2;
        vTrial{1} = find(detectHit & stimnum ~= 0);
        vTrial{2} = find(~detectHit & stimnum ~= 0);
        EXP.legendtxt = {'highVis', 'invis'};
    case 'HitMiss_Det_nDiscr'% (50)
        EXP.nClass = 2;
        vTrial{1} = find(detectHit & ~discrimHit & stimnum ~= 0);
        vTrial{2} = find(~detectHit & ~discrimHit & stimnum ~= 0);
        EXP.legendtxt = {'lowVis', 'inVis'};
    case 'HitMiss_nDet_Discr'% (51)
        EXP.nClass = 2;
        vTrial{1} = find(detectHit & discrimHit & stimnum ~= 0);
        vTrial{2} = find(detectHit & ~discrimHit & stimnum ~= 0);
        EXP.legendtxt = {'highVis', 'lowVis'};
        
    case 'HL_vis_detDiscr'% (52)
        EXP.nClass = 3;
        vTrial{1} = find(detectHit & discrimHit );
        vTrial{2} = find(detectHit & ~discrimHit );
        vTrial{3} = find(~detectHit & ~discrimHit );
        
        EXP.legendtxt = {'det_discr','det','invis'};

end
for iClass = 1:EXP.nClass
    EXP.nTrialsPerClass(iClass) = length(vTrial{iClass});
end
disp([subID ' nTrialsPerClass = ' num2str(EXP.nTrialsPerClass) ' : ' EXP.cond])



%     conds(:,1) = rsoa>100 & detectHit & discrimHit & (location==1 | location==3);cnameLR{1} = 'hivisLeft';
%     conds(:,2) = rsoa>100 & detectHit & discrimHit & (location==2 | location==4);cnameLR{2} = 'hivisRight';
%     conds(:,3) = rsoa<=100 & detectHit & discrimHit & (location==1 | location==3);cnameLR{3} = 'lovisLeft';
%     conds(:,4) = rsoa<=100 & detectHit & discrimHit & (location==2 | location==4);cnameLR{4} = 'lovisRight';
%     conds(:,5) = rsoa<=100 & ~detectHit & (location==1 | location==3);cnameLR{5} = 'invisLeft';
%     conds(:,6) = rsoa<=100 & ~detectHit & (location==2 | location==4);cnameLR{6} = 'invisRight';
%     conds(:,7) = rsoa<0;cnameLR{7} = 'blank';

