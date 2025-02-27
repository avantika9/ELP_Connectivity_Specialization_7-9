% SCript for adding contrasts to the PPPI SPM.MAT file AM 8/22/2023

% Addpath
addpath('/gpfs51/dors2/gpc/JamesBooth/JBooth-Lab/BDL/AM_ELP/Scripts_AM/spm12_elp');
addpath('/gpfs51/dors2/gpc/JamesBooth/JBooth-Lab/BDL/AM_ELP/Scripts_AM/PPI_analysis/gPPI')
datapath = '/gpfs51/dors2/gpc/JamesBooth/JBooth-Lab/BDL/AM_ELP/Conn_PhonSem_AM_7_9/preprocessed';
% Subject
subjects={};
data_info='/gpfs51/dors2/gpc/JamesBooth/JBooth-Lab/BDL/AM_ELP/Conn_PhonSem_AM_7_9/preprocessed/Subject_selection.xlsx';
if isempty(subjects)
    M=readtable(data_info);
    subjects=M.Subjects;
end
% PPI folder name
PPI_folder = 'PPI_VOI_l_IFGop_gPPI'; % Two folders change
spm_jobman('initcfg');

% Start for loop
for num=1:length(subjects)

% Open SPM.mat file
PPI_SPM_path = [datapath '/' subjects{num} '/' 'ses7_analysis/deweight' '/' PPI_folder '/' 'SPM.mat'];
load(PPI_SPM_path)
% Set up the contrast of interest
weights = {[zeros(1,4) -2 1 1 zeros(1,12) -2 1 1 zeros(1,42)]};
contrasts={'PPI_onsetrhyme_vs_perceptual'}; % hange as per folder

% Estimate
contrast(PPI_SPM_path,contrasts,weights);

end

%%
% PPI folder name
PPI_folder = 'PPI_VOI_l_IFGtri_gPPI'; % Two folders change
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

%% Notes : The following contrast names are obtained from the SPM File by
% typing the following SPM.xX.name and thereafter the contrast weights are
% set-up

% {'Sn(1) P_C*bf(1)'}    {'Sn(1) P_O*bf(1)'}    {'Sn(1) P_R*bf(1)'}    {'Sn(1) P_U*bf(1)'}    {'Sn(1) PPI_P_C'}    {'Sn(1) PPI_P_O'}    {'Sn(1) PPI_P_R'}    {'Sn(1) PPI_P_U'}    {'Sn(1) VOI_l_pST…'}
% {'Sn(1) m1'}    {'Sn(1) m2'}    {'Sn(1) m3'}    {'Sn(1) m4'}    {'Sn(1) m5'}    {'Sn(1) m6'}    {'Sn(2) P_C*bf(1)'}    {'Sn(2) P_O*bf(1)'}    {'Sn(2) P_R*bf(1)'}    {'Sn(2) P_U*bf(1)'}    {'Sn(2) PPI_P_C'}
% {'Sn(2) PPI_P_O'}    {'Sn(2) PPI_P_R'}    {'Sn(2) PPI_P_U'}    {'Sn(2) VOI_l_pST…'}    {'Sn(2) m1'}    {'Sn(2) m2'}    {'Sn(2) m3'}    {'Sn(2) m4'}    {'Sn(2) m5'}    {'Sn(2) m6'}                
% {'Sn(3) S_C*bf(1)'} {'Sn(3) S_H*bf(1)'}    {'Sn(3) S_L*bf(1)'}    {'Sn(3) S_U*bf(1)'}    {'Sn(3) PPI_S_C'}    {'Sn(3) PPI_S_H'}    {'Sn(3) PPI_S_L'}    {'Sn(3) PPI_S_U'}    {'Sn(3) VOI_l_pST…'}    {'Sn(3) m1'}    {'Sn(3) m2'}
% {'Sn(3) m3'}    {'Sn(3) m4'}    {'Sn(3) m5'}    {'Sn(3) m6'}    {'Sn(4) S_C*bf(1)'}    {'Sn(4) S_H*bf(1)'}    {'Sn(4) S_L*bf(1)'}    {'Sn(4) S_U*bf(1)'}    {'Sn(4) PPI_S_C'}    {'Sn(4) PPI_S_H'}
% {'Sn(4) PPI_S_L'}    {'Sn(4) PPI_S_U'}    {'Sn(4) VOI_l_pST…'}    {'Sn(4) m1'}    {'Sn(4) m2'}    {'Sn(4) m3'}    {'Sn(4) m4'}    {'Sn(4) m5'}    {'Sn(4) m6'}    {'Sn(1) constant'}    {'Sn(2) constant'}
% {'Sn(3) constant'}    {'Sn(4) constant'}