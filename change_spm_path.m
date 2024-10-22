addpath('/gpfs51/dors2/gpc/JamesBooth/JBooth-Lab/BDL/AM/ELP/Scripts_AM/spm12_elp');

subjects={};
data_info='/gpfs51/dors2/gpc/JamesBooth/JBooth-Lab/BDL/AM/ELP/Conn_PhonSem_AM_7_9/preprocessed/Subject_selection.xlsx';
if isempty(subjects)
    M=readtable(data_info);
    subjects=M.Subjects;
end

for num=1:length(subjects)
cd(fullfile(strcat('/gpfs51/dors2/gpc/JamesBooth/JBooth-Lab/BDL/AM/ELP/Conn_PhonSem_AM_7_9/preprocessed/', subjects{num},'/ses7_analysis')));
spm_changepath('SPM.mat',strcat('/gpfs51/dors2/gpc/JamesBooth/JBooth-Lab/BDL/AM/ELPConn_PhonSem_AM_7_9/preprocessed/',subjects{num},'/ses7_analysis'), ...
                         strcat('/gpfs51/dors2/gpc/JamesBooth/JBooth-Lab/BDL/AM/ELP/Conn_PhonSem_AM_7_9/preprocessed/',subjects{num},'/ses7_analysis'));

spm_changepath('SPM.mat', strcat('/gpfs51/dors2/gpc/JamesBooth/JBooth-Lab/BDL/AM/ELPConn_PhonSem_AM_7_9/preprocessed/',subjects{num},'/ses-7/func/'),...
                          strcat('/gpfs51/dors2/gpc/JamesBooth/JBooth-Lab/BDL/AM/ELP/Conn_PhonSem_AM_7_9/preprocessed/',subjects{num},'/ses-7/func/'));

cd(fullfile(strcat('/gpfs51/dors2/gpc/JamesBooth/JBooth-Lab/BDL/AM/ELP/Conn_PhonSem_AM_7_9/preprocessed/', subjects{num},'/ses7_analysis/deweight')));
spm_changepath('SPM.mat',strcat('/gpfs51/dors2/gpc/JamesBooth/JBooth-Lab/BDL/AM/ELPConn_PhonSem_AM_7_9/preprocessed/',subjects{num},'/ses7_analysis/deweight'), ...
                         strcat('/gpfs51/dors2/gpc/JamesBooth/JBooth-Lab/BDL/AM/ELP/Conn_PhonSem_AM_7_9/preprocessed/',subjects{num},'/ses7_analysis/deweight'));
                     
spm_changepath('SPM.mat', strcat('/gpfs51/dors2/gpc/JamesBooth/JBooth-Lab/BDL/AM/ELPConn_PhonSem_AM_7_9/preprocessed/',subjects{num},'/ses-7/func/'),...
                          strcat('/gpfs51/dors2/gpc/JamesBooth/JBooth-Lab/BDL/AM/ELP/Conn_PhonSem_AM_7_9/preprocessed/',subjects{num},'/ses-7/func/'));

                     
                     
cd(fullfile(strcat('/gpfs51/dors2/gpc/JamesBooth/JBooth-Lab/BDL/AM/ELP/Conn_PhonSem_AM_7_9/preprocessed/', subjects{num},'/ses9_analysis')));
spm_changepath('SPM.mat',strcat('/gpfs51/dors2/gpc/JamesBooth/JBooth-Lab/BDL/AM/ELPConn_PhonSem_AM_7_9/preprocessed/',subjects{num},'/ses9_analysis'), ...
                         strcat('/gpfs51/dors2/gpc/JamesBooth/JBooth-Lab/BDL/AM/ELP/Conn_PhonSem_AM_7_9/preprocessed/',subjects{num},'/ses9_analysis'));

spm_changepath('SPM.mat', strcat('/gpfs51/dors2/gpc/JamesBooth/JBooth-Lab/BDL/AM/ELPConn_PhonSem_AM_7_9/preprocessed/',subjects{num},'/ses-9/func/'),...
                          strcat('/gpfs51/dors2/gpc/JamesBooth/JBooth-Lab/BDL/AM/ELP/Conn_PhonSem_AM_7_9/preprocessed/',subjects{num},'/ses-9/func/'));
                    
                     
                     
cd(fullfile(strcat('/gpfs51/dors2/gpc/JamesBooth/JBooth-Lab/BDL/AM/ELP/Conn_PhonSem_AM_7_9/preprocessed/', subjects{num},'/ses9_analysis/deweight')));
spm_changepath('SPM.mat',strcat('/gpfs51/dors2/gpc/JamesBooth/JBooth-Lab/BDL/AM/ELPConn_PhonSem_AM_7_9/preprocessed/',subjects{num},'/ses9_analysis/deweight'), ...
                         strcat('/gpfs51/dors2/gpc/JamesBooth/JBooth-Lab/BDL/AM/ELP/Conn_PhonSem_AM_7_9/preprocessed/',subjects{num},'/ses9_analysis/deweight'));

spm_changepath('SPM.mat', strcat('/gpfs51/dors2/gpc/JamesBooth/JBooth-Lab/BDL/AM/ELPConn_PhonSem_AM_7_9/preprocessed/',subjects{num},'/ses-9/func/'),...
                          strcat('/gpfs51/dors2/gpc/JamesBooth/JBooth-Lab/BDL/AM/ELP/Conn_PhonSem_AM_7_9/preprocessed/',subjects{num},'/ses-9/func/'));
          
end
