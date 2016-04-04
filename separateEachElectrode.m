function separateEachElectrode(subID,EXP,dataset)
% save each electrode as a separate file for easier analysis
% check if photodiode channel is available

dbstop if error
if nargin < 1
    subID = '180'
end

%% load subject info

switch dataset
    case 'localizer'
        subSpecs_IowaLocalizer
    case 'CFS'
        subSpecs_IowaCFS
    case 'BM'
        subSpecs_IowaBM
    case 'DF'
        subSpecs_IowaDF
%         warning('use other DF specific script')
%         keyboard
end  
%% load the file info & save each channel
for iSession = SUB.vSession
    nFiles = dir([DIR.rawData SUB.dataFile{iSession} '*.mat']);
    if strcmpi(dataset,'DF')
        nChan = 0;
    end
    for iFile = 1:length(nFiles) %specifically for sub 162, channels are separated across 2 files per session
        disp(['reading file contents : '  nFiles(iFile).name ' : ' datestr(now) ])
        loadfilename = [DIR.rawData '/' nFiles(iFile).name];
        fileInfo{iSession} = whos('-file',loadfilename);
        
        eachChanDir = [DIR.rawData '/' getfilenum(SUB.session(iSession),3) '/rawEachChan/'];
        if isempty(dir(eachChanDir))
            mkdir(eachChanDir)
        end
        nFileInfo = length(fileInfo{iSession});
        for iFileInfo = 1:nFileInfo
            switch fileInfo{iSession}(iFileInfo).name(1:2)
                case {'li','hi','ev','ex'}
                    savefilename = [getfilenum(SUB.session(iSession),3) '_' fileInfo{iSession}(iFileInfo).name '.mat' ];
                    varname = fileInfo{iSession}(iFileInfo).name;
                    disp([num2str(iFileInfo) ' : ' savefilename ' : (saved) ' varname ' : (orig) ' fileInfo{iSession}(iFileInfo).name ])
                    load(loadfilename, fileInfo{iSession}(iFileInfo).name)
                    
                    save([eachChanDir '/' savefilename ], varname )
                    s = ['clear ' fileInfo{iSession}(iFileInfo).name ';'];
                    eval(s)
                    
                case 'em'
                    disp([SUB.dataFile{iSession} ' : empty found'])
                case 'dn' % DF
                    load(loadfilename)
                    for iChan = 1:size(dndata,3)
                        nChan = nChan+1;
                        savefilename = [getfilenum(SUB.session(iSession),3) '_' 'li' num2str(nChan) '.mat' ];
                        eval(['li' num2str(nChan) '.dat' '=' 'dndata(:,:,iChan)'';']);
                        eval(['li' num2str(nChan) '.chan' '= nChan ;'])
                        disp(['saving ' 'li' num2str(nChan)])
                        save([eachChanDir '/' savefilename ], ['li' num2str(nChan)] )
                        
                    end
                otherwise
                    disp(fileInfo{iSession}(iFileInfo).name)
%                     keyboard
            end
        end
    end
    
    % keyboard
end
