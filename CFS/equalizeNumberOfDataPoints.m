function equalizeNumberOfDataPoints(subID)

switch subID
    case '156'
    otherwise
        return
end
subSpecs_IowaCFS

rmLineNoise=0;
vSession = [];
for iSession= 1:SUB.nSession
    if rmLineNoise
        rawSessionDir{iSession} = [DIR.rawData '/' getfilenum(SUB.session(iSession),3) '/rmLineNoiseEachChan/'];
    else
        rawSessionDir{iSession} = [DIR.rawData '/' getfilenum(SUB.session(iSession),3) '/correctEachChan/'];
        saveSessionDir{iSession} = [rawSessionDir{iSession}(1:end-1) '_new/'];
    end
    vSession = [vSession iSession]; %

    if ~exist(saveSessionDir{iSession},'dir')
        mkdir(saveSessionDir{iSession})
    end
end

%%
nElectrode = length(SUB.chan);
for iSession = vSession
    
    clear tmp1 tmp1
    for iElectrode = 1:nElectrode % 1:nElectrode - 1
        if rmLineNoise
            rawDataFile = dir([rawSessionDir{iSession} '/' getfilenum(SUB.session(iSession),3)  '_li' num2str(iElectrode) '_rm.mat']);
        else
            rawDataFile = dir([rawSessionDir{iSession} '/' getfilenum(SUB.session(iSession),3)  '_li' num2str(iElectrode) '.mat']);
        end
        if isempty(rawDataFile)
            disp(['not found : ' bCNT.label{iElectrode}])
            continue
        end
        
        %         if ~exist('tmp1','var')
        load([rawSessionDir{iSession} '/' rawDataFile.name])
        eval(['tmp1 = li' num2str(iElectrode) ';'])
        eval(['clear li' num2str(iElectrode) ';'])
        %     end
        
        if iElectrode==1
            dataLength = length(tmp1.dat);
            tmpT = tmp1.t;
            tmpFS = tmp1.fs;
        end
        
        if length(tmp1.dat)<dataLength
            dataLength = length(tmp1.dat);
            tmpT = tmp1.t;
            tmpFS = tmp1.fs;
        end
    end
    
    for iElectrode = 1:nElectrode
        
        if rmLineNoise
            rawDataFile = dir([rawSessionDir{iSession} '/' getfilenum(SUB.session(iSession),3)  '_li' num2str(iElectrode) '_rm.mat']);
        else
            rawDataFile = dir([rawSessionDir{iSession} '/' getfilenum(SUB.session(iSession),3)  '_li' num2str(iElectrode) '.mat']);
        end
        if isempty(rawDataFile)
            disp(['not found : ' bCNT.label{iElectrode}])
            continue
        end
        
        %         if ~exist('tmp1','var')
        load([rawSessionDir{iSession} '/' rawDataFile.name])
        eval(['tmp1 = li' num2str(iElectrode) ';'])
        eval(['clear li' num2str(iElectrode) ';'])
        
        if length(tmp1.dat) ~= dataLength
            if length(tmp1.dat)>dataLength
                disp(['deleting timepoints of chan li' num2str(iElectrode)])
                dataIdx2delete = zeros(1,length(tmp1.dat));
                A = length(tmp1.dat)/length(tmp1.t);
                dataIdx2delete = repmat(~ismember(tmp1.t,tmpT),1,A);
                
                tmp1.dat(dataIdx2delete) = [];
                tmp1.t (~ismember(tmp1.t,tmpT)) = [];
                tmp1.fs(~ismember(tmp1.t,tmpFS)) = [];
               
                eval(['li' num2str(iElectrode) '=tmp1;'])
                
                save([rawSessionDir{iSession}  num2str(SUB.session(iSession)) '_li' num2str(iElectrode) '.mat'] , ['li' num2str(iElectrode) ])
            else
                keyboard
            end
        end
        
        clear tmp1 tmp1
        
    end
end