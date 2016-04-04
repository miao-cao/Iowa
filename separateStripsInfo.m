
%%
if strcmp(SUB.cntID,'147_DF_CFS')
    
    % grids/strips for each view
    labels_temporal={'L_temp_grid'};
    labels_ventral={'L_temp_pole','L_ant_subTemp','L_mid_subTemp','L_post_subTemp_strip','R_mid_subTemp'};
    labels_none={'L_Amyg'};
    labels_ignore={'Not_Connected'};
    
    % Double-check the information below with Nao as it is critical - especially for view='none' electrodes
    % number of electrodes per (vertical) line for each grid/strip
    el_perline_temporal=[8];
    el_perline_ventral=[4 4 4 4 4];
    el_perline_none=[4];
    el_perline_ignore=[999];
    
    % number of electrodes per (horizontal) row for each grid/strip
    el_perrow_temporal=[12];
    el_perrow_ventral=[1 1 1 1 1];
    el_perrow_none=[1];
    el_perrow_ignore=[999];
    
    
    % flags - 1 if the corresponding set of electrodes need label renaming
    flag_separate_temporal=[0];
    flag_separate_ventral=[0 0 0 0 0];
    flag_separate_none=[0];
    flag_separate_ignore=[0];
    
 
% New label L_temp_grid starting at index 1 el number 96
% New label L_temp_pole starting at index 97 el number 4
% New label L_ant_subTemp starting at index 101 el number 4
% New label L_mid_subTemp starting at index 105 el number 4
% New label L_post_subTemp_strip starting at index 109 el number 4
% New label L_Amyg starting at index 113 el number 4
% New label R_mid_subTemp starting at index 117 el number 4
% New label Not_Connected starting at index 121 el number 8
end
%%
if strcmp(SUB.cntID,'147_BM')
    
    % grids/strips for each view
    labels_temporal={'L_temp_grid','L_front_grid'};
    labels_ventral={'L_temp_pole','L_ant_subTemp','L_mid_subTemp','L_post_subTemp_strip','R_mid_subTemp'};
    labels_none={'L_Amyg'};
    labels_ignore={'Not_Connected'};
    
    % Double-check the information below with Nao as it is critical - especially for view='none' electrodes
    % number of electrodes per (vertical) line for each grid/strip
    el_perline_temporal=[8,8];
    el_perline_ventral=[4 4 4 4 4];
    el_perline_none=[4];
    el_perline_ignore=[999];
    
    % number of electrodes per (horizontal) row for each grid/strip
    el_perrow_temporal=[8,4];
    el_perrow_ventral=[1 1 1 1 1];
    el_perrow_none=[1];
    el_perrow_ignore=[999];
    
    
    % flags - 1 if the corresponding set of electrodes need label renaming
    flag_separate_temporal=[0 0];
    flag_separate_ventral=[0 0 0 0 0];
    flag_separate_none=[0];
    flag_separate_ignore=[0];
    
 
% New label L_temp_grid starting at index 1 el number 96
% New label L_temp_pole starting at index 97 el number 4
% New label L_ant_subTemp starting at index 101 el number 4
% New label L_mid_subTemp starting at index 105 el number 4
% New label L_post_subTemp_strip starting at index 109 el number 4
% New label L_Amyg starting at index 113 el number 4
% New label R_mid_subTemp starting at index 117 el number 4
% New label Not_Connected starting at index 121 el number 8
end

%%
if strcmp(SUB.cntID,'149')
    
    % grids/strips for each view
    labels_temporal={'R_temp_grid'};
    labels_ventral={'R_post_subTemp_grid','R_ant_subTemp_strip','R_mid_subTemp_strip','L_ant_subTemp_strip','L_mid_subTemp_strip','L_post_subTemp_strip'};
    labels_none={'R_Heschl','R_Amyg','L_Amyg'};
    labels_ignore={'Not_Connected'};
    
    % Double-check the information below with Nao as it is critical - especially for view='none' electrodes
    % number of electrodes per (vertical) line for each grid/strip
    el_perline_temporal=[8];
    el_perline_ventral=[8 4 4 4 4 4];
    el_perline_none=[4 4 4];
    el_perline_ignore=[999];
    
    % number of electrodes per (horizontal) row for each grid/strip
    el_perrow_temporal=[8];
    el_perrow_ventral=[4 1 1 1 1 1];
    el_perrow_none=[1 1 1];
    el_perrow_ignore=[999];
    
    
    % flags - 1 if the corresponding set of electrodes need label renaming
    flag_separate_temporal=[0];
    flag_separate_ventral=[1 0 0 0 0 0];
    flag_separate_none=[0 0 0];
    flag_separate_ignore=[0];
    
    new_labels_ventral{1}={'R_post_post_subTemp_grid','R_ant_post_subTemp_grid'};
    
    grid_size_ventral{1}=[16 16];
    


% New label R_temp_grid starting at index 1 el number 64
% New label R_post_subTemp_grid starting at index 65 el number 32
% New label R_ant_subTemp_strip starting at index 97 el number 4
% New label R_mid_subTemp_strip starting at index 101 el number 4
% New label R_Heschl starting at index 105 el number 4
% New label R_Amyg starting at index 109 el number 4
% New label L_ant_subTemp_strip starting at index 113 el number 4
% New label L_mid_subTemp_strip starting at index 117 el number 4
% New label L_post_subTemp_strip starting at index 121 el number 4
% New label L_Amyg starting at index 125 el number 4
end
%%
if strcmp(SUB.cntID,'153')
    
    % grids/strips for each view
    labels_temporal={'R_temp_grid'};
    labels_ventral={'R_post_subTemp_grid','R_temp_pole','R_ant_subTemp_strip','L_post_subTemp_strip','L_ant_subTemp_strip','L_lat_temp_pole'};
    labels_none={'R_Amyg','R_Hesch','L_Amyg'};
    labels_ignore={'Not_Connected'};
    
    % Double-check the information below with Nao as it is critical - especially for view='none' electrodes
    % number of electrodes per (vertical) line for each grid/strip
    el_perline_temporal=[8];
    el_perline_ventral=[8 4 4 4 4 4];
    el_perline_none=[4 4 4];
    el_perline_ignore=[999];
    
    % number of electrodes per (horizontal) row for each grid/strip
    el_perrow_temporal=[8];
    el_perrow_ventral=[4 1 1 1 1 1];
    el_perrow_none=[1 1 1];
    el_perrow_ignore=[999];
    
    
    % flags - 1 if the corresponding set of electrodes need label renaming
    flag_separate_temporal=[0];
    flag_separate_ventral=[1 0 0 0 0 0];
    flag_separate_none=[0 0 0];
    flag_separate_ignore=[0];
    
    new_labels_ventral{1}={'R_post_post_subTemp_grid','R_ant_post_subTemp_grid'};
% it is not necessary to swap the labels below; actually there was a mistake in the pdf
%     new_labels_ventral{4}={'L_ant_subTemp_strip'}; % these two labels were inverted my mistake; note that the contact number is not correct, but the channel number is
%     new_labels_ventral{5}={'L_post_subTemp_strip'};
    
    grid_size_ventral{1}=[16 16];
%     grid_size_ventral{4}=[4];
%     grid_size_ventral{5}=[4];
    
% New label R_temp_grid starting at index 1 el number 64
% New label R_post_subTemp_grid starting at index 65 el number 32
% New label R_temp_pole starting at index 97 el number 4
% New label R_ant_subTemp_strip starting at index 101 el number 4
% New label R_Amyg starting at index 105 el number 4
% New label R_Hesch starting at index 109 el number 4
% New label L_post_subTemp_strip starting at index 113 el number 4
% New label L_ant_subTemp_strip starting at index 117 el number 4
% New label L_lat_temp_pole starting at index 121 el number 4
% New label L_Amyg starting at index 125 el number 4    
end

%%
if strcmp(SUB.cntID,'154a_CFS_73_74')
%     
    % grids/strips for each view
    labels_temporal={'R_temp_grid'};
    labels_ventral={'L_ant_subTemp_strip'};
    labels_none={'L_Amyg','R_Amyg','R_Heschl'};
    labels_ignore={'Not_Connected'};
    
    % Double-check the information below with Nao as it is critical - especially for view='none' electrodes
    % number of electrodes per (vertical) line for each grid/strip
    el_perline_temporal=[8];
    el_perline_ventral=[4];
    el_perline_none=[4 4 4];
    el_perline_ignore=[999];
    
    % number of electrodes per (horizontal) row for each grid/strip
    el_perrow_temporal=[12];
    el_perrow_ventral=[1];
    el_perrow_none=[1 1 1];
    el_perrow_ignore=[999];
    
    
    % flags - 1 if the corresponding set of electrodes need label renaming
    flag_separate_temporal=[0];
    flag_separate_ventral=[0];
    flag_separate_none=[0 0 0];
    flag_separate_ignore=[0];
   
%     
% 
% New label R_temp_grid_ starting at index 1 el number 96
% New label L_ant_subTemp_strip_ starting at index 97 el number 4
% New label L_Amyg_ starting at index 101 el number 4
% New label R_Amyg_ starting at index 105 el number 4
% New label R_Heschl_ starting at index 109 el number 4
% New label Not_Connected starting at index 113 el number 16
end

%%
if strcmp(SUB.cntID,'154b_DF_BM_CFS_137')
    
    % grids/strips for each view
    labels_temporal={'R_temp_grid'};
    labels_ventral={'R_subTemp_grid','L_ant_subTemp_strip'};
    labels_none={'L_Amyg','R_Amyg','R_Heschl'};
    labels_ignore={'Not_Connected'};
    
    % Double-check the information below with Nao as it is critical - especially for view='none' electrodes
    % number of electrodes per (vertical) line for each grid/strip
    el_perline_temporal=[8];
    el_perline_ventral=[8 4];
    el_perline_none=[4 4 4];
    el_perline_ignore=[999];
    
    % number of electrodes per (horizontal) row for each grid/strip
    el_perrow_temporal=[8];
    el_perrow_ventral=[4 1];
    el_perrow_none=[1 1 1];
    el_perrow_ignore=[999];
        
    % flags - 1 if the corresponding set of electrodes need label renaming
    flag_separate_temporal=[0];
    flag_separate_ventral=[1 0];
    flag_separate_none=[0 0 0];
    flag_separate_ignore=[0];
    
%     new_labels_temporal{1}={'R_temp_grid'};
% 
%     grid_size_temporal{1} = el_perline_temporal(1)*el_perrow_temporal(1);
        
    new_labels_ventral{1}={'R_post_subTemp_grid','R_ant_subTemp_grid'};
%     new_labels_ventral{2}={'L_ant_subTemp_strip'};
                            
    grid_size_ventral{1}=[16 16];
%     grid_size_ventral{2}=[el_perline_ventral(2)*el_perrow_ventral(2)];
%     new_labels_temporal{1}={'R_ant_Temp_grid','R_post_subTemp_grid'};

% New label R_subTemp_grid starting at index 1 el number 32
% New label R_temp_grid starting at index 33 el number 64
% New label L_ant_subTemp_stip starting at index 97 el number 4
% New label L_Amyg starting at index 101 el number 4
% New label R_Amyg starting at index 105 el number 4
% New label R_Heschl starting at index 109 el number 4
% New label Not_Connecte starting at index 113 el number 48    
end
%%
if strcmp(SUB.cntID,'156_DF_BM_Loc')
        % grids/strips for each view
        labels_temporal={'R_temp_grid'};
        labels_ventral={'L_temp_pole','L_ant_subTemp_strip','L_mid_subTemp_strip','R_ant_subTemp_strip','R_post_subTemp_strip','L_post_subTemp_grid','L_middle_subTemp_grid'};
        labels_none={'L_Amyg','L_Heschl','R_Amyg'};
        labels_ignore={'Not_Connected'};
        
        % Double-check the information below with Nao as it is critical - especially for view='none' electrodes
        % number of electrodes per (vertical) line for each grid/strip
        el_perline_temporal=[8];
        el_perline_ventral=[4 4 4 4 4 8 8];
        el_perline_none=[4 4 4];
        el_perline_ignore=[999];
        
        % number of electrodes per (horizontal) row for each grid/strip
        el_perrow_temporal=[8];
        el_perrow_ventral=[1 1 1 1 1 2 2];
        el_perrow_none=[1 1 1];
        el_perrow_ignore=[999];
        
        
        % flags - 1 if the corresponding set of electrodes need label renaming
        flag_separate_temporal=[0];
        flag_separate_ventral=[0 0 0 0 0 0 0];
        flag_separate_none=[0 0 0];
        flag_separate_ignore=[0];

    
% New label L_temp_pole_ starting at index 1 el number 4
% New label L_ant_subTemp_strip_ starting at index 5 el number 4
% New label L_mid_subTemp_strip_ starting at index 9 el number 4
% New label L_Amyg_ starting at index 13 el number 4
% New label L_Heschl_ starting at index 17 el number 4
% New label R_ant_subTemp_strip_ starting at index 21 el number 4
% New label R_post_subTemp_strip_ starting at index 25 el number 4
% New label R_Amyg_ starting at index 29 el number 4
% New label R_temp_grid_ starting at index 33 el number 64
% New label L_post_subTemp_grid_ starting at index 97 el number 16
% New label L_middle_subTemp_grid_ starting at index 113 el number 16

end
%%
if strcmp(SUB.cntID,'156_CFS')
    
    % grids/strips for each view
    labels_temporal={'R_temp_grid'};
    labels_ventral={'L_post_subTemp_grid','L_middle_subTemp_grid','L_temp_pole','L_ant_subTemp_strip','L_mid_subTemp_strip','R_ant_subTemp_strip','R_post_subTemp_strip'};
    labels_none={'L_Amyg','L_Heschl','R_Amyg'};
    labels_ignore={'Not_Connected'};
    
    % Double-check the information below with Nao as it is critical - especially for view='none' electrodes
    % number of electrodes per (vertical) line for each grid/strip
    el_perline_temporal=[8];
    el_perline_ventral=[8 8 4 4 4 4 4];
    el_perline_none=[4 4 4];
    el_perline_ignore=[999];
    
    % number of electrodes per (horizontal) row for each grid/strip
    el_perrow_temporal=[8];
    el_perrow_ventral=[2 2 1 1 1 1 1];
    el_perrow_none=[1 1 1];
    el_perrow_ignore=[999];
    
    
    % flags - 1 if the corresponding set of electrodes need label renaming
    flag_separate_temporal=[0];
    flag_separate_ventral=[0 0 0 0 0 0 0];
    flag_separate_none=[0 0 0];
    flag_separate_ignore=[0];
    
% New label L_post_subTemp_grid starting at index 1 el number 16
% New label L_middle_subTemp_grid starting at index 17 el number 16
% New label R_temp_grid starting at index 33 el number 64
% New label L_temp_pole starting at index 97 el number 4
% New label L_ant_subTemp_strip starting at index 101 el number 4
% New label L_mid_subTemp_strip starting at index 105 el number 4
% New label L_Amyg starting at index 109 el number 4
% New label L_Heschl starting at index 113 el number 4
% New label R_ant_subTemp_strip starting at index 117 el number 4
% New label R_post_subTemp_strip starting at index 121 el number 4
% New label R_Amyg starting at index 125 el number 4    
end


if strcmp(SUB.cntID,'162')
    
    % grids/strips for each view
    labels_temporal={'L_temp_grid','L_frontal_grid'};
    labels_ventral={'L_temp_pole','L_ant_subTemp_strip','L_mid_subTemp_strip','R_ant_subTemp_strip','R_post_subTemp_strip'};
    labels_none={'L_Amyg','L_Heschl','R_Amyg'};
    labels_ignore={'Not_Connected'};
    
    % Double-check the information below with Nao as it is critical - especially for view='none' electrodes
    % number of electrodes per (vertical) line for each grid/strip
    el_perline_temporal=[8 8];
    el_perline_ventral=[4 4 4 4 4];
    el_perline_none=[4 4 4];
    el_perline_ignore=[999];
    
    % number of electrodes per (horizontal) row for each grid/strip
    el_perrow_temporal=[12 4];
    el_perrow_ventral=[1 1 1 1 1];
    el_perrow_none=[1 1 1];
    el_perrow_ignore=[999];
    
    
    % flags - 1 if the corresponding set of electrodes need label renaming
    flag_separate_temporal=[0 0];
    flag_separate_ventral=[0 0 0 0 0];
    flag_separate_none=[0 0 0];
    flag_separate_ignore=[0];
    

% New label L_temp_grid_ starting at index 1 el number 96
% New label L_frontal_grid_ starting at index 97 el number 32
% New label Not_Connected_ starting at index 129 el number 32
% New label L_temp_pole_ starting at index 161 el number 4
% New label L_ant_subTemp_strip_ starting at index 165 el number 4
% New label L_mid_subTemp_strip_ starting at index 169 el number 4
% New label L_Amyg_ starting at index 173 el number 4
% New label L_Heschl_ starting at index 177 el number 4
% New label R_ant_subTemp_ starting at index 181 el number 4
% New label R_post_subTemp_ starting at index 185 el number 4
% New label R_Amyg_ starting at index 189 el number 4
end
%%
if strcmp(SUB.cntID,'168')
    
    % grids/strips for each view
    labels_temporal={'L_temp_grid','L_frontal_grid'};
    labels_ventral={'L_post_subTemp','L_temp_pole','L_ant_subTemp_strip','R_ant_subTemp','R_ant_mid_subTemp'};
    labels_none={'L_Amyg','L_Heschl','R_Amyg'};
    labels_ignore={'Not_Connected'};
    
    % Double-check the information below with Nao as it is critical - especially for view='none' electrodes
    % number of electrodes per (vertical) line for each grid/strip
    el_perline_temporal=[8 4];
    el_perline_ventral=[8 4 4 4 4];
    el_perline_none=[4 4 4];
    el_perline_ignore=[999];
    
    % number of electrodes per (horizontal) row for each grid/strip
    el_perrow_temporal=[12 8];
    el_perrow_ventral=[4 1 1 1 1];
    el_perrow_none=[1 1 1];
    el_perrow_ignore=[999];
    
    
    % flags - 1 if the corresponding set of electrodes need label renaming
    flag_separate_temporal=[0 0];
    flag_separate_ventral=[1 0 0 0 0];
    flag_separate_none=[0 0 0];
    flag_separate_ignore=[0];
    
    new_labels_ventral{1}={'L_ant_post_subTemp','L_post_post_subTemp'};
    
    grid_size_ventral{1}=[16 16];
    
% New label L_temp_grid starting at index 1 el number 96
% New label L_frontal_grid starting at index 97 el number 32
% New label L_post_subTemp starting at index 129 el number 32
% New label L_temp_pole starting at index 161 el number 4
% New label L_ant_subTemp_strip starting at index 165 el number 4
% New label L_Amyg starting at index 169 el number 4
% New label L_Heschl starting at index 173 el number 4
% New label R_ant_subTemp starting at index 177 el number 4
% New label R_ant_mid_subTemp starting at index 181 el number 4
% New label R_Amyg starting at index 185 el number 4    
end
%%
if strcmp(SUB.cntID,'173')
    
% New label L_temp_grid_ starting at index 1 el number 10
% New label Not_Connected_ starting at index 11 el number 118
% New label L_frontal_grid_ starting at index 129 el number 32
% New label L_subTemp_grid_ starting at index 161 el number 32
% New label L_temp_pole_ starting at index 193 el number 32
% New label L_Heschl_ starting at index 225 el number 4
% New label L_Amyg_ starting at index 229 el number 4
% New label R_Amyg_ starting at index 233 el number 4
% New label L_ant_subTemp_ starting at index 237 el number 4
% New label R_subTemp_med_ starting at index 241 el number 16
 
end
%%
if strcmp(SUB.cntID,'178')
    
    % grids/strips for each view
    labels_temporal={'L_temp_grid','L_frontal_grid'};
    labels_ventral={'L_temp_pole','L_post_subTemp','L_ant_subFrontal_strip','L_post_subFrontal_strip'};
    labels_none={'L_Heschl','L_Amyg','L_Hipp','L_Heschl_High'};
    labels_ignore={'Not_Connected'};
    
    % Double-check the information below with Nao as it is critical - especially for view='none' electrodes
    % number of electrodes per (vertical) line for each grid/strip
    el_perline_temporal=[8 8];
    el_perline_ventral=[8 8 4 4];
    el_perline_none=[4 4 4 4];
    el_perline_ignore=[999];
    
    % number of electrodes per (horizontal) row for each grid/strip
    el_perrow_temporal=[12 4];
    el_perrow_ventral=[4 4 1 1];
    el_perrow_none=[1 1 1 1];
    el_perrow_ignore=[999];
    
    
    % flags - 1 if the corresponding set of electrodes need label renaming
    flag_separate_temporal=[0 0];
    flag_separate_ventral=[1 1 0 0];
    flag_separate_none=[0 0 0 0];
    flag_separate_ignore=[0];
    
    
    % new labels - a different one for each grid/strip
%     new_labels_temporal{1}={'L_temp_grid'};
%     new_labels_temporal{2}={'L_frontal_grid'};
    
    new_labels_ventral{1}={'L_ant_temp_pole','L_post_temp_pole'};
    new_labels_ventral{2}={'L_ant_post_subTemp','L_post_post_subTemp'};
%     new_labels_ventral{3}={'L_ant_subFrontal_strip'};
%     new_labels_ventral{4}={'L_post_subFrontal_strip'};
    
%     new_labels_none{1}={'L_Heschl'};
%     new_labels_none{2}={'L_Amyg'};
%     new_labels_none{3}={'L_Hipp'};
%     new_labels_none{4}={'L_Heschl_High'};
%     
%     new_labels_ignore{1}={'Not_Connected'};
    
    
%     grid_size_temporal{1}=el_perline_temporal(1)*el_perrow_temporal(1);
%     grid_size_temporal{2}=el_perline_temporal(2)*el_perrow_temporal(2);
    grid_size_ventral{1}=[16 16];
    grid_size_ventral{2}=[16 16];
%     grid_size_ventral{3}=el_perline_ventral(3)*el_perrow_ventral(3);
%     grid_size_ventral{4}=el_perline_ventral(4)*el_perrow_ventral(4);
%     grid_size_none{1}=el_perline_none(1)*el_perrow_none(1);
%     grid_size_ignore{1}=el_perline_ignore(1)*el_perrow_ignore(1);
    
% New label L_temp_grid starting at index 1 el number 96
% New label L_frontal_grid starting at index 97 el number 32
% New label L_temp_pole starting at index 129 el number 32
% New label L_post_subTemp starting at index 161 el number 32
% New label L_ant_subFrontal_strip starting at index 193 el number 4
% New label L_post_subFrontal_strip starting at index 197 el number 4
% New label L_Heschl starting at index 201 el number 4
% New label L_Amyg starting at index 205 el number 4
% New label L_Hipp starting at index 209 el number 4
% New label Not_Connected starting at index 213 el number 12
% New label L_Heschl_High starting at index 225 el number 32  
end
%% 180

if strcmp(SUB.cntID,'180')
    
    % grids/strips for each view
    labels_temporal={'R_temp_grid','R_frontal_grid'};
%     labels_ventral={'L_temp_pole','L_post_subTemp','L_ant_subFrontal_strip','L_post_subFrontal_strip'};
    labels_ventral={'R_post_subTemp_strip','R_post_subTemp_middle_strip','R_ant_subTemp_strip','R_temp_pole_strip','R_ant_subFrontal_strip','R_post_subFrontal_strip','R_paraHippocampus_strip'};
    labels_none={'R_Heschl','R_Amyg','R_post_Hippocampus_depth'};
    labels_ignore={'Not_Connected'};
    
    % Double-check the information below with Nao as it is critical - especially for view='none' electrodes
    % number of electrodes per (vertical) line for each grid/strip
    el_perline_temporal=[8 8];
    el_perline_ventral=[8 8 8 8 4 4 10]; 
    el_perline_none=[4 4 6];
    el_perline_ignore=[999];
    
    % number of electrodes per (horizontal) row for each grid/strip
    el_perrow_temporal=[12 4];
    el_perrow_ventral=[2 2 2 2 1 1 1];
    el_perrow_none=[1 1 1 ];
    el_perrow_ignore=[999];
    
    
    % flags - 1 if the corresponding set of electrodes need label renaming
    flag_separate_temporal=[0 0];
    flag_separate_ventral=[0 0 0 0 0 0 0];
    flag_separate_none=[0 0 0 0 0];
    flag_separate_ignore=[0];
    
    %     
% New label R_temp_grid_ starting at index 1 el number 96
% New label R_frontal_grid_ starting at index 97 el number 32
% New label R_post_subTemp_strip_ starting at index 129 el number 16
% New label R_post_subTemp_middle_strip_ starting at index 145 el number 16
% New label R_ant_subTemp_strip_ starting at index 161 el number 16
% New label R_temp_pole_strip_ starting at index 177 el number 16
% New label R_ant_subFrontal_strip_ starting at index 193 el number 4
% New label R_post_subFrontal_strip_ starting at index 197 el number 4
% New label R_Heschl_ starting at index 201 el number 4
% New label R_Amyg_ starting at index 205 el number 4
% New label R_paraHippocampus_strip_ starting at index 209 el number 10
% New label R_post_Hippocampus_depth_ starting at index 219 el number 6
end

%% 181
if 0
if strcmp(SUB.cntID,'181')
    
    % grids/strips for each view
    labels_temporal={'L_temp_grid','L_frontal_grid'};
    labels_ventral={'L_temp_pole','L_post_subTemp','L_ant_subFrontal_strip','L_post_subFrontal_strip'};
    labels_none={'L_Heschl','L_Amyg','L_Hipp','L_Heschl_High'};
    labels_ignore={'Not_Connected'};
    
    % Double-check the information below with Nao as it is critical - especially for view='none' electrodes
    % number of electrodes per (vertical) line for each grid/strip
    el_perline_temporal=[8 8];
    el_perline_ventral=[8 8 4 4];
    el_perline_none=[4 4 4 4];
    el_perline_ignore=[999];
    
    % number of electrodes per (horizontal) row for each grid/strip
    el_perrow_temporal=[12 4];
    el_perrow_ventral=[4 4 1 1];
    el_perrow_none=[1 1 1 1];
    el_perrow_ignore=[999];
    
    
    % flags - 1 if the corresponding set of electrodes need label renaming
    flag_separate_temporal=[0 0];
    flag_separate_ventral=[1 1 0 0];
    flag_separate_none=[0 0 0 0];
    flag_separate_ignore=[0];
    
    
    % new labels - a different one for each grid/strip
    new_labels_temporal{1}={'L_temp_grid'};
    new_labels_temporal{2}={'L_frontal_grid'};
    
    new_labels_ventral{1}={'L_ant_temp_pole','L_post_temp_pole'};
    new_labels_ventral{2}={'L_ant_post_subTemp','L_post_post_subTemp'};
    new_labels_ventral{3}={'L_ant_subFrontal_strip'};
    new_labels_ventral{4}={'L_post_subFrontal_strip'};
    
    new_labels_none{1}={'L_Heschl'};
    new_labels_none{2}={'L_Amyg'};
    new_labels_none{3}={'L_Hipp'};
    new_labels_none{4}={'L_Heschl_High'};
    
    new_labels_ignore{1}={'Not_Connected'};
    
    
    grid_size_temporal{1}=el_perline_temporal(1)*el_perrow_temporal(1);
    grid_size_temporal{2}=el_perline_temporal(2)*el_perrow_temporal(2);
    grid_size_ventral{1}=[16 16];
    grid_size_ventral{2}=[16 16];
    grid_size_ventral{3}=el_perline_ventral(3)*el_perrow_ventral(3);
    grid_size_ventral{4}=el_perline_ventral(4)*el_perrow_ventral(4);
    grid_size_none{1}=el_perline_none(1)*el_perrow_none(1);
    grid_size_ignore{1}=el_perline_ignore(1)*el_perrow_ignore(1);
    
%     New label L_temp_grid_ starting at index 1 el number 64
% New label subCutaneous_strip_ starting at index 65 el number 6

end
end
%% 186
% R_post_subTemp_grid_, L_temp_pole_grid_, R_subTemp_middle_strip_ not on
% map
if strcmp(SUB.cntID,'186')
    
% New label R_temp_grid_ starting at index 1 el number 96
% New label R_inf_frontal_grid_ starting at index 97 el number 32
% New label R_post_subTemp_grid_ starting at index 129 el number 32
% New label R_ant_subFrontal_strip_ starting at index 161 el number 4
% New label R_post_subFrontal_strip_ starting at index 165 el number 4
% New label R_ant_medFrontal_depth_ starting at index 169 el number 4
% New label R_Heschl_ starting at index 173 el number 4
% New label R_Amyg_depth_ starting at index 177 el number 4
% New label R_temp_pole_strip starting at index 181 el number 4
% New label R_ant_subTemp_strip_ starting at index 185 el number 4
% New label L_Amyg_ starting at index 189 el number 4
% New label R_sup_frontal_strip_ starting at index 193 el number 16
% New label R_paraHippocampus_strip starting at index 209 el number 10
% New label R_post_med_frontal_depth_ starting at index 219 el number 6
% New label L_temp_pole_grid_ starting at index 225 el number 12
% New label R_subTemp_middle_strip_ starting at index 237 el number 4
% New label Not_Connected_ starting at index 241 el number 11
% New label R_Heschl_micro_ starting at index 252 el number 16
% New label L_Amyg_micro_ starting at index 268 el number 16
% New label subCutaneous_strip_ starting at index 284 el number 6


    % grids/strips for each view
    labels_temporal={'R_temp_grid'};
    labels_frontal = {'R_sup_frontal_strip','R_inf_frontal_grid'};
    
    labels_ventral={'R_ant_subFrontal_strip','R_post_subFrontal_strip','R_temp_pole_strip','R_ant_subTemp_strip','R_paraHippocampus_strip','R_subTemp_middle_strip'};
    labels_none={'R_ant_medFrontal_depth','R_Heschl','R_Amyg_depth','L_Amyg','R_post_med_frontal_depth','L_ant_temp_pole_grid','R_Heschl_micro','L_Amyg_micro','subCutaneous_strip','L_pos_temp_pole_grid'};
    labels_ignore={'Not_Connected'};
    
    % Double-check the information below with Nao as it is critical - especially for view='none' electrodes
    % number of electrodes per (vertical) line for each grid/strip
    el_perline_temporal     =[8];
    el_perline_frontal      =[8 8];
    el_perline_ventral      =[4 4 4 4 10 4];
    el_perline_none         =[4 4 4 4 6 6 16 16 6 3];
    el_perline_ignore       =[999];
    
    % number of electrodes per (horizontal) row for each grid/strip
    el_perrow_temporal      =[12];
    el_perrow_frontal       =[2 4];
    el_perrow_ventral       =[1 1 1 1 1 2 1];
    el_perrow_none          =[1 1 1 1 1 2 1 1 1 4];
    el_perrow_ignore        =[999];
    
    
    % flags - 1 if the corresponding set of electrodes need label renaming
    flag_separate_temporal=[0 0];
    flag_separate_frontal=[0];
    
    flag_separate_ventral=[0 0 0 0 0 0];
    flag_separate_none=[0 0 0 0 0 0 0 0 0 0];
    flag_separate_ignore=[0];
    
     
  
% New label R_temp_grid_ starting at index 1 el number 96
% New label R_inf_frontal_grid_ starting at index 97 el number 32
% ################### still needs to be implemented ##############################
% New label R_post_subTemp_grid_ starting at index 129 el number 32
% ################### still needs to be implemented ##############################
% New label R_ant_subFrontal_strip_ starting at index 161 el number 4
% New label R_post_subFrontal_strip_ starting at index 165 el number 4
% New label R_ant_medFrontal_depth_ starting at index 169 el number 4
% New label R_Heschl_ starting at index 173 el number 4
% New label R_Amyg_depth_ starting at index 177 el number 4
% New label R_temp_pole_strip_ starting at index 181 el number 4
% New label R_ant_subTemp_strip_ starting at index 185 el number 4
% New label L_Amyg_ starting at index 189 el number 4
% New label R_sup_frontal_strip_ starting at index 193 el number 16
% New label R_paraHippocampus_strip_ starting at index 209 el number 10
% New label R_post_med_frontal_depth_ starting at index 219 el number 6
% ################### still needs to be implemented ##############################
% New label L_ant_temp_pole_grid_ starting at index 225 el number 12
% ################### still needs to be implemented ##############################
% New label R_subTemp_middle_strip_ starting at index 237 el number 4
% New label Not_Connected_ starting at index 241 el number 1
% ################### still needs to be implemented ##############################
% New label L_pos_temp_pole_grid_ starting at index 242 el number 10
% ################### still needs to be implemented ##############################
end


if strcmp(SUB.cntID,'232')

labels_temporal={'R_par_grid','R_dors_frontal_grid','R_dors_par_grid','R_med_lat_frontal_grid','R_lat_frontal_grid'};
labels_ventral={'R_frontal_interhemispheric_strip','R_par_interhemispheric_strip'};
labels_none={'R_post_med_frontal_depth','R_ant_med_par_depth','R_pseparateStripsInfoos_med_par_strip','R_ant_medFrontal_depth','subCutaneous_strip'};
labels_ignore={'Not_Connected'};



% Double-check the information below with Nao as it is critical - especially for view='none' electrodes
% number of electrodes per (vertical) line for each grid/strip
el_perline_temporal     =[8 8 8 5 5];
el_perline_ventral      =[8 8];
el_perline_none         =[4 8 6 8 6];
el_perline_ignore       =[999];

% number of electrodes per (horizontal) row for each grid/strip
el_perrow_temporal      =[4 2 2 2 2];
el_perrow_ventral       =[1 1];
el_perrow_none          =[1 1 1 1 1];
el_perrow_ignore        =[999];


% flags - 1 if the corresponding set of electrodes need label renaming
flag_separate_temporal=[0 0 0 0 0];
flag_separate_ventral=[0 0];
flag_separate_none=[0 0 0 0 0];
flag_separate_ignore=[0];




% New label R_par_grid_ starting at index 1 el number 32
% New label R_dors_frontal_grid_ starting at index 33 el number 16
% New label R_dors_par_grid_ starting at index 49 el number 16
% New label R_post_med_frontal_depth_ starting at index 65 el number 4
% New label Not_Connected_ starting at index 69 el number 4
% New label R_ant_med_par_depth_ starting at index 73 el number 8
% New label R_med_lat_frontal_grid_ starting at index 81 el number 10
% New label R_pos_med_par_strip_ starting at index 91 el number 6
% New label R_ant_medFrontal_depth_ starting at index 97 el number 32
% New label R_frontal_interhemispheric_strip_ starting at index 129 el number 8
% New label R_par_interhemispheric_strip_ starting at index 137 el number 8
% New label R_lat_frontal_grid_ starting at index 145 el number 32
% New label subCutaneous_strip starting at index 177 el number 6
% 
end

if strcmp(SUB.cntID,'242')

    
%     labels_temporal={'L_inf_temp_occ_grid','L_ant_mid_temp_grid','L_pos_mid_temp_grid','L_sup_temp_occ_grid','L_ant_temp_ant_temp_pole','L_pos_temp_ant_temp_pole'};
    labels_temporal={'L_inf_temp_occ_grid','L_ant_mid_temp_grid','L_pos_mid_temp_grid','L_sup_temp_occ_grid'};
%     labels_ventral={'L_subTemp_grid','L_paraHippocampus_strip','R_subTemp_strip','L_ant_vent_ant_temp_pole','L_pos_vent_ant_temp_pole','L_pos_temp_pole','R_paraHippocampus_strip'};
    labels_ventral={'L_subTemp_grid','L_paraHippocampus_strip','R_subTemp_strip','L_pos_temp_pole','R_paraHippocampus_strip'};
%     labels_none={'L_Heschl','R_Amyg','L_post_Hippocampus_depth','L_Amyg','L_temp_lesion_depth','subCutaneous_strip'};
    labels_none={'L_Heschl','R_Amyg','L_post_Hippocampus_depth','L_Amyg','L_temp_lesion_depth','L_ant_vent_ant_temp_pole','L_pos_vent_ant_temp_pole','subCutaneous_strip'};
    labels_ignore={'Not_Connected'};



% Double-check the information below with Nao as it is critical - especially for view='none' electrodes
% number of electrodes per (vertical) line for each grid/strip
el_perline_temporal     =[8 2 2 8];
el_perline_ventral      =[8 10 4 4 3 3 10];
el_perline_none         =[4 4 4 4 4 6 5 6];
el_perline_ignore       =[999];

% number of electrodes per (horizontal) row for each grid/strip
el_perrow_temporal      =[4 5 5 2];
el_perrow_ventral       =[4 1 1 1 1 4 1];
el_perrow_none          =[1 1 1 1 1 1 1 1];
el_perrow_ignore        =[999];


% flags - 1 if the corresponding set of electrodes need label renaming
flag_separate_temporal=[0 0 0 0 0 0];
flag_separate_ventral=[1 0 0 0 0 0 0];
flag_separate_none=[0 0 0 0 0 0];
flag_separate_ignore=[0];


% new labels - a different one for each grid/strip
new_labels_temporal{1}={'L_inf_temp_occ_grid'};
new_labels_temporal{2}={'L_ant_mid_temp_grid'};
new_labels_temporal{3}={'L_pos_mid_temp_grid'};
new_labels_temporal{4}={'L_sup_temp_occ_grid'};
% new_labels_temporal{5}={'L_ant_temp_ant_temp_pole'};
% new_labels_temporal{6}={'L_pos_temp_ant_temp_pole'};

new_labels_ventral{1}={'L_ant_subTemp_grid','L_post_subTemp_grid'};
new_labels_ventral{2}={'L_paraHippocampus_strip'};
new_labels_ventral{3}={'R_subTemp_strip'};
% new_labels_ventral{4}={'L_ant_vent_ant_temp_pole'};
% new_labels_ventral{5}={'L_pos_vent_ant_temp_pole'};
new_labels_ventral{4}={'L_pos_temp_pole'};
new_labels_ventral{5}={'R_paraHippocampus_strip'};

new_labels_none{1}={'L_paraHippocampus_strip'};
new_labels_none{1}={'L_Heschl'};
new_labels_none{2}={'R_Amyg'};
new_labels_none{3}={'L_post_Hippocampus_depth'};
new_labels_none{4}={'L_Amyg'};
new_labels_none{5}={'L_temp_lesion_depth'};
new_labels_none{6}={'L_ant_vent_ant_temp_pole'};
new_labels_none{7}={'L_pos_vent_ant_temp_pole'};
new_labels_none{8}={'subCutaneous_strip'};

new_labels_ignore{1}={'Not_Connected'};

% for i = length(el_perline_temporal)
% grid_size_temporal{i}=el_perline_temporal(i)*el_perrow_temporal(i);
% end

grid_size_ventral{1}=[16 16];
% grid_size_ventral{2}=el_perline_ventral(2)*el_perrow_ventral(2);
% grid_size_ventral{3}=el_perline_ventral(3)*el_perrow_ventral(3);
% grid_size_ventral{4}=el_perline_ventral(4)*el_perrow_ventral(4);
% grid_size_ventral{5}=el_perline_ventral(5)*el_perrow_ventral(5);
% grid_size_ventral{6}=el_perline_ventral(6)*el_perrow_ventral(6);
% grid_size_ventral{7}=el_perline_ventral(7)*el_perrow_ventral(7);
% 
% grid_size_none{1}=el_perline_none(1)*el_perrow_none(1);
% grid_size_none{2}=el_perline_none(2)*el_perrow_none(2);
% grid_size_none{3}=el_perline_none(3)*el_perrow_none(3);
% grid_size_none{4}=el_perline_none(4)*el_perrow_none(4);
% grid_size_none{5}=el_perline_none(5)*el_perrow_none(5);
% grid_size_none{6}=el_perline_none(6)*el_perrow_none(6);
% 
% grid_size_ignore{1}=el_perline_ignore(1)*el_perrow_ignore(1);
% 

% 
% New label L_inf_temp_occ_grid_ starting at index 1 el number 32
% New label L_subTemp_grid_ starting at index 33 el number 32
% New label L_ant_mid_temp_grid_ starting at index 65 el number 10
% New label Not_Connected_ starting at index 75 el number 6
% New label L_pos_mid_temp_grid_ starting at index 81 el number 48
% New label L_sup_temp_occ_grid_ starting at index 129 el number 16
% New label L_paraHippocampus_strip_ starting at index 145 el number 16
% New label L_Heschl_ starting at index 161 el number 4
% New label R_subTemp_strip_ starting at index 165 el number 4
% New label R_Amyg_ starting at index 169 el number 4
% New label L_post_Hippocampus_depth_ starting at index 173 el number 20
% New label L_Amyg_ starting at index 193 el number 8
% New label L_temp_lesion_depth_ starting at index 201 el number 8
% New label L_ant_ant_temp_pole_ starting at index 209 el number 6
% New label L_pos_ant_temp_pole_ starting at index 215 el number 10
% New label L_pos_temp_pole_ starting at index 225 el number 16
% New label R_paraHippocampus_strip_ starting at index 241 el number 16
end
