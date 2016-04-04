function createBipolar_Iowa(subID,EXP,SUB,DIR,bCNT)
% derived from getBipolarMontage.m , this version creates vertical and horizontal bipolar channels and creates a mat file for each sub with info
% special treatment for session '154-137' has been removed
% nargin = 0;
% 09 Aug 22 by NT
% rereference the signal to the nearby (close contact number) within the
% same grid or strip group
save_bCNT=0;
if isempty(bCNT)
    save_bCNT=1;
end

HORIZONTAL = 1;
VERTICAL = 1;

bigMatrixBM=0;

dbstop if error
if ~exist('subID','var')
    subID = '153'
end

DIR.fig = [DIR.figBase '/getBipolarMontage/'];
if isempty(dir(DIR.fig))
    mkdir(DIR.fig)
end

vSession = [];
if bigMatrixBM
    rawSessionDir{1} = [DIR.rawData '/' 'allSessions' '/rawEachChan/'];
    vSession = [1]; %
else
    for iSession= SUB.vSession
        rawSessionDir{iSession} = [DIR.rawData '/' getfilenum(SUB.session(iSession),3) '/correctEachChan/'];
        vSession = [vSession iSession]; %
    end
end

checkBipolar =0;%only run one session to check bipolar
if checkBipolar
    vSession=1
end
%%
endName = 5;
PLOT.visible = 'on';
PLOT.eachBipolarMontage = 0;
PLOT.checkPerChan = 0;
PLOT.erp = 0;
PLOT.printPNG = 1;
PLOT.printEPS = 0;
%% get contact info

if save_bCNT
    
    load([DIR.map '/cntInfo.mat'])
    % load([mapDir '/cntInfo_' SUB.cntID '.mat'],'CNT')
    CNT = [];
    for iTmp = 1:length(cntInfo)
        if strcmp( cntInfo(iTmp).id , SUB.cntID)
            CNT = cntInfo(iTmp);
            break
        end
    end
    if isempty(CNT)
        disp('error : cntInfo not found')
        keyboard
    end
    
    load([DIR.map '/cntInfo_' SUB.cntID '.mat'],'CNT')
    
    bCNT = CNT;
    
    %% load photoDiode trigger timing
    
    
    % load temporal and ventral images and coordinates of physical electrodes in the images
    
    load([DIR.mapMatFile SUB.cntID '/aligned_temporal.mat']);
    bCNT.img_temp = img;
    xcent_temp = xcent;
    ycent_temp = ycent;
    
    load([DIR.mapMatFile SUB.cntID '/aligned_ventral.mat']);
    bCNT.img_vent = img;
    xcent_vent = xcent;
    ycent_vent = ycent;
    
    if exist([DIR.mapMatFile SUB.cntID '/aligned_frontal.mat'],'file')
        load([DIR.mapMatFile SUB.cntID '/aligned_frontal.mat']);
        bCNT.img_front = img;
        xcent_front = xcent;
        ycent_front = ycent;
    end
    
    %% load only ROI electrodes
    % nElectrode = length(dir([rawDataDir{iSession} '/' getfilenum(SUB.session(iSession),3) '_li*_rm.mat']));
    nElectrode = length(CNT.label)
    
    getStripsInfo;
    
    % generate information for physical electrodes
    for iSession = vSession
        iElectrode_temp=1;
        iElectrode_vent=1;
        iElectrode_front=1;
        electrode_vent = [];
        electrode_temp = [];
        for iElectrode = 1:nElectrode
            
            if (length(bCNT.label{iElectrode})>12  && strcmp(bCNT.label{iElectrode}(1:13),'Not_Connected'))
                bCNT.view{iElectrode}='Ignore';
                bCNT.hemisphere{iElectrode}='Ignore';
                bCNT.region{iElectrode}='Ignore';
                bCNT.elperline(iElectrode)=el_perline_ignore(1);
                bCNT.elperrow(iElectrode)=el_perrow_ignore(1);
                bCNT.xcent(iElectrode)=NaN;
                bCNT.ycent(iElectrode)=NaN;
                bCNT.flag_select(iElectrode)=0;
            else
                
                if strcmp(bCNT.label{iElectrode}(1),'L')
                    bCNT.hemisphere{iElectrode}='L';
                elseif strcmp(bCNT.label{iElectrode}(1),'R')
                    bCNT.hemisphere{iElectrode}='R';
                elseif strcmp(bCNT.label{iElectrode}(1:end-endName),'subCutaneous_strip')
                    bCNT.hemisphere{iElectrode}='U';
                else
                    disp('Electrode label not recognized... exiting');
                    return;
                end
                
                
                flag_temporal=0;
                for l=1:length(labels_temporal)
                    if strcmp(bCNT.label{iElectrode}(1:end-endName),labels_temporal(l))
                        bCNT.region{iElectrode}=labels_temporal(l);
                        bCNT.elperline(iElectrode)=el_perline_temporal(l);
                        bCNT.elperrow(iElectrode)=el_perrow_temporal(l);
                        flag_temporal=1;
                    end
                end
                if flag_temporal
                    bCNT.view{iElectrode}='temporal';
                    bCNT.xcent(iElectrode)=xcent_temp(iElectrode_temp);
                    bCNT.ycent(iElectrode)=ycent_temp(iElectrode_temp);
                    iElectrode_temp=iElectrode_temp+1;
                    electrode_temp = [electrode_temp iElectrode];
                end
                
                if exist('labels_frontal','var')
                    flag_frontal=0;
                    for l=1:length(labels_frontal)
                        if strcmp(bCNT.label{iElectrode}(1:end-endName),labels_frontal(l))
                            bCNT.region{iElectrode}=labels_frontal(l);
                            bCNT.elperline(iElectrode)=el_perline_frontal(l);
                            bCNT.elperrow(iElectrode)=el_perrow_frontal(l);
                            flag_frontal=1;
                        end
                    end
                    if flag_frontal
                        bCNT.view{iElectrode}='frontal';
                        bCNT.xcent(iElectrode)=xcent_front(iElectrode_front);
                        bCNT.ycent(iElectrode)=ycent_front(iElectrode_front);
                        iElectrode_front=iElectrode_front+1;
                    end
                end
                
                flag_ventral=0;
                for l=1:length(labels_ventral)
                    if strcmp(bCNT.label{iElectrode}(1:end-endName),labels_ventral(l))
                        bCNT.region{iElectrode}=labels_ventral(l);
                        bCNT.elperline(iElectrode)=el_perline_ventral(l);
                        bCNT.elperrow(iElectrode)=el_perrow_ventral(l);
                        flag_ventral=1;
                    end
                end
                if flag_ventral
                    bCNT.view{iElectrode}='ventral';
                    bCNT.xcent(iElectrode)=xcent_vent(iElectrode_vent);
                    bCNT.ycent(iElectrode)=ycent_vent(iElectrode_vent);
                    iElectrode_vent=iElectrode_vent+1;
                    electrode_vent = [electrode_vent iElectrode];
                end
                
                
                flag_none=0;
                for l=1:length(labels_none)
                    if strcmp(bCNT.label{iElectrode}(1:end-endName),labels_none(l))
                        bCNT.region{iElectrode}=labels_none(l);
                        bCNT.elperline(iElectrode)=el_perline_none(l);
                        bCNT.elperrow(iElectrode)=el_perrow_none(l);
                        flag_none=1;
                    end
                end
                if flag_none
                    bCNT.view{iElectrode}='none';
                    bCNT.xcent(iElectrode)=NaN;
                    bCNT.ycent(iElectrode)=NaN;
                end
                
                
                
                
            end
            
            bCNT.pairs(iElectrode,:)=[iElectrode iElectrode]; % just for consistency with bipolar channels
            
        end
    end
    
else
    nElectrode = SUB.nChan(1);
end
%%
if VERTICAL
    % generate vertical bipolar channels across (vertical) lines
    for iSession = vSession
        iBipolar = 0;
        
        clear tmp1 tmp2
        
        count_row=0;
        
        for iElectrode = 1:nElectrode-1 % 1:nElectrode - 1
            %% check if the next electrode is in the same region and in the same line
%             if (strcmp(bCNT.region{iElectrode},bCNT.region{iElectrode+1}) && (mod(iElectrode,bCNT.elperline(iElectrode)) || (bCNT.elperline(iElectrode) - (count_row+1)~=0)) && ~strcmp(bCNT.view{iElectrode},'Ignore')) && ~strcmp(bCNT.hemisphere{iElectrode},'U')
            if (strcmp(bCNT.region{iElectrode},bCNT.region{iElectrode+1}) && (bCNT.elperline(iElectrode) - (count_row+1)~=0) && ~strcmp(bCNT.view{iElectrode},'Ignore')) && ~strcmp(bCNT.hemisphere{iElectrode},'U')
                
                if bigMatrixBM
                    rawDataFile = dir([rawSessionDir{iSession} '/' 'allSession'  '_li' num2str(iElectrode) '.mat']);
                else
                    rawDataFile = dir([rawSessionDir{iSession} '/' getfilenum(SUB.session(iSession),3)  '_li' num2str(iElectrode) '.mat']);
                end
                
                if isempty(rawDataFile)
                    disp(['not found : ' bCNT.label{iElectrode}])
                    continue
                end
                
                if ~exist('tmp1')
                    disp(['start loading ' rawDataFile.name ' : ' datestr(now) ])
                    load([rawSessionDir{iSession} '/' rawDataFile.name])
                    eval(['tmp1 = li' num2str(iElectrode) ';'])
                    eval(['clear li' num2str(iElectrode) ';'])
                end
                
                if bigMatrixBM
                    rawDataFile = dir([rawSessionDir{iSession} '/' 'allSession'  '_li' num2str(iElectrode+1) '.mat']);
                else
                    rawDataFile = dir([rawSessionDir{iSession} '/' getfilenum(SUB.session(iSession),3)  '_li' num2str(iElectrode+1) '.mat']);
                end
                
                %             % rawDataFile = dir([rawDataDir{iSession} '/' getfilenum(SUB.session(iSession),3) '_li' num2str(iElectrode+1) '_rm.mat']); % bipolar creation is now performed before line removal
                %             rawDataFile = dir([rawSessionDir{iSession} '/' getfilenum(SUB.session(iSession),3) '_li' num2str(iElectrode+1) '.mat']);
                if isempty(rawDataFile)
                    disp(['not found : ' bCNT.label{iElectrode+1}])
                    continue
                end
                
                
                
                % disp(['iElectrode = ' num2str(iElectrode) ' : start loading ' rawDataFile.name ' : ' datestr(now) ])
                load([rawSessionDir{iSession} '/' rawDataFile.name])
                eval(['tmp2 = li' num2str(iElectrode+1) ';'])
                eval(['clear li' num2str(iElectrode+1) ';'])
                
                % disp(['getBipolarMontage : ' num2str(iElectrode) ...
                %   ' subtract ' CNT.label{iElectrode} ...
                %    ' from ' CNT.label{iElectrode+1} ])
                tmp3 = tmp2;
                tmp3.dat = tmp2.dat - tmp1.dat;
                tmp3.chan = [ num2str(tmp2.chan) ' - ' num2str(tmp1.chan) ];
                % keyboard
                %% update CNT label
                iBipolar = iBipolar + 1;
                iBipolarElectrode = nElectrode+iBipolar;
                
                %             if strcmp( getfilenum(SUB.session(iSession),3),'154-137')
                %                 if iElectrode == 97
                %                     iBipolar = 1;
                %                 end
                %                 if 97 <= iElectrode
                %                     iBipolarElectrode = iBipolar + 254;
                %                 end
                %             end
                bCNT.label{iBipolarElectrode} = [ 'b' bCNT.label{iElectrode} bCNT.label{iElectrode+1}(end-(endName-1):end)];
                
                %%
                if PLOT.eachBipolarMontage
                    figure(1),clf,
                    set(gcf,'visible',PLOT.visible)
                    subplot(4,1,1)
                    pwelch(tmp3.dat,[],[],[],round(SUB.fs))
                    axis tight
                    xlim([0 0.2])
                    title('spectrum for bipolar')
                    %%
                    subplot(4,1,2)
                    pwelch(tmp1.dat,[],[],[],SUB.samplerate(iSession))
                    axis tight
                    xlim([0 0.2])
                    title(['spectrum for ' bCNT.label{iElectrode}],'interpret','none')
                    %%
                    subplot(2,1,2)
                    hold on
                    vTime = round(1:SUB.samplerate(iSession));
                    tt = vTime/SUB.samplerate(iSession);
                    plot(tt,tmp1.dat(vTime),'r')
                    plot(tt,tmp2.dat(vTime),'g')
                    plot(tt,tmp3.dat(vTime),'b')
                    axis tight
                    % xlim([0 SUB.samplerate])
                    h = legend(bCNT.label{iElectrode},bCNT.label{iElectrode+1},'bipolar');
                    set(h,'box','off','interpret','none')
                    print(gcf,'-dpng',[DIR.fig '/' bCNT.label{iBipolarElectrode} '.png'])
                end
                
                if PLOT.erp
                    if iBipolarElectrode==192 || iBipolarElectrode==294
                        figure,clf
                        H(1) = plot(tmp1.dat);
                        hold on
                        H(2) = plot(tmp2.dat,'r');
                        hold on
                        H(3) = plot(tmp3.dat,'k');
                        xlim([100 200])
                        title([bCNT.label{iElectrode} '-' bCNT.label{iElectrode+1} '/n' bCNT.label{iBipolarElectrode}],'interpret','none')
                        keyboard
                    end
                end
                
                eval(['li' num2str(iBipolarElectrode) '=tmp3;'])
                
                %             disp(['iBipolarElectrode = ' num2str(iBipolarElectrode) ' : saved as ' getfilenum(SUB.session(iSession),3) '_li' num2str(iBipolarElectrode) '_rm.mat : ' datestr(now)]) % bipolar creation is now performed before line removal
                %             savefile = [rawDataDir{iSession} '/' getfilenum(SUB.session(iSession),3) '_li' num2str(iBipolarElectrode) '_rm.mat'];
                
                disp(['iBipolarElectrode = ' num2str(iBipolarElectrode) ' : saved as ' getfilenum(SUB.session(iSession),3) '_li' num2str(iBipolarElectrode) '.mat : ' datestr(now)])
                if bigMatrixBM
                    savefile = [rawSessionDir{iSession} '/' 'allSession' '_li' num2str(iBipolarElectrode) '.mat'];
                else
                    savefile = [rawSessionDir{iSession} '/' getfilenum(SUB.session(iSession),3) '_li' num2str(iBipolarElectrode) '.mat'];
                end
                save(savefile ,['li' num2str(iBipolarElectrode) ])
                eval(['clear li' num2str(iBipolarElectrode) ';'])
                
                tmp1 = tmp2;
                
                
                
                bCNT.view{iBipolarElectrode}=bCNT.view{iElectrode};
                bCNT.hemisphere{iBipolarElectrode}=bCNT.hemisphere{iElectrode};
                bCNT.region{iBipolarElectrode}=bCNT.region{iElectrode};
                bCNT.elperline(iBipolarElectrode)=bCNT.elperline(iElectrode);
                bCNT.elperrow(iBipolarElectrode)=bCNT.elperrow(iElectrode);
                bCNT.xcent(iBipolarElectrode)=(bCNT.xcent(iElectrode)+bCNT.xcent(iElectrode+1))/2;
                bCNT.ycent(iBipolarElectrode)=(bCNT.ycent(iElectrode)+bCNT.ycent(iElectrode+1))/2;
                bCNT.pairs(iBipolarElectrode,:)=[iElectrode iElectrode+1];
                bCNT.flag_select(iBipolarElectrode)=mod(count_row,2)+1;
                count_row=count_row+1;
                
                
                %% check bipolar rereferencing on map
                if PLOT.checkPerChan
                    if ismember(iElectrode,electrode_vent)
                        
%                         if electrode_vent(1) ==  iElectrode
%                             figureSettings
                            image(uint8(bCNT.img_vent))
                            hold on
%                         end
                        plot(bCNT.xcent([iElectrode iElectrode+1]),bCNT.ycent([iElectrode iElectrode+1]),'bo','MarkerSize',7)
                        hold on
                        if iBipolar~=0
                            plot(bCNT.xcent(iBipolarElectrode),bCNT.ycent(iBipolarElectrode),'ro','MarkerSize',7)
                            hold on
                        end
                        bCNT.label{iElectrode}
                        bCNT.label{iBipolarElectrode}
                        bCNT.xcent(iElectrode)
                        bCNT.xcent(iBipolarElectrode)
                        keyboard
                    elseif ismember(iElectrode,electrode_temp)
%                         if electrode_temp(1) ==  iElectrode
%                             figureSettings
                            image(uint8(bCNT.img_temp))
                            hold on
%                         end
                        plot(bCNT.xcent([iElectrode iElectrode+1]),bCNT.ycent([iElectrode iElectrode+1]),'bo','MarkerSize',7)
                        hold on
                        if iBipolar~=0
                            plot(bCNT.xcent(iBipolarElectrode),bCNT.ycent(iBipolarElectrode),'ro','MarkerSize',7)
                            hold on
                        end
                        bCNT.label{iElectrode}
                        bCNT.label{iBipolarElectrode}
                        bCNT.xcent(iElectrode)
                        bCNT.xcent(iBipolarElectrode)
                        keyboard
                    end
                    
                end
                
                
                
            else
                disp(['no bipolar data created: ' num2str(iElectrode)])
                clear tmp1 tmp2
                count_row=0;
            end
            
        end
    end
    
    
    iBipolarVert=iBipolar;
end
%%


if HORIZONTAL
    % generate horizontal bipolar channels across (horizontal) rows
    for iSession = vSession
        iBipolar = iBipolarVert;
        
        clear tmp1 tmp2
        
        count_col=1;
        
        for iElectrode = 1:nElectrode-1 % 1:nElectrode - 1
            jElectrode=iElectrode+bCNT.elperline(iElectrode);
            %% check if the next electrode exists and it is in the same region
            if (jElectrode<=nElectrode && strcmp(bCNT.region{iElectrode},bCNT.region{jElectrode}) && ~strcmp(bCNT.view{iElectrode},'Ignore')) && ~strcmp(bCNT.hemisphere{iElectrode},'U')
                
                
                if bigMatrixBM
                    rawDataFile = dir([rawSessionDir{iSession} '/' 'allSession'  '_li' num2str(iElectrode) '.mat']);
                else
                    
                    rawDataFile = dir([rawSessionDir{iSession} '/' getfilenum(SUB.session(iSession),3)  '_li' num2str(iElectrode) '.mat']);
                end
                %             % rawDataFile = dir([rawDataDir{iSession} '/' getfilenum(SUB.session(iSession),3)  '_li' num2str(iElectrode) '_rm.mat']); % bipolar creation is now performed before line removal
                %             rawDataFile = dir([rawSessionDir{iSession} '/' getfilenum(SUB.session(iSession),3)  '_li' num2str(iElectrode) '.mat']);
                if isempty(rawDataFile)
                    disp(['not found : ' bCNT.label{iElectrode}])
                    continue
                end
                
                %             if ~exist('tmp1')
                disp(['start loading ' rawDataFile.name ' : ' datestr(now) ])
                load([rawSessionDir{iSession} '/' rawDataFile.name])
                eval(['tmp1 = li' num2str(iElectrode) ';'])
                eval(['clear li' num2str(iElectrode) ';'])
                %             end
                
                if bigMatrixBM
                    rawDataFile = dir([rawSessionDir{iSession} '/' 'allSession'  '_li' num2str(jElectrode) '.mat']);
                else
                    rawDataFile = dir([rawSessionDir{iSession} '/' getfilenum(SUB.session(iSession),3)  '_li' num2str(jElectrode) '.mat']);
                end
                %             % rawDataFile = dir([rawDataDir{iSession} '/' getfilenum(SUB.session(iSession),3) '_li' num2str(jElectrode) '_rm.mat']); % bipolar creation is now performed before line removal
                %             rawDataFile = dir([rawSessionDir{iSession} '/' getfilenum(SUB.session(iSession),3) '_li' num2str(jElectrode) '.mat']);
                if isempty(rawDataFile)
                    disp(['not found : ' bCNT.label{jElectrode}])
                    continue
                end
                
                
                
                % disp(['iElectrode = ' num2str(iElectrode) ' : start loading ' rawDataFile.name ' : ' datestr(now) ])
                load([rawSessionDir{iSession} '/' rawDataFile.name])
                eval(['tmp2 = li' num2str(jElectrode) ';'])
                eval(['clear li' num2str(jElectrode) ';'])
                
                % disp(['getBipolarMontage : ' num2str(iElectrode) ...
                %   ' subtract ' CNT.label{iElectrode} ...
                %    ' from ' CNT.label{jElectrode} ])
                tmp3 = tmp2;
                tmp3.dat = tmp2.dat - tmp1.dat;
                tmp3.chan = [ num2str(tmp2.chan) ' - ' num2str(tmp1.chan) ];
                % keyboard
                %% update CNT label
                iBipolar = iBipolar + 1;
                iBipolarElectrode = nElectrode+iBipolar;
                
                %             if strcmp( getfilenum(SUB.session(iSession),3),'154-137')
                %                 if iElectrode == 97
                %                     iBipolar = 1;
                %                 end
                %                 if 97 <= iElectrode
                %                     iBipolarElectrode = iBipolar + 254;
                %                 end
                %             end
                bCNT.label{iBipolarElectrode} = [ 'b' bCNT.label{iElectrode} bCNT.label{jElectrode}(end-(endName-1):end)];
                
                %%
                if PLOT.eachBipolarMontage
                    figure(1),clf,
                    set(gcf,'visible',PLOT.visible)
                    subplot(4,1,1)
                    pwelch(tmp3.dat,[],[],[],round(SUB.samplerate(iSession)))
                    axis tight
                    xlim([0 0.2])
                    title('spectrum for bipolar')
                    %%
                    subplot(4,1,2)
                    pwelch(tmp1.dat,[],[],[],SUB.samplerate(iSession))
                    axis tight
                    xlim([0 0.2])
                    title(['spectrum for ' bCNT.label{iElectrode}],'interpret','none')
                    %%
                    subplot(2,1,2)
                    hold on
                    vTime = round(1:SUB.samplerate(iSession));
                    tt = vTime/SUB.samplerate(iSession);
                    plot(tt,tmp1.dat(vTime),'r')
                    plot(tt,tmp2.dat(vTime),'g')
                    plot(tt,tmp3.dat(vTime),'b')
                    axis tight
                    % xlim([0 SUB.samplerate])
                    h = legend(bCNT.label{iElectrode},bCNT.label{jElectrode},'bipolar');
                    set(h,'box','off','interpret','none')
                    print(gcf,'-dpng',[DIR.fig '/' bCNT.label{iBipolarElectrode} '.png'])
                end
                
                if PLOT.erp
                    if iBipolarElectrode==192 || iBipolarElectrode==294
                        figure,clf
                        H(1) = plot(tmp1.dat);
                        hold on
                        H(2) = plot(tmp2.dat,'r');
                        hold on
                        H(3) = plot(tmp3.dat,'k');
                        xlim([100 200])
                        title([bCNT.label{iElectrode} '-' bCNT.label{iElectrode+1} '/n' bCNT.label{iBipolarElectrode}],'interpret','none')
                        keyboard
                    end
                end
                
                
                
                
                eval(['li' num2str(iBipolarElectrode) '=tmp3;'])
                
                %             disp(['iBipolarElectrode = ' num2str(iBipolarElectrode) ' : saved as ' getfilenum(SUB.session(iSession),3) '_li' num2str(iBipolarElectrode) '_rm.mat : ' datestr(now)]) % bipolar creation is now performed before line removal
                %             savefile = [rawDataDir{iSession} '/' getfilenum(SUB.session(iSession),3) '_li' num2str(iBipolarElectrode) '_rm.mat'];
                
                disp(['iBipolarElectrode = ' num2str(iBipolarElectrode) ' : saved as ' getfilenum(SUB.session(iSession),3) '_li' num2str(iBipolarElectrode) '.mat : ' datestr(now)])
                %             savefile = [rawSessionDir{iSession} '/' getfilenum(SUB.session(iSession),3) '_li' num2str(iBipolarElectrode) '.mat'];
                if bigMatrixBM
                    savefile = [rawSessionDir{iSession} '/' 'allSession' '_li' num2str(iBipolarElectrode) '.mat'];
                else
                    savefile = [rawSessionDir{iSession} '/' getfilenum(SUB.session(iSession),3) '_li' num2str(iBipolarElectrode) '.mat'];
                end
                
                save(savefile ,['li' num2str(iBipolarElectrode) ])
                eval(['clear li' num2str(iBipolarElectrode) ';'])
                
                %             tmp1 = tmp2;
                
                
                
                bCNT.view{iBipolarElectrode}=bCNT.view{iElectrode};
                bCNT.hemisphere{iBipolarElectrode}=bCNT.hemisphere{iElectrode};
                bCNT.region{iBipolarElectrode}=bCNT.region{iElectrode};
                bCNT.elperline(iBipolarElectrode)=bCNT.elperline(iElectrode);
                bCNT.elperrow(iBipolarElectrode)=bCNT.elperrow(iElectrode);
                bCNT.xcent(iBipolarElectrode)=(bCNT.xcent(iElectrode)+bCNT.xcent(jElectrode))/2;
                bCNT.ycent(iBipolarElectrode)=(bCNT.ycent(iElectrode)+bCNT.ycent(jElectrode))/2;
                bCNT.pairs(iBipolarElectrode,:)=[iElectrode jElectrode];
                
                
                count_col_tmp=mod(count_col,2*bCNT.elperline(iElectrode));
                if count_col_tmp==0
                    count_col_tmp=2*bCNT.elperline(iElectrode);
                end
                if count_col_tmp>bCNT.elperline(iElectrode)
                    bCNT.flag_select(iBipolarElectrode)=4;
                else
                    bCNT.flag_select(iBipolarElectrode)=3;
                end
                
                
                count_col=count_col+1;
                
                %% check bipolar rereferencing on map
                if PLOT.checkPerChan
                    if ismember(iElectrode,electrode_vent)
                        
                        if electrode_vent(1) ==  iElectrode
                            figureSettings
                            image(uint8(bCNT.img_vent))
                            hold on
                        end
                        plot(bCNT.xcent([iElectrode iElectrode+1]),bCNT.ycent([iElectrode iElectrode+1]),'bo','MarkerSize',7)
                        hold on
                        if iBipolar~=0
                            plot(bCNT.xcent(iBipolarElectrode),bCNT.ycent(iBipolarElectrode),'ro','MarkerSize',7)
                            hold on
                        end
                        bCNT.label{iElectrode}
                        bCNT.label{iBipolarElectrode}
                        bCNT.xcent{iElectrode}
                        bCNT.xcent{iBipolarElectrode}
                        
                        keyboard
                    end
                end
                
            else
                disp('no bipolar data created')
                clear tmp1 tmp2
                count_col=1;
            end
            
        end
    end
end
%% check bipolar rereferencing
if 1%checkBipolar
    getStripsInfo;
    
    frontChanIdx    =[];
    frontBipChanIdx =[];
    ventChanIdx     =[];
    ventBipChanIdx  =[];
    tempChanIdx     =[];
    tempBipChanIdx  =[];
    for iChan = 1:length(bCNT.label)
        
        if isfield(bCNT,'img_front')
            for iFront = 1:length(labels_frontal)
                if strcmpi(bCNT.label{iChan}(1:end-(endName)),labels_frontal(iFront))
                    frontChanIdx = [frontChanIdx iChan];
                elseif strcmpi([bCNT.label{iChan}(2:end-(endName*2))],labels_frontal(iFront))
                    frontBipChanIdx = [frontBipChanIdx iChan];
                end
            end
        end
        for iVent = 1:length(labels_ventral)
            if strcmpi(bCNT.label{iChan}(1:end-(endName)),labels_ventral(iVent))
                ventChanIdx = [ventChanIdx iChan];
            elseif strcmpi([bCNT.label{iChan}(2:end-(endName*2))],labels_ventral(iVent))
                ventBipChanIdx = [ventBipChanIdx iChan];
            end
        end
        for iTemp = 1:length(labels_temporal)
            if strcmpi(bCNT.label{iChan}(1:end-(endName)),labels_temporal(iTemp))
                tempChanIdx = [tempChanIdx iChan];
            elseif strcmpi([bCNT.label{iChan}(2:end-(endName*2))],labels_temporal(iTemp))
                tempBipChanIdx = [tempBipChanIdx iChan];
            end
        end
        
    end
    
    if isfield(bCNT,'img_front')
        figureSettings
        image(uint8(bCNT.img_front))
        hold on
        plot(bCNT.xcent(frontChanIdx),bCNT.ycent(frontChanIdx),'bo'),plot(bCNT.xcent(frontBipChanIdx),bCNT.ycent(frontBipChanIdx),'ro')
%         keyboard
    end
    
    figureSettings
    image(uint8(bCNT.img_vent))
    hold on
    plot(bCNT.xcent(ventChanIdx),bCNT.ycent(ventChanIdx),'bo'),plot(bCNT.xcent(ventBipChanIdx),bCNT.ycent(ventBipChanIdx),'ro')

    savefilename = [subID '_' 'bipolar_ventral'];
    figureSave
%     keyboard
    


    figureSettings
    image(uint8(bCNT.img_temp))
    hold on
    plot(bCNT.xcent(tempChanIdx),bCNT.ycent(tempChanIdx),'bo'),plot(bCNT.xcent(tempBipChanIdx),bCNT.ycent(tempBipChanIdx),'ro')
    savefilename = [subID '_' 'bipolar_lateral'];
    figureSave
%     keyboard
    
    %     figureSettings
    %     image(uint8(bCNT.img_temp))
    %     hold on
    %     plot(bCNT.xcent(tempChanIdx),bCNT.ycent(tempChanIdx),'bo'),plot(bCNT.xcent(tempBipChanIdx),bCNT.ycent(tempBipChanIdx),'ro')
    %     keyboard
    
end
%% update CNT

% load([mapDir '/bcntInfo.mat'],'bcntInfo')
% for iTmp = 1:length(cntInfo)
%     if strcmp( cntInfo(iTmp).id , SUB.cntID)
%         bcntInfo(iTmp) = bCNT;
%         break
%     end
% end
% disp('update contact information for bipolar montage')
% save([mapDir '/bcntInfo.mat'],'bcntInfo')

% in this version we generate a subject specific bcntInfo structure
if save_bCNT
    disp('generate contact information for bipolar montage')
    save([DIR.map '/bcntInfo_' SUB.cntID '.mat'],'bCNT')
end
% save([mapDir '/bcntInfo_' subID '.mat'],'bCNT')
