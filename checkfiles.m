global CCN;
addpath(genpath('/gpfs51/dors2/gpc/JamesBooth/JBooth-Lab/BDL/AM_ELP/typical_data_analysis/2preprocessing'));
root='/gpfs51/dors2/gpc/JamesBooth/JBooth-Lab/BDL/AM_ELP/Conn_PhonSem_AM_7_9';
subjects={};
data_info='/gpfs51/dors2/gpc/JamesBooth/JBooth-Lab/BDL/AM_ELP/Subjects.xlsx'; %In this excel, there should be a column of subjects with the header (subjects). The subjects should all be sub plus numbers (sub-5002).

if isempty(subjects)
    M=readtable(data_info);
   subjects=M.subjects;
end


CCN.preprocessed_folder='preprocessed'; %This is your data folder needs to be preprocessed
CCN.session='ses-9'; %This is the time point you want to analyze. If you have two time points, do the preprocessing one time point at a time by changing ses-T1 to ses-T2.
CCN.func_folder='sub*'; % This is your functional folder name
CCN.func_pattern='sub*.nii'; %This is your functional data name


%%
for i = 1:numel(subjects)
% Check if artreapit.txt file exits
 fprintf('work on subject %s\n', subjects{i});
        CCN.subj_folder=[root '/' CCN.preprocessed_folder '/' subjects{i}];
        out_path=[CCN.subj_folder '/' CCN.session];
        CCN.func_f='[subj_folder]/[session]/func/[func_folder]/';
        func_f=expand_path(CCN.func_f);
        func_file=[];
        for m=1:length(func_f)
            func_file{m}=expand_path([func_f{m} '[func_pattern]']);
        end
        
for x=1:length(func_file)
if exist(char(fullfile(func_f(1),'art_repaired.txt')), 'file') ~= 2
   msg ('file not found');
   error(msg)
end   
end
end