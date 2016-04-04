function separateStrips(subID,SUB,DIR)
% derived from createBipolarNew.m  , this script reads cntInfo and generates cntInfo_cntID where each physical grid/strip corresponds to a different label. Can also be used for correcting wrongly assigned labels.
% nargin = 0;
% 09 Aug 22 by NT
% rereference the signal to the nearby (close contact number) within the
% same grid or strip group
dbstop if error
if nargin < 1
    subID = '153'
end

DIR.fig = [DIR.figBase '/figure_getBipolarMontage'];
if isempty(dir(DIR.fig))
    mkdir(DIR.fig)
end
%%
PLOT.visible = 'off';
PLOT.eachBipolarMontage = 0;

%% get contact info
CNT = [];
load([DIR.map '/cntInfo.mat'])
endName = 5;

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
% CNT_old = CNT;

%% load subject info
% getSubInfo
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

separateStripsInfo;


% keyboard;
% generate information for physical electrodes
% for iSession = vSession
iElectrode_temp=1;
iElectrode_vent=1;

iElectrode=1;

while(iElectrode<=nElectrode)
    
    
    for l=1:length(labels_temporal)
        if strcmp(CNT.label{iElectrode}(1:end-endName),labels_temporal(l))
            if(flag_separate_temporal(l))
                
            end
        end
    end
    
    
    for l=1:length(labels_ventral)
        if strcmp(CNT.label{iElectrode}(1:end-endName),labels_ventral(l))
            if(flag_separate_ventral(l))
                n_parts=length(new_labels_ventral{l});
                for part=1:n_parts
                    for el=1:grid_size_ventral{l}(part)
                        % CNT.label{iElectrode+el-1}=[CNT.label{iElectrode+el-1}(1:2) new_labels_ventral{l}{part} CNT.label{iElectrode+el-1}(end-3:end)];
                        CNT.label{iElectrode+el-1}=[new_labels_ventral{l}{part} CNT.label{iElectrode+el-1}(end-(endName-1):end)];
                    end
                    iElectrode=iElectrode+el;
                end
            end
        end
    end
    
    for l=1:length(labels_none)
        if strcmp(CNT.label{iElectrode}(1:end-endName),labels_none(l))
            if(flag_separate_none(l))
                
            end
        end
    end
    
    for l=1:length(labels_ignore)
        if strcmp(CNT.label{iElectrode}(1:end-endName),labels_ignore(l))
            if(flag_separate_ignore(l))
                
            end
        end
    end
    
    iElectrode=iElectrode+1;
    
end

% end




% keyboard;

%% update CNT

% load([DIR.map '/bcntInfo.mat'],'bcntInfo')
% for iTmp = 1:length(cntInfo)
%     if strcmp( cntInfo(iTmp).id , SUB.cntID)
%         bcntInfo(iTmp) = bCNT;
%         break
%     end
% end
% disp('update contact information for bipolar montage')
% save([DIR.map '/bcntInfo.mat'],'bcntInfo')

% in this version we generate a subject specific bcntInfo structure
disp('generate contact information for bipolar montage')
save([DIR.map '/cntInfo_' SUB.cntID '.mat'],'CNT')
% save([DIR.map '/cntInfo_' subID '.mat'],'CNT')