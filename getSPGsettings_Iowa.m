% function SPG = getSPGsettings_Iowa
% getSPGsettings

SPG.qid                      = 0.05;        %significance level for checkGammaPower, checkLowFreqPhase, checkMovingWinPAC

SPG.subtractBaseline         = 1;           %subtract baseline in checkRawData, checkGammaPower and checkLowFreqPhase
SPG.baseline                 = [-.3 -.1];

SPG.ff2checkPower            = [0 200];
SPG.ff2checkPhase            = [0 40];

SPG.times2compute           = [-0.8 1.3]; %will automatically reduce with half the size of the largest movingwindow
SPG.times2check              = [-0.5 1]; %times 2 check for checkGammaPower and checkLowFreqPhase

SPG.TW                      = [2 2^2 2^3 2^4 2^5 2^6 2^7 2^8 2^9 2^10]; %nSamples
SPG.nTW                     = 10;
SPG.stepSize                = 200; %samples

SPG.params.tapers           = [1 1];
SPG.params.Fs               = SUB.fs;
SPG.params.fpass            = [1 200]; % online filter during recordings

% SPG.stepSizes               = [0.5 1 2 4 8 16 32 64 128];
% SPG.TW   = [2^10]; %nSamples


% % low freq phase
% movingwin.phase = [0.5 0.001];
% params.phase.tapers = [1 1];
% params.phase.Fs = fs;
% params.phase.fpass = [1 20];
% % high freq power
% movingwin.power = [0.05 0.001];
% params.power.tapers = [1 1];
% params.power.Fs = fs;
% params.power.fpass = [1 200];
% 
% movingwin.fft = [0.05 0.001];
% params.fft.tapers = [1 1];
% params.fft.Fs = fs;
% params.fft.fpass = [1 200];
% 

% %% SPG settings
% 
% SPG.qid                      = 0.05; %significance level for checkGammaPower, checkLowFreqPhase, checkMovingWinPAC
% SPG.times2check              = [-0.5 1]; %times 2 check for checkGammaPower and checkLowFreqPhase
% 
% SPG.subtractBaseline         = 1; %subtract baseline in checkRawData, checkGammaPower and checkLowFreqPhase
% SPG.baseline                 = [-.3 -.1];
% 
% SPG.ff2checkPower            = [50 150];
% SPG.ff2checkPhase            = [1 40];
% SPG.times2compute            = [-1.5 1.5]; %will automatically reduce with half the size of the largest movingwindow
% 
% SPG.sepSes                   = 0;%compute SPG on separate sessions
% SPG.distributeTrials         = 0;%create sessions with +/- equal number of trials, for decoding
% SPG.nSessionDecode           = NaN; % number of sessions created
% 
% % % (movingWin)PAC settings
% 
% SPG.permute             = 1;
% SPG.nPermutes           = 100;
% 
% SPG.samplingRate2test   = [fs];
% SPG.movingWindowPAC     = [250]; %in ms
% 
% SPG.times2savePAC       = [-0.2:0.1:1];
% SPG.nBins               = 18;
% 
% SPG.TW   = [2 2^2 2^3 2^4 2^5 2^6 2^7 2^8 2^9 2^10]; %nSamples
% % SPG.movingWindowSizes   = [2^10]; %nSamples
