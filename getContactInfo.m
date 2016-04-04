% *_Amyg_*, *R_Amyg_*, *_Heschl_* - we don't have electrode maps for these - they are too deep into the brain
% all other electrodes should be represented in the corresponding temporal or ventral maps

clear all

subjid = {'145','146_24_CFS','146_56_DF','147_DF_CFS','147_BM',... %1:5
    '149','153','154a_CFS_73_74','154b_DF_BM_CFS_137',... %6:10
    '156_DF_BM_Loc','156_CFS','162','168','173','178','180','181','186','206','232','242'}; %7:12

subIdx = [];

for i = 1:length(subjid), cntInfo(i).id = subjid{i}; end

%Channel Labels

%for 145

% mklabel = @(B,A) strcat(B,cellfun( @num2str,mat2cell( A,1,ones(1,length(A)) ) ,'uniformoutput',false));
mklabel = @(B,A) strcat(B,cellfun( @getfilenum,mat2cell( A,1,ones(1,length(A)) ) ,'uniformoutput',false));

%% For Patient 145
% 53 54 - BM
% 61 63 - CFS
iSub = 1;
cntInfo(iSub).label(1:96) = mklabel('L_temp_grid_',1:96);
cntInfo(iSub).label(97:100) = mklabel('L_temp_pole_',137:140);
cntInfo(iSub).label(101:104) = mklabel('L_ant_subTemp_',141:144);
cntInfo(iSub).label(105:108) = mklabel('L_mid_subTemp_',145:148);
cntInfo(iSub).label(109:112) = mklabel('L_post_temp_pole_',149:152);
cntInfo(iSub).label(113:116) = mklabel('L_Amyg_',133:136);
cntInfo(iSub).label(117:120) = mklabel('L_Heschl_',111:114);
cntInfo(iSub).label(121:124) = mklabel('R_ant_subTemp_',153:156);
cntInfo(iSub).label(125:128) = mklabel('R_post_subTemp_',157:160);
%% 146_24_CFS
iSub = iSub + 1;
cntInfo(iSub).label(1:96) = mklabel('L_temp_grid_',1:96);
cntInfo(iSub).label([97:100]+0) = mklabel('L_ant_mid_subTemp_',[173:176]+0);
cntInfo(iSub).label([97:100]+4) = mklabel('L_post_mid_subTemp_',[173:176]+4);
cntInfo(iSub).label([97:100]+8) = mklabel('L_post_subTemp_',[173:176]+8);
cntInfo(iSub).label([97:100]+12) = mklabel('R_mid_subTemp_',[189:192]);
cntInfo(iSub).label([97:100]+16) = mklabel('R_post_subTemp_',[189:192]+4);
cntInfo(iSub).label([97:100]+20) = mklabel('L_Amyg_',[165:168]);
cntInfo(iSub).label([97:100]+24) = mklabel('R_Amyg_',[161:164]);
cntInfo(iSub).label([97:100]+28) = mklabel('L_Heschl_',[143:146]);
%% 146_56_DF
iSub = iSub + 1;
cntInfo(iSub).label(1:32) = mklabel('L_frontal_grid_',97:128);
cntInfo(iSub).label(33:96) = mklabel('L_temp_grid_',33:96);
cntInfo(iSub).label([97:100]+0) = mklabel('L_ant_mid_subTemp_',[173:176]+0);
cntInfo(iSub).label([97:100]+4) = mklabel('L_post_mid_subTemp_',[173:176]+4);
cntInfo(iSub).label([97:100]+8) = mklabel('L_post_subTemp_',[173:176]+8);
cntInfo(iSub).label([97:100]+12) = mklabel('R_mid_subTemp_',[189:192]);
cntInfo(iSub).label([97:100]+16) = mklabel('R_post_subTemp_',[189:192]+4);
cntInfo(iSub).label([97:100]+20) = mklabel('L_Amyg_',[165:168]);
cntInfo(iSub).label([97:100]+24) = mklabel('R_Amyg_',[161:164]);
cntInfo(iSub).label([97:100]+28) = mklabel('L_Heschl_',[143:146]);



%% For Patient 147_DF_CFS_BM
iSub = iSub + 1;
cntInfo(iSub).label(1:96) = mklabel('L_temp_grid_',1:96);
cntInfo(iSub).label(97:100) = mklabel('L_temp_pole_',129:132);
cntInfo(iSub).label(101:104) = mklabel('L_ant_subTemp_',(0:3) + 133);
cntInfo(iSub).label(105:108) = mklabel('L_mid_subTemp_',(0:3) + 137);
cntInfo(iSub).label(109:112) = mklabel('L_post_subTemp_strip_',(0:3) + 141);
cntInfo(iSub).label(113:116) = mklabel('L_Amyg_',(0:3) + 149);
cntInfo(iSub).label((0:3)+117) = mklabel('R_mid_subTemp_',(0:3) + 145);
cntInfo(iSub).label(121:128) = mklabel('Not_Connected_',(1:8));

%% For Patient 147_BM
iSub = iSub + 1;
cntInfo(iSub).label(1:64) = mklabel('L_temp_grid_',33:96);%left temp grid 1:96 in CFS and Loc
cntInfo(iSub).label(65:96) = mklabel('L_frontal_grid_',97:128);%left temp grid 65:96 in CFS and Loc
cntInfo(iSub).label(97:100) = mklabel('L_temp_pole_',129:132);
cntInfo(iSub).label(101:104) = mklabel('L_ant_subTemp_',(0:3) + 133);
cntInfo(iSub).label(105:108) = mklabel('L_mid_subTemp_',(0:3) + 137);
cntInfo(iSub).label(109:112) = mklabel('L_post_subTemp_strip_',(0:3) + 141);
cntInfo(iSub).label(113:116) = mklabel('L_Amyg_',(0:3) + 149);
cntInfo(iSub).label((0:3)+117) = mklabel('R_mid_subTemp_',(0:3) + 145);
cntInfo(iSub).label(121:128) = mklabel('Not_Connected_',(1:8));


%% For Patient 149 %Using the incorrect numbering to match the figure!!
iSub = iSub + 1;
cntInfo(iSub).label(1:64) = mklabel('R_temp_grid_',1:64);
cntInfo(iSub).label(65:96) = mklabel('R_post_subTemp_grid_',97:128);
% cntInfo(iSub).label((0:3)+97) = mklabel('R_ant_subTemp_strip_',(0:3) + 173  );
% cntInfo(iSub).label((0:3)+101) = mklabel('R_mid_subTemp_strip_',(0:3) + 177 );
cntInfo(iSub).label((0:3)+97) = mklabel('R_ant_subTemp_strip_',(0:3) + 173 - 4 );
cntInfo(iSub).label((0:3)+101) = mklabel('R_mid_subTemp_strip_',(0:3) + 177 - 4 );
cntInfo(iSub).label((0:3)+105) = mklabel('R_Heschl_',(0:3) + 143);
% cntInfo(iSub).label((0:3)+109) = mklabel('R_Amyg_',(0:3) + 149 );
% cntInfo(iSub).label((0:3)+113) = mklabel('L_ant_subTemp_strip_',(0:3) + 181 );
% cntInfo(iSub).label((0:3)+117) = mklabel('L_mid_subTemp_strip_',(0:3) + 185 );
% cntInfo(iSub).label((0:3)+121) = mklabel('L_post_subTemp_strip_',(0:3) + 189);
% cntInfo(iSub).label((0:3)+125) = mklabel('L_Amyg_',(0:3) + 167  );
cntInfo(iSub).label((0:3)+109) = mklabel('R_Amyg_',(0:3) + 149 - 2 );
cntInfo(iSub).label((0:3)+113) = mklabel('L_ant_subTemp_strip_',(0:3) + 181 - 4 );
cntInfo(iSub).label((0:3)+117) = mklabel('L_mid_subTemp_strip_',(0:3) + 185 - 4 );
cntInfo(iSub).label((0:3)+121) = mklabel('L_post_subTemp_strip_',(0:3) + 189 - 4 );
cntInfo(iSub).label((0:3)+125) = mklabel('L_Amyg_',(0:3) + 167 - 2 );

%% For Patient 153 (all localizer sessions)
iSub = iSub + 1;

cntInfo(iSub).subID                 = '153';

cntInfo(iSub).label(1:64)           = mklabel('R_temp_grid_',           1:64);
cntInfo(iSub).label(65:96)          = mklabel('R_post_subTemp_grid_',   129:160);
cntInfo(iSub).label((0:3)+97)       = mklabel('R_temp_pole_',           (0:3) + 205);
cntInfo(iSub).label((0:3)+101)      = mklabel('R_ant_subTemp_strip_',   (0:3) + 209);
cntInfo(iSub).label((0:3)+105)      = mklabel('R_Amyg_',                (0:3) + 201);
cntInfo(iSub).label((0:3)+109)      = mklabel('R_Heschl_',              (0:3) + 175);
% cntInfo(iSub).label((0:3)+113) = mklabel('L_ant_subTemp_strip_',(0:3) + 213);
% cntInfo(iSub).label((0:3)+117) = mklabel('L_post_subTemp_strip_',(0:3) + 217);
cntInfo(iSub).label((0:3)+117)      = mklabel('L_ant_subTemp_strip_',   (0:3) + 213); %Swapped due to connection error
cntInfo(iSub).label((0:3)+113)      = mklabel('L_post_subTemp_strip_',  (0:3) + 217);
% cntInfo(iSub).label((0:3)+121) = mklabel('L_lat_temp_strip_',(0:3) + 221);
cntInfo(iSub).label((0:3)+121)      = mklabel('L_lat_temp_pole_',       (0:3) + 221);
cntInfo(iSub).label((0:3)+125)      = mklabel('L_Amyg_',                (0:3) + 195);

%% For Patient 154a_CFS_73_74
% localizer: 71, 72 (154a)
iSub = iSub + 1;
cntInfo(iSub).subID                 = '154a';

cntInfo(iSub).label(1:96)           = mklabel('R_temp_grid_',           (1:96));
cntInfo(iSub).label((0:3)+97)       = mklabel('L_ant_subTemp_strip_',   (0:3) + 205);
cntInfo(iSub).label((0:3)+101)      = mklabel('L_Amyg_',                (0:3) + 199);
cntInfo(iSub).label((0:3)+105)      = mklabel('R_Amyg_',                (0:3) + 181);
cntInfo(iSub).label((0:3)+109)      = mklabel('R_Heschl_',              (0:3) + 175);
cntInfo(iSub).label(113:128)        = mklabel('Not_Connected_',          1:16);

% For Patient 154_DF_BM_CFS_137
%% combine 154b CFS_73_74 and DF_BM_CFS_137
% localizer: 134, 135 (154b)
iSub = iSub + 1;
cntInfo(iSub).subID                 = '154b';

cntInfo(iSub).label(1:64)           = mklabel('R_temp_grid_',           1:64);
cntInfo(iSub).label((0:31) + 65)    = mklabel('R_subTemp_grid_',        129:160); % for DF_BM_CFS_137
% cntInfo(iSub).label([65:96]+64)   = mklabel('R_temp_grid_',65:96);% for CFS_73_74
% cntInfo(iSub).label(1:32)         = mklabel('R_subTemp_grid_',129:160);
cntInfo(iSub).label((0:3)+97)       = mklabel('L_ant_subTemp_strip_',    (0:3) + 205);
cntInfo(iSub).label((0:3)+101)      = mklabel('L_Amyg_',                (0:3) + 199);
cntInfo(iSub).label((0:3)+105)      = mklabel('R_Amyg_',                (0:3) + 181);
cntInfo(iSub).label((0:3)+109)      = mklabel('R_Heschl_',              (0:3) + 175);
cntInfo(iSub).label(113:128)        = mklabel('Not_Connected_',          1:16);

%% For Patient 156_DF_BM_loc
iSub = iSub + 1;

cntInfo(iSub).subID                 = '156';

cntInfo(iSub).label(33:96)          = mklabel('R_temp_grid_',           33:96);
cntInfo(iSub).label((0:15)+97)      = mklabel('L_post_subTemp_grid_',   129:144);
cntInfo(iSub).label((0:15)+113)     = mklabel('L_middle_subTemp_grid_', 145:160);
cntInfo(iSub).label((0:3)+17)       = mklabel('L_Heschl_',              (0:3) + 175);
cntInfo(iSub).label((0:3)+13)       = mklabel('L_Amyg_',                (0:3) + 181);
cntInfo(iSub).label((0:3)+29)       = mklabel('R_Amyg_',                (0:3) + 199);
cntInfo(iSub).label((0:3)+1)        = mklabel('L_temp_pole_',           (0:3) + 205);
cntInfo(iSub).label((0:3)+5)        = mklabel('L_ant_subTemp_strip_',   (0:3) + 209);
cntInfo(iSub).label((0:3)+9)        = mklabel('L_mid_subTemp_strip_',   (0:3) + 213);
cntInfo(iSub).label((0:3)+21)       = mklabel('R_ant_subTemp_strip_',   (0:3) + 217);
cntInfo(iSub).label((0:3)+25)       = mklabel('R_post_subTemp_strip_',  (0:3) + 221);

%% For Patient 156_CFS, NOT for localizer
iSub = iSub + 1;

cntInfo(iSub).label(33:96)          = mklabel('R_temp_grid_',           33:96);
cntInfo(iSub).label((0:15)+1)       = mklabel('L_post_subTemp_grid_',   129:144);
cntInfo(iSub).label((0:15)+17)      = mklabel('L_middle_subTemp_grid_', 145:160);
cntInfo(iSub).label((0:3)+113)      = mklabel('L_Heschl_',              (0:3) + 175);
cntInfo(iSub).label((0:3)+109)      = mklabel('L_Amyg_',                (0:3) + 181);
cntInfo(iSub).label((0:3)+125)      = mklabel('R_Amyg_',                (0:3) + 199);
cntInfo(iSub).label((0:3)+97)       = mklabel('L_temp_pole_',           (0:3) + 205);
cntInfo(iSub).label((0:3)+101)      = mklabel('L_ant_subTemp_strip_',   (0:3) + 209);
cntInfo(iSub).label((0:3)+105)      = mklabel('L_mid_subTemp_strip_',   (0:3) + 213);
cntInfo(iSub).label((0:3)+117)      = mklabel('R_ant_subTemp_strip_',   (0:3) + 217);
cntInfo(iSub).label((0:3)+121)      = mklabel('R_post_subTemp_strip_',  (0:3) + 221);

%% 162
iSub = iSub + 1;
cntInfo(iSub).subID                 = '162';

cntInfo(iSub).label(1:96)           = mklabel('L_temp_grid_',1:96);
cntInfo(iSub).label(97:128)         = mklabel('L_frontal_grid_',97:128);
cntInfo(iSub).label(129:160)        = mklabel('Not_Connected_',129:160);
cntInfo(iSub).label((160:163)+1)    = mklabel('L_temp_pole_',[205:208]);
cntInfo(iSub).label((160:163)+5)    = mklabel('L_ant_subTemp_strip_',[209:212]);
cntInfo(iSub).label((160:163)+9)    = mklabel('L_mid_subTemp_strip_',[213:216]);
cntInfo(iSub).label((160:163)+13)   = mklabel('L_Amyg_',[201:204]);
cntInfo(iSub).label((160:163)+17)   = mklabel('L_Heschl_',[175:178]);
cntInfo(iSub).label((160:163)+21)   = mklabel('R_ant_subTemp_strip_',[217:220]);
cntInfo(iSub).label((160:163)+25)   = mklabel('R_post_subTemp_strip_',[221:224]);
cntInfo(iSub).label((160:163)+29)   = mklabel('R_Amyg_',[195:198]);
% cntInfo(iSub).label((160:163)+29) = mklabel('R_Amyg_',[195:200]);


%% 168
iSub = iSub + 1;

cntInfo(iSub).subID                 = '168';

cntInfo(iSub).label(1:96)           = mklabel('L_temp_grid_',           1:96);
cntInfo(iSub).label(97:128)         = mklabel('L_frontal_grid_',        97:128);
cntInfo(iSub).label(129:160)        = mklabel('L_post_subTemp_',        129:160);
cntInfo(iSub).label((160:163)+1)    = mklabel('L_temp_pole_',           161:164);
cntInfo(iSub).label((160:163)+5)    = mklabel('L_ant_subTemp_strip_',   [165:168]);
cntInfo(iSub).label((160:163)+9)    = mklabel('L_Amyg_',                [177:180]);
cntInfo(iSub).label((160:163)+13)   = mklabel('L_Heschl_',              [181:184]);
% cntInfo(iSub).label((160:163)+13) = mklabel('L_Heschl_',[181:184]);
cntInfo(iSub).label((160:163)+17)   = mklabel('R_ant_subTemp_',         [169:172]);
cntInfo(iSub).label((160:163)+21)   = mklabel('R_ant_mid_subTemp_',     [173:176]);
cntInfo(iSub).label((160:163)+25)   = mklabel('R_Amyg_',                [187:190]);
% cntInfo(iSub).label((160:163)+25) = mklabel('R_Amyg_',[187:190]);
cntInfo(iSub).label((160:163)+29)   = mklabel('Not_Connected_',         [189:192]);

%% 173

iSub = iSub + 1;

cntInfo(iSub).subID                 = '173';
cntInfo(iSub).task                  = {'localizer'};
cntInfo(iSub).session               = [037, 038, 039, 040, 112, 162, 164, 165];

cntInfo(iSub).label(1:10)           = mklabel('L_temp_grid_',           1:10);
cntInfo(iSub).label(11:16)          = mklabel('Not_Connected_',         1:6);
cntInfo(iSub).label(17:26)          = mklabel('L_temp_grid_',           11:20);
cntInfo(iSub).label(27:32)          = mklabel('Not_Connected_',         7:12);
cntInfo(iSub).label(33:44)          = mklabel('L_temp_grid_',           21:32);
cntInfo(iSub).label(45:48)          = mklabel('Not_Connected_',         13:16);
cntInfo(iSub).label(49:58)          = mklabel('L_temp_grid_',           33:42);
cntInfo(iSub).label(59:64)          = mklabel('Not_Connected_',         17:22);
cntInfo(iSub).label(65:74)          = mklabel('L_temp_grid_',           43:52);
cntInfo(iSub).label(75:84)          = mklabel('L_temp_grid_',           65:74);
cntInfo(iSub).label(85:94)          = mklabel('L_temp_grid_',           75:84);
cntInfo(iSub).label(95:96)          = mklabel('Not_Connected_',         23:24);
cntInfo(iSub).label(97:108)         = mklabel('L_temp_grid_',           53:64);
cntInfo(iSub).label(109:112)        = mklabel('Not_Connected_',         25:28);
cntInfo(iSub).label(113:124)        = mklabel('L_temp_grid_',           85:96);
cntInfo(iSub).label(125:128)        = mklabel('Not_Connected_',         29:32);
cntInfo(iSub).label(129:160)        = mklabel('L_frontal_grid_',        97:128);
cntInfo(iSub).label(161:192)        = mklabel('L_subTemp_grid_',        129:160);
cntInfo(iSub).label(193:224)        = mklabel('L_temp_pole_',           161:192);
cntInfo(iSub).label(225:228)        = mklabel('L_Heschl_',              193:196);% the experiment record entry form states that the electrodes used here are 193:198. this doesn't add up to the acquired channel numbers
cntInfo(iSub).label(229:232)        = mklabel('L_Amyg_',                1:4);
cntInfo(iSub).label(233:236)        = mklabel('R_Amyg_',                205:208);
cntInfo(iSub).label(237:240)        = mklabel('L_ant_subTemp_',         209:212);
cntInfo(iSub).label(241:244)        = mklabel('R_subTemp_med_',         213:216);
cntInfo(iSub).label(245:256)        = mklabel('Not_Connected_',         33:44);

%% 178
iSub = iSub + 1;
cntInfo(iSub).subID                 = '178';

cntInfo(iSub).label(1:96)           = mklabel('L_temp_grid_',           1:96);
cntInfo(iSub).label(97:128)         = mklabel('L_frontal_grid_',        97:128);
cntInfo(iSub).label(129:160)        = mklabel('L_temp_pole_',           129:160); % This is called 'Left Temporal Grid in protocol
cntInfo(iSub).label(161:192)        = mklabel('L_post_subTemp_',        161:192);
cntInfo(iSub).label(193:196)        = mklabel('L_ant_subFrontal_strip_',193:196);
cntInfo(iSub).label(197:200)        = mklabel('L_post_subFrontal_strip_',197:200);
cntInfo(iSub).label(201:204)        = mklabel('L_Heschl_',              201:204);
cntInfo(iSub).label(205:208)        = mklabel('L_Amyg_',                205:208);
cntInfo(iSub).label(209:212)        = mklabel('L_Hipp_',                209:212);
cntInfo(iSub).label(213:224)        = mklabel('Not_Connected_',         213:224);
cntInfo(iSub).label(225:240)        = mklabel('L_Heschl_High_',         225:240);
cntInfo(iSub).label(241:256)        = mklabel('Not_Connected_',         241:256);


%% 180

iSub = iSub + 1;
cntInfo(iSub).subID                 = '180';

cntInfo(iSub).label(1:96)           = mklabel('R_temp_grid_',                   1:96);%96
cntInfo(iSub).label(97:128)         = mklabel('R_frontal_grid_',                97:128);%32
cntInfo(iSub).label(129:144)        = mklabel('R_post_subTemp_strip_',          129:144);%16
cntInfo(iSub).label(145:160)        = mklabel('R_post_subTemp_middle_strip_',   145:160);%16
cntInfo(iSub).label(161:176)        = mklabel('R_ant_subTemp_strip_',           161:176);%16
cntInfo(iSub).label(177:192)        = mklabel('R_temp_pole_strip_',             177:192); %16
cntInfo(iSub).label(193:196)        = mklabel('R_ant_subFrontal_strip_',        193:196);%4
cntInfo(iSub).label(197:200)        = mklabel('R_post_subFrontal_strip_',       197:200);%4
cntInfo(iSub).label(201:204)        = mklabel('R_Heschl_',                      201:204);
cntInfo(iSub).label(205:208)        = mklabel('R_Amyg_',                        205:208);
cntInfo(iSub).label(209:218)        = mklabel('R_paraHippocampus_strip_',       209:218);% last 6 electrodes of this strip is not shown on ventral image. I used ginput to create these to my best guess.
cntInfo(iSub).label(219:224)        = mklabel('R_post_Hippocampus_depth_',      219:224);
% cntInfo(iSub).label(225:240)        = mklabel('Not_Connected_',                 225:240);
% cntInfo(iSub).label(241:256)        = mklabel('R_Amyg_depth_',                  241:256);%(micro 1-15, macro 5)
% cntInfo(iSub).label(257:262)        = mklabel('subCutaneous_strip_',            257:262);%6

%% 181

%protocol is incomplete, I think..
iSub = iSub + 1;
cntInfo(iSub).subID                 = '181';

cntInfo(iSub).label(1:64)           = mklabel('L_temp_grid_',                    1:64);% in protocol this is parietal
cntInfo(iSub).label(65:70)          = mklabel('subCutaneous_strip_',             65:70);%


%% 186


iSub = iSub + 1;
cntInfo(iSub).subID                 = '186';

cntInfo(iSub).label(1:96)           = mklabel('R_temp_grid_',                   1:96);%96 chan 91 is broken
% cntInfo(iSub).label(91:91)          = mklabel('Not_Connected_',                 91:91); %1 see protocol
% cntInfo(iSub).label(92:96)          = mklabel('R_temp_grid_',                   92:96);%96 chan 91 is broken
cntInfo(iSub).label(97:128)         = mklabel('R_inf_frontal_grid_',            97:128);%32
cntInfo(iSub).label(129:160)        = mklabel('R_post_subTemp_grid_',           129:160);%32
cntInfo(iSub).label(161:164)        = mklabel('R_ant_subFrontal_strip_',        161:164);%4
cntInfo(iSub).label(165:168)        = mklabel('R_post_subFrontal_strip_',       165:168);%4
cntInfo(iSub).label(169:172)        = mklabel('R_ant_medFrontal_depth_',        169:172);%4
cntInfo(iSub).label(173:176)        = mklabel('R_Heschl_',                      173:176);
cntInfo(iSub).label(177:180)        = mklabel('R_Amyg_depth_',                  177:180);
cntInfo(iSub).label(181:184)        = mklabel('R_temp_pole_strip_',             181:184); %4
cntInfo(iSub).label(185:188)        = mklabel('R_ant_subTemp_strip_',           185:188);%4
cntInfo(iSub).label(189:192)        = mklabel('L_Amyg_',                        189:192);
cntInfo(iSub).label(193:208)        = mklabel('R_sup_frontal_strip_',           193:208);%16
cntInfo(iSub).label(209:218)        = mklabel('R_paraHippocampus_strip_',       209:218);%10
cntInfo(iSub).label(219:224)        = mklabel('R_post_med_frontal_depth_',      219:224);%6
cntInfo(iSub).label(225:236)        = mklabel('L_ant_temp_pole_grid_',          225:236); %4

cntInfo(iSub).label(237:240)        = mklabel('R_subTemp_middle_strip_',        237:240);
% cntInfo(iSub).label(241:241)        = mklabel('Not_Connected_',                 241:241); %1 see protocol
cntInfo(iSub).label(241:251)        = mklabel('L_pos_temp_pole_grid_',          241:251); %4 protocol says 252, but I only see 8 channels


% % cntInfo(iSub).label(252:265)        = mklabel('R_Heschl_micro_',                252:265); 
% cntInfo(iSub).label(252:267)        = mklabel('R_Heschl_',                      252:267); 
% % cntInfo(iSub).label(268:281)        = mklabel('L_Amyg_micro_',                  268:281);
% cntInfo(iSub).label(268:283)        = mklabel('L_Amyg_',                        268:283);
% % in protocol these are right Heschl and left amygdala (micro and macro) it says however that there is high impedance and probably a loose connection
% 
% cntInfo(iSub).label(284:289)        = mklabel('subCutaneous_strip_',             284:289);%6


%% 206

iSub = iSub + 1;
cntInfo(iSub).subID                 = '206';

%% 232
iSub = iSub + 1;
cntInfo(iSub).subID                 = '232';

cntInfo(iSub).label(1:32)           = mklabel('R_par_grid_',                    1:32);%32
cntInfo(iSub).label(33:48)          = mklabel('R_dors_frontal_grid_',           33:48);%16
cntInfo(iSub).label(49:64)          = mklabel('R_dors_par_grid_',               49:64);%16
cntInfo(iSub).label(65:68)          = mklabel('R_post_med_frontal_depth_',      65:68);%
cntInfo(iSub).label(69:72)          = mklabel('Not_Connected_',                 69:72); %
cntInfo(iSub).label(73:76)          = mklabel('R_ant_med_par_depth_',            73:76);%4
cntInfo(iSub).label(77:80)          = mklabel('Not_Connected_',                 77:80); %
cntInfo(iSub).label(81:90)          = mklabel('R_med_lat_frontal_grid_',         81:90);% in protocol first lateral frontal grid
cntInfo(iSub).label(91:96)          = mklabel('R_pos_med_par_strip_',            91:96);%
cntInfo(iSub).label(97:104)         = mklabel('R_ant_medFrontal_depth_',        97:104);%
cntInfo(iSub).label(105:128)        = mklabel('Not_Connected_',                 105:128); %
cntInfo(iSub).label(129:136)        = mklabel('R_frontal_interhemispheric_strip_',129:136);%
cntInfo(iSub).label(137:144)        = mklabel('R_par_interhemispheric_strip_',  137:144);%
cntInfo(iSub).label(145:154)        = mklabel('R_lat_frontal_grid_',            145:154);%
cntInfo(iSub).label(155:160)        = mklabel('Not_Connected_',                 155:160); %

% cntInfo(iSub).label(155:176)        = mklabel('Not_Connected_',                 155:176); %
% cntInfo(iSub).label(177:182)        = mklabel('subCutaneous_strip_',             177:182);%

%% 242
%NOT FINISHED!
iSub = iSub + 1;
cntInfo(iSub).subID                 = '242';

cntInfo(iSub).label(1:32)           = mklabel('L_inf_temp_occ_grid_',           1:32);%32
cntInfo(iSub).label(33:64)          = mklabel('L_subTemp_grid_',                33:64);%
cntInfo(iSub).label(65:74)          = mklabel('L_ant_mid_temp_grid_',           65:74);%
cntInfo(iSub).label(75:80)          = mklabel('Not_Connected_',                 75:80); %
cntInfo(iSub).label(81:90)          = mklabel('L_pos_mid_temp_grid_',           81:90);%
cntInfo(iSub).label(91:128)         = mklabel('Not_Connected_',                 91:128); %
cntInfo(iSub).label(129:144)        = mklabel('L_sup_temp_occ_grid_',           129:144);%
cntInfo(iSub).label(145:154)        = mklabel('L_paraHippocampus_strip_',       145:154);% 
% cntInfo(iSub).label(153:154)        = mklabel('L_temp_paraHippocampus_strip_',  153:154);% actually till 254
cntInfo(iSub).label(155:160)        = mklabel('Not_Connected_',                 155:160); %
cntInfo(iSub).label(161:164)        = mklabel('L_Heschl_',                      161:164);
cntInfo(iSub).label(165:168)        = mklabel('R_subTemp_strip_',               165:168);%
cntInfo(iSub).label(169:172)        = mklabel('R_Amyg_',                        169:172);
cntInfo(iSub).label(173:176)        = mklabel('L_post_Hippocampus_depth_',      173:176);
cntInfo(iSub).label(177:192)        = mklabel('Not_Connected_',                 177:192); %
cntInfo(iSub).label(193:200)        = mklabel('L_Amyg_',                        193:200);
cntInfo(iSub).label(201:204)        = mklabel('L_temp_lesion_depth_',           201:204);
cntInfo(iSub).label(205:208)        = mklabel('Not_Connected_',                 205:208); %
cntInfo(iSub).label(209:214)        = mklabel('L_ant_ant_temp_pole_',           209:214); % This is called 'Left Temporal Grid in protocol
% cntInfo(iSub).label(213:214)        = mklabel('L_ant_temp_ant_temp_pole_',      213:214); % This is called 'Left Temporal Grid in protocol
cntInfo(iSub).label(215:219)        = mklabel('L_pos_ant_temp_pole_',           215:219); % This is called 'Left Temporal Grid in protocol
% cntInfo(iSub).label(218:219)        = mklabel('L_ant_temp_ant_temp_pole_',      218:219); % This is called 'Left Temporal Grid in protocol
cntInfo(iSub).label(220:224)        = mklabel('Not_Connected_',                 220:224); %
cntInfo(iSub).label(225:236)        = mklabel('L_pos_temp_pole_',               225:236); % This is called 'Left Temporal Grid in protocol
cntInfo(iSub).label(237:240)        = mklabel('Not_Connected_',                 237:240); %
cntInfo(iSub).label(241:250)        = mklabel('R_paraHippocampus_strip_',       241:250);%10
cntInfo(iSub).label(251:256)        = mklabel('Not_Connected_',                 251:256); %micro electrodes included


% cntInfo(iSub).label(251:288)        = mklabel('Not_Connected_',                 251:288); %micro electrodes included
% cntInfo(iSub).label(289:294)        = mklabel('subCutaneous_strip_',            289:294);%



%% check regions
temp_grid = zeros(length(cntInfo),1);
Amyg = temp_grid;
Heschl = temp_grid;
temp_pole = temp_grid;
subTemp = temp_grid;
Not_Connected = temp_grid;
frontal = temp_grid;
subFrontal = temp_grid;
medFrontal = temp_grid;
Hipp = temp_grid;
Cutaneous= temp_grid;
parietal = temp_grid;
occipital = temp_grid;
lesion =  temp_grid;
for iSub = 1:length(cntInfo)
    for iLabel = 1:length(cntInfo(iSub).label)
        if findstr(cntInfo(iSub).label{iLabel},'temp_grid')
            temp_grid(iSub) = temp_grid(iSub) + 1;
        elseif findstr(cntInfo(iSub).label{iLabel},'Amyg')
            Amyg(iSub) = Amyg(iSub) + 1;
        elseif findstr(cntInfo(iSub).label{iLabel},'Heschl')
            Heschl(iSub) = Heschl(iSub) + 1;
        elseif findstr(cntInfo(iSub).label{iLabel},'temp_pole')
            temp_pole(iSub) = temp_pole(iSub) + 1;
        elseif findstr(cntInfo(iSub).label{iLabel},'subTemp')
            subTemp(iSub) = subTemp(iSub) + 1;
        elseif findstr(cntInfo(iSub).label{iLabel},'Not_Connected')
            Not_Connected(iSub) = Not_Connected(iSub) + 1;
        elseif findstr(cntInfo(iSub).label{iLabel},'frontal')
            frontal(iSub) = frontal(iSub) + 1;
        elseif findstr(cntInfo(iSub).label{iLabel},'subFrontal')
            subFrontal(iSub) = subFrontal(iSub) + 1;
        elseif findstr(cntInfo(iSub).label{iLabel},'medFrontal')
            medFrontal(iSub) = medFrontal(iSub) + 1;
        elseif findstr(cntInfo(iSub).label{iLabel},'Hipp')
            Hipp(iSub) = Hipp(iSub) + 1;
        elseif findstr(cntInfo(iSub).label{iLabel},'Cutaneous')
            Cutaneous(iSub) = Cutaneous(iSub) + 1;
        elseif findstr(cntInfo(iSub).label{iLabel},'par')
            parietal(iSub) = Cutaneous(iSub) + 1;
        elseif findstr(cntInfo(iSub).label{iLabel},'occ')
            occipital(iSub) = Cutaneous(iSub) + 1;
        elseif findstr(cntInfo(iSub).label{iLabel},'lesion')
            lesion(iSub) = Cutaneous(iSub) + 1;
        else
            cntInfo(iSub).label{iLabel}
            keyboard
        end
    end
end
%%
% save(['/Volumes/Hamachi/naotsu/IowaData/MAP/cntInfo.mat'])
% save(['/export/kani/shared/IowaData/MAP/cntInfo.mat'])

if isdir('/Volumes/Jochem_4T/Iowa/')
    save(['/Volumes/Jochem_4T/Iowa/MAP' '/cntInfo.mat'])
end
% %% save per subject
% cntInfoAll = cntInfo;
% clear cntInfo
% for iSub = 1:length(subjid)
%     cntInfo = cntInfoAll(iSub);
%     
%     if ~isempty(cntInfo.task)
%         for iTask = 1:length(cntInfo.task)
%             if strcmpi(cntInfo.task{iTask},'localizer')
%                 save(['/export/kani/jochem/human/Iowa/MAP/localizer/cntInfo_' cntInfo.subID '.mat'],'cntInfo')
%             elseif strcmpi(cntInfo.task{iTask},'CFS')
%                 save(['/export/kani/jochem/human/Iowa/MAP/CFS/cntInfo_' cntInfo.subID '.mat'],'cntInfo')
%             end
%             
%         end
%         
%     end
%     
% end
% 


%%
% % 
% for i = 1:length(subjid),
%         
%     dd = dir(sprintf('%s_saccwin*',subjid{i}));
%     fns = {dd.name};
% 
%     for f = 1:length(fns)
% 
%         channelData = cntInfo(i);
%         save(fns{f},'-append','channelData');
% 
%     end
% 
% 
% end
% %
% %
