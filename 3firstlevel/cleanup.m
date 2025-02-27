%%
%this code is for clean up your firstlevel expanded 3d vs6_wtask*.nii
% files if you used my firstlevel analysis code before July 3rd, 2019

global CCN

test_subjects={};
run_script=0;
root='/gpfs51/dors2/gpc/JamesBooth/JBooth-Lab/BDL/jinwang/SemPhon_7_8/preprocessed/';
CCN.session='ses-7';
CCN.func_pattern='sub*';
CCN.files='wsub*bold.nii';
addpath(genpath('/gpfs51/dors2/gpc/JamesBooth/JBooth-Lab/BDL/jinwang/SemPhon_7_8/scripts'));

listing=dir(root);
all_list=extractfield(listing,'name');
index=strfind(all_list,'sub');
idx=find(not(cellfun('isempty',index)));
subjects_all=all_list(idx);
if run_script ==1
    subjects=test_subjects;
else
    subjects=subjects_all(~ismember(subjects_all,test_subjects));
end
for i=1:length(subjects)
    CCN.functional_f=[root subjects{i} '/[session]/func/[func_pattern]/[files]'];
    functional_files=expand_path(CCN.functional_f);
    for d=1:length(functional_files)
        delete(functional_files{d});
    end
end
