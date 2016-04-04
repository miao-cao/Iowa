function EXP = getCondition_IowaLocalizer(EXP,subID,tmpCondIdx)

if ~exist('tmpCondIdx','var') || isempty(tmpCondIdx)
    tmpCondIdx=3;
end    

if (tmpCondIdx==3) && strcmpi(subID,'178')
    tmpCondIdx=2;
end
EXP.AllConditions = {'allSeparate', 'faceVsNonFace','faceVsMondrian','faceVsHouse','faceVsVeh'};
%separate cond only in check SPG/decoding, cond are not separated in SPG calculation

EXP.cond = EXP.AllConditions{tmpCondIdx};

switch EXP.cond
    case 'allSeparate'
        EXP.nCond=5;
    otherwise
        EXP.nCond=2;
end
