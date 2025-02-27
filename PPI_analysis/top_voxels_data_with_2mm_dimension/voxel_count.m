%% Voxel count
% This little script is to check if we selected the number of top-activated
% voxels as expected or not after using the make_paramOjbect.m or
% top_voxels_jin script. Written by Jin Wang, 5/3/2019

clear all; % This is to clear the work space in matlab window
addpath(genpath('/dors/gpc/JamesBooth/JBooth-Lab/BDL/LabTools/nifti')); % This is to add the nifti tool in. The load_nii is a function from this tool
%roi_name= '/l_IFGop_onsetrhyme_vs_perc_VS_weakstrong_vs_perc_p1_k100_roi.nii';% The name of your individual Rois
%roi_name = '/l_IFGtri_weakstrong_vs_perc_VS_onsetrhyme_vs_perc_p1_k100_roi.nii'
roi_name = '/pMTG_weakstrong_vs_perc_VS_onsetrhyme_vs_perc_p1_k100_roi.nii'
%roi_name = '/pSTG_onsetrhyme_vs_perc_VS_weakstrong_vs_perc_p1_k100_roi.nii';


path='/gpfs51/dors2/gpc/JamesBooth/JBooth-Lab/BDL/AM_ELP/Scripts_AM/templates_cerebroMatic/AM_ROIs/ROIs/ses9_sem_specialization/'; % The path of your individual ROIs folder
subjects ={}; %The subject in your individual ROIs folder

data_info='/gpfs51/dors2/gpc/JamesBooth/JBooth-Lab/BDL/AM_ELP/Conn_PhonSem_AM_7_9/preprocessed/Subject_selection.xlsx';
if isempty(subjects)
    M=readtable(data_info);
    subjects=M.Subjects;
end

aal_path='/gpfs51/dors2/gpc/JamesBooth/JBooth-Lab/BDL/AM_ELP/Scripts_AM/templates_cerebroMatic/AM_ROIs'; % Your aal anatomical mask path
%aal_name='/l_IFGop.nii'; % Your anatomical mask name
%aal_name='/l_IFGtri.nii';
aal_name='/pMTG.nii';
%aal_name='/pSTG.nii';
%%%%%%%%%%%%%should not edit below %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
num_voxels=zeros(length(subjects),1);
cnt=1;
num_voxels_overlap=zeros(length(subjects),1);
s2 = load_nii([aal_path aal_name]);
for ii=1:length(subjects)
    s1(cnt) = load_nii([path subjects{ii} roi_name]);
    num_voxels(cnt,1)=sum(double(s1(cnt).img(:))==1);
    s3=double(s1(cnt).img)+double(s2.img);
    num_voxels_overlap(cnt,1)=sum(s3(:)==2);
    cnt=cnt+1;
end

disp(num_voxels)
disp(num_voxels_overlap)
% the num_voxels show you the num of voxels in your brain mask
% the num_voxels_overlap show you the num of voxels that overlaps in your
% brain mask with the specific brain anatomical brain mask. (e.g. if you
% select your top 100 voxels in IFG as your brain mask, but now you want to
% see how many of the 100 voxels locate in IFG triangualr. Then your mask
% aal_name can be the name of your anatomical mask.
