function getGridLabels(subID,SUB,DIR)
% derived from separateStrips.m , this function prints to stdout grid/strip labels and corresponding indexes
% nargin = 0;
% 09 Aug 22 by NT
% rereference the signal to the nearby (close contact number) within the
% same grid or strip group
dbstop if error
if nargin < 1
    subID = '156'
end
% try
%     subSpecsIowaFaceLocalizer
% catch 
%     subSpecsIowaCFS
% end
% DIR.fig = [DIR.figBase '/figure_getBipolarMontage'];
% if isempty(dir(DIR.fig))
%     mkdir(DIR.fig)
% end
%%
% PLOT.visible = 'off';
% PLOT.eachBipolarMontage = 0;

%% get contact info
CNT = [];
load([DIR.map '/cntInfo.mat'])

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
% load([DIR.map '/cntInfo_' SUB.cntID '.mat'])

% CNT_old = CNT;
% CNT = cntInfo;

%% load subject info
% subSpecsIowaFaceLocalizer
%% load photoDiode trigger timing
vSession = [];
for iSession= 1:SUB.nSession
    rawSessionDir{iSession} = [DIR.sub '/' getfilenum(SUB.session(iSession),3) '/rawEachChan/'];
    segDataDir{iSession} = [DIR.sub '/' getfilenum(SUB.session(iSession),3) '/segmented/'];
    vSession = [vSession iSession]; %
end



%% load only ROI electrodes
% nElectrode = length(dir([rawDataDir{iSession} '/' Sub.dataFile{iSession} '_li*_rm.mat']));
nElectrode = length(CNT.label)

labels={};
index_start=[];

% keyboard;

iElectrode=1;

% labels{length(labels)+1}=CNT.label{iElectrode}(3:end-4);
labels{length(labels)+1}=CNT.label{iElectrode}(1:end-4);
index_start=[index_start iElectrode];



iElectrode=2;

while(iElectrode<=nElectrode)
    
    flag_new=1;
    for l=1:length(labels)
        if strcmp(CNT.label{iElectrode}(1:end-4),labels(l))
            flag_new=0;
        end
    end
    if flag_new==1
        index_start=[index_start iElectrode];
        labels{length(labels)+1}=CNT.label{iElectrode}(1:end-4);
        % fprintf('New label %s starting at index %i\n',CNT.label{iElectrode}(1:end-4),iElectrode);
    end
    
    iElectrode=iElectrode+1;
    
end

index_start=[index_start iElectrode];
el_num=index_start(2:end)-index_start(1:end-1);


for l=1:length(labels)
    fprintf('New label %s starting at index %i el number %i\n',labels{l},index_start(l),el_num(l));
end
