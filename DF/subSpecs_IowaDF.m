
removeBadChan = 1;

setDir_Iowa

switch subID
    case '147'
        SUB.session         = [018 019];
        SUB.task            = {'DF','DF'};
        SUB.stimCat         = {'checkerboard','checkerboard'};
        SUB.nChan           = 128;
        SUB.dataFile        = {['147-' num2str(getfilenum(SUB.session(1),3))], ['147-' num2str(getfilenum(SUB.session(2),3))] };
%         SUB.phDioThreshold  = [-.55 -.6 0.06 0.06];
%         SUB.phDioDirection  = {'negative','negative','positive','positive'};
%         SUB.phDioStart      = [8.6 6.6 8.8 15.9] * 10000;
        SUB.trialOffset     = [2 2 2 2] * 1000;
        SUB.alignOnset      = {'PhDio','PhDio','PhDio','PhDio'};
        SUB.vSession        = [1 2];
        SUB.fs              = 2.0345e+03;        
    otherwise
        keyboard
end

% if isempty(SUB.stimCat)
%     [StimCategory] = getStimCategory(subID,SUB,DIR);
% end

SUB.nSession = length(SUB.session);
SUB.id      = subID;
SUB.tRange  = [-0.8 1.3]; %time before and after stim onset
SUB.ext     = [num2str(SUB.tRange(1) ) '_' num2str( SUB.tRange(2) )];

%%
switch subID
    case '147'
        SUB.cntID = '147_DF_CFS';
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

