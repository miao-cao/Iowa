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
    
    % New label L_temp_grid starting at index 1 el number 96
    % New label L_temp_pole starting at index 97 el number 4
    % New label L_ant_subTemp starting at index 101 el number 4
    % New label L_mid_subTemp starting at index 105 el number 4
    % New label L_post_subTemp_strip starting at index 109 el number 4
    % New label L_Amyg starting at index 113 el number 4
    % New label R_mid_subTemp starting at index 117 el number 4
    % New label Not_Connected starting at index 121 el number 8
    
end

 
if strcmp(SUB.cntID,'147_BM')
    % grids/strips for each view
    labels_temporal={'L_temp_grid','L_frontal_grid'};
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
    
    % New label L_temp_grid starting at index 1 el number 96
    % New label L_temp_pole starting at index 97 el number 4
    % New label L_ant_subTemp starting at index 101 el number 4
    % New label L_mid_subTemp starting at index 105 el number 4
    % New label L_post_subTemp_strip starting at index 109 el number 4
    % New label L_Amyg starting at index 113 el number 4
    % New label R_mid_subTemp starting at index 117 el number 4
    % New label Not_Connected starting at index 121 el number 8
    
end

if strcmp(SUB.cntID,'149')
    
    % grids/strips for each view
    labels_temporal={'R_temp_grid'};
    % labels_ventral={'R_post_subTemp_grid','R_ant_subTemp_strip','R_mid_subTemp_strip','L_ant_subTemp_strip','L_mid_subTemp_strip','L_post_subTemp_strip'};
    labels_ventral={'R_post_post_subTemp_grid','R_ant_post_subTemp_grid','R_ant_subTemp_strip','R_mid_subTemp_strip','L_ant_subTemp_strip','L_mid_subTemp_strip','L_post_subTemp_strip'};
    labels_none={'R_Heschl','R_Amyg','L_Amyg'};
    labels_ignore={'Not_Connected'};
    
    % Double-check the information below with Nao as it is critical - especially for view='none' electrodes
    % number of electrodes per (vertical) line for each grid/strip
    el_perline_temporal=[8];
    % el_perline_ventral=[8 4 4 4 4 4];
    el_perline_ventral=[8 8 4 4 4 4 4];
    el_perline_none=[4 4 4];
    el_perline_ignore=[999];
    
    % number of electrodes per (horizontal) row for each grid/strip
    el_perrow_temporal=[8];
    % el_perrow_ventral=[4 1 1 1 1 1];
    el_perrow_ventral=[2 2 1 1 1 1 1];
    el_perrow_none=[1 1 1];
    el_perrow_ignore=[999];
    
    
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

if strcmp(SUB.cntID,'153')
    
    % grids/strips for each view
    labels_temporal={'R_temp_grid'};
    % labels_ventral={'R_post_subTemp_grid','R_temp_pole','R_ant_subTemp_strip','L_post_subTemp_strip','L_ant_subTemp_strip','L_lat_temp_pole'};
    labels_ventral={'R_post_post_subTemp_grid','R_ant_post_subTemp_grid','R_temp_pole','R_ant_subTemp_strip','L_post_subTemp_strip','L_ant_subTemp_strip','L_lat_temp_pole'};
    labels_none={'R_Amyg','R_Heschl','L_Amyg'};
    labels_ignore={'Not_Connected'};
    
    % Double-check the information below with Nao as it is critical - especially for view='none' electrodes
    % number of electrodes per (vertical) line for each grid/strip
    el_perline_temporal=[8];
    % el_perline_ventral=[8 4 4 4 4 4];
    el_perline_ventral=[8 8 4 4 4 4 4];
    el_perline_none=[4 4 4];
    el_perline_ignore=[999];
    
    % number of electrodes per (horizontal) row for each grid/strip
    el_perrow_temporal=[8];
    % el_perrow_ventral=[4 1 1 1 1 1];
    el_perrow_ventral=[2 2 1 1 1 1 1];
    el_perrow_none=[1 1 1];
    el_perrow_ignore=[999];
    
    
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

if strcmp(SUB.cntID, '154a_CFS_73_74')
    
    % grids/strips for each view
    labels_temporal={'R_temp_grid'};
    labels_ventral={'L_ant_subTemp_strip'};
    labels_none={'L_Amyg','R_Amyg','R_Heschl'};
    labels_ignore={'Not_Connected'};
    
    % Double-check the information below with Nao as it is critical - especially for view='none' electrodes
    % number of electrodes per (vertical) line for each grid/strip
    el_perline_temporal=[8];% 
    el_perline_ventral=[4];
    el_perline_none=[4 4 4];
    el_perline_ignore=[999];
    
    % number of electrodes per (horizontal) row for each grid/strip
    el_perrow_temporal=[12];
    el_perrow_ventral=[1];
    el_perrow_none=[1 1 1];
    el_perrow_ignore=[999];
         
% 
% New label R_temp_grid_ starting at index 1 el number 64
% New label R_subTemp_grid_ starting at index 65 el number 32
% New label L_ant_subTemp_strip_ starting at index 97 el number 4
% New label L_Amyg_ starting at index 101 el number 4
% New label R_Amyg_ starting at index 105 el number 4
% New label R_Heschl_ starting at index 109 el number 4
% New label Not_Connected starting at index 113 el number 16

    
end

if strcmp(SUB.cntID, '154b_DF_BM_CFS_137')
    
    % grids/strips for each view
    labels_temporal={'R_temp_grid'};
    labels_ventral={'R_post_subTemp_grid','R_ant_subTemp_grid','L_ant_subTemp_strip'};
    labels_none={'L_Amyg','R_Amyg','R_Heschl'};
    labels_ignore={'Not_Connected'};
    
    % Double-check the information below with Nao as it is critical - especially for view='none' electrodes
    % number of electrodes per (vertical) line for each grid/strip
    el_perline_temporal=[8];
    el_perline_ventral=[8 8 4];
    el_perline_none=[4 4 4];
    el_perline_ignore=[999];
    
    % number of electrodes per (horizontal) row for each grid/strip
    el_perrow_temporal=[8];
    el_perrow_ventral=[2 2 1];
    el_perrow_none=[1 1 1];
    el_perrow_ignore=[999];
        
% New label R_subTemp_grid starting at index 1 el number 32
% New label R_temp_grid starting at index 33 el number 64
% New label L_ant_subTemp_stip starting at index 97 el number 4
% New label L_Amyg starting at index 101 el number 4
% New label R_Amyg starting at index 105 el number 4
% New label R_Heschl starting at index 109 el number 4
% New label Not_Connecte starting at index 113 el number 48    
    
end

if strcmp(SUB.cntID, '154_combined')
    labels_temporal={'R_temp_grid'};
    labels_ventral={'R_ant_subTemp_grid','R_post_subTemp_grid','L_ant_subTemp_strip'};
    labels_none={'L_Amyg','R_Amyg','R_Heschl'};
    labels_ignore={'Not_Connected'};
    
end

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

if strcmp(SUB.cntID,'168')
    
    % grids/strips for each view
    labels_temporal={'L_temp_grid','L_frontal_grid'};
    % labels_ventral={'L_post_subTemp','L_temp_pole','L_ant_subTemp_strip','R_ant_subTemp','R_ant_mid_subTemp'};
    labels_ventral={'L_ant_post_subTemp','L_post_post_subTemp','L_temp_pole','L_ant_subTemp_strip','R_ant_subTemp','R_ant_mid_subTemp'};
    labels_none={'L_Amyg','L_Heschl','R_Amyg'};
    labels_ignore={'Not_Connected'};
    
    % Double-check the information below with Nao as it is critical - especially for view='none' electrodes
    % number of electrodes per (vertical) line for each grid/strip
    el_perline_temporal=[8 8];
    % el_perline_ventral=[8 4 4 4 4];
    el_perline_ventral=[8 8 4 4 4 4];
    el_perline_none=[4 4 4];
    el_perline_ignore=[999];
    
    % number of electrodes per (horizontal) row for each grid/strip
    el_perrow_temporal=[12 4];
    % el_perrow_ventral=[4 1 1 1 1];
    el_perrow_ventral=[2 2 1 1 1 1];
    el_perrow_none=[1 1 1];
    el_perrow_ignore=[999];
    
    
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

if strcmp(SUB.cntID,'178')
    % grids/strips for each view
    labels_temporal={'L_temp_grid','L_frontal_grid'};
    % labels_ventral={'L_temp_pole','L_post_subTemp','L_ant_subFrontal_strip','L_post_subFrontal_strip'};
    labels_ventral={'L_ant_temp_pole','L_post_temp_pole','L_ant_post_subTemp','L_post_post_subTemp','L_ant_subFrontal_strip','L_post_subFrontal_strip'};
    labels_none={'L_Heschl','L_Amyg','L_Hipp','L_Heschl_High'};
    labels_ignore={'Not_Connected'};
    
    % Double-check the information below with Nao as it is critical - especially for view='none' electrodes
    % number of electrodes per (vertical) line for each grid/strip
    el_perline_temporal=[8 8];
    % el_perline_ventral=[8 8 8 8];
    el_perline_ventral=[8 8 8 8 4 4];
    el_perline_none=[4 4 4 16];
    el_perline_ignore=[999];
    
    % number of electrodes per (horizontal) row for each grid/strip
    el_perrow_temporal=[12 4];
    % el_perrow_ventral=[2 2 2 2];
    el_perrow_ventral=[2 2 2 2 1 1];
    el_perrow_none=[1 1 1 1];
    el_perrow_ignore=[999];
    
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
    el_perrow_none=[1 1 1];
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

if strcmp(SUB.cntID,'186')

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

end

if strcmp(SUB.cntID,'222')
    
end

if strcmp(SUB.cntID,'232')

labels_temporal={'R_par_grid','R_dors_frontal_grid','R_dors_par_grid','R_med_lat_frontal_grid','R_lat_frontal_grid'};
labels_ventral={'R_frontal_interhemispheric_strip','R_par_interhemispheric_strip'};
labels_none={'R_post_med_frontal_depth','R_ant_med_par_depth','R_pos_med_par_strip','R_ant_medFrontal_depth','subCutaneous_strip'};
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

end

if strcmp(SUB.cntID,'242')

    
        labels_temporal={'L_inf_temp_occ_grid','L_ant_mid_temp_grid','L_pos_mid_temp_grid','L_sup_temp_occ_grid','L_ant_temp_ant_temp_pole','L_pos_temp_ant_temp_pole'};
    labels_ventral={'L_ant_subTemp_grid','L_post_subTemp_grid','L_paraHippocampus_strip','R_subTemp_strip','L_ant_vent_ant_temp_pole','L_pos_vent_ant_temp_pole','L_pos_temp_pole','R_paraHippocampus_strip'};
    labels_none={'L_Heschl','R_Amyg','L_post_Hippocampus_depth','L_Amyg','L_temp_lesion_depth','subCutaneous_strip'};
    labels_ignore={'Not_Connected'};



% Double-check the information below with Nao as it is critical - especially for view='none' electrodes
% number of electrodes per (vertical) line for each grid/strip
el_perline_temporal     =[8 5 5 8 2 2];
el_perline_ventral      =[8 8 10 4 4 3 3 10];
el_perline_none         =[4 4 4 4 4 6];
el_perline_ignore       =[999];

% number of electrodes per (horizontal) row for each grid/strip
el_perrow_temporal      =[4 2 2 2 1 1];
el_perrow_ventral       =[2 2 1 1 1 1 4 1];
el_perrow_none          =[1 1 1 1 1 1];
el_perrow_ignore        =[999];


% flags - 1 if the corresponding set of electrodes need label renaming
flag_separate_temporal=[0 0 0 0 0 0];
flag_separate_ventral=[0 0 0 0 0 0 0];
flag_separate_none=[0 0 0 0 0 0];
flag_separate_ignore=[0];


end