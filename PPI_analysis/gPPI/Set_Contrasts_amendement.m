% SCript for adding contrasts to the PPPI SPM.MAT file AM 8/22/2023

% Addpath
addpath('/gpfs51/dors2/gpc/JamesBooth/JBooth-Lab/BDL/AM/ELP/Scripts_AM/spm12_elp');
addpath('/gpfs51/dors2/gpc/JamesBooth/JBooth-Lab/BDL/AM/ELP/Scripts_AM/PPI_analysis/gPPI')
datapath = '/gpfs51/dors2/gpc/JamesBooth/JBooth-Lab/BDL/AM/ELP/Conn_PhonSem_AM_7_9/preprocessed';
% Subject
subjects={};
data_info='/gpfs51/dors2/gpc/JamesBooth/JBooth-Lab/BDL/AM/ELP/Conn_PhonSem_AM_7_9/preprocessed/Subject_selection.xlsx';
if isempty(subjects)
    M=readtable(data_info);
    subjects=M.Subjects;
end
%%
% PPI folder name
PPI_folder = 'PPI_VOI_l_pSTG_gPPI'; % Two folders change
spm_jobman('initcfg');

% Start for loop
for num=1:length(subjects)

% Open SPM.mat file
PPI_SPM_path = [datapath '/' subjects{num} '/' 'ses7_analysis/deweight' '/' PPI_folder '/' 'SPM.mat'];
load(PPI_SPM_path)
% Set up the contrast of interest
weights = {[zeros(1,4) -2 1 1 zeros(1,12) -2 1 1 zeros(1,42)]};
contrasts={'PPI_onsetrhyme_vs_perceptual'}; % change as per folder

% Estimate
contrast(PPI_SPM_path,contrasts,weights);

end
%%
% PPI folder name
PPI_folder = 'PPI_VOI_l_pMTG_gPPI'; % Two folders change
spm_jobman('initcfg');

% Start for loop
for num=1:length(subjects)

% Open SPM.mat file
PPI_SPM_path = [datapath '/' subjects{num} '/' 'ses7_analysis/deweight' '/' PPI_folder '/' 'SPM.mat'];
load(PPI_SPM_path)
% Set up the contrast of interest
weights = {[zeros(1,30) -2 1 1 zeros(1,12) -2 1 1 zeros(1,16)]};
contrasts={'PPI_lowhigh_vs_perceptual'}; % change as per folder

% Estimate
contrast(PPI_SPM_path,contrasts,weights);

end