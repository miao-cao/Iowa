function chanLoc = getCorrespondingChannels_Iowa(subID,EXP,chanCFS)
% upgraded version of this script in
% /export/kani/shared/IowaData/CFS_NEW/analysis
HORIZONTAL = 0;
VERTICAL = 1;
switch subID
    case {'154a', '154b'}
        
        
        % sub154a
        % 1:96      'R_temp_grid_'
        % (0:3)+97  'L_ant_subTemp_strip_'
        % (0:3)+101 'L_Amyg_'
        % (0:3)+105 'R_Amyg_'
        % (0:3)+109 'R_Heschl_'
        % 113:128   'Not_Connected_'
        
        % sub154b
        % 1:64        'R_temp_grid_'
        % (0:31) + 65 'R_subTemp_grid_'
        % (0:3)+97    'L_ant_subTemp_strip_'
        % (0:3)+101   'L_Amyg_'
        % (0:3)+105   'R_Amyg_'
        % (0:3)+109   'R_Heschl_'
        % 113:128     'Not_Connected_'
        %%
        if 1
            TW=1;
            subID = '154a';
            subSpecs_IowaLocalizer
            bCNT_a=bCNT;
            
            [x y]=find(bCNT_a.pairs==1);
            x(y~=1)=[];
            
            verChan = 1:length(bCNT.label);
            if HORIZONTAL
                horChan = verChan;
                bCNT_a.verChan = verChan(x(2):x(3)-1);
                bCNT_a.horChan = horChan(x(3):length(bCNT.label));
            else
                bCNT_a.verChan = verChan(x(2):end);                
                bCNT_a.horChan = [];
            end
            
            subID = '154b';
            subSpecs_IowaLocalizer
            bCNT_b=bCNT;
            
            [x y]=find(bCNT_b.pairs==1);
            x(y~=1)=[];
            
            verChan = 1:length(bCNT.label);
            if HORIZONTAL
                horChan = verChan;
                bCNT_b.verChan = verChan(x(2):x(3)-1);
                bCNT_b.horChan = horChan(x(3):length(bCNT.label));
            else
                bCNT_b.verChan = verChan(x(2):end);                
                bCNT_b.horChan = [];
            end
            
            
            bCNT_new.id='154_combined';
            bCNT_new.img_temp   = bCNT_a.img_temp;
            bCNT_new.img_vent   = bCNT_a.img_vent;
            
            unipolar_ind=find(bCNT_a.flag_select==0);
            
            for uni_ind=unipolar_ind
                bCNT_new.label{uni_ind}        = bCNT_a.label{uni_ind};
                bCNT_new.hemisphere{uni_ind}   = bCNT_a.hemisphere{uni_ind};
                bCNT_new.region{uni_ind}       = bCNT_a.region{uni_ind};
                bCNT_new.elperline(uni_ind)    = bCNT_a.elperline(uni_ind);
                bCNT_new.elperrow(uni_ind)     = bCNT_a.elperrow(uni_ind);
                bCNT_new.view{uni_ind}         = bCNT_a.view{uni_ind};
                bCNT_new.xcent(uni_ind)        = bCNT_a.xcent(uni_ind);
                bCNT_new.ycent(uni_ind)        = bCNT_a.ycent(uni_ind);
                bCNT_new.pairs(uni_ind,1:2)    = bCNT_a.pairs(uni_ind,1:2);
                bCNT_new.flag_select(uni_ind)  = bCNT_a.flag_select(uni_ind);
            end
            
            unipolar_ind=find(bCNT_b.flag_select==0);
            
            for uni_ind_b=unipolar_ind
                if ~any(strcmpi(bCNT_b.label{uni_ind_b},bCNT_a.label)) % if not already included in bCNT_a
                    uni_ind=uni_ind+1;
                    
                    bCNT_new.label{uni_ind}        = bCNT_b.label{uni_ind_b};
                    bCNT_new.hemisphere{uni_ind}   = bCNT_b.hemisphere{uni_ind_b};
                    bCNT_new.region{uni_ind}       = bCNT_b.region{uni_ind_b};
                    bCNT_new.elperline(uni_ind)    = bCNT_b.elperline(uni_ind_b);
                    bCNT_new.elperrow(uni_ind)     = bCNT_b.elperrow(uni_ind_b);
                    bCNT_new.view{uni_ind}         = bCNT_b.view{uni_ind_b};
                    bCNT_new.xcent(uni_ind)        = bCNT_b.xcent(uni_ind_b);
                    bCNT_new.ycent(uni_ind)        = bCNT_b.ycent(uni_ind_b);
                    bCNT_new.pairs(uni_ind,1:2)    = [uni_ind uni_ind]; % note that bCNT.pairs refer to indexes in the bCNT structures themselves
                    bCNT_new.flag_select(uni_ind)  = bCNT_b.flag_select(uni_ind_b);
                    map_vect(uni_ind_b)=uni_ind;
                end
            end
            
            new_ind=uni_ind;
            bipolar_ind=find(bCNT_a.flag_select~=0);
            
            for bi_ind=bipolar_ind
                new_ind=new_ind+1;
                bCNT_new.label{new_ind}        = bCNT_a.label{bi_ind};
                bCNT_new.hemisphere{new_ind}   = bCNT_a.hemisphere{bi_ind};
                bCNT_new.region{new_ind}       = bCNT_a.region{bi_ind};
                bCNT_new.elperline(new_ind)    = bCNT_a.elperline(bi_ind);
                bCNT_new.elperrow(new_ind)     = bCNT_a.elperrow(bi_ind);
                bCNT_new.view{new_ind}         = bCNT_a.view{bi_ind};
                bCNT_new.xcent(new_ind)        = bCNT_a.xcent(bi_ind);
                bCNT_new.ycent(new_ind)        = bCNT_a.ycent(bi_ind);
                bCNT_new.pairs(new_ind,1:2)    = bCNT_a.pairs(bi_ind,1:2);
                bCNT_new.flag_select(new_ind)  = bCNT_a.flag_select(bi_ind);
                if ismember(bi_ind,bCNT_a.horChan)
                    bCNT_new.hor(new_ind) = 1;
                end
                if ismember(bi_ind,bCNT_a.verChan)
                    bCNT_new.ver(new_ind) = 1;
                end
            end
            
            bipolar_ind=find(bCNT_b.flag_select~=0);
            
            for bi_ind=bipolar_ind
                if ~any(strcmpi(bCNT_b.label{bi_ind},bCNT_a.label))
                    new_ind=new_ind+1;
                    
                    bCNT_new.label{new_ind}        = bCNT_b.label{bi_ind};
                    bCNT_new.hemisphere{new_ind}   = bCNT_b.hemisphere{bi_ind};
                    bCNT_new.region{new_ind}       = bCNT_b.region{bi_ind};
                    bCNT_new.elperline(new_ind)    = bCNT_b.elperline(bi_ind);
                    bCNT_new.elperrow(new_ind)     = bCNT_b.elperrow(bi_ind);
                    bCNT_new.view{new_ind}         = bCNT_b.view{bi_ind};
                    bCNT_new.xcent(new_ind)        = bCNT_b.xcent(bi_ind);
                    bCNT_new.ycent(new_ind)        = bCNT_b.ycent(bi_ind);
                    bCNT_new.pairs(new_ind,1:2)    = [map_vect(bCNT_b.pairs(bi_ind,1)) map_vect(bCNT_b.pairs(bi_ind,2))]; % note that bCNT.pairs refer to indexes in the bCNT structures themselves
                    bCNT_new.flag_select(new_ind)  = bCNT_b.flag_select(bi_ind);
                    if ismember(bi_ind,bCNT_b.horChan)
                        bCNT_new.hor(new_ind) = 1;
                    end
                    if ismember(bi_ind,bCNT_b.verChan)
                        bCNT_new.ver(new_ind) = 1;
                    end
                end
                
            end
            
            for iChan = 1:length(bCNT_new.label)
                if ~isempty(find(strcmpi(bCNT_new.label{iChan}, bCNT_a.label))) && ~isempty(find(strcmpi(bCNT_new.label{iChan}, bCNT_b.label)))
                    bCNT_new.sharedSessions(iChan) = 1;
                else
                    bCNT_new.sharedSessions(iChan) = 0;
                end
            end
            
            bCNT=bCNT_new;
            disp('generate contact information for bipolar montage')
            save([DIR.map '/bcntInfo_' bCNT_new.id '.mat'],'bCNT')
            
        else
            
            %%
            
            if 1
                subID = '154a';
                subSpecsIowaCFS
                labels.sub154a = bCNT.label;
                bCNT_154a = bCNT;
                subID = '154b';
                subSpecsIowaCFS
                labels.sub154b = bCNT.label;
                bCNT_154b = bCNT;
                
                chanLoc = zeros(1,312);
                for iChan = 1:312
                    try
                        chanLoc(iChan) = find(strcmpi(labels.sub154a{iChan},labels.sub154b));
                    catch
                        iChan;
                    end
                end
                
                %% new ChanLabels
                
                chanLab(1:96)       = labels.sub154a(1:96);     %= labels.sub154b(1:64), (65:96==N.A.)
                chanLab(97:128)     = labels.sub154a(97:128);   %= labels.sub154b(97:128)
                chanLab(129:160)    = labels.sub154b(65:96);    %= labels.sub154a, N.A.
                chanLab(161:216)    = labels.sub154a(129:184);  %= labels.sub154b(129:184)
                chanLab(217:244)    = labels.sub154a(185:212);  %= labels.sub154b, N.A.
                %             chanLab(245:312)    = labels.sub154a(213:280);  %= labels.sub154b(213:280)
                chanLab(245:344)    = labels.sub154a(213:312);  %= labels.sub154b(213:280) (281:312==N.A.)
                chanLab(345:372)    = labels.sub154b(185:212);  %= labels.sub154a, N.A.
                chanLab(373:388)    = labels.sub154b(281:296);  %= labels.sub154a, N.A.
                
                if 0 %sanity check
                    chanLoc = zeros(1,length(labels.sub154a));
                    for iChan=1:length(labels.sub154a)
                        try
                            chanLoc(iChan) = find(strcmpi(labels.sub154a{iChan},chanLab));
                        catch
                            iChan;
                        end
                    end
                    
                    chanLoc = zeros(1,length(labels.sub154b));
                    for iChan=1:length(labels.sub154b)
                        try
                            chanLoc(iChan) = find(strcmpi(labels.sub154b{iChan},chanLab));
                        catch
                            iChan;
                        end
                    end
                end
                
                new_bCNT.label      = chanLab;
                new_bCNT.id         = '154_combined';
                new_bCNT.subID      = '154';
                new_bCNT.img_temp   = bCNT_154a.img_temp;
                new_bCNT.img_vent   = bCNT_154a.img_vent;
                
                for iChan = 1:length(chanLab)
                    
                    if ~isempty(find(strcmpi(chanLab{iChan},labels.sub154a)))
                        oldChan = find(strcmpi(chanLab{iChan},labels.sub154a));
                        
                        new_bCNT.hemisphere{iChan}   = bCNT_154a.hemisphere{oldChan};
                        new_bCNT.region{iChan}       = bCNT_154a.region{oldChan};
                        new_bCNT.elperline(iChan)    = bCNT_154a.elperline(oldChan);
                        new_bCNT.elperrow(iChan)     = bCNT_154a.elperrow(oldChan);
                        new_bCNT.view{iChan}         = bCNT_154a.view{oldChan};
                        new_bCNT.xcent(iChan)        = bCNT_154a.xcent(oldChan);
                        new_bCNT.ycent(iChan)        = bCNT_154a.ycent(oldChan);
                        new_bCNT.pairs(iChan,1:2)        = bCNT_154a.pairs(oldChan,1:2);
                        new_bCNT.flag_select(iChan)  = bCNT_154a.flag_select(oldChan);
                        if ~isempty(find(strcmpi(chanLab{iChan},labels.sub154b)))
                            new_bCNT.sharedSessions(iChan) = 1;
                        else
                            new_bCNT.sharedSessions(iChan) = 0;
                        end
                    elseif ~isempty(find(strcmpi(chanLab{iChan},labels.sub154b)))
                        oldChan = find(strcmpi(chanLab{iChan},labels.sub154b));
                        
                        new_bCNT.hemisphere{iChan}   = bCNT_154b.hemisphere{oldChan};
                        new_bCNT.region{iChan}       = bCNT_154b.region{oldChan};
                        new_bCNT.elperline(iChan)    = bCNT_154b.elperline(oldChan);
                        new_bCNT.elperrow(iChan)     = bCNT_154b.elperrow(oldChan);
                        new_bCNT.view{iChan}         = bCNT_154b.view{oldChan};
                        new_bCNT.xcent(iChan)        = bCNT_154b.xcent(oldChan);
                        new_bCNT.ycent(iChan)        = bCNT_154b.ycent(oldChan);
                        new_bCNT.pairs(iChan,1:2)        = bCNT_154b.pairs(oldChan,1:2);
                        new_bCNT.flag_select(iChan)  = bCNT_154b.flag_select(oldChan);
                    else
                        keyboard
                    end
                end
                clear bCNT*
                bCNT = new_bCNT;
                
                save([DIR.map filesep 'bcntInfo_' bCNT.id '.mat'],'bCNT');
            end
        end
    case '156'
        % LOC       - CFS
        % 33::96	- 33::96
        % 97::112	- 1::16
        % 113::128	- 17::32
        % 17::20	- 113::116
        % 13::16	- 109::112
        % high imp flipped 8::1, 16::9	- high imp flipped 8::1, 16::9
        % 29::32	- 125::128
        % 1::4      - 97::100
        % 5::8      - 101::104
        % 9::12     - 105::108
        % 21::24	- 117::120
        % 25::28	- 121::124
        
        %         if isfield(EXP,'cond')
        % %             return
        %         end
        %         % unipolar
        %         chan.LOC = [33:96   97:112    113:128     17:20       13:16       29:32       1:4     5:8         9:12        21:24       25:28];
        %         chan.CFS = [33:96   1:16      17:32       113:116     109:112     125:128     97:100  101:104     105:108     117:120     121:124];
        
        %bipolar
        if 0
            subSpecsIowaCFS
            labels.CFS = bCNT.label;
            subSpecsIowaFaceLocalizer
            labels.Loc = bCNT.label;
            
            for iChanCFS = 1:308
                %%
                [x,y]=grep(labels.Loc,labels.CFS{iChanCFS}(1:end-8));
                find(y)
                %%
            end
        else
            chan.LOC = [33:96 97:112 113:128 17:20   13:16   29:32   1:4    5:8     9:12    21:24   25:28   209:222 223:236 153:208 129:131 132:134 135:137 138:140 141:143 144:146 147:149 150:152 293:300 301:308 237:292];
            chan.CFS = [33:96 1:16   17:32   113:116 109:112 125:128 97:100 101:104 105:108 117:120 121:124 129:142 143:156 157:212 213:215 216:218 219:221 222:224 225:227 228:230 231:233 234:236 237:244 245:252 253:308];
        end
        
        if length(chanCFS) == 1 && ~isempty(chanCFS)
            chanLoc = chan.LOC(chan.CFS==chanCFS);
        else
            [~,chanIdx.CFS] = sort(chan.CFS);
            chanLoc = (chan.LOC(chanIdx.CFS));
        end
    otherwise
        chanLoc=chanCFS;
end
