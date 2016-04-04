function [times2decodeSPG,times2computeSPG,times2downsampleIdx,times2downsample,tt2useERP] = getTimeIdxTW(SPG,DP,tRange,fs)

%% set times

ttAll      = tRange(1):1/fs:tRange(2);
ttSPG      = SPG.times2compute(1):1/fs:SPG.times2compute(2);
ttDP       = DP.times2decode(1):1/fs:DP.times2decode(2);

[~,DP.times2decodeIdx(1)] = min(abs(DP.times2decode(1)-ttSPG));
[~,DP.times2decodeIdx(2)] = min(abs(DP.times2decode(2)-ttSPG));


times2downsampleIdx = DP.times2decodeIdx(1):DP.samplingRate2test:DP.times2decodeIdx(2);
% times2downsampleERP = tmpSPG(iMovingwin).tt;
times2downsample    =  ttSPG(times2downsampleIdx);




[~,tt2useERP(1)] = min(abs(SPG.times2compute(1)-ttAll));
[~,tt2useERP(2)] = min(abs(SPG.times2compute(2)-ttAll));


%%
%TW=timewindow
%TTW=total timewindow

times2decodeSPG = cell(length(SPG.TW),length(SPG.TW));
times2computeSPG = cell(1,length(SPG.TW));

for iTW = 1:length(SPG.TW)
    TW = SPG.TW(iTW);
    times2decodeSort = [];
    for iTTW = 1:length(SPG.TW)
        
        if iTTW<iTW, continue, end
        
        TTW = SPG.TW(iTTW);
        tmpTime2decodeSPG = [];
        if iTTW == iTW
            multipleTimeWindow  = 0;
            nTimeWindow         = NaN;
            times2decodeSPG{iTW,iTTW} = times2downsampleIdx;
            
        elseif iTTW>iTW
            multipleTimeWindow  = 1;
            nTimeWindow         = TTW/TW;
            
            timePoints = linspace(-TTW/2+TW/2,TTW/2-TW/2,nTimeWindow);
            movingwinERP = (1:TW) - TW/2;
            
            for iTime = 1:length(times2downsampleIdx)
                
                tmpSPGIdx = times2downsampleIdx(iTime)+timePoints;
                
                tmpTime2decodeSPG = [tmpTime2decodeSPG tmpSPGIdx];
                
            end
            times2decodeSPG{iTW,iTTW} = tmpTime2decodeSPG;            
        end
        
        times2decodeSort = [times2decodeSort times2decodeSPG{iTW,iTTW}];
    end
    
    times2computeSPG{iTW} = sort(unique(times2decodeSort));
end




%%
% switch DP.decodeSPG
%     case 'FFT'
%         if DP.multipleTimeWindow
%             clear tmpDataPower tmpDataPhase tmpLogData tmpDataFft tmpERP
%             
%             timePoints = linspace(-DP.totalTimeWin/2+SPG.TW(iMovingwin)/2,DP.totalTimeWin/2-SPG.TW(iMovingwin)/2,DP.nTimeWindows2use)+1;
%             
%             movingwinERP = (1:SPG.TW(iMovingwin)) - SPG.TW(iMovingwin)/2;
%             for iTime = 1:length(times2downsampleIdx)
%                 
%                 tmpSPGIdx = times2downsampleIdx(iTime)+timePoints;
%                 SPGIdx = ismember(tmpSPG(iMovingwin).stepCentreIdx, tmpSPGIdx);
%                 
%                 
%                 for iTimeERP = 1:length(timePoints)
%                     tmpERP(iTime,iTimeERP,:,:) = data.erp(times2downsampleIdx(iTime)+timePoints(iTimeERP)+movingwinERP,:);
%                 end
%             end
%             
%         else
%             if 1
%                 SPGIdx = ismember(tmpSPG(iMovingwin).stepCentreIdx, times2downsampleIdx);
%                 
%                 
%                 
%             end
%             
%             movingwinERP = (1:SPG.TW(iMovingwin)) - SPG.TW(iMovingwin)/2;
%             tmpERP = nan(length(times2downsample),length(movingwinERP),size(data.erp,2));
%             for iTime = 1:length(times2downsample)
%                 tmpERP(iTime,:,:)        = squeeze(data.erp(times2downsampleIdx(iTime)+movingwinERP,:));
%             end
%             %     data.logPower   = squeeze(data.logPower (times2downsampleIdx,:,:));
%             
%         end
%     case 'MTSPEC'
%        if 0 
%            data.phase = data.phase(times2downsampleIdx,:,:);
%            data.power = data.power(times2downsampleIdx,:,:);
%            data.fft    = data.fft(times2downsampleIdx,:,:);
%            %         data.erp    = data.erp(times2downsampleIdx,:,:);
%        end
% end