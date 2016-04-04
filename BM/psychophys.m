function [ trdat,rsps,TSs] = psychophys(fnames,fdir,SUB)

%Returns psychophysical thresholds and trial data

if nargin < 2
    fdir = '';
end

if ~iscell(fnames)
    fnames = {fnames};
end


for i = SUB.vSession
%     if isempty(fnames{i})
%         continue
%     end
    load(sprintf('%s%s%s',fdir,fnames{i}))
    TSs(i) = TS;
    rsps(i) = getrespdata(sprintf('%s%s%s.txt',fdir,fnames{i}));



    trdat(i).soa = rsps(i).data(:,9);   %Stimulus mask SOA
    trdat(i).detectHit = rsps(i).data(:,10);  %Detection hit 
    trdat(i).discrimHit = rsps(i).data(:,11);  %Discrimination Hit
    trdat(i).location =  rsps(i).data(:,3);   % Stimulus Location
    trdat(i).expression=  rsps(i).data(:,4);  % Stimulus Expression
    trdat(i).locationResp  = rsps(i).data(:,5);   % Location Response
    trdat(i).expressionResp= rsps(i).data(:,7);  % Expression Response
    trdat(i).locationRT  = rsps(i).data(:,6);   % Location Response time
    trdat(i).expressionRT= rsps(i).data(:,8);  % Expression Response time
    trdat(i).stimnum = rsps(i).data(:,2);      %  Stimulus ID
    trdat(i).trial = rsps(i).data(:,1);
    trdat(i).block = i*ones(size(rsps(i).data(:,1)));
    trdat(i).file = fnames{i};
    
    trdat(i).psparams.thresh = .25;
    trdat(i).psparams.detectStats.delta= .25;
    trdat(i).psparams.discrimStats.delta= 1/3;
    trdat(i).psparams.FalseNegAsymp = .02;

    trdat(i).psparams.xrange = [0:1:1e3];
    trdat(i).psparams.betas = 0:.1:20;

    keep = trdat(i).location ~=0; 
    trdat(i).keep = keep;
    
%     %Compute thresholds for detection
%     [trdat(i).psparams.detectStats.lP, trdat(i).psparams.detectStats.mM, trdat(i).psparams.detectStats.sdM, trdat(i).psparams.detectStats.mS, trdat(i).psparams.detectStats.sdS] =...
%         WeibFit(trdat(i).soa(keep),trdat(i).detectHit(keep),0,trdat(i).psparams.thresh ,trdat(i).psparams.detectStats.delta,trdat(i).psparams.FalseNegAsymp,trdat(i).psparams.xrange,trdat(i).psparams.betas);
% 
%     trdat(i).detthresh = trdat(i).psparams.detectStats.mM;
% 
%     %Compute thresholds for discrimination
%     [trdat(i).psparams.discrimStats.lP, trdat(i).psparams.discrimStats.mM, trdat(i).psparams.discrimStats.sdM, trdat(i).psparams.discrimStats.mS, trdat(i).psparams.discrimStats.sdS] =...
%         WeibFit(trdat(i).soa(keep),trdat(i).discrimHit(keep),0,trdat(i).psparams.thresh ,trdat(i).psparams.discrimStats.delta,trdat(i).psparams.FalseNegAsymp,trdat(i).psparams.xrange,trdat(i).psparams.betas);
% 
%     trdat(i).discrthresh = trdat(i).psparams.discrimStats.mM;

end

% % 
% for i = 1:length(fnames)
%     criterion(1) = mean([trdat.detthresh]);
%     criterion(2) = mean([trdat.discrthresh]);
%     
%     trdat(i).criterion = criterion;
%     
%     trdat(i).subdet = trdat(i).soa <= criterion(1);
%     
%     trdat(i).subdiscr = trdat(i).soa <= criterion(2);
%     
% end
% 
