function segmentData(subID,EXP)
% nargin = 0;
% rewritten by NT 2009 Jan 11
% based on getEventOnsetTiming
dbstop if error
if nargin < 1
    subID = '178'
end
PLOT.print = 1;
PLOT.visible = 'off';

%% rewritten by NT, 2009 Jan 10
subSpecs_IowaCFS
DIR.fig = [DIR.figBase '/figureERP/'];
if isempty(dir(DIR.fig))
    mkdir(DIR.fig)
end

%% load subject info
% getSubInfo
%% load photoDiode trigger timing
clear rmpd
vSession = [];
for iSession= 1:SUB.nSession
    clear tmp tmp2
    trigDir{iSession} = [DIR.rawData '/' getfilenum(SUB.session(iSession),3) '/rawEachChan/'];
    rawDataDir{iSession} = [DIR.rawData '/' getfilenum(SUB.session(iSession),3) '/correctEachChan/'];
    segDataDir{iSession} = [DIR.rawData '/' getfilenum(SUB.session(iSession),3) '/segmented/'];
    if isempty(dir(segDataDir{iSession}))
        mkdir(segDataDir{iSession})
    end
    
    trigFile{iSession} = dir([trigDir{iSession} '/*_PdEvtrig.mat']);
%    trigFile{iSession} = dir([rawDataDir{iSession} '/*ex*1_PdEvtrig.mat']);
    
    if isempty(trigFile{iSession})
        disp(['trigFile not found for ' trigDir{iSession}])
        continue
    end
    
    vSession = [vSession iSession]; %
    
    tmp = load([trigDir{iSession} trigFile{iSession}.name]);
    load([trigDir{iSession} trigFile{iSession}.name],'pdTrig');
    PDTRIG{iSession} = pdTrig{iSession};
    
end
%% get contact info
% loadContactInfo_bipolar_CFS
%% get only segment
tmpTrange = PDTRIG{1}(1,1)+SUB.tRange;
vTrange = floor(tmpTrange(1)*SUB.fs) : ceil(tmpTrange(2)*SUB.fs) ;
nTrange = length(vTrange)               
%%

for iSession = vSession
    for iElectrode = SUB.chan
               
        rawDataFile = dir([rawDataDir{iSession} '/' getfilenum(SUB.session(iSession),3) ...
            '_li' num2str(iElectrode) '.mat']);
        if isempty(rawDataFile)
            disp(['li' num2str(iElectrode) '.mat : not found'])
            continue
        end
        
        disp(['start loading ' rawDataFile.name ' : ' datestr(now) ])
        load([rawDataDir{iSession} '/' rawDataFile.name])
        eval(['tmp = li' num2str(iElectrode) ';'])
        data(iElectrode).dat = tmp.dat;
        eval(['clear li' num2str(iElectrode) ';'])

        for iTrial = 1:size(PDTRIG{iSession},1)
            for iInterval = 1:2
                tmpTrange = PDTRIG{iSession}(iTrial,iInterval) + SUB.tRange ;
                % vTrange = floor(tmpTrange(1)*SUB.fs) : ceil(tmpTrange(2)*SUB.fs) ;
                vTrange = [0:nTrange-1] + floor(tmpTrange(1)*SUB.fs); 
                
                if vTrange(end) > length(data(iElectrode).dat);
                    if ~isWarned
                        warning(['data curtailed: possiblly terminated manually : ' SUB.dataFile{iSession}])
                        %%
                        figure(1),clf
                        hold on
                        plot([1:length(data(iElectrode).dat)]/2034.5,data(iElectrode).dat)
                        plot(PDTRIG{1}(:,1)*[1 1],ylim,'k')
                        %%
                        keyboard
                        isWarned = 1;
                    end
                elseif PDTRIG{iSession}(iTrial,iInterval) == 0
                    warning(['photo diode timing = 0: CHECK : ' SUB.dataFile{iSession}])
                    segData(iTrial,:,iInterval) = nan;
                else
                    segData(iTrial,:,iInterval) = data(iElectrode).dat(vTrange);
                end
            end
        end
        
        saveFile = [segDataDir{iSession} '/' getfilenum(SUB.session(iSession),3) ...
            '_li' num2str(iElectrode) ...
            '_seg' num2str(SUB.tRange(1)) '_' num2str(SUB.tRange(2)) '.mat'];
        disp(['saving ' saveFile ' : ' datestr(now)])
        save(saveFile,'segData')
    end
end
