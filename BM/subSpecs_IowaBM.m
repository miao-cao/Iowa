setDir_Iowa
removeBadChan = 1;

switch subID
    case '145'
        SUB.session                       = [53 54];% session numbers
        SUB.vSession                      = 1:2;% sessions 2 use
        SUB.samplerate                    = [2.0345e+03 2.0345e+03];
        SUB.nChan                         = 128;% unipolar channels 
        SUB.experimentname                = {'BM'  'BM'};
        SUB.task                          = {'4AFCspatial'  '4AFCspatial'};
        SUB.dataFile                      = {'145-053'  '145-054' };
        SUB.logFile                       = {'Responses_145_1','Responses_145_2'};
%         SUB.evntFile                      = {'049_evnt.mat'  '050_evnt.mat'};
        SUB.evntFile                      = {'053_evnt.mat'  '054_evnt.mat'};        
    case '147'
        SUB.session                       = [49 50];% session numbers
        SUB.vSession                      = 1:2;% sessions 2 use
        SUB.samplerate                    = [2.0345e+03 2.0345e+03];
        SUB.nChan                         = 128;% unipolar channels 
        SUB.seizureFocus                  = 'L';
        SUB.experimentname                = {'BM'  'BM'};
        SUB.task                          = {'4AFCspatial'  '4AFCspatial'};
        SUB.dataFile                      = {'pt1470929am_147-049'  'pt1470929am_147-050' };
        SUB.logFile                       = {'Responses_147_1'  'Responses_147_2'};
        SUB.behFile                       = {'147_beh_session_049_050'};
%         SUB.evntFile                      = {'049_evnt.mat'  '050_evnt.mat'};
        SUB.evntFile                      = {'Recovered_Event_Codes_147-049.mat'  'Recovered_Event_Codes_147-050.mat'};
    case '149' %no parallel port file.
        SUB.session                       = [65 66];
        SUB.vSession                      = 1:2;
        SUB.samplerate                    = [2.0345e+03 2.0345e+03];
        SUB.nChan                         = 128;
        SUB.experimentname                = {'BM'  'BM'};
        SUB.task                          = {'4AFCspatial'  '4AFCspatial'};
        SUB.dataFile                      = {'pt1490207am_149-065'  'pt1490207am_149-066' };
        SUB.logFile                       = {'Responses_149_1'  'Responses_149_2'};
        SUB.behFile                       = {'149_beh_session_065_066'};
        SUB.evntFile                      = {'065_evnt.mat'  '066_evnt.mat'};
    case '153'
        SUB.session                       = [68 69];
        SUB.vSession                      = 1:2;
        SUB.samplerate                    = [2.0345e+03 2.0345e+03];
        SUB.nChan                         = 128;
        SUB.seizureFocus                  = 'R';
        SUB.experimentname                = {'BM'  'BM'};
        SUB.task                          = {'4AFCspatial'  '4AFCspatial'};
        SUB.dataFile                      = {'153-068'  '153-069' };
        SUB.logFile                       = {'Responses_153_1'  'Responses_153_2'};
        SUB.behFile                       = {'153_beh_session_068_069'};
%         SUB.evntFile                      = {'Recovered_Event_Codes_153-068.mat'  'Recovered_Event_Codes_153-068.mat'};
        SUB.evntFile                      = {'068_evnt.mat'  '069_evnt.mat'};
    case '154'
        SUB.session                       = [129 130];
        SUB.vSession                      = 1:2;
        SUB.samplerate                    = [2.0345e+03 2.0345e+03];
        SUB.nChan                         = 128;
        SUB.seizureFocus                  = 'R';
        SUB.experimentname                = {'BM'  'BM'};
        SUB.task                          = {'4AFCspatial'  '4AFCspatial'};
        SUB.dataFile                      = {'154-129'  '154-130' };
        SUB.logFile                       = {'Responses_154_1'  'Responses_154_2'};
        SUB.behFile                       = {'154_beh_session_129_130'};
        SUB.evntFile                      = {'129_evnt.mat'  '130_evnt.mat'};
    case '156'
        SUB.session                       = [117 141];
        SUB.vSession                      = 1:2;
        SUB.samplerate                    = [2.0345e+03 2.0345e+03];
        SUB.nChan                         = 128;
        SUB.seizureFocus                  = 'R';%really left, but temp grid was on right
        SUB.experimentname                = {'BM'  'BM'};
        SUB.task                          = {'4AFCspatial'  '4AFCspatial'};
        SUB.dataFile                      = {'156-117'  '156-141' };
        SUB.logFile                       = {'Responses_156_1'  'Responses_156_2'};
        SUB.behFile                       = {'156_beh_session_117_141'};
        SUB.evntFile                      = {'117_evnt.mat'  '141_evnt.mat'};
    case '162'
        SUB.session                       = [80 81 82 128 129 130];%last 2 sessions are probe detection?
        SUB.vSession                      = 1:4;
        SUB.samplerate                    = [2.0345e+03 2.0345e+03 2.0345e+03 2.0345e+03 2.0345e+03 2.0345e+03];
        SUB.nChan                         = 192;
        SUB.seizureFocus                  = 'L';
        SUB.experimentname                = {'BM'  'BM'};
        SUB.task                          = {'4AFCspatial'  '4AFCspatial' '4AFCspatial' '4AFCspatial' 'probeDet' 'probeDet'};
        SUB.dataFile                      = {'pt1620402pm_162-080'  'pt1620402pm_162-081' 'pt1620402pm_162-082' 'pt1620405am_162-128' 'pt1620405am_162-129' 'pt1620405am_162-130'};
        SUB.logFile                       = {'Responses_162_1'  'Responses_162_2' 'Responses_162_3'  'Responses_162_4' '' ''};
        SUB.behFile                       = {'162_beh_session_080_081_082_128_129_130'};
        SUB.evntFile                      = {'080_evnt.mat'  '081_evnt.mat' '082_evnt.mat' '128_evnt.mat' '129_evnt.mat' '130_evnt.mat'};
    case '178'
        SUB.session                       = [72 74 138];% what are first 2 sessions, different paradigm?
        SUB.vSession                      = 3;
        SUB.samplerate                    = [2.0345e+03 2.0345e+03 2.0345e+03];
        SUB.nChan                         = 256;
        SUB.seizureFocus                  = 'L';
        SUB.experimentname                = {'BM'  'BM'};
        SUB.task                          = {'2AFCtemp'  '2AFCtemp' '4AFCspatial'}; %???
        SUB.dataFile                      = {'178-072'  '178-074' 'pt1781217pm_178-138' '178-138'};% what is the last file?
        SUB.logFile                       = {'' '' 'Responses_178_4' ''};
        SUB.behFile                       = {'178_beh_session_072_074_138'};
        SUB.evntFile                      = {'072_evnt.mat' '074_evnt.mat' '138_evnt.mat'};
end

SUB.nSession = length(SUB.session);
SUB.id      = subID;

SUB.tRange  = [-0.8 1.3]; %time before and after stim onset
SUB.ext     = [num2str(SUB.tRange(1) ) '_' num2str( SUB.tRange(2) )];
SUB.fs      = SUB.samplerate(1);

SUB.allSes = num2str(getfilenum(SUB.session(1),3));
for iSession = 2:SUB.nSession
    SUB.allSes = [SUB.allSes '_' num2str(getfilenum(SUB.session(iSession),3))];
end

switch subID
    case '146'
        SUB.cntID = '146_24_CFS';
    case '147'
        SUB.cntID = '147_BM';
    case '154'
        SUB.cntID = '154b_DF_BM_CFS_137';
    case '156'
        SUB.cntID = '156_DF_BM_Loc';
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
