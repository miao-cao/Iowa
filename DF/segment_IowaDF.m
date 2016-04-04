function segment_IowaDF(subID)
% FB 170614 derived from computeDSDB.m and Localizer_New/Analysis/segmentFaceLocalizer_bipolar.m
% nargin  = 0

%% Apr 2, 07
% reorganize the preprocessing scheme so that I can use mac minis for
% prerprocessing

% Preprocess
% reproduce Hiroto's 2006 SFN paper Fig 3

% data format:
% -- dndata: time x trial x channel
%       140-007_bank0dn04.mat > 4096x200x16
%
% reshaped into: time x trial-channel
%

% clear all

dbstop if error
subSpecs_IowaDF
%% set parameters for D and params
if  nargin < 1
    D = [];
end

if ~isfield(D,'Job')
    tmpJob = {'convertTochannelDSDB','save','plot','AppendToChannelSDB'};
    D.Job = tmpJob{2};
    
    
    D.stepRatio = [] % 2^1
    % D.movingwin = [0.01 .001] % [.2/D.stepRatio .2/D.stepRatio/2]
    % D.movingwin = [.5 .1]
    % D.movingwin = [0.05 0.01];
    % D.selectTime = [0.95 1.5];
    D.selectTime = [0.5 2]; % trange = [-.5 1] for CFS and Loc
    trange=D.selectTime-1.; % for homogeneity with CFS
    
    D.movingwin = [0.1 0.05]; % identical to setSPG_ParamsCFS.m
    
    D.saveRawSpectgram = 0;
    D.saveLogSpectgram = 0;
    D.subject = 'p147'
end




if ~isfield(D,'PARAMS') % these parameters are identical to the ones in setSPG_ParamsCFS.m
    D.PARAMS.tapers = [3 5];
    D.PARAMS.pad = 1;
    % D.PARAMS.fpass = [0 D.params{iStudy}.Fs/3];
    %     D.PARAMS.fpass = [0 100];
    %     D.PARAMS.fpass = [50 300];
    D.PARAMS.fpass = [0 200];
end

subID=D.subject(2:end);
setDir;

% D.baseDir = [serverDir '/iowa/HirotoData'];
D.baseDir = [serverDir '/IowaData/DF/data/HirotoData437G/'];

%% load subject info
getSubInfo

D.subDir = [ D.baseDir filesep D.subject]
for iSession=1:nSession
    D.params{iSession} = D.PARAMS;
    
    % D.studyDir{iSession} = [D.subDir filesep D.subject(2:end) '_' getfilenum(S.session(iSession),3) ];
    % D.rawDir{iSession} = [D.studyDir{iSession} '/raw'];
    % D.dsdbDir{iSession} = [D.studyDir{iSession} '/dsdb'];
    %     D.segTimeDir{iStudy} = [D.studyDir{iStudy} '/segTime'];
    %     D.decChanDir{iStudy} = [D.studyDir{iStudy} '/decChan'];
    %     D.decFreqDir{iStudy} = [D.studyDir{iStudy} '/decFreq'];
    %     D.decChanFreqDir{iStudy} = [D.studyDir{iStudy} '/decChanFreq'];
    
    D.params{iSession}.Fs = Sub.samplerate(iSession);
    D.params{iSession}.fpass = D.PARAMS.fpass;
    
    %     % rawDataDir{iSession} = [subDir '/' Sub.dataFile{iSession} '/rawEachChan/'];
    %     rawDataDir{iStudy} = [subDir '/' D.subject(2:end) '-' S.session(iStudy) '/rawEachChan/'];
    %     segDataDir{iStudy} = [subDir '/' D.subject(2:end) '-' S.session(iStudy) '/segmented/'];
    %     if ~exist(segDataDir{iStudy},'dir')
    %         mkdir(segDataDir{iStudy})
    %     end
    
    rawDataDir{iSession} = [subDir '/' Sub.dataFile{iSession} '/rawEachChan/'];
    segDataDir{iSession} = [subDir '/' Sub.dataFile{iSession} '/segmented/'];
    if ~exist(segDataDir{iSession},'dir')
        mkdir(segDataDir{iSession})
    end
    
end



switch D.subject
    case 'p147'
        cntID = '147_DF_CFS';
    otherwise
        disp('Check subID');
        return;
end
load([mapDir '/bcntInfo_' cntID '.mat'],'bCNT')




nElectrode=length(bCNT.flag_select);

for iSession= 1:nSession
    if isfield(D,'skipComputeDSDBStudy')
        if D.skipComputeDSDBStudy == iSession
            continue
        end
    end
    
    for iElectrode = 1:nElectrode
        
        rawDataFile = dir([rawDataDir{iSession} '/' Sub.dataFile{iSession}  '_li' num2str(iElectrode) '.mat']);
        if isempty(rawDataFile)
            disp(['not found : ' bCNT.label{iElectrode}])
            continue
        end
        
        % if ~exist('tmp1')
        disp(['start loading ' rawDataFile.name ' : ' datestr(now) ])
        load([rawDataDir{iSession} '/' rawDataFile.name])
        eval(['tmp = li' num2str(iElectrode) ';'])
        eval(['clear li' num2str(iElectrode) ';'])
        
        
        [nTimeTime nTrial] = size(tmp.dat);
        
        
        if isfield(D,'selectTime')
            orig_t = 0:nTimeTime;
            orig_t = orig_t / D.params{iSession}.Fs;
            vUsedTime = find( D.selectTime(1) <= orig_t & orig_t <= D.selectTime(end) );
            tmp.dat = tmp.dat(vUsedTime,:);
        end
        dat=tmp.dat';
        clear tmp
        
        
        %         [s t f ] = mtspecgramc(tmpdndata,D.movingwin,D.params{iStudy});
        %         if isfield(D,'selectTime')
        %             t = t + D.selectTime(1);
        %         end
        %         clear tmpdndata
        %
        %         saveFilename = [num2str(D.movingwin(1)) ,'_', num2str(D.movingwin(2)) '_' ,filenames(iFiles).name ];
        %         if D.saveRawSpectgram
        %             save(['s_' saveFilename ],'s','t','f','D');
        %         end
        %         sdb = 10*log10(s);
        %         clear s
        %         if D.saveLogSpectgram
        %             save(['sdb_' saveFilename ],'sdb','t','f','D');
        %         end
        %         [nTime,nFreq] = size(sdb);
        %         if ~isfield(D,'baselineTime')
        %             D.baselineTime = .5;
        %         end
        %         tBaseline = find(t < D.baselineTime);
        %         sdbmBaseline = mean(sdb(tBaseline,:,:),1);
        %         dsdb = sdb-repmat(sdbmBaseline,[nTime,1]);
        %         if isempty(dir(D.dsdbDir{iStudy}))
        %             mkdir(D.dsdbDir{iStudy})
        %         end
        %         save([D.dsdbDir{iStudy} '/dsdb_' saveFilename],'dsdb','t','f','sdbmBaseline','tBaseline','D');
        %         clear sdbmBaseline sdb dsdb
        
        
        saveFile = [segDataDir{iSession} '/' Sub.dataFile{iSession} ...
            '_li' num2str(iElectrode) ...
            '_seg' num2str(trange(1)) '_' num2str(trange(2)) '.mat'];
        disp(['saving ' saveFile ' : ' datestr(now)])
        save(saveFile,'dat')
        clear dat;
    end
    
end