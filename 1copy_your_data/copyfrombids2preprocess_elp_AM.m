%%
% This is the code for copying data from ELP bids or other bids data that have multiple sessions.
% written by Jin Wang 1/5/2021
% This will have an output txt file to show the list of subjects who have more than one T1weighted images multiple_T1w_subjects.txt file
% You should use copy_repeated_anat.m to re-evaluate the best T1 for each
% subject to use for later preprocessing.
addpath(genpath('/gpfs51/dors2/gpc/JamesBooth/JBooth-Lab/BDL/AM_ELP/typical_data_analysis/1copy_your_data')); %make sure you copied the code expand_path.m in your codes
global CCN;

root='/gpfs51/dors2/gpc/JamesBooth/JBooth-Lab/BDL/ELP/bids';  %This is the path where the data raw data sits
%subjects={'sub-5008'}; % you can either manually put in your subjects (e.g.'sub-5004' 'sub-5009') or leave it empty and define a path of an excel that contains subject numbers as indicated below. 
data_info='/gpfs51/dors2/gpc/JamesBooth/JBooth-Lab/BDL/AM_ELP/Subjects.xlsx'; %In this excel, there should be a column of subjects with the header (subjects). The subjects should all be sub plus numbers (sub-5002).
if isempty(subjects)
    M=readtable(data_info);
    subjects=M.subjects;
end

new_root='/gpfs51/dors2/gpc/JamesBooth/JBooth-Lab/BDL/AM_ELP/Conn_PhonSem_AM_7_9/raw'; %This is the folder path where you want to do analysis
CCN.funcf1='sub*Phon*bold.nii.gz'; %This is the functional folder you want to copy. In this example, it's just Plaus and Gram.
CCN.funcf2='sub*Sem*bold.nii.gz';
CCN.anat='*_T1w.nii.gz'; % This is the file name of your anatomical data
session='ses-9'; % This is the session. You can define 'ses*' to grab all sessions too. In this example, it's just grabbing ses-7.
writefile='multiple_T1w_subjects_bids_ses-9.txt'; % This file is used to record repetited T1s, and will be used in code delete_bad_t1.m later when you want unique t1 to preprocess the data. 

%%%%%%%%%%%%%%%%%%typically do not modify anything below unless necessary%%%%%%%%%%%%%%%%%
%create a multiple_t1.txt, if there is an existing one, delete it. 
cd(new_root);
if exist(writefile)
    delete(writefile);
end
fid=fopen([new_root '/' writefile],'w');

for i= 1:length(subjects)
    old_dir=[root '/' subjects{i} '/' session];
    new_dir=[new_root '/' subjects{i} '/' session];
    if ~isempty(expand_path([old_dir '/func/' '[funcf1]'])) && ~isempty(expand_path([old_dir '/func/' '[funcf2]'])) %This line should modified if your wanted files are not two as in my example.
        if ~exist(new_dir)
            mkdir(new_dir);
            mkdir([new_dir '/func']);
            mkdir([new_dir '/anat']);
        end
        source{1}=expand_path([old_dir '/func/[funcf1]']); source{2}=expand_path([old_dir '/func/[funcf2]']);%This line should modified if your wanted files are not two as in my example.
        for j=1:length(source)
            for jj=1:length(source{j})
                [f_path, f_name, ext]=fileparts(source{j}{jj});
                %e_name=[f_name(1:end-8) 'events.tsv'];
                mkdir([new_dir '/func/' f_name(1:end-4)]);
                dest=[new_dir '/func/' f_name(1:end-4) '/' f_name ext];
                %dest_event=[new_dir '/func/' f_name(1:end-4) '/' e_name];
                %dest_json=[new_dir '/func/' f_name(1:end-4) '/' f_name(1:end-4) '.json'];
                system(['chmod -R 770 ', fileparts(dest)]);
                copyfile(source{j}{jj},dest);
                system(['chmod 770 ', dest]);
                gunzip(dest);
                delete(dest);
                %copyfile([f_path '/' e_name],dest_event);
                %copyfile([f_path '/' f_name(1:end-4) '.json'], dest_json);
            end
        end
        
        sanat=expand_path([old_dir '/anat/[anat]']);
        if length(sanat)>1
            fprintf(fid,'%s\n', subjects{i});
        end
        for k=1:length(sanat)
            [a_path, a_name, ext]=fileparts(sanat{k});
            dt=[new_dir '/anat/' a_name ext];
            system(['chmod -R 770 ', fileparts(dt)]);
            copyfile(sanat{k},dt);
            system(['chmod 770 ', dt]);
            gunzip(dt);
            delete(dt);
        end
    else
        fprintf('%s targeted tasks not found\n', subjects{i}); % in the command window, it will print out the subjects that you requested but not found in bids.
    end
end


