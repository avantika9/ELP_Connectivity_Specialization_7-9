%%Script to find top x or x% voxels for each subject for a given contrast, masked by an ROI or not. This script puts all the necessary 
%info into an object. After running this script, you should run the command: makeroi(paramObject). 
%Written by Jerome Prado many many moons ago (as far as Jeci Younger knows anyway)
% Edited by AM for ELP Dataset - PPI Analysis
% Obtaining the top 100 connnected voxels from PPI SPM file within the top 1000 VOXEL MASK for
% temporal, parietal and frontal ROIs
% The make_paramObject has to be run across subjects specified in
% idfile.txt using the submit.sh script


function make_paramObject(subject_id)

% Go to subject folder
% Phon folder for STG
% cd(strcat('/gpfs51/dors2/gpc/JamesBooth/JBooth-Lab/BDL/AM/ELP/Conn_PhonSem_AM_7_9/preprocessed/AM_ROIs/ROIs_amendment/ses7_phon_specialization/', subject_id));

% Sem folder for MTG
cd(strcat('/gpfs51/dors2/gpc/JamesBooth/JBooth-Lab/BDL/AM/ELP/Conn_PhonSem_AM_7_9/preprocessed/AM_ROIs/ROIs_amendment/ses7_sem_specialization/', subject_id));
%add your paths
addpath(genpath('/gpfs51/dors2/gpc/JamesBooth/JBooth-Lab/BDL/AM/ELP/Scripts_AM/spm12_elp'));
spm('defaults','fmri');

addpath('/gpfs51/dors2/gpc/JamesBooth/JBooth-Lab/BDL/AM/ELP/Scripts_AM/spm12_elp/toolbox/marsbar'); %You can leave this line alone. This just ensures that marsbar is in your path.
addpath('/gpfs51/dors2/gpc/JamesBooth/JBooth-Lab/BDL/AM/ELP/Scripts_AM/PPI_analysis/top_voxels_data_with_2mm_dimension');

paramObject.data_root='/gpfs51/dors2/gpc/JamesBooth/JBooth-Lab/BDL/AM/ELP/Conn_PhonSem_AM_7_9/preprocessed'; %the parent directory for all the subject folders

% ROI 1 STG
%paramObject.SPM_mat_folder='/ses7_analysis/deweight/PPI_VOI_l_pSTG_gPPI'; %the name of the directory under the subject data folder containing the SPM.mat file with contrast info 
%paramObject.contrast_name= 'PPI_onsetrhyme_vs_perceptual';%the name of the contrast associated with the statistical map you want to use. Check your SPM.mat file for names 

% ROI 2 MTG
paramObject.SPM_mat_folder='/ses7_analysis/deweight/PPI_VOI_l_pMTG_gPPI'; %the name of the directory under the subject data folder containing the SPM.mat file with contrast info 
paramObject.contrast_name= 'PPI_lowhigh_vs_perceptual';%the name of the contrast associated with the statistical map you want to use. Check your SPM.mat file for names 


%All Regions
paramObject.regions={};
%paramObject.images={'l_aTemporal_onsetrhyme_vs_perceptual_p1_k1000_roi' 'l_IFG_onsetrhyme_vs_perceptual_p1_k1000_roi' 'l_Parietal_onsetrhyme_vs_perceptual_p1_k1000_roi'}; %'l_IFGop' 'pSTG'
paramObject.images={'l_aTemporal_weakstrong_vs_perceptual_p1_k1000_roi' 'l_IFG_weakstrong_vs_perceptual_p1_k1000_roi' 'l_Parietal_weakstrong_vs_perceptual_p1_k1000_roi'}; %'l_IFGop' 'pSTG'

paramObject.subjects={subject_id};% This script will have to be run on individual subjects as top 100 voxels are selected from top 1000 voxel mask


%%OPTIONAL PARAMETERS%%
%%If these values are not specified, defaults will be used (p=.05, radius=8mm, k=100%)
paramObject.p=1; %uncorrected p-value for statistical map with which sphere is intersected
%paramObject.radius=6; %sphere radius, in mm (again, the utility of this line I think has been lost -JY)
paramObject.k='100'; %specify paramObject.k as either 'k%' or just 'k'
			%if k is specified as k%, it will take the top k percentile of voxels
			%if k is specified as k, then it will take the top k voxels
			%It will always select at least 1 voxel (e.g., top 10% of a 9 voxel blob < 1, so select the top 1 voxel)
paramObject.savesphere=1; %do you want to save the base spheres for each person? Might be useful for debugging failed ROI attempts
paramObject.savedir='/ROIs_connected_top100';%name of the subdirectory to be created in the current directory into which the ROIs will be saved
				%if a savedir is not specified, a directory with today's
				%date will be created
makeroi(paramObject);                
end                