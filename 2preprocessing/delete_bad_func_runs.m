%% Delete bad runs or subjects that are not in your final dataset excel list
%This code is to clean the bad functional data after you know your final
%dataset excel. This assumes you have already run main_just_for_movment.m
%and count_repairee_acc_update.m, which means that in your folder, you have
%some artrepaired.txt leftovers and .png or jpgs. You need to clean them
%and also delete the bad subjects or runs you do not want to include.
% written by Jin Wang 1/5/2021

filenm='Subject_selection.xlsx'; 
%This is your data_to_keep excel after you screen the repeated runs (based on your criteria, say mv, acc, or both). 
%You only have unique better func runs in this excel. If you have multiple tasks, you make your first column subjects, 
%other multiple columns as run names(e.g. Plausrun1, Plausrun2, Gramrun1, Gramrun2).
path='/gpfs51/dors2/gpc/JamesBooth/JBooth-Lab/BDL/AM_ELP/Conn_PhonSem_AM_7_9/preprocessed';
data_folder='/gpfs51/dors2/gpc/JamesBooth/JBooth-Lab/BDL/AM_ELP/Conn_PhonSem_AM_7_9/preprocessed';
session ='ses-9';
good_subjects=[];
M=readtable([path '/' filenm],'Sheet','GoodRunsSes9');
good_subjects=M.Subjects;

%%%%%%%%%%%%%%%%%%%%%%%should not edit below%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%read in the good subject lists from your data_to_keep excel
%cd(path)

    
%read in all the subjects in your data_folder
listing=dir(data_folder);
all_list=extractfield(listing,'name');
index=strfind(all_list,'sub-');
idx=find(not(cellfun('isempty',index)));
subjects=all_list(idx);
m=1;
for i=1:length(subjects)
    %cd(data_folder);
    if m>length(good_subjects)
        rmdir([data_folder '/' subjects{i}],'s');
    else
    if strcmp(subjects{i},good_subjects{m})
        sub_path=[data_folder '/' subjects{i} '/' session];
        if any(size(dir([sub_path '/*.png']),1))
            cd(sub_path);
            delete *.png
        end
        T=M(m,:);
        m=m+1;
        hdr=T.Properties.VariableNames;
        cd([sub_path '/func']);
        list=dir([sub_path '/func']);
        all_names=extractfield(list,'name');
        index2=strfind(all_names,'sub');
        idx2=find(not(cellfun('isempty',index2)));
        all_f=all_names(idx2);
        for j=1:length(all_f)
            if isfile(all_f{j})
                delete(all_f{j});
            else
                n=2;
                while n<=length(hdr)
                    good_run=T{:,n};
                    if strcmp(all_f{j},char(good_run))
                        break
                    end
                    n=n+1;
                end
                
                if n>length(hdr)
                    rmdir([sub_path '/func/' all_f{j}], 's');
                else
                    file_p=[sub_path '/func/' all_f{j}];
                    if exist([file_p '/ArtifactMask.nii'])
                        delete([file_p '/ArtifactMask.nii']);
                    end
                    if exist([file_p '/art_repaired.txt'])
                        delete([file_p '/art_repaired.txt']);
                    end
                    if exist([file_p '/art_deweighted.txt'])
                        delete([file_p '/art_deweighted.txt']);
                    end
                    file_name=all_f{j};
%                     even_file=file_name(1:end-4);
%                     if exist([file_p '/' even_file 'events.tsv'])
%                         delete([file_p '/' even_file 'events.tsv']);
%                     end
%                     if exist([file_p '/' all_f{j} '.json'])
%                         delete([file_p '/' all_f{j} '.json']);
%                     end
                end
            end
        end
    else
        rmdir([data_folder '/' subjects{i}],'s');
    end
    end
end



