function ROIoverlaps
% This script will combine all the individual ROIs, and using mricron to
% show color-code clusters depending on the amount of overlaps. written by
% Jin Wang 5/3/2019
clear all;
addpath(genpath('/gpfs51/dors2/gpc/JamesBooth/JBooth-Lab/BDL/LabTools/nifti')); % addpath the nifti function tools, for this script it is mainly using the load_nii.m and save_nii.m.

%root_dir = '/gpfs51/dors2/gpc/JamesBooth/JBooth-Lab/BDL/AM_ELP/Scripts_AM/templates_cerebroMatic/AM_ROIs/ROIs/ses7_phon_specialization'; % your individual ROI paths
root_dir = '/gpfs51/dors2/gpc/JamesBooth/JBooth-Lab/BDL/AM/ELP/Conn_PhonSem_AM_7_9/preprocessed/AM_ROIs/ROIs_amendment/ses7_sem_specialization';

subjects={};
data_info='/gpfs51/dors2/gpc/JamesBooth/JBooth-Lab/BDL/AM/ELP/Conn_PhonSem_AM_7_9/preprocessed/Subject_selection.xlsx';
if isempty(subjects)
    M=readtable(data_info);
    subjects=M.Subjects;
end

%roi_name = 'l_aTemporal_onsetrhyme_vs_perceptual_p1_k1000_roi_PPI_onsetrhyme_vs_perceptual_p1_k100_roi.nii';
%roi_name = 'l_Parietal_onsetrhyme_vs_perceptual_p1_k1000_roi_PPI_onsetrhyme_vs_perceptual_p1_k100_roi.nii';
%roi_name = 'l_IFG_onsetrhyme_vs_perceptual_p1_k1000_roi_PPI_onsetrhyme_vs_perceptual_p1_k100_roi.nii';
%roi_name = 'l_aTemporal_weakstrong_vs_perceptual_p1_k1000_roi_PPI_lowhigh_vs_perceptual_p1_k100_roi.nii';
%roi_name = 'l_Parietal_weakstrong_vs_perceptual_p1_k1000_roi_PPI_lowhigh_vs_perceptual_p1_k100_roi.nii';
roi_name = 'l_IFG_weakstrong_vs_perceptual_p1_k1000_roi_PPI_lowhigh_vs_perceptual_p1_k100_roi.nii';

    %set s.img as zeros, the matrix sized depends on the first subejct
    %s.img size
    idx = 1; 
    roi_dir = [root_dir '/' subjects{1} '/ROIs_connected_top100/' subjects{1} '/' roi_name ];
    s = load_nii(roi_dir);
    s.img = zeros(size(s(1).img));
    
    % add subjects s.img up
    for ii = 1:length(subjects)
        roi_dir = [root_dir '/' subjects{ii} '/ROIs_connected_top100/' subjects{ii} '/' roi_name];
        m(idx) = load_nii(roi_dir);
        s.img = s.img + double(m(idx).img);
        idx=idx+1;
    end


%%
cd(root_dir);

%save_nii(s, 'ses7_PPI_l_aTemporal_onsetrhyme_vs_perceptual_p1_k100_roi_combined.nii')
%save_nii(s, 'ses7_PPI_l_Parietal_onsetrhyme_vs_perceptual_p1_k100_roi_combined.nii')
% save_nii(s, 'ses7_PPI_l_IFG_onsetrhyme_vs_perceptual_p1_k100_roi_combined.nii')
%save_nii(s, 'ses7_PPI_l_aTemporal_weakstrong_vs_perceptual_p1_k100_roi_combined.nii')
%save_nii(s, 'ses7_PPI_l_Parietal_weakstrong_vs_perceptual_p1_k100_roi_combined.nii')
save_nii(s, 'ses7_PPI_l_IFG_weakstrong_vs_perceptual_p1_k100_roi_combined.nii')


end