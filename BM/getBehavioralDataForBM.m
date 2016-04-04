warning off
%%
CHECK_BEHAVIOR = 0;
PLOT_VISIBLE_BEHAVIOR = 'off';
PRINT_BEHAVIOR = 0;
%%
filename = [subID '_' 'beh' '_' 'session' '_' SUB.allSes];

load([DIR.beh filename '.mat'])

%% responses
% 
% button numbers representing locations 1-4
% Locations are 1 - Upper Left, 2 - Upper right
%               3 - Lower Left, 4 - Lower right

% 1,2,3: buttons representing respectively Happy, Neutral, Fearful
%%
block           = trialData.block;
soa             = trialData.soa;
stimnum         = trialData.stimnum;
soa(stimnum == 0) = -inf; % catch trials
detectHit       = trialData.detectHit; % localization correct
discrimHit      = trialData.discrimHit; % emotion correct
expression      = trialData.expression;

%% sort trials according to SOA
vTrialSOA{1} = find(0<=soa & soa<50);
vTrialSOA{2} = find(50<= soa & soa <200);
vTrialSOA{3} = find(200<=soa);
vTrialSOA{4} = find(isinf(soa));
%% sort trials according to thresholds for each subIDs
% based on function R = analyzeECoG_BM_behavior(subID)

if 1
    %% directory setting
    %% load TrialParameters (for all files)
    DELIMITER = '\t';
    HEADERLINES = 8;
    %% clear TXT
    clear allTxtFiles
    allTxtFiles = dir([DIR.behBase 'Responses_' subID '*.txt']);
    nSessions = length(allTxtFiles);
    switch subID
        case {'178'}
            nSessions = 1;
    end
    vSessions = 1:nSessions;
    switch subID
        case {'178'}
            vSessions = 4;
    end
    
    %% load *.log  clear TXT
    for iSession = vSessions
        beh_filename{iSession} = [DIR.behBase 'Responses_' subID '_' num2str(iSession) ];
        txtFilename{iSession} = [beh_filename{iSession} '.txt'];
        TXT{iSession} = importdata(txtFilename{iSession}, DELIMITER, HEADERLINES);
        matFilename{iSession} = [beh_filename{iSession} '.mat'];
        MAT{iSession} = load(matFilename{iSession});
    end
    %% histogram for SOA
    iSOA = 9;
    iStimID = 2;
    stimID = [];
    iLocHit =  10;
    locHit =[];
    iEmoHit = 11;
    emoHit = [];
    
    clear mDetectThres sdDetectThres mDiscrimThres sdDiscrimThres
    jSession = 0;
    for iSession = vSessions
        jSession = jSession + 1;
        stimID = [stimID ; TXT{iSession}.data(:,iStimID)];
        
        locHit = [locHit; TXT{iSession}.data(:,iLocHit)  ];
        emoHit = [emoHit; TXT{iSession}.data(:,iEmoHit)  ];
        
        mDetectThres(jSession) = MAT{iSession}.TS.detectStats.meanThresh;
        sdDetectThres(jSession) = MAT{iSession}.TS.detectStats.sdThresh;
        mDiscrimThres(jSession) = MAT{iSession}.TS.discrimStats.meanThresh;
        sdDiscrimThres(jSession) = MAT{iSession}.TS.discrimStats.sdThresh;
    end
    %%
    xmDiscrimThres =max(mDiscrimThres);
    xsdDiscrimThres =max(sdDiscrimThres);
    xmDetectThres =max(mDetectThres);
    xsdDetectThres =max(sdDetectThres);
    
    mmDiscrimThres = mean(mDiscrimThres);
    mmDetectThres = mean(mDetectThres);
    % keyboard
    disp(['mmDetectThres = ' num2str(mmDetectThres) ' : mmDiscrim = ' num2str(mmDiscrimThres) ])
    
    nSD = 1.5 ;
    DetectDiscrimBoundary = xmDetectThres + xsdDetectThres*nSD;
    DiscrimSupraBoundary = min([200 xmDiscrimThres + xsdDiscrimThres*nSD]);
    
    %%
    vDetectSOA = find( soa <= DetectDiscrimBoundary & stimID > 0 );
    vDiscrimSOA = find( DetectDiscrimBoundary < soa & ...
        soa < DiscrimSupraBoundary ...
        & stimID > 0 );
    vSupraSOA = find ( DiscrimSupraBoundary <= soa & stimID > 0 );
    vCatchSOA = find ( stimID == 0 );
    %% use hard threshold == mean
    vBelowDetectSOA = find( soa <= mmDetectThres  & stimID > 0 );
    vBelowDiscrimSOA = find( mmDetectThres < soa & ...
        soa < mmDiscrimThres ...
        & stimID > 0 );
    vAboveDiscrimSOA = find ( mmDiscrimThres <= soa & stimID > 0 );
    
    %%
    if CHECK_BEHAVIOR
        fs = 15;
        figure(1),clf,hold on
        set(gca,'fontsize',fs)
        set(gcf,'visible',PLOT_VISIBLE_BEHAVIOR)
        hist(soa,20)
        plot(xmDetectThres*[1 1], ylim,'r')
        plot(mmDetectThres*[1 1], ylim,'r','linewidth',2)
        % plot([xmDetectThres - xsdDetectThres * nSD] *[1 1], ylim,'r--')
        plot(DetectDiscrimBoundary *[1 1], ylim,'g-')
        plot(DetectDiscrimBoundary *[1 1], ylim,'r--')
        plot(xmDiscrimThres*[1 1], ylim,'g')
        plot(mmDiscrimThres*[1 1], ylim,'g','linewidth',2)
        % plot([xmDiscrimThres - xsdDiscrimThres * nSD] *[1 1], ylim,'r--')
        plot(DiscrimSupraBoundary *[1 1], ylim,'g--')
        xlabel('SOA [msec]')
        title({[subID ' : # of ~detection thresh. trials = ',num2str(length(vDetectSOA))];
            ['# of ~discrimination thresh. trials = ',num2str(length(vDiscrimSOA))];
            ['# of above ~discrimination thresh. trials = ',num2str(length(vSupraSOA))];
            
            [subID ' : # of below detect thr. trials = ',num2str(length(vBelowDetectSOA))];
            ['# of below disc thre trials = ',num2str(length(vBelowDiscrimSOA))];
            ['# of above disc thre trials = ',num2str(length(vAboveDiscrimSOA))];
            
            ['# catch trials = ',num2str(length(vCatchSOA))];
            ['# total trials = ',num2str(length(soa)) ' : criterion SOA SDT = ' num2str(nSD) ]})
        
        if PRINT_BEHAVIOR
            print(gcf,'-dpng',[DIR.fig 'SOAhist_' subID '.png'])
        end
    end
    %% sanity check
    if sum(locHit(vCatchSOA)) + sum(emoHit(vCatchSOA)) > 0
        error('')
    end
    if  length(vDetectSOA) + length(vDiscrimSOA) + length(vSupraSOA) + length(vCatchSOA) ...
            ~= length(soa)
        error('')
    end
    if  length(vBelowDetectSOA) + length(vBelowDiscrimSOA) + length(vAboveDiscrimSOA) + length(vCatchSOA) ...
            ~= length(soa)
        error('')
    end
    
    
    %% detection and discrimination performance
    mDetectSOAUsed = mean(soa(vDetectSOA)) ;
    mDiscrimSOAUsed = mean(soa(vDiscrimSOA)) ;
    mSupraSOAUsed = mean(soa(vSupraSOA)) ;
    mCatchSOAUsed = mean(soa(vCatchSOA)) ;
    
    mDetectLocHit = mean(locHit(vDetectSOA));
    mDiscrimLocHit = mean(locHit(vDiscrimSOA));
    mSupraLocHit = mean(locHit(vSupraSOA));
    mCatchLocHit = mean(locHit(vCatchSOA));
    
    mDetectEmoHit = mean(emoHit(vDetectSOA));
    mDiscrimEmoHit = mean(emoHit(vDiscrimSOA));
    mSupraEmoHit = mean(emoHit(vSupraSOA));
    mCatchEmoHit = mean(emoHit(vCatchSOA));
    
    %% detection and discrimination performance
    mBelowDetectSOAUsed = mean(soa(vBelowDetectSOA)) ;
    mBelowDiscrimSOAUsed = mean(soa(vBelowDiscrimSOA)) ;
    mAboveDiscrimSOAUsed = mean(soa(vAboveDiscrimSOA)) ;
    
    mBelowDetectLocHit = mean(locHit(vBelowDetectSOA));
    mBelowDiscrimLocHit = mean(locHit(vBelowDiscrimSOA));
    mAboveDiscrimLocHit = mean(locHit(vAboveDiscrimSOA));
    
    mBelowDetectEmoHit = mean(emoHit(vBelowDetectSOA));
    mBelowDiscrimEmoHit = mean(emoHit(vBelowDiscrimSOA));
    mAboveDiscrimEmoHit = mean(emoHit(vAboveDiscrimSOA));
    
    
    %%
    if CHECK_BEHAVIOR
        figure(2),clf,hold on
        set(gca,'fontsize',fs)
        set(gcf,'visible',PLOT_VISIBLE_BEHAVIOR)
        
        plot(mDetectSOAUsed,mDetectLocHit,'o')
        plot(mDiscrimSOAUsed,mDiscrimLocHit,'>')
        plot(mSupraSOAUsed,mSupraLocHit,'<')
        plot(mCatchSOAUsed,mCatchLocHit,'x')
        
        plot(mDetectSOAUsed,mDetectEmoHit,'ro')
        plot(mDiscrimSOAUsed,mDiscrimEmoHit,'r>')
        plot(mSupraSOAUsed,mSupraEmoHit,'r<')
        plot(mCatchSOAUsed,mCatchEmoHit,'rx')
        
        plot(mBelowDetectSOAUsed,mBelowDetectLocHit,'o','linewidth',2)
        plot(mBelowDiscrimSOAUsed,mBelowDiscrimLocHit,'>','linewidth',2)
        plot(mAboveDiscrimSOAUsed,mAboveDiscrimLocHit,'<','linewidth',2)
        
        plot(mBelowDetectSOAUsed,mBelowDetectEmoHit,'ro','linewidth',2)
        plot(mBelowDiscrimSOAUsed,mBelowDiscrimEmoHit,'r>','linewidth',2)
        plot(mAboveDiscrimSOAUsed,mAboveDiscrimEmoHit,'r<','linewidth',2)
        
        plot(xlim,.25 *[1 1],'b--')
        plot(xlim,.33 *[1 1],'r--')
        plot(xlim,.25 + .25*.75*[1 1],'b')
        plot(xlim,.33 + .25*.66*[1 1],'r')
        xlabel('mean SOA [msec]')
        ylabel('prob. correct')
        title({[subID ' : Blue=Location (4AFC) : RED=Emotion (3AFC)'];
            [' # of ~detection thresh. trials = ',num2str(length(vDetectSOA))];
            ['# of ~discrimination thresh. trials = ',num2str(length(vDiscrimSOA))];
            ['# of above discrimination thresh. trials = ',num2str(length(vSupraSOA))];
            [' # of below detect thresh. trials = ',num2str(length(vBelowDetectSOA))];
            ['# of below disc thresh. trials = ',num2str(length(vBelowDiscrimSOA))];
            ['# of above disc thresh. trials = ',num2str(length(vAboveDiscrimSOA))];
            ['# catch trials = ',num2str(length(vCatchSOA))];
            ['# total trials = ',num2str(length(soa)) ' : criterion SOA SDT = ' num2str(nSD) ]})
        
        if PRINT_BEHAVIOR
            print(gcf,'-dpng',[DIR.fig  'pCorr_' subID '.png'])
        end
    end
    %% check # of trials for decoding
    if CHECK_BEHAVIOR
        figure(3),clf, hold on
        clear yticklabel
        barh(1,length(vBelowDetectSOA))
        barh(2,sum(locHit(vBelowDetectSOA)))
        barh(3,sum(emoHit(vBelowDetectSOA)))
        barh(4,sum(emoHit(vBelowDetectSOA)&locHit(vBelowDetectSOA)))
        
        barh(5,length(vBelowDiscrimSOA))
        barh(6,sum(locHit(vBelowDiscrimSOA)))
        barh(7,sum(emoHit(vBelowDiscrimSOA)))
        barh(8,sum(emoHit(vBelowDiscrimSOA)&locHit(vBelowDiscrimSOA)))
        
        barh(9,length(vAboveDiscrimSOA))
        barh(10,sum(locHit(vAboveDiscrimSOA)))
        barh(11,sum(emoHit(vAboveDiscrimSOA)))
        barh(12,sum(emoHit(vAboveDiscrimSOA)&locHit(vAboveDiscrimSOA)))
        
        yticklabel{1} = ['# of tr below detectThrSOA' ];
        yticklabel{2} = ['# of locHit (soa<=' num2str(mmDetectThres,3) ')'];
        yticklabel{3} = ['# of emoHit '];
        yticklabel{4} = ['# of bothHit '];
        
        yticklabel{5} = ['# of tr below discrimThrSOA' ];
        yticklabel{6} = ['# of locHit (' num2str(mmDetectThres,3) '<soa<' num2str(mmDiscrimThres,3) ')'];
        yticklabel{7} = ['# of emoHit '];
        yticklabel{8} = ['# of bothHit '];
        
        yticklabel{9} = ['# of tr above discrimThrSOA' ];
        yticklabel{10} = ['# of locHit (soa >=' num2str(mmDiscrimThres,3) ')'];
        yticklabel{11} = ['# of emoHit '];
        yticklabel{12} = ['# of bothHit '];
        
        set(gca,'ytick',1:length(yticklabel),'yticklabel',yticklabel)
        clear yticklabel
        xlabel('# of trials')
        title({[subID ' : # total trials = ',num2str(length(soa)) ]})
        if PRINT_BEHAVIOR
            print(gcf,'-dpng',[DIR.fig  'nTrials_' subID '.png'])
        end
    end
    %%
    
    
    % %% detection and discrimination performance
    % R.mDetectSOAUsed = mDetectSOAUsed ;
    % R.mDiscrimSOAUsed = mDiscrimSOAUsed ;
    % R.mSupraSOAUsed = mSupraSOAUsed ;
    % R.mCatchSOAUsed = mCatchSOAUsed ;
    %
    % R.mDetectLocHit= mDetectLocHit;
    % R.mDiscrimLocHit= mDiscrimLocHit;
    % R.mSupraLocHit= mSupraLocHit;
    % R.mCatchLocHit= mCatchLocHit;
    %
    % R.mDetectEmoHit= mDetectEmoHit;
    % R.mDiscrimEmoHit= mDiscrimEmoHit;
    % R.mSupraEmoHit= mSupraEmoHit;
    % R.mCatchEmoHit= mCatchEmoHit;
    %
    % R.nDetectTrials = length(vDetectSOA);
    % R.nDiscrimTrials = length(vDiscrimSOA);
    % R.nSupraTrials = length(vSupraSOA);
    % R.nCatchTrials = length(vCatchSOA);
    % --- end of original analyze behavior file ---
    
    %%
    for iType = 1:length(vTrialSOA)
        mSOA(iType) = mean(soa(vTrialSOA{iType}));
        mDetectHit(iType) = mean(detectHit(vTrialSOA{iType}));
        nTrialSOA(iType) = length(vTrialSOA{iType});
    end
    if sum(nTrialSOA) ~= length(soa)
        disp('error in # of trials')
        keyboard
    end
    %%
    [sortedSOA,vSortedSOA] = sort(soa);
    usoa = unique(soa);
    usoa = usoa(~isinf(usoa));
    clear udetecthit
    for iSOA = 1:length(usoa)
        udetecthit(iSOA) = mean(detectHit(soa==usoa(iSOA)));
    end
    
    
    if CHECK_BEHAVIOR
        figure(10),clf,
        set(gcf,'visible',PLOT_VISIBLE_BEHAVIOR)
        
        subplot(2,1,1)
        hold on
        plot(usoa,udetecthit,'o')
        %  plot(0,mean(detectHit(isnan(soa))),'ro','markersize',20)
        %
        [b,stat] = robustfit(usoa,udetecthit);
        plot(usoa,usoa*b(2)+b(1),'r')
        
        %
        xlabel('soa [ms]')
        ylabel('detect hit')
        title([subID ' : ' num2str(sum(nTrialSOA)) ' trials'] )
        
        %%
        subplot(2,1,2)
        plot(mSOA,mDetectHit,'o','markersize',10)
        for iType = 1:length(vTrialSOA)
            % text(mSOA(iType),mDetectHit(iType),num2str(length(vTrialSOA{iType})),'fontsize',20)
        end
        xlabel('soa [ms]')
        ylabel('detect hit')
        title(['# of trials = ' num2str(sum(nTrialSOA)) ' : ' num2str(nTrialSOA) ] )
        
        print(gcf,'-dpng',[DIR.fig '/checkBehavior_' subID '.png'])
        
    end
    warning on
end