function prepareSegmentWithBeh(subID,EXP)
%
% this function checks the available behavioural files for a particular
% session, this/these can be a combination of several .xls and .mat files.
% It compares these against each other and saves the relevant information.

if ~exist('subID','var')
    subID = '153';
end
if ~exist('iSession','var')
    iSession=1;
end
subSpecs_IowaLocalizer

for iSession = 1:SUB.nSession
    clear behEvnt* v* fixationChange vCenterTask stim* resp*
    filename = [subID '-' getfilenum(SUB.session(iSession),3)];
    
    %%
    disp(['loading beh files from ' filename ' : ' datestr(now) ])
    behFiles = dir([DIR.beh subID '*']);
    
    [~,evntIdx] =  grep({behFiles.name}, filename);
    evntIdx = find(evntIdx);
    
    for iBehFile = 1:length(evntIdx)
        switch behFiles(evntIdx(iBehFile)).name(end-3:end)
            case '.xls'
                %% read xls file, line by line
                behEvntXls = struct([]);
                
                iDate = 0; %sometimes there are multiple sessions within one xls file.. separate them and see to which session it belongs, if present, compare it to the mat file
                fileExtBeh{iBehFile} = '.xls';
                
                fin = fopen([DIR.beh behFiles(evntIdx(iBehFile)).name],'r');
                delimiter = '\t';
                
                while ~feof(fin)
                    s=fgets(fin);
                    tmp = strread(s,'%s','delimiter',delimiter);
                    while isempty(tmp)
                        s=fgets(fin);
                        tmp = strread(s,'%s','delimiter',delimiter);
                    end
                    
                    if strcmpi(tmp{1}(1:4),['Date'])
                        iDate   = iDate + 1;
                        iTrial  = 1;
                        
                        behEvntXls(iDate).date = tmp{1};
                        s=fgets(fin);
                        tmp = strread(s,'%s','delimiter',delimiter);
                        behEvntXls(iDate).time = tmp{1};
                        s=fgets(fin);
                        tmp = strread(s,'%s','delimiter',delimiter);
                        behEvntXls(iDate).session = tmp{1};
                        s=fgets(fin);
                        tmp = strread(s,'%s','delimiter',delimiter);
                        behEvntXls(iDate).framerate = tmp{1};
                        
                        s=fgets(fin);
                        tmp = strread(s,'%s','delimiter',delimiter);
                        
                    elseif strcmpi(tmp{1},'iTrial:')
                        s=fgets(fin);
                        tmp = strread(s,'%s','delimiter',delimiter);
                        behEvntXls(iDate).trial(iTrial).vStim = str2double(tmp{2});
                        behEvntXls(iDate).vStim(iTrial)       = str2double(tmp{2});
                        s=fgets(fin);
                        tmp = strread(s,'%s','delimiter',delimiter);
                        behEvntXls(iDate).trial(iTrial).resp = str2double(tmp{2});
                        s=fgets(fin);
                        tmp = strread(s,'%s','delimiter',delimiter);
                        behEvntXls(iDate).trial(iTrial).RT = str2double(tmp{2});
                        iTrial = iTrial+1;
                        
                    elseif strcmpi(tmp{1}(1:5),'start')
                        behEvntXls(iDate).startExpTime = str2double(tmp{2});
                        s=fgets(fin);
                        tmp = strread(s,'%s','delimiter',delimiter);
                        behEvntXls(iDate).endExpTime = str2double(tmp{2});
                        
                    end
                    
                end
                fclose(fin);
                %             keyboard
                %             for iTrial = 1:length(behEvntXls
                
            case '.mat'
                %% get relevant information out of mat file
                behEvntMat = struct([]);
                fileExtBeh{iBehFile} = '.mat';
                
                load([DIR.beh behFiles(evntIdx(iBehFile)).name])%, ...
                %                 'vStim','resp','responseTime','startTrialTime','endTrialTime','ITI','endExpTime','startExpTime')
                
                behEvntMat(1).vStim = vStim;
                
                %             try
                behEvntMat(1).resp = resp;
                %             end
                
                behEvntMat(1).RT               = responseTime;
                behEvntMat(1).startTrialTime   = startTrialTime;
                behEvntMat(1).endTrialTime     = endTrialTime;
                behEvntMat(1).ITI              = ITI;
                
                if exist('oneBack','var')
                    behEvntMat(1).oneBack = oneBack;
                    behEvntMat(1).task = 'oneBack';
                end
                
                if exist('fixationChange','var')
                    behEvntMat(1).fixationChange = fixationChange;
                    behEvntMat(1).task = 'fixationColor';
                end
                
                if exist('iCenterTask','var')
                    switch iCenterTask
                        case 0
                            behEvntMat(1).fixationChange = vCenterTask;
                            behEvntMat(1).task = 'fixationRotate';
                        case 1
                            behEvntMat(1).fixationChange = vCenterTask;
                            behEvntMat(1).task = 'fixationColor';
                        case 2
                            behEvntMat(1).oneBack = vCenterTask;
                            behEvntMat(1).task = 'oneBack';
                    end
                end
                
                if exist('nTrialPerStim','var')
                    behEvntMat(1).nTrialsPerStim            = nTrialPerStim;
                end
                
                if exist('vStimID','var') && ~exist('stimID','var')
                    behEvntMat(1).vStimID                   = vStimID;
                elseif ~exist('vStimID','var') && exist('stimID','var')
                    behEvntMat(1).vStimID                   = stimID;
                else
                    keyboard
                end
                
                if exist('FaceCont','var')
                    behEvntMat(1).faceCont                  = FaceCont;
                elseif exist('faceCont','var')
                    behEvntMat(1).faceCont                  = unique(faceCont(~isnan(faceCont)));
                else
                    behEvntMat(1).faceCont                  = NaN;
                end
                
                if exist('ToolCont','var')
                    behEvntMat(1).toolCont                  = ToolCont;
                elseif exist('toolCont','var')
                    behEvntMat(1).toolCont                  = unique(toolCont(~isnan(toolCont)));
                else
                    behEvntMat(1).toolCont                  = NaN;
                end
                
                if exist('PlaceCont','var')
                    behEvntMat(1).placeCont                  = PlaceCont;
                elseif exist('placeCont','var')
                    behEvntMat(1).placeCont                  = unique(placeCont(~isnan(placeCont)));
                else
                    behEvntMat(1).placeCont                  = NaN;
                end
                
                if exist('MondCont','var')
                    behEvntMat(1).mondCont                  = MondCont;
                elseif exist('mondCont','var')
                    behEvntMat(1).mondCont                  = unique(mondCont(~isnan(mondCont)));
                else
                    behEvntMat(1).mondCont                  = NaN;
                end
                
                behEvntMat(1).startExpTime              = startExpTime;
                if exist('endExpTime','var')
                    behEvntMat(1).endExpTime                = endExpTime;
                end
                behEvntMat(1).D                         = D;
                behEvntMat(1).S                         = S;
                
                
                switch behEvntMat(1).task
                    case 'oneBack'
                        behEvntMat(1).accuracy = length(find(behEvntMat(1).resp == behEvntMat(1).oneBack))/behEvntMat(1).S.nTrial;
                        
                        behEvntMat(1).pHit = sum(behEvntMat(1).resp==1 & behEvntMat(1).oneBack == 1)/sum(behEvntMat(1).oneBack == 1);
                        behEvntMat(1).pFA  = sum(behEvntMat(1).resp==1 & behEvntMat(1).oneBack == 0)/sum(behEvntMat(1).oneBack == 0);
                        
                        behEvntMat(1).Aprime = AreaUnderROC([[0 behEvntMat(1).pHit 1]', [0 behEvntMat(1).pFA 1]']);
                        %                     title({[subjectname, ' : task performance'];...
                        %                         ['pHit=',num2str(pHit),': pFA=',num2str(pFA),': A''=',num2str(Aprime)]},'interpret','none')
                    case {'fixationColor','fixationRotate'}
                        behEvntMat(1).accuracy = length(behEvntMat(1).resp == behEvntMat(1).fixationChange)/behEvntMat(1).S.nTrial;
                        
                        behEvntMat(1).pHit = sum(behEvntMat(1).resp==1 & behEvntMat(1).fixationChange == 1)/sum(behEvntMat(1).fixationChange == 1);
                        behEvntMat(1).pFA  = sum(behEvntMat(1).resp==1 & behEvntMat(1).fixationChange == 0)/sum(behEvntMat(1).fixationChange == 0);
                        
                        behEvntMat(1).Aprime = AreaUnderROC([[0 behEvntMat(1).pHit 1]', [0 behEvntMat(1).pFA 1]']);
                        %
                        %                 case 'fixationRotate'
                        %                     keyboard
                end
                
                
        end
    end
    
    %% compare the two behavioural files, if multiple files exist
    if exist('behEvntXls','var') && exist('behEvntMat','var')
        startTimeCompare = zeros(1,length(behEvntXls));
        endTimeCompare = zeros(1,length(behEvntXls));
        
        for iBeh = 1:length(behEvntXls)
            if isempty(behEvntXls(iBeh).startExpTime) 
                startTimeCompare(iBeh)  = NaN;
                endTimeCompare(iBeh)    = NaN;
            else
                startTimeCompare(iBeh)  = behEvntXls(iBeh).startExpTime - behEvntMat.startExpTime;
                endTimeCompare(iBeh)    = behEvntXls(iBeh).endExpTime   - behEvntMat.endExpTime;
            end
        end
        
        [~, behXlsIdx(1)] = min(abs(startTimeCompare));
        [~, behXlsIdx(2)] = min(abs(endTimeCompare));
        
        if behXlsIdx(1) ~= behXlsIdx(2)
            warning('Xls start- and endTimes don''t correspond with Mat file')
        end
        
        %check number of trials between xls and mat files
        if length(behEvntXls(behXlsIdx(1)).trial) ~= length(behEvntMat.vStim)
            warning('nTrials not the same for xls and mat behaviour files')
%             keyboard
        end
        
        %check number of trials between xls and mat files
        for iTrial = 1:length(behEvntMat.vStim)
            if behEvntXls(behXlsIdx(1)).trial(iTrial).vStim ~= behEvntMat.vStim(iTrial)
                warning(['vStim is not the same for xls and mat behaviour files for trial ' num2str(iTrial)])
%                 keyboard
            end
        end
        
        behEvnt = behEvntMat; % if we have both xls and mat file, we use mat. More information there
        behEvnt.file = 'mat';
    elseif exist('behEvntXls','var')
        behEvnt = behEvntXls;
        
    elseif exist('behEvntMat','var')
        behEvnt = behEvntMat;
        behEvnt.file = 'mat';
    end
    
    switch filename
        case '186-078'
            behEvnt = behEvnt(1);
        case '186-079'
            behEvnt = behEvnt(2);
        case '206-060'
            behEvnt = behEvnt(4);
        case '206-063'
            behEvnt = behEvnt(3);
            
    end
    if length(behEvnt)>1
        warning('behEvnt has multiple trial sets (from xls)')
%         keyboard
    end
    
    if exist('behEvntXls','var') && ~exist('behEvntMat','var')
        behEvnt.file = 'xls';
        
        for iTrial = 1:length(behEvnt.vStim)
            behEvnt.resp(iTrial) = behEvnt.trial(iTrial).resp;
            behEvnt.RT(iTrial) = behEvnt.trial(iTrial).RT;
        end
        behEvnt=rmfield(behEvnt,'trial');
        
    end
    %% save behavioral file
    % keyboard
    save([DIR.seg filesep filename '_behav.mat'],'behEvnt','fileExtBeh')
end
