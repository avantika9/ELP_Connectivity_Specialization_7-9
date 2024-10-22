%% Delete bad T1s
% AM 6/30/2023
% PREEQUISITE EXCEL SHEET WITH SUBJECTLIST HAVING MULTIPLE T1s FOR EACH
% SESSION - Add Excel sheet

% Change the following
% addpath to script
addpath(genpath('/gpfs51/dors2/gpc/JamesBooth/JBooth-Lab/BDL/AM_ELP/typical_data_analysis/1copy_your_data'));

% Filepath  to subject list file - excel file
Subject_filepath = '/gpfs51/dors2/gpc/JamesBooth/JBooth-Lab/BDL/AM_ELP/Subjects.xlsx';
% Read Subject excel  sheet with multiple T1s for ses 7 or ses9
M=readtable(Subject_filepath, 'sheet', 'T1ses9_multiple'); % Change 

% Path to preprocessed folder where data exists
data_path='/gpfs51/dors2/gpc/JamesBooth/JBooth-Lab/BDL/AM_ELP/Conn_PhonSem_AM_7_9/preprocessed';
% Specify Sesssion
session='ses-9'; % This code can only run session by session. You cannot run multiple sessions all at once using this simple code.



%% Make a list of subjects with multiple T1s (nothing to change from here)
subjects =  unique(M.AllSubjects);

% Create a new table 'T' with GOOD T1s for each subject by selecting Max
% value of T1
T = cell2table(cell(0,3),'VariableNames',{'AllSubjects','RunId','score'});

for n = 1:numel(subjects)
x= M(strcmp(M.AllSubjects,subjects(n,1)),:);
[~,maxidx] = max(x.score);
temp_T = x(maxidx,:);
T = [T;temp_T];
end

good_t1=T.RunId; 
for i=1:length(subjects)
    t1s_path=[data_path '/' subjects{i} '/' session '/anat'];
    cd(t1s_path);
    t1s=dir(t1s_path);
    for j=3:length(t1s)
        thist1=t1s(j).name;
        thist1=thist1(1:end-4);
        if ~strcmp(thist1,good_t1{i})
           delete([thist1 '.nii']); % Delete bad T1s
        end
    end
end
