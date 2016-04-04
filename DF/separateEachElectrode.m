function separateEachElectrode(D)
% FB 170614 derived from computeDSDB_250709.m , Localizer_New/Analysis/createBipolarCFSBM.m and Localizer_New/Analysis/separateEachElectrode.m
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
    D.selectTime = [0.95 1.5];
    
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

S = getDF_PatientInfo('subject',D.subject);

D.subDir = [ D.baseDir filesep D.subject]
for iStudy =  1:length(S.session)
    D.params{iStudy} = D.PARAMS;
    
    D.studyDir{iStudy} = [D.subDir filesep D.subject(2:end) '_' getfilenum(S.session(iStudy),3) ];
    D.rawDir{iStudy} = [D.studyDir{iStudy} '/raw'];
    D.dsdbDir{iStudy} = [D.studyDir{iStudy} '/dsdb'];
    %     D.segTimeDir{iStudy} = [D.studyDir{iStudy} '/segTime'];
    %     D.decChanDir{iStudy} = [D.studyDir{iStudy} '/decChan'];
    %     D.decFreqDir{iStudy} = [D.studyDir{iStudy} '/decFreq'];
    %     D.decChanFreqDir{iStudy} = [D.studyDir{iStudy} '/decChanFreq'];
    
    D.params{iStudy}.Fs = S.samplerate(iStudy);
    D.params{iStudy}.fpass = D.PARAMS.fpass;
    
    % rawDataDir{iSession} = [subDir '/' Sub.dataFile{iSession} '/rawEachChan/'];
    rawDataDir{iStudy} = [subDir '/' D.subject(2:end) '-' num2str(S.session(iStudy)) '/rawEachChan/'];
    if isempty(dir(rawDataDir{iStudy}))
        mkdir(rawDataDir{iStudy})
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



vSession = 1:length(D.studyDir)
for iStudy = vSession
    if isfield(D,'skipComputeDSDBStudy')
        if D.skipComputeDSDBStudy == iStudy
            continue
        end
    end
    filenames = dir([D.rawDir{iStudy} filesep '*bank*dn4.mat'])
    
    
    for iFiles = 1:length(filenames)
        disp(['compute DSDB : ' filenames(iFiles).name, ': ' , datestr(now) ])
        load([D.rawDir{iStudy} filesep filenames(iFiles).name]);
        [nTimeTime nTrial nChan] = size(dndata);
        
        for iChan=1:nChan
            iElectrode=iChan+(iFiles-1)*nChan;
            savefile = [rawDataDir{iStudy} '/' D.subject(2:end) '-' num2str(S.session(iStudy)) '_li' num2str(iElectrode) '.mat'];
            eval(['li' num2str(iElectrode) '.dat=dndata(:,:,iChan);']);
            eval(['li' num2str(iElectrode) '.chan=num2str(iElectrode);']);
            save(savefile ,['li' num2str(iElectrode)]);
            eval(['clear li' num2str(iElectrode) ';']);
        end
        
        clear dndata;
        
        %         if isfield(D,'selectTime')
        %             orig_t = 0:nTimeTime;
        %             orig_t = orig_t / D.params{iStudy}.Fs;
        %             vUsedTime = find( D.selectTime(1) <= orig_t & orig_t <= D.selectTime(end) );
        %             dndata = dndata(vUsedTime,:,:);
        %             [nTimeTime nTrial nChan] = size(dndata);
        %         end
        %         tmpdndata = reshape(dndata,nTimeTime,[]);
        %         clear dndata
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
    end
    
end