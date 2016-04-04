function createLogForAllSub_IowaLocalizer(subReadyForAnalysis,EXP)
%% load all subject data
idx = 0;
for iSub = 1:length(subReadyForAnalysis)
    subID = subReadyForAnalysis{iSub};
    subSpecs_IowaLocalizer
 
    
    for iSession =1:SUB.nSession 
        idx = idx+1;
        
        filename = [subID '-' getfilenum(SUB.session(iSession),3)];
        loadfilename = [filename '_trialCheck'];
        load([DIR.seg filesep loadfilename])
        
        filename2save{idx,1}          = filename;
        nSession2save{idx,1}          = num2str(iSession);
        sessionID{idx,1}              = getfilenum(SUB.session(iSession),3);
        stimCat{idx,1}                = SUB.stimCat{iSession};
        behavFile{idx,1}              = num2str(FILE.behFile);
        PPortFile{idx,1}              = num2str(FILE.PPortFile);
        PhDioFile{idx,1}              = num2str(FILE.PhDioFile);
        
        if isfield(trialNumbers,'beh')
            nTrialsBeh{idx,1}             = num2str(trialNumbers.beh);%FILE.nTrials{1};
        else
            nTrialsBeh{idx,1}             = num2str(NaN);
        end
        if isfield(trialNumbers,'PhDio')
            nTrialsPhDio{idx,1}             = num2str(trialNumbers.PhDio);%FILE.nTrials{1};
        else
            nTrialsPhDio{idx,1}             = num2str(NaN);
        end
        if isfield(trialNumbers,'PPort')
            nTrialsPPort{idx,1}             = num2str(trialNumbers.PPort);%FILE.nTrials{1};
        else
            nTrialsPPort{idx,1}             = num2str(NaN);
        end

        vStimCompare{idx,1}           = FILE.evnt;
        alignTrials{idx,1}            = SUB.alignOnset{iSession};
        timingCompare{idx,1}          = FILE.timingCompare;
        timingThreshold{idx,1}        = num2str(FILE.timingDifferenceThreshold);
        timingCompareResult{idx,1}    = FILE.timing;
        
        switch behEvnt.file
            case 'xls'
                task{idx,1}                   = num2str(NaN);

                accuracy{idx,1}               = num2str(NaN);
                pHit{idx,1}                   = num2str(NaN);
                pFA{idx,1}                    = num2str(NaN);
                Aprime{idx,1}                 = num2str(NaN);
                
                faceCont{idx,1}               = num2str(NaN);
                placeCont{idx,1}              = num2str(NaN);
                toolCont{idx,1}               = num2str(NaN);
                mondCont{idx,1}               = num2str(NaN);
                
                
                nTrialsPerCat1{idx,1}        = num2str(length(find(behEvnt.vStim==1)));
                nTrialsPerCat2{idx,1}        = num2str(length(find(behEvnt.vStim==2)));
                nTrialsPerCat3{idx,1}        = num2str(length(find(behEvnt.vStim==3)));
                nTrialsPerCat4{idx,1}        = num2str(length(find(behEvnt.vStim==4)));
                nTrialsPerCat5{idx,1}        = num2str(length(find(behEvnt.vStim==5)));
                
                screenRect1{idx,1}            = num2str(NaN);
                screenRect2{idx,1}            = num2str(NaN);
                screenRect3{idx,1}            = num2str(NaN);
                screenRect4{idx,1}            = num2str(NaN);
                
                stimRect1{idx,1}              = num2str(NaN);
                stimRect2{idx,1}              = num2str(NaN);
                stimRect3{idx,1}              = num2str(NaN);
                stimRect4{idx,1}              = num2str(NaN);
                
                targetEyeLeft{idx,1}          = num2str(NaN);
                
                fixationCrossHalfLength{idx,1}= num2str(NaN);

                framerate{idx,1}              = behEvnt.framerate;
            case 'mat'
                task{idx,1}                   = behEvnt.task;
                
                accuracy{idx,1}               = num2str(behEvnt.accuracy);
                pHit{idx,1}                   = num2str(behEvnt.pHit);
                pFA{idx,1}                    = num2str(behEvnt.pFA);
                Aprime{idx,1}                 = num2str(behEvnt.Aprime);
                
                faceCont{idx,1}               = num2str(behEvnt.faceCont);
                placeCont{idx,1}              = num2str(behEvnt.toolCont);
                toolCont{idx,1}               = num2str(behEvnt.toolCont);
                mondCont{idx,1}               = num2str(behEvnt.mondCont);
                
                if isfield(behEvnt,'nTrialsPerStim')
                    nTrialsPerCat1{idx,1}        = num2str(behEvnt.nTrialsPerStim(1));
                    nTrialsPerCat2{idx,1}        = num2str(behEvnt.nTrialsPerStim(2));
                    nTrialsPerCat3{idx,1}        = num2str(behEvnt.nTrialsPerStim(3));
                    nTrialsPerCat4{idx,1}        = num2str(behEvnt.nTrialsPerStim(4));
                    nTrialsPerCat5{idx,1}        = num2str(behEvnt.nTrialsPerStim(5));
                else
                    nTrialsPerCat1{idx,1}        = num2str(length(find(behEvnt.vStim==1)));
                    nTrialsPerCat2{idx,1}        = num2str(length(find(behEvnt.vStim==2)));
                    nTrialsPerCat3{idx,1}        = num2str(length(find(behEvnt.vStim==3)));
                    nTrialsPerCat4{idx,1}        = num2str(length(find(behEvnt.vStim==4)));
                    nTrialsPerCat5{idx,1}        = num2str(length(find(behEvnt.vStim==5)));
                end
                    
                screenRect1{idx,1}            = num2str(behEvnt.D.screen_rect(1));
                screenRect2{idx,1}            = num2str(behEvnt.D.screen_rect(2));
                screenRect3{idx,1}            = num2str(behEvnt.D.screen_rect(3));
                screenRect4{idx,1}            = num2str(behEvnt.D.screen_rect(4));
                
                stimRect1{idx,1}              = num2str(behEvnt.D.rect_{1}(1));
                stimRect2{idx,1}              = num2str(behEvnt.D.rect_{1}(2));
                stimRect3{idx,1}              = num2str(behEvnt.D.rect_{1}(3));
                stimRect4{idx,1}              = num2str(behEvnt.D.rect_{1}(4));

                targetEyeLeft{idx,1}          = num2str(behEvnt.D.target_eye_left);
                
                fixationCrossHalfLength{idx,1}= num2str(behEvnt.D.lng_fix);
                
                framerate{idx,1}             = num2str(behEvnt.D.frameRate);
        end
        
        
    end
end
clear A
%%

columnTitels = {'fileName','nSession','sessionID','task','stimCategory','behavFile','PPortFile','PhDioFile',...
    'nTrialsBeh','nTrialsPhDio','nTrialsPPort','vStimCompare',...
    'alignTrials','timingCompare','timingThreshold(s)','timingError',...
    'accuracy','pHit','pFA','A''',...
    'faceCont','placeCont','toolCont','mondCont',...
    'nTrialsPerCat1','nTrialsPerCat2','nTrialsPerCat3','nTrialsPerCat4','nTrialsPerCat5',...
    'screenRect1','screenRect2','screenRect3','screenRect4',...
    'stimRect1','stimRect2','stimRect3','stimRect4',...
    'targetEyeLeft','fixationCrossHalfLength','framerate'...
    };

A = [filename2save,nSession2save,sessionID,task,stimCat,(behavFile),(PPortFile),(PhDioFile),...
    nTrialsBeh,nTrialsPhDio,nTrialsPPort,vStimCompare,...
    alignTrials,timingCompare,timingThreshold,timingCompareResult,...
    accuracy,pHit,pFA,Aprime,...
    faceCont,placeCont,toolCont,mondCont,...
    nTrialsPerCat1,nTrialsPerCat2,nTrialsPerCat3,nTrialsPerCat4,nTrialsPerCat5,...
    screenRect1,screenRect2,screenRect3,screenRect4,...
    stimRect1,stimRect2,stimRect3,stimRect4,...
    targetEyeLeft,fixationCrossHalfLength,framerate...
    ];

savefilename='logAllSub';
cd(DIR.base)
f = fopen([savefilename '.xls'], 'w');
fprintf(f,'%s\t',columnTitels{1,:});
fprintf(f,'\n');

for n = 1:idx
    %     fprintf(f, '%s\t%d\t%s\n', A(n), B(n), C{n});
    fprintf(f,'%s\t',A{n,:});
    fprintf(f,'\n');
end
fclose(f);

