setDir_Iowa
removeBadChan = 1;

switch subID
    case '147'
        SUB.subject                       = {'147'  '147'};
        SUB.session                       = [47 48];
        SUB.vSession                      = 1:2;
        SUB.samplerate                    = [2.0345e+03 2.0345e+03];
        SUB.nChan                         = 128;
        SUB.experimentname                = {'cfs_prelim'  'cfs_prelim'};
        SUB.task                          = {'detect'  'detect'};
        SUB.Trial_Num                     = [48 48];
        SUB.dataFile                      = {'147-047'  '147-048'};
        SUB.logFile                       = {'147_sess1_day2_9-28-14-34.mat'  '147_sess2_Day2_9-28-14-45.mat'};
        SUB.photoDiodeReadyVoltage        = [0.4000 0.4000];
        SUB.photoDiodeTriggerVoltage      = [0.6500 0.6500];
    case '149'
        SUB.session                       = [86 87 88 89];
        SUB.vSession                      = 1:4;
        SUB.samplerate                    = [2.0345e+03 2.0345e+03 2.0345e+03 2.0345e+03];
        SUB.nChan                         = 128;
        SUB.Trial_Num                     = [48 48 48 48];
        SUB.dataFile                      = {'149-086',  '149-087',  '149-088',  '149-089'};
%         SUB.dataFile                      = {'pt1490208pm_149-086',  'pt1490208pm_149-087',  'pt1490208pm_149-088',  'pt1490208pm_149-089'};
        SUB.logFile                       = {'Pt149_sess1_2-8-14-20.mat'  'Pt149_sess2_2-8-14-32.mat'  'Pt149_sess3_2-8-14-41.mat'  'Pt149_sess4_2-8-14-52.mat'};
        SUB.experimentname                = {'cfs'  'cfs'  'cfs'  'cfs'};
        SUB.task                          = {'rate'  'rate'  'rate'  'rate'};
        SUB.photoDiodeReadyVoltage        = [0.0250 0.0400 0.0400 0.0400];
        SUB.photoDiodeTriggerVoltage      = [0.0750 0.0600 0.0600 0.0600];

    case '153'
        SUB.session                       = [128 129 130 131];
        SUB.vSession                      = 1:4;
        SUB.samplerate                    = [2.0345e+03 2.0345e+03 2.0345e+03 2.0345e+03];
        SUB.nChan                         = 128;
        SUB.Trial_Num                     = [48 48 48 48];
        SUB.dataFile                      = {'pt1530827am2_153-128',  'pt1530827am2_153-129',  'pt1530827am2_153-130',  'pt1530827am2_153-131'};
        SUB.logFile                       = {'153_8-27-10-52.mat'  '153_2_8-27-11-2.mat'  '153_3_8-27-11-10.mat'  '153_4_8-27-11-19.mat'};
        SUB.experimentname                = {'cfs'  'cfs'  'cfs'  'cfs'};
        SUB.task                          = {'rate'  'rate'  'rate'  'rate'};
        SUB.photoDiodeReadyVoltage        = [0.0250 0.0400 0.0400 0.0400];
        SUB.photoDiodeTriggerVoltage      = [0.0750 0.0600 0.0600 0.0600];
    case '154a'
        SUB.session                       = [73 74];
        SUB.samplerate                    = [2.0345e+03 2.0345e+03];
        SUB.vSession                      = 1:2;

%         SUB.nChan                       = 128;
        SUB.nChan                         = 128;
        SUB.Trial_Num                     = [48 48];
        SUB.dataFile                      = {'154-073',  '154-074'};
        SUB.logFile                       = {'154_9-19-10-31.mat'  '154_2_9-19-10-50.mat'};
        SUB.experimentname                = {'cfs'  'cfs'};
        SUB.photoDiodeReadyVoltage        = [0.2000 0.2000];
        SUB.photoDiodeTriggerVoltage      = [0.4000 0.4000];
    case '154b'
        SUB.session                       = [137];
%         SUB.nChan                       = 128;
        SUB.vSession                      = 1;
        SUB.samplerate                    = [2.0345e+03];
        SUB.nChan                         = 128;
        SUB.Trial_Num                     = [48];
        SUB.dataFile                      = {'154-137'};
        SUB.logFile                       = {'154_9-22-12-22.mat'};
        SUB.experimentname                = {'cfs' };
        SUB.photoDiodeReadyVoltage        = [0.3000];
        SUB.photoDiodeTriggerVoltage      = [0.6000];  
    case '154'
        SUB.session                       = [73 74 137];
        SUB.vSession                      = 1:3;
        SUB.samplerate                    = [2.0345e+03 2.0345e+03 2.0345e+03];
        SUB.nChan                         = 128;
        SUB.experimentname                = {'cfs'  'cfs' 'cfs'};
        SUB.task                          = {'rate'  'rate' 'rate'};
        SUB.Trial_Num                     = [48 48 48];
        SUB.dataFile                      = {'154-073'  '154-074'  '154-137'};
        SUB.logFile                       = {'154_9-19-10-31.mat'  '154_2_9-19-10-50.mat' '154_9-22-12-22.mat'};
        SUB.photoDiodeReadyVoltage        = [0.2000 0.2000 0.3000];
        SUB.photoDiodeTriggerVoltage      = [0.4000 0.4000 0.6];
%         id= [18 19 20 21]
%         subject= {'154'  '154'  '154'  '154'}
%         session= [73 74 0 137]
%         samplerate= [2.0345e+03 2.0345e+03 2.0345e+03 2.0345e+03]
%         experimentname= {'cfs'  'cfs'  'cfs_incomplete'  'cfs'}
%         task= {'rate'  'rate'  'rate'  'rate'}
%         Trial_Num= [48 48 1 48]
%         dataFile= {'154-073'  '154-074'  'x'  '154-137'}
%         logFile= {'154_9-19-10-31.mat'  '154_2_9-19-10-50.mat'  'imc_154_9-22-12-15.mat'  '154_9-22-12-22.mat'}
%         photoDiodeReadyVoltage= [0.2000 0.2000 NaN 0.3000]
%         photoDiodeTriggerVoltage= [0.4000 0.4000 0 0.6000]
    case '156'
        SUB.session                       = [154];
        SUB.vSession                      = 1;
        SUB.nChan                         = 128;
        SUB.samplerate                    = [2.0345e+03];
        SUB.Trial_Num                     = [40];
        SUB.dataFile                      = {'156-154'};
        SUB.logFile                       = {'156_12-14-12-6.mat'};
        SUB.experimentname                = {'cfs'};
        SUB.photoDiodeReadyVoltage        = [-0.2000];
        SUB.photoDiodeTriggerVoltage      = [-0.4000];        
%                           id= [22 23 24 25]
%                      subject= {'156'  '156'  '156'  '156'}
%                      session= [0 0 153 154]
%                   samplerate= [2.0345e+03 2.0345e+03 2.0345e+03 2.0345e+03]
%               experimentname= {'cfs_practice'  'cfs_practice'  'cfs_incomplete'  'cfs'}
%                         task= {'rate'  'rate'  'rate'  'rate'}
%                    Trial_Num= [9 2 9 40]
%                     dataFile= {'x'  'x'  '156-153'  '156-154'}
%                      logFile= {'imc_156_12-14-10-54.mat'  'imc_156_12-14-11-3.mat'  'imc_156_12-14-11-6.mat'  '156_12-14-12-6.mat'}
%       photoDiodeReadyVoltage= [NaN NaN NaN -0.2000]
%     photoDiodeTriggerVoltage= [0 0 0 -0.4000]

    case '168'
        SUB.session                       = [54 55];
        SUB.vSession                      = 1:2;
        SUB.nChan                         = 192;       
        SUB.samplerate                    = [2.0345e+03 2.0345e+03];
        SUB.Trial_Num                     = [48 48];
        SUB.dataFile                      = {'168-54',  '168-55'};
        SUB.logFile                       = {'168_12-10-16-44.mat'  '168_12-10-16-56.mat'};
        SUB.experimentname                = {'cfs'  'cfs'};
        SUB.photoDiodeReadyVoltage        = [0.2000 0.2000];
        SUB.photoDiodeTriggerVoltage      = [0.6000 0.6000];
%                           id= [26 27]
%                      subject= {'168'  '168'}
%                      session= [54 55]
%                   samplerate= [2.0345e+03 2.0345e+03]
%               experimentname= {'cfs'  'cfs'}
%                         task= {'rate'  'rate'}
%                    Trial_Num= [48 48]
%                     dataFile= {'168-54'  '168-55'}
%                      logFile= {'168_12-10-16-44.mat'  '168_12-10-16-56.mat'}
%       photoDiodeReadyVoltage= [0.2000 0.2000]
%     photoDiodeTriggerVoltage= [0.6000 0.6000]
%     case '173'
%         SUB.session       = [37 38 39 40 112 162 164 165];
%         SUB.task          = {'fixationRotate',  'fixationRotate',  'oneBack',  'oneBack', 'fixationRotate',  'oneBack',  'oneBack',  'fixationRotate'};
%         SUB.stimCategory  = {'ekman',  'animal',  'animal',  'animal',  'favorite',  'favorite3',  'favorite2',  'favorite3'};
%         SUB.nChan         = 256;       

    case '178'
        SUB.session                     = [71 73];
        SUB.vSession                    = 1:2;
        SUB.nChan                       = 256;
        SUB.samplerate                  = [2.0345e+03 2.0345e+03];
        SUB.Trial_Num                   = [48 48];
        SUB.dataFile                    = {'178-71', '178-73'};
        SUB.logFile                     = {'178_12-12-9-36.mat', '178_12-12-9-59.mat'};
        SUB.photoDiodeReadyVoltage      = [-0.2000 -0.2000];
        SUB.photoDiodeTriggerVoltage    = [-0.4000 -0.4000];
%                                   id= [28 29 30 31]
%                      subject= {'178'  '178'  '178'  '178'}
%                      session= [71 72 73 74]
%                   samplerate= [2.0345e+03 2.0345e+03 2.0345e+03 2.0345e+03]
%               experimentname= {'cfs'  'cfs_bm'  'cfs'  'cfs_bm'}
%                         task= {'rate'  'rate'  'rate'  'rate'}
%                    Trial_Num= [48 48 48 48]
%                     dataFile= {'178-71'  '178-72'  '178-73'  '178-74'}
%                      logFile= {'178_12-12-9-36.mat'  '178_12-12-9-47.mat'  '178_12-12-9-59.mat'  '178_12-12-10-47.mat'}
%       photoDiodeReadyVoltage= [-0.2000 -0.2000 -0.2000 -0.2000]
%     photoDiodeTriggerVoltage= [-0.4000 -0.4000 -0.4000 -0.4000]

    case '180'
        SUB.session                       = [135];
        SUB.task                          = {'CFS'};
        SUB.nChan                         = 224;
        SUB.Trial_Num                     = [16];
        SUB.dataFile                      = {'pt1800921am1_180-135'};
        SUB.photoDiodeReadyVoltage        = [-0.2000];
        SUB.photoDiodeTriggerVoltage      = [-0.4000];
    case '181'
    case '186'
        SUB.session                       = [143 147];
        SUB.task                          = {'cfs'};
        SUB.Trial_Num                     = [48 48];
        SUB.nChan                         = 251;                      
        SUB.dataFile                      = {'pt1860523pm1_186-143', 'pt1860523pm1_186-147'};
        SUB.photoDiodeReadyVoltage        = [-0.2000 -0.2000];
        SUB.photoDiodeTriggerVoltage      = [-0.4000 -0.4000];
    case '222'
        SUB.session                       = [90 92];
        SUB.vSession                      = 1:2;
        SUB.task                          = {'CFS'};
        SUB.samplerate                    = [2.0345e+03 2.0345e+03];
        SUB.nChan                         = 256;                            
        SUB.Trial_Num                     = [48 48];
        SUB.dataFile                      = {'pt2220920am2_222-090', 'pt2220920am2_222-092'};
        SUB.logFile                       = {'222_9-20-10-48.mat', '222_9-20-11-7.mat'};
        SUB.photoDiodeReadyVoltage        = [-0.01500 -0.01500];
        SUB.photoDiodeTriggerVoltage      = [-0.04000 -0.04000];
    case '232'
        SUB.session                       = [56 57];
        SUB.task                          = {'CFS'};
        SUB.nChan                         = 160;                            
        SUB.Trial_Num                     = [48 48];
        SUB.dataFile                      = {'pt2320121am1_232-056', 'pt2320121am1_232-056'};
        SUB.logFile                       = {'232_1-21-10-44.mat', '232_1-21-10-54.mat'};
        SUB.photoDiodeReadyVoltage        = [-0.01500 -0.01500];
        SUB.photoDiodeTriggerVoltage      = [-0.04000 -0.04000];
    case '242'
%         SUB.session   = [55 57];
%         SUB.task      = {};
%         SUB.nChan     = 256;                              
    otherwise
        keyboard
end

SUB.nSession = length(SUB.session);
SUB.id      = subID;

SUB.tRange  = [-0.8 1.3]; %time before and after stim onset
SUB.ext     = [num2str(SUB.tRange(1) ) '_' num2str( SUB.tRange(2) )];
SUB.fs = SUB.samplerate(1);

switch subID
    case '146'
        SUB.cntID = '146_24_CFS';
    case '147'
        SUB.cntID = '147_DF_CFS';
    case '154a'
        SUB.cntID = '154a_CFS_73_74';
    case '154b'
        SUB.cntID = '154b_DF_BM_CFS_137';
    case '154'
        SUB.cntID = '154_combined';
    case '156'
        SUB.cntID = '156_CFS';
    otherwise
        SUB.cntID = subID;
end

try
    load([DIR.map 'bcntInfo_' SUB.cntID '.mat'],'bCNT')
    SUB.bCNT = bCNT;
catch
    disp(['error = bcntInfo not found, subID ' subID])
end

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
