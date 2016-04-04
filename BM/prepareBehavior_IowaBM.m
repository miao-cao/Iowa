function prepareBehavior_IowaBM(subID)
% based on process_data.m

subSpecs_IowaBM
% respdata = { {'Responses_145_1','Responses_Pt145_2'}
%     {'Responses_147_1','Responses_147_2'} %GET
%     {'Responses_149_1','Responses_149_2'}
%     %              {'Responses_pt_149_sess1_1','Responses_pt149_sess2_2'}
%     {'Responses_153_1','Responses_153_2'}
%     {'Responses_154_1','Responses_154_2'}
%     {'Responses_156_1','Responses_156_2'}
%     {'Responses_162_1','Responses_162_2','Responses_162_3','Responses_162_4'}
%     {'Responses_178_4'}};



[ trialDataPerSes,respPerSes,TSs] = psychophys(SUB.logFile,DIR.behBase,SUB);


% respData =  respPerSes(1);
% trialData = struct([]);

trialData.soa               = cat(1,trialDataPerSes.soa);
trialData.detectHit         = cat(1,trialDataPerSes.detectHit);
trialData.discrimHit        = cat(1,trialDataPerSes.discrimHit);
trialData.location          = cat(1,trialDataPerSes.location);
trialData.expression        = cat(1,trialDataPerSes.expression);
trialData.locationResp      = cat(1,trialDataPerSes.locationResp);
trialData.expressionResp    = cat(1,trialDataPerSes.expressionResp);
trialData.locationRT        = cat(1,trialDataPerSes.locationRT);
trialData.expressionRT      = cat(1,trialDataPerSes.expressionRT);
trialData.stimnum           = cat(1,trialDataPerSes.stimnum);
trialData.trial             = cat(1,trialDataPerSes.trial);
trialData.block             = cat(1,trialDataPerSes.block);
trialData.keep              = cat(1,trialDataPerSes.keep);


for iSession = SUB.vSession
    trialData.file{iSession}        = trialDataPerSes(iSession).file;
    trialData.psparams(iSession)    = trialDataPerSes(iSession).psparams;
end
    
savefilename = [subID '_' 'beh' '_' 'session' '_' SUB.allSes];

save([DIR.beh savefilename '.mat'],'trialData','trialDataPerSes','respPerSes','TSs')
% keyboard