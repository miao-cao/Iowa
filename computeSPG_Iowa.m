function computeSPG_Iowa(data,iChan,SPG,SUB,savefilenameBase,SPGDir)
% compute the spectrogram of LFP data with previously defined SPG settings
% (e.g. time window, TW), see getSPGsettings_Iowa

%% get timing
fs = SUB.fs;
tt = (1:size(data{1},2))/fs - abs(SUB.tRange(1));

[~,times2computeIdx(1)] = min(abs(SPG.times2compute(1) - tt));
[~,times2computeIdx(2)] = min(abs(SPG.times2compute(2) - tt));

for trialType = 1:length(data)
    data{trialType} = data{trialType}(:,times2computeIdx(1):times2computeIdx(2));
end
tt = tt(times2computeIdx(1):times2computeIdx(2));

%%
    
for iTW = SPG.nTW
    savefilename = [savefilenameBase '_' num2str(SPG.TW(iTW)) ];
    if exist([SPGDir savefilename '.mat'],'file'), 
        continue, 
    else
%         keyboard
    end
    if SPG.TW(iTW) <=2, continue, end
    movingwin = [SPG.TW(iTW)/fs SPG.stepSize/fs];
    
    for trialType = 1:length(data)
        
        [tmpSPG(trialType).power,  tmpSPG(trialType).ttPower,   tmpSPG(trialType).ffPower]    = ...
            mtspecgramc(data{trialType}', movingwin,   SPG.params);
        
        tmpSPG(trialType).logPower = 10*log10(tmpSPG(trialType).power);
        
        [tmpSPG(trialType).phase,  tmpSPG(trialType).ttPhase,   tmpSPG(trialType).ffPhase]    = ...
            mtspecgramc_phase(data{trialType}',movingwin,   SPG.params);
%         
%         [tmpSPG(trialType).fft,    tmpSPG(trialType).ttFft,     tmpSPG(trialType).ffFft]     = ...
%             mtspecgramc_fft(allERP{trialType}',movingwin,   SPG.params);
        
    end
    %% save
    eval(['chan' num2str(iChan) ' = tmpSPG;' ]);
    
    disp(['Finished computing SPG for ' savefilenameBase '_' num2str(SPG.TW(iTW))]);
    
    save([SPGDir savefilename '.mat'],  ['chan' num2str(iChan)],'tt','fs','SPG','-v7.3');
    
    if isdir('/gpfs/M2Home/projects/Monash052/jochem/')
        copyToKani(SPGDir, [savefilename '.mat'])
    end
end

end
%%


