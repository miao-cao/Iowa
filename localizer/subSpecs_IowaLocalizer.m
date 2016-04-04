
removeBadChan = 1;

setDir_Iowa

switch subID
    case '147'
        SUB.session         = [64 65 132 133];
        SUB.dataFile        = {'153-064','153-065','153-132','153-133'};
        SUB.task            = {'fixationColor','oneBack','fixationColor','oneBack'};
        SUB.stimCat         = {'ekman','ekman','ekman','ekman'};
        SUB.nChan           = 128;
        SUB.phDioThreshold  = [-.55 -.6 0.06 0.06];
        SUB.phDioDirection  = {'negative','negative','positive','positive'};
        SUB.phDioStart      = [8.6 6.6 8.8 15.9] * 10000;
        SUB.trialOffset     = [2 2 2 2] * 1000;
        SUB.alignOnset      = {'PhDio','PhDio','PhDio','PhDio'};
        SUB.vSession        = 1:4;
        SUB.fs              = 2.0345e+03;        
    case '153'
        SUB.session         = [64 65 132 133];
        SUB.dataFile        = {'153-064','153-065','153-132','153-133'};
        SUB.task            = {'fixationColor','oneBack','fixationColor','oneBack'};
        SUB.stimCat         = {'ekman','ekman','ekman','ekman'};
        SUB.nChan           = 128;
        SUB.phDioThreshold  = [-.55 -.6 0.06 0.06];
        SUB.phDioDirection  = {'negative','negative','positive','positive'};
        SUB.phDioStart      = [8.6 6.6 8.8 15.9] * 10000;
        SUB.trialOffset     = [2 2 2 2] * 1000;
        SUB.alignOnset      = {'PhDio','PhDio','PhDio','PhDio'};
        SUB.vSession        = 1:4;
        SUB.fs              = 2.0345e+03;
    case '154a'
        % Across session difference, chan 65:96
        SUB.session         = [71 72];
        SUB.dataFile        = {'154-071','154-072'};
        SUB.task            = {'fixationColor','oneBack'};
        SUB.stimCat         = {'ekman','ekman'};
        SUB.nChan           = 128;
        SUB.phDioThreshold  = [0.2 0.2];
        SUB.phDioDirection  = {'positive','positive'};
        SUB.phDioStart      = [5.7 6.3] * 10000;
        SUB.trialOffset     = [2 2] * 1000;
        SUB.alignOnset      = {'PhDio','PhDio'};
        SUB.vSession        = 1:2;
        SUB.fs              = 2.0345e+03;
    case '154b'
        % photodiode data corrupt
        % Across session difference, chan 65:96
        SUB.session         = [134 135];
        SUB.dataFile        = {'154-134','154-135'};
        SUB.task            = {'oneBack','fixationColor'};
        SUB.stimCat         = {'ekman','ekman'};
        SUB.nChan           = 128;
        SUB.phDioThreshold  = [0.05 0.6];
        SUB.phDioDirection  = {'positive','positive'};
        SUB.phDioStart      = [20.45 5.4] * 10000;
        SUB.trialOffset     = [2 2] * 1000;
        SUB.alignOnset      = {'PPort','PPort'};
        SUB.vSession        = 1:2;
        SUB.fs              = 2.0345e+03;
    case '154'
        SUB.session         = [71 72 134 135];
        SUB.dataFile        = {'154-071','154-072','154-134','154-135'};
        SUB.task            = {'fixationColor','oneBack','oneBack','fixationColor'};
        SUB.stimCat         = {'ekman','ekman','ekman','ekman'};
        SUB.phDioThreshold  = [0.2 0.2 0.05 0.6];
        SUB.phDioDirection  = {'positive','positive','positive','positive'};
        SUB.phDioStart      = [5.7 6.3 20.45 5.4] * 10000;
        SUB.trialOffset     = [2 2 2 2] * 1000;
        SUB.alignOnset      = {'PhDio','PhDio','PPort','PPort'};
        SUB.vSession        = 1:4;
%         SUB.nChan       = 160;
        SUB.fs              = 2.0345e+03;
    case '156'
        SUB.session         = [110 111 142 143];
        SUB.dataFile        = {'156-110','156-111','156-142','156-143'};
        SUB.task            = {'fixationColor','oneBack','oneBack','fixationColor'};
        SUB.stimCat         = {'ekman','ekman','ekman','ekman'};
        SUB.phDioThreshold  = [-0.1 -0.1 -0.7 -0.1];
        SUB.phDioDirection  = {'negative','negative','negative','negative'};
        SUB.phDioStart      = [1.42 2 2 7.3] * 10000;
        SUB.trialOffset     = [2 2 2 2] * 1000;
        SUB.alignOnset      = {'PhDio','PhDio','PPort','PhDio'};
        SUB.nChan           = 128;
        SUB.vSession        = 1:4;
        SUB.fs              = 2.0345e+03;
%         SUB.fs              = 2e+03; %protocol says it is 2000. But in
%         the PhDiofile it is 2034.5
    case '168'
        SUB.session         = [51 52];
        SUB.dataFile        = {'168-051','168-051'};
        SUB.task            = {'oneBack','oneBack'};
        SUB.stimCat         = {'ekman','ekman'};
        SUB.phDioThreshold  = [0.15 0.15];
        SUB.phDioDirection  = {'positive','positive'};
        SUB.phDioStart      = [3.7 1.6] * 10000;
        SUB.trialOffset     = [2 2] * 1000;
        SUB.alignOnset      = {'PhDio','PhDio'};
        SUB.nChan           = 192;
        SUB.vSession        = 1:2;
        SUB.fs              = 2.0345e+03;
    case '173'
        SUB.session         = [37 38 39 40 112 162 164 165];
        SUB.dataFile        = {'173-037','173-038','173-039','173-040','173-112','173-162','173-164','173-165'};
        SUB.task            = {'fixationRotate',  'fixationRotate',  'oneBack',  'oneBack', 'fixationRotate',  'oneBack',  'oneBack',  'fixationRotate'};
        SUB.stimCat         = {'ekman',  'animal',  'animal',  'animal',  'favorite',  'favorite3',  'favorite2',  'favorite3'};
        SUB.phDioThreshold  = [0.2 0.1 0.1 0.1 0.04 0.1 0.1 0.1];
        SUB.phDioDirection  = {'positive','positive','positive','positive','positive','positive','positive','positive'};
        SUB.phDioStart      = [0.9 1 4.7 10.55 1 2.3 4.15 1.6] * 10000;
        SUB.trialOffset     = [2 2 2 2 2 2 2 2] * 1000;
        SUB.alignOnset      = {'PhDio','PhDio','PhDio','PhDio','PhDio','PhDio','PhDio','PhDio'};
        SUB.nChan           = 256;
        SUB.vSession        = 1;
        SUB.fs              = 2.0345e+03;
    case '178'
        SUB.session         = [61 62 63 64];
        SUB.dataFile        = {'178-061','178-062','178-063','178-064'};
        SUB.task            = {'fixationColor',  'fixationColor',  'oneBack',  'oneBack'};
        SUB.stimCat         = {'animal','animal','animal','animal'};
        SUB.phDioThreshold  = [-0.1 -0.1 -0.1 -0.1];
        SUB.phDioDirection  = {'negative','negative','negative','negative'};
        SUB.phDioStart      = [6.2 5.8 2.45 6.45] * 10000;
        SUB.trialOffset     = [2 2 2 2] * 1000;
        SUB.alignOnset      = {'PhDio','PhDio','PhDio','PhDio'};
        SUB.nChan           = 256;
        SUB.vSession        = 1:4;
        SUB.fs              = 2.0345e+03;
    case '180'
        SUB.session         = [117 118 120 121];
        SUB.dataFile        = {'pt1800920am1_180-117','pt1800920am1_180-118','pt1800920am1_180-120','pt1800920am1_180-121'};
        SUB.task            = {'fixationRotate','fixationRotate','oneBack','oneBack'};
        SUB.stimCat         = {'animal','ekman','ekman','animal'};
        SUB.phDioThreshold  = [-0.3 -0.3 -0.3 -0.3];
        SUB.phDioDirection  = {'negative','negative','negative','negative'};
        SUB.phDioStart      = [4.6 10.3 11.6 15.8] * 10000;
        SUB.trialOffset     = [2 2 2 2] * 1000;
        SUB.alignOnset      = {'PhDio','PhDio','PhDio','PhDio'};
        SUB.nChan           = 224;
        SUB.vSession        = 2:3;
        SUB.fs              = 2.0345e+03;
    case '181'
        SUB.session         = [1 2];
        SUB.dataFile        = {'pt1811026pm1_181-001','pt1811026pm1_181-002'};
        SUB.task            = {'','oneBack'};
        SUB.stimCat         = {'',''};
        SUB.phDioThreshold  = [-0.3 -0.3];
        SUB.phDioDirection  = {'negative','negative'};
        SUB.phDioStart      = [2.4 0.5] * 10000;
        SUB.trialOffset     = [2 2] * 1000;
        SUB.alignOnset      = {'PhDio','PhDio'};
        SUB.nChan           = 192;
        SUB.vSession        = 1:2;
        SUB.fs              = 2.0345e+03;
    case '186'
        SUB.session         = [77 78 79 80];
        SUB.dataFile        = {'pt1860519am2_186-077','pt1860519am2_186-078','pt1860519am2_186-079','pt1860519am2_186-080'};
        SUB.task            = {'fixationColor','','','fixationColor'};
        SUB.stimCat         = {'ekman','ekman','ekman','ekman'};
        SUB.phDioThreshold  = [-0.2 -0.2 -0.2 -0.2];
        SUB.phDioDirection  = {'negative','negative','negative','negative'};
        SUB.phDioStart      = [2.84 0.72 0.81 1.1] * 10000;
        SUB.trialOffset     = [2 2 2 2] * 1000;
        SUB.alignOnset      = {'PhDio','PhDio','PhDio','PhDio'};
        
        SUB.nChan           = 251;
        SUB.vSession        = 1:4;
        SUB.fs              = 2.0345e+03;
    case '206'
        % behFile has too few trials
        SUB.session         = [60 63];
        SUB.dataFile        = {'206-060','206-063'};
        SUB.task            = {'',''};
        SUB.stimCat         = {'',''};
        SUB.phDioThreshold  = [-0.045 -0.025];
%         SUB.phDioThreshold  = [-0.1 -0.1];
        SUB.phDioDirection  = {'negative','negative'};
        SUB.phDioStart      = [2.5 0.75] * 10000;
        SUB.trialOffset     = [2 2] * 1000;
        SUB.alignOnset      = {'PhDio','PhDio'};
        SUB.nChan           = 192;
        SUB.vSession        = 1:2;
        SUB.fs              = 2.0345e+03;
    case '232'
        SUB.session         = [54 55];
        SUB.dataFile        = {'pt2320121am1_232-054','pt2320121am1_232-055'};
        SUB.task            = {'fixationColor','oneBack'};
        SUB.stimCat         = {'ekman','ekman'};
        SUB.phDioThreshold  = [-0.1 -0.03];
        SUB.phDioDirection  = {'negative','negative'};
        SUB.phDioStart      = [0.46 0.95] * 10000;
        SUB.trialOffset     = [2 2] * 1000;
        SUB.alignOnset      = {'Beh','PhDio'};
        SUB.nChan           = 160;
        SUB.vSession        = 1:2;
        SUB.tStartTime      = [2.3322 NaN];%acquired from phDio data, the first trial was extractable
        SUB.fs              = 2.0345e+03;
    case '242'
        SUB.session         = [55 57];
        SUB.dataFile        = {'pt2420314pm1_242-055','pt2420314pm1_242-057'};
        SUB.task            = {'',''};
        SUB.stimCat         = {'',''};
        SUB.phDioThreshold  = [-0.045 -0.02];
        SUB.phDioDirection  = {'negative','negative'};
        SUB.phDioStart      = [7.3 8.4] * 10000;
        SUB.trialOffset     = [2 2] * 1000;
        SUB.alignOnset      = {'Beh','PhDio'};
        SUB.nChan           = 256;
        SUB.vSession        = 1:2;
        SUB.nChan           = 256;
        SUB.vSession        = 1:2;
        SUB.fs              = 2.0345e+03;
    otherwise
        keyboard
end

if isempty(SUB.stimCat)
    [StimCategory] = getStimCategory(subID,SUB,DIR);
end

SUB.nSession = length(SUB.session);
SUB.id      = subID;
SUB.tRange  = [-0.8 1.3]; %time before and after stim onset
SUB.ext     = [num2str(SUB.tRange(1) ) '_' num2str( SUB.tRange(2) )];

%%
switch subID
    case '154a'
        SUB.cntID = '154a_CFS_73_74';
    case '154b'
        SUB.cntID = '154b_DF_BM_CFS_137';
    case '154'
        SUB.cntID = '154_combined';
    case '156'
        SUB.cntID = '156_DF_BM_Loc';%note, different from CFS!!
    case {'180a','180b'}
        SUB.cntID = '180';
    otherwise
        SUB.cntID = subID;
end

try
    load([DIR.map '/bcntInfo_' SUB.cntID '.mat'],'bCNT')
    SUB.bCNT = bCNT;
catch
    disp('error : bcntInfo not found')
end

%%

if exist('bCNT','var')
    SUB.chan        = 1:length(bCNT.label);
    if ~isfield(SUB,'nChan')
        SUB.nChan = length(find(~strncmpi(bCNT.label,'b',1)));
    end
    SUB.chan_uni    = 1:SUB.nChan(1);
    SUB.chan_bip    = SUB.chan(length(SUB.chan_uni)+1:length(SUB.chan));

    if removeBadChan
        [~,badChanIdx]                  = grep(bCNT.label,'Not_Connected');
        SUB.chan(find(badChanIdx))      = [];
        SUB.chan_uni(find(badChanIdx))  = [];
    end
else
    SUB.chan        = 1:SUB.nChan(1);
    SUB.chan_uni    = 1:SUB.nChan(1);
    SUB.chan_bip    = [];
end
% end
skipChan=0;
if ~exist('arrayID','var') || isempty(arrayID)
    arrayID = SUB.chan_bip;
elseif length(arrayID) == 1
    if ~ismember(arrayID, SUB.chan(length(SUB.chan_uni)+1:length(SUB.chan)));
        skipChan=1;
        return,
    end
else
    arrayID(~ismember(arrayID,SUB.chan))=[];
end

