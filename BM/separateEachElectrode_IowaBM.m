function separateEachElectrode_IowaBM(subID)

% save each electrode as a separate file for easier analysis
% check if photodiode channel is available
dbstop if error
if nargin < 1
    subID = '147'
end

%% load subject info
subSpecs_IowaBM
%% load the file info & save each channel

if exist([DIR.rawData filesep SUB.dataFile{1} '.mat'],'file')
    for iSession = 1:SUB.nSession
        disp(['reading file contents : '  SUB.dataFile{iSession} ' : ' datestr(now) ])
        loadfilename        = [DIR.rawData filesep SUB.dataFile{iSession} '.mat'];
        fileInfo{iSession}  = whos('-file',loadfilename);
        
        eachChanDir = [DIR.rawData '/' getfilenum(SUB.session(iSession),3) '/rawEachChan/'];
        if isempty(dir(eachChanDir))
            mkdir(eachChanDir)
        end
        
        
        nFileInfo = length(fileInfo{iSession});
        for iFileInfo = 1:nFileInfo
            % disp(fileInfo{iSession}(iFileInfo).name)
            switch fileInfo{iSession}(iFileInfo).name(1:2)
                case {'li','hi','ev','ex'}
                    savefilename = [getfilenum(SUB.session(iSession),3) '_' fileInfo{iSession}(iFileInfo).name '.mat' ];
                    varname = fileInfo{iSession}(iFileInfo).name;
                    %                end
                    disp([num2str(iFileInfo) ' : ' savefilename ' : (saved) ' varname ' : (orig) ' fileInfo{iSession}(iFileInfo).name ])
                    load(loadfilename, fileInfo{iSession}(iFileInfo).name)
                                        
                    save([eachChanDir '/' savefilename ], varname )
                    s = ['clear ' fileInfo{iSession}(iFileInfo).name ';'];
                    eval(s)
                    
                case 'em'
                    disp([SUB.dataFile{iSession} ' : empty found'])
                otherwise
                    disp(fileInfo{iSession}(iFileInfo).name)
                    keyboard
            end
        end
        
        
        % keyboard
    end
    
else % get large precomputed dataset
    %%
    filename = ['BM' subID '.mat'];
    
    eachChanDir = [DIR.rawData '/' 'allSessions' '/rawEachChan/'];
    if isempty(dir(eachChanDir))
        mkdir(eachChanDir)
    end
    
    
    for iElectrode = 1:SUB.nChan
        disp(['channel ' num2str(iElectrode)])
        electrodeName = ['lfp' num2str(iElectrode)];
        
        load([DIR.rawData filename] ,electrodeName)
        eval(['tmp.dat = ' electrodeName ';'])
        eval(['clear ' electrodeName])
        
        tmp.chan = iElectrode;
%         tmp.fs = 
        eval(['li' num2str(iElectrode) '=tmp;'])
        clear tmp
        savefilename = ['allSession' '_' 'li' num2str(iElectrode) '.mat' ];
        save([eachChanDir savefilename],['li' num2str(iElectrode) ])
        eval(['clear li' num2str(iElectrode) ';'])
    end
    
end



end
