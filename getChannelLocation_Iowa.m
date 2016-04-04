function [chanIdx,SUB] = getChannelLocation_Iowa(bCNT,SUB)
% outputs details on channels, such as which strip/grid, which area, uni or
% bipolar.

endName = 5; % the last part of the chan label name that is cut off to match the grid label

getStripsInfo

[~,labTempIdx] = grep(labels_temporal,'temp');
[~,labParIdx] = grep(labels_temporal,'par');
[~,labFrontIdx] = grep(labels_temporal,'front');

if (sum(labFrontIdx)+sum(labTempIdx)+sum(labParIdx)) ~= length(labels_temporal)
    keyboard
end

if sum(find(labParIdx))
    if 0
        disp('parietal channels used as temporal')
        labTempIdx = logical(labTempIdx+labParIdx);
    else
        labels_parietal = labels_temporal(labParIdx);
    end
end
tmpLabTemp = labels_temporal(labTempIdx);
tmpLabFront = labels_temporal(labFrontIdx);

if isfield(bCNT,'img_front')
    keyboard
    labels_frontal{length(labels_frontal)+1:length(labels_frontal)+length(tmpLabFront)} = tmpLabFront;
else
    labels_frontal = tmpLabFront;
end
labels_temporal = tmpLabTemp;

chanIdx.frontal             =[];
chanIdx.ventral             =[];
chanIdx.temp                =[];
chanIdx.parietal            =[];
chanIdx.none                =[];%deep
chanIdx.notConnected        =[];

chanIdx.frontalBipolar      =[];
chanIdx.frontalBipolarHor   =[];
chanIdx.frontalBipolarVer   =[];
chanIdx.ventralBipolar      =[];
chanIdx.ventralBipolarHor   =[];
chanIdx.ventralBipolarVer   =[];
chanIdx.tempBipolar         =[];
chanIdx.tempBipolarHor      =[];
chanIdx.tempBipolarVer      =[];
chanIdx.parietalBipolar     =[];
chanIdx.parietalBipolarHor  =[];
chanIdx.parietalBipolarVer  =[];
chanIdx.noneBipolar         =[];

switch SUB.cntID
    case '156_DF_BM_Loc'
        % the 2nd bipolar rereferencing (horizontal) does not start at chan
        % 1, but at chan 33
        [x y]=find(bCNT.pairs==1);
        x(y~=1)=[];
        [x2 y2]=find(bCNT.pairs==33);
        x2(y2~=1)=[];
        if length(x)==3
            x(3) = x2(3);
        end
    otherwise
        [x y]=find(bCNT.pairs==1);
        x(y~=1)=[];
end

switch SUB.cntID
    case '154_combined'
        % for 154, multiple sessions (with different channels) where mixed,
        % for that purpose I saved the horizontal and vertical indices when
        % combining the 2 bCNT structures in getCorrespondingChannels_Iowa
        verChan = find(bCNT.ver);
        if length(x)==3
            horChan = find(bCNT.hor);
        else
            horChan = [];
        end
    otherwise
        if length(x)==3
            verChan = 1:length(bCNT.label);
            horChan = verChan;
            verChan = verChan(x(2):x(3)-1);
            horChan = horChan(x(3):length(bCNT.label));
        else
            verChan = 1:length(bCNT.label);
            verChan = verChan(x(2):length(bCNT.label));
            horChan = [];
        end
end
chanIdx.horizontal = horChan;
chanIdx.vertical = verChan;

for iChan = 1:length(bCNT.label)
    iLabel = 0;
    for iVent = 1:length(labels_ventral)
        iLabel = iLabel+1;
        if iChan==1
            chanIdx.labels(iLabel).unipolar=[];
            chanIdx.labels(iLabel).bipolar =[];
        end
        chanIdx.labels(iLabel).ID = labels_ventral{iVent};
        if strcmpi(bCNT.label{iChan}(1:end-(endName)),labels_ventral(iVent))
            chanIdx.ventral = [chanIdx.ventral iChan];
            chanIdx.labels(iLabel).unipolar = [chanIdx.labels(iLabel).unipolar iChan];
        elseif strcmpi([bCNT.label{iChan}(2:end-(endName*2))],labels_ventral(iVent))
            chanIdx.ventralBipolar = [chanIdx.ventralBipolar iChan];
            chanIdx.labels(iLabel).bipolar = [chanIdx.labels(iLabel).bipolar iChan];
        end
    end
    for iTemp = 1:length(labels_temporal)
        iLabel = iLabel+1;
        if iChan==1
            chanIdx.labels(iLabel).unipolar=[];
            chanIdx.labels(iLabel).bipolar =[];
        end
        chanIdx.labels(iLabel).ID = labels_temporal{iTemp};
        if strcmpi(bCNT.label{iChan}(1:end-(endName)),labels_temporal(iTemp))
            chanIdx.temp = [chanIdx.temp iChan];
            chanIdx.labels(iLabel).unipolar = [chanIdx.labels(iLabel).unipolar iChan];
        elseif strcmpi([bCNT.label{iChan}(2:end-(endName*2))],labels_temporal(iTemp))
            chanIdx.tempBipolar = [chanIdx.tempBipolar iChan];
            chanIdx.labels(iLabel).bipolar = [chanIdx.labels(iLabel).bipolar iChan];
        end
    end
    
    for iNone = 1:length(labels_none)
        iLabel = iLabel+1;
        if iChan==1
            chanIdx.labels(iLabel).unipolar=[];
            chanIdx.labels(iLabel).bipolar =[];
        end
        chanIdx.labels(iLabel).ID = labels_none{iNone};
        if strcmpi(bCNT.label{iChan}(1:end-(endName)),labels_none(iNone))
            chanIdx.none = [chanIdx.none iChan];
            chanIdx.labels(iLabel).unipolar = [chanIdx.labels(iLabel).unipolar iChan];
        elseif strcmpi([bCNT.label{iChan}(2:end-(endName*2))],labels_none(iNone))
            chanIdx.noneBipolar = [chanIdx.noneBipolar iChan];
            chanIdx.labels(iLabel).bipolar = [chanIdx.labels(iLabel).bipolar iChan];
        end
    end
    
    for iIgnore = 1:length(labels_ignore)
        if strcmpi(bCNT.label{iChan}(1:end-(endName)),labels_ignore(iIgnore))
            chanIdx.none = [chanIdx.notConnected iChan];
        end
    end
    
    if exist('labels_frontal','var')
        for iFront = 1:length(labels_frontal)
            iLabel = iLabel+1;
            if iChan==1
                chanIdx.labels(iLabel).unipolar=[];
                chanIdx.labels(iLabel).bipolar =[];
            end
            chanIdx.labels(iLabel).ID = labels_frontal{iFront};
            if strcmpi(bCNT.label{iChan}(1:end-(endName)),labels_frontal(iFront))
                chanIdx.frontal = [chanIdx.frontal iChan];
                chanIdx.labels(iLabel).unipolar = [chanIdx.labels(iLabel).unipolar iChan];
            elseif strcmpi([bCNT.label{iChan}(2:end-(endName*2))],labels_frontal(iFront))
                chanIdx.frontalBipolar = [chanIdx.frontalBipolar iChan];
                chanIdx.labels(iLabel).bipolar = [chanIdx.labels(iLabel).bipolar iChan];
            end
        end
    end
    
    if exist('labels_parietal','var')
        for iPar = 1:length(labels_parietal)
            iLabel = iLabel+1;
            if iChan==1
                chanIdx.labels(iLabel).unipolar=[];
                chanIdx.labels(iLabel).bipolar =[];
            end
            chanIdx.labels(iLabel).ID = labels_parietal{iPar};
            if strcmpi(bCNT.label{iChan}(1:end-(endName)),labels_parietal(iPar))
                chanIdx.parietal = [chanIdx.parietal iChan];
                chanIdx.labels(iLabel).unipolar = [chanIdx.labels(iLabel).unipolar iChan];
            elseif strcmpi([bCNT.label{iChan}(2:end-(endName*2))],labels_parietal(iPar))
                chanIdx.parietalBipolar = [chanIdx.parietalBipolar iChan];
                chanIdx.labels(iLabel).bipolar = [chanIdx.labels(iLabel).bipolar iChan];
            end
        end
    end
    
    if isfield(SUB,'iChan')
        if SUB.iChan == iChan
            SUB.chanLocation = bCNT.label{iChan}(2:end-(endName*2));
        end
    end
end



chanIdx.ventralBipolarHor  = chanIdx.ventralBipolar(ismember(chanIdx.ventralBipolar, horChan));
chanIdx.ventralBipolarVer  = chanIdx.ventralBipolar(ismember(chanIdx.ventralBipolar, verChan));

chanIdx.tempBipolarHor  = chanIdx.tempBipolar(ismember(chanIdx.tempBipolar, horChan));
chanIdx.tempBipolarVer  = chanIdx.tempBipolar(ismember(chanIdx.tempBipolar, verChan));

if exist('labels_frontal','var')
    chanIdx.frontalBipolarHor  = chanIdx.frontalBipolar(ismember(chanIdx.frontalBipolar, horChan));
    chanIdx.frontalBipolarVer  = chanIdx.frontalBipolar(ismember(chanIdx.frontalBipolar, verChan));
end
if exist('labels_parietal','var')
    chanIdx.parietalBipolarHor  = chanIdx.parietalBipolar(ismember(chanIdx.parietalBipolar, horChan));
    chanIdx.parietalBipolarVer  = chanIdx.parietalBipolar(ismember(chanIdx.parietalBipolar, verChan));
end

