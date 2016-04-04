% getDecodeDir
[~, eachDec] = grep(DEC.allDimension,'each');
[~, multiDec] = grep(DEC.allDimension,'multi');

if eachDec(DEC.iDim2use) || (multiDec(DEC.iDim2use) && ~DEC.randChanSelection)
    DIR.decodeBase      = [DIR.sub 'decode'      filesep EXP.cond filesep DEC.dimension filesep 'nFoldVal_' num2str(DEC.nCrossVal) ];
    DIR.decodeCheckBase = [DIR.sub 'checkDecode' filesep EXP.cond filesep DEC.dimension filesep 'nFoldVal_' num2str(DEC.nCrossVal) ];
elseif DEC.randChanSelection && multiDec(DEC.iDim2use)
    DIR.decodeBase      = [DIR.sub 'decode'      filesep EXP.cond filesep DEC.dimension filesep 'rChanSel_' num2str(DEC.randChanPercentage) 'p_' num2str(DEC.randChanCrossVal) 'cV'];
    DIR.decodeCheckBase = [DIR.sub 'checkDecode' filesep EXP.cond filesep DEC.dimension filesep 'rChanSel_' num2str(DEC.randChanPercentage) 'p_' num2str(DEC.randChanCrossVal) 'cV'];
end


DIR.decodeExtSearchlight = ['SL_t(' num2str(DEC.searchlightTimeWin(1)) '_' num2str(DEC.searchlightTimeWin(2)) ')_f(' num2str(DEC.searchlightFreqWin(1)) '_' num2str(DEC.searchlightFreqWin(2)) ')'];

switch DEC.saveCategory
    case 'erp'
        DIR.decodeExtPerm   = [ 'perm'];
        DIR.decodeExtPermOLD   = [ '_perm'];
    otherwise
        DIR.decodeExtPerm   = ['ff_' num2str(DEC.freq2decode(1)) '_' num2str(DEC.freq2decode(2))  '_perm' filesep];
        DIR.decodeEXT       = ['ff_' num2str(DEC.freq2decode(1)) '_' num2str(DEC.freq2decode(2)) filesep];
        %         if isfield(DEC,'freq2decode') && ~isempty(DEC.freq2decode) && DEC.permute
        %             DIR.decode      = [DIR.decodeBase filesep DEC.saveCategory filesep DIR.decodeExtPerm];
        %             DIR.decodeCheck = [DIR.decodeCheckBase filesep DEC.saveCategory filesep DIR.decodeExtPerm];
        %         elseif isfield(DEC,'freq2decode') && ~isempty(DEC.freq2decode)
        %             DIR.decode      = [DIR.decodeBase filesep DEC.saveCategory filesep DIR.decodeEXT];
        %             DIR.decodeCheck = [DIR.decodeCheckBase filesep DEC.saveCategory filesep DIR.decodeEXT];
        %         end
end

if DEC.permute && DEC.searchlight
    DIR.decode       = [DIR.decodeBase filesep DEC.saveCategory filesep DIR.decodeExtSearchlight '_' DIR.decodeExtPerm filesep];
    DIR.decodeCheck  = [DIR.decodeCheckBase filesep DEC.saveCategory filesep DIR.decodeExtSearchlight '_' DIR.decodeExtPerm filesep];
elseif DEC.permute && ~DEC.searchlight
    DIR.decode       = [DIR.decodeBase filesep DEC.saveCategory filesep DIR.decodeExtPerm filesep];
    DIR.decodeCheck  = [DIR.decodeCheckBase filesep DEC.saveCategory filesep DIR.decodeExtPerm filesep];
    switch DEC.saveCategory
        case 'erp'
            DIR.decodeOLD       = [DIR.decodeBase filesep DEC.saveCategory filesep DIR.decodeExtPermOLD filesep];
            DIR.decodeCheckOLD  = [DIR.decodeCheckBase filesep DEC.saveCategory filesep DIR.decodeExtPermOLD filesep];
            
            if exist(DIR.decodeOLD,'dir')
                movefile(DIR.decodeOLD,DIR.decode);
            end
            if exist(DIR.decodeCheckOLD,'dir')
                movefile(DIR.decodeCheckOLD,DIR.decode);
            end

    end
elseif ~DEC.permute && DEC.searchlight
    DIR.decode       = [DIR.decodeBase filesep DEC.saveCategory filesep DIR.decodeExtSearchlight filesep];
    DIR.decodeCheck  = [DIR.decodeCheckBase filesep DEC.saveCategory filesep DIR.decodeExtSearchlight filesep];
else
    DIR.decode       = [DIR.decodeBase filesep DEC.saveCategory filesep ];
    DIR.decodeCheck  = [DIR.decodeCheckBase filesep DEC.saveCategory filesep ];
end

if strcmpi(EXP.cond,'vis_H_vs_L')
    tmpIdx = strfind(DIR.decode,'vis_H_vs_L');
    tmpDir = [DIR.decode(1:tmpIdx-1) 'high_low_visibility' ];
    if exist(tmpDir,'dir')
%         keyboard
        movefile(tmpDir,[DIR.decode(1:tmpIdx-1) 'vis_H_vs_L' ])
    end

end

if strcmpi(EXP.cond,'vis_H_vs_L_c2')
    tmpIdx = strfind(DIR.decode,'vis_H_vs_L_c2');
    tmpDir = [DIR.decode(1:tmpIdx-1) 'high_low_visibility_at_c2' ];
    if exist(tmpDir,'dir')
%         keyboard
        movefile(tmpDir,[DIR.decode(1:tmpIdx-1) 'vis_H_vs_L_c2' ])
    end

end

if strcmpi(EXP.cond,'HM_LE_100ms')
    tmpIdx = strfind(DIR.decode,'HM_LE_100ms');
    tmpDir = [DIR.decode(1:tmpIdx-1) 'hitVsMiss_locAndEmo_100ms' ];
    if exist(tmpDir,'dir')
%         keyboard
        movefile(tmpDir,[DIR.decode(1:tmpIdx-1) 'HM_LE_100ms' ])
    end

end

if strcmpi(EXP.cond,'S(1)L(2)_ipsi')
    tmpIdx = strfind(DIR.decode,'S(1)L(2)_ipsi');
    tmpDir = [DIR.decode(1:tmpIdx-1) 'short(1)VsLong(2)_ipsiLat' ];
    if exist(tmpDir,'dir')
%         keyboard
        movefile(tmpDir,[DIR.decode(1:tmpIdx-1) 'S(1)L(2)_ipsi' ])
    end

end
if strcmpi(EXP.cond,'S(1)L(2)_contra')
    tmpIdx = strfind(DIR.decode,'S(1)L(2)_contra');
    tmpDir = [DIR.decode(1:tmpIdx-1) 'short(1)VsLong(2)_contraLat' ];
    if exist(tmpDir,'dir')
%         keyboard
        movefile(tmpDir,[DIR.decode(1:tmpIdx-1) 'S(1)L(2)_contra' ])
    end

end
if strcmpi(EXP.cond,'HvsM_50ms')
    tmpIdx = strfind(DIR.decode,'HvsM_50ms');
    tmpDir = [DIR.decode(1:tmpIdx-1) 'hitVsMiss_short' ];
    if exist(tmpDir,'dir')
        movefile(tmpDir,[DIR.decode(1:tmpIdx-1) 'HvsM_50ms' ])
    end
end
if strcmpi(EXP.cond,'S(1)L(3)')
    tmpIdx = strfind(DIR.decode,'S(1)L(3)');
    tmpDir = [DIR.decode(1:tmpIdx-1) 'short(1)VsLong(3)' ];
    if exist(tmpDir,'dir')
        movefile(tmpDir,[DIR.decode(1:tmpIdx-1) 'S(1)L(3)' ])
    end
end
if strcmpi(EXP.cond,'S(1)L(2)')
    tmpIdx = strfind(DIR.decode,'S(1)L(2)');
    tmpDir = [DIR.decode(1:tmpIdx-1)  'short(1)VsLong(2)' ];
    if exist(tmpDir,'dir')
        movefile(tmpDir,[DIR.decode(1:tmpIdx-1) 'S(1)L(2)' ])
    end
end




if ~exist(DIR.decode,'dir')
    mkdir(DIR.decode)
end
if ~exist(DIR.decodeCheck,'dir')
    mkdir(DIR.decodeCheck)
end




% %% oldDir
% if isfield(DEC,'freq2decode') && ~isempty(DEC.freq2decode)
%     DIR.decodeExtPerm   = ['ff_' num2str(DEC.freq2decode(1)) '_' num2str(DEC.freq2decode(2))  '_perm' filesep];
%     DIR.decodeEXT       = ['ff_' num2str(DEC.freq2decode(1)) '_' num2str(DEC.freq2decode(2)) filesep];
%
%     if isfield(DEC,'freq2decode') && ~isempty(DEC.freq2decode) && DEC.permute
%         DIR.decodeSPGOLD   = [DIR.decodeBase filesep DIR.decodeExtPerm filesep DEC.saveCategory filesep];
%         DIR.decodeCheckOLD     = [DIR.decodeCheckBase filesep DIR.decodeExtPerm filesep DEC.saveCategory filesep];
%     elseif isfield(DEC,'freq2decode') && ~isempty(DEC.freq2decode)
%         DIR.decodeSPGOLD   = [DIR.decodeBase filesep DIR.decodeEXT filesep DEC.saveCategory filesep];
%         DIR.decodeCheckOLD     = [DIR.decodeCheckBase filesep DIR.decodeEXT filesep DEC.saveCategory filesep];
%     end
%
% end

