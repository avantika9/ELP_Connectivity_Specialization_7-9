%% First level analysis more contrast. 
% You can run this if you have other
% new contrasts you want to estimate after you already did your firstlevel
% modeling and estimation. This will add on your previous contrast in the
% same analysis folder.

addpath(genpath('/dors/booth/JBooth-Lab/BDL/LabCode/typical_data_analysis')); % the path of your scripts
spm_path='/dors/booth/JBooth-Lab/BDL/LabCode/typical_data_analysis/spm12_elp'; %the path of spm
addpath(genpath(spm_path));

%define your data path
data=struct();
root='/dors/booth/JBooth-Lab/BDL/jinwang/SemPhon_7_8';  %your project path
test_subjects={'sub-5550' 'sub-5553'}; % your subjects
run_script=1;

%%Usually you do not need to modify them if you follow the rule of the folder structure convention in the walkthrough
global CCN
CCN.preprocessed='preprocessed';
CCN.session='ses*'; % the time points you want to analyze 
CCN.func_pattern='T*'; % the name of your functional folders
analysis_folder='analysis'; % the name of your first level modeling folder
model_deweight='deweight'; % the deweigthed modeling folder, it will be inside of your analysis folder
CCN.preprocessed='preprocessed'; % your data folder
CCN.file='vs6_wtask*bold.nii'; % the name of your preprocessed data (4d)
CCN.files='vs6_wtask*bold_0*'; % the name of your preprocessed data (3d) expanded one.
CCN.rpfile='rp_*.txt'; %the movement files

%define your contrasts, make sure your contrasts and your weights should be
%matched.
% contrasts={};

% contrasts={'onset_vs_rhyme_VS_weak_vs_strong' 'onset_vs_perc_VS_weak_vs_perc' 'rhyme_vs_perc_VS_strong_vs_perc'};
% onset_vs_rhyme=[1 -1 0 0];
% weak_vs_strong=[-1 1 0 0];
% onset_vs_perc=[1 0 -1 0];
% weak_vs_perc=[0 1 -1 0];
% rhyme_vs_perc=[0 1 -1 0];
% strong_vs_perc=[1 0 -1 0];
contrasts={'sunrelated_vs_perc_VS_munrelated_vs_perc' 'sunrelated_vs_perc' 'munrelated_vs_perc'};
unrelated_vs_perc=[0 0 -1 1];

%adjust the contrast by adding six 0s into the end of each session
rp_w=zeros(1,6);
empty=zeros(1,10);
weights={[unrelated_vs_perc rp_w unrelated_vs_perc rp_w -1*unrelated_vs_perc rp_w -1*unrelated_vs_perc rp_w] ...
    [unrelated_vs_perc rp_w unrelated_vs_perc rp_w empty empty] ...
    [empty empty unrelated_vs_perc rp_w unrelated_vs_perc rp_w]};
% weights={[onset_vs_rhyme rp_w onset_vs_rhyme rp_w -1*weak_vs_strong rp_w -1*weak_vs_strong rp_w]...
%     [onset_vs_perc rp_w onset_vs_perc rp_w -1*weak_vs_perc rp_w -1*weak_vs_perc rp_w]...
%     [rhyme_vs_perc rp_w rhyme_vs_perc rp_w -1*strong_vs_perc rp_w -1*strong_vs_perc rp_w]};

%%%%%%%%%%%%%%%%%%%%%%%%Do not edit below here%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
listing=dir([root '/' CCN.preprocessed]);
all_list=extractfield(listing,'name');
index=strfind(all_list,'sub');
idx=find(not(cellfun('isempty',index)));
subjects_all=all_list(idx);
if run_script ==1
    subjects=test_subjects;
else
    subjects=subjects_all(~ismember(subjects_all,test_subjects));
end


%check if you define your contrasts in a correct way
if length(weights)~=length(contrasts)
    error('the contrasts and the weights are not matched');
end

% Initialize
%addpath(spm_path);
spm('defaults','fmri');
spm_jobman('initcfg');
spm_figure('Create','Graphics','Graphics');

% Dependency and sanity checks
if verLessThan('matlab','R2013a')
    error('Matlab version is %s but R2013a or higher is required',version)
end

req_spm_ver = 'SPM12 (6225)';
spm_ver = spm('version');
if ~strcmp( spm_ver,req_spm_ver )
    error('SPM version is %s but %s is required',spm_ver,req_spm_ver)
end
try
    %Start to analyze the data from here
    for i=1:length(subjects)
        fprintf('work on subject %s', subjects{i});
        CCN.subject=[root '/' CCN.preprocessed '/' subjects{i}];
        %specify the outpath,create one if it does not exist
        out_path=[CCN.subject '/' analysis_folder];
        if ~exist(out_path)
            mkdir(out_path)
        end
        %specify the deweighting spm folder, create one if it does not exist
        model_deweight_path=[out_path '/' model_deweight];
        if exist(model_deweight_path,'dir')~=7
            mkdir(model_deweight_path)
        end
        
%         %find folders in func
%         CCN.functional_dirs='[subject]/[session]/func/[func_pattern]/';
%         functional_dirs=expand_path(CCN.functional_dirs);
%         
%         %load 6 movement parameters
%         mv=[];
%         rp_file=expand_path([CCN.functional_dirs '[rpfile]']);
%         for i=1:length(rp_file)
%             rp=load(rp_file{i});
%             mv{i}=rp;
%         end
%         data.mv=mv;
%         
%         %load the functional data
%         swfunc=[];
%         P=[];
%         for j=1:length(functional_dirs)
%             P{j}=char(expand_path([functional_dirs{j} '[files]']));
%             if isempty(P{j}) % if there is no expanded data, then expand the preprocessed data
%                 file=expand_path([functional_dirs{j} '[file]']);
%                 hdr = load_nii_hdr(char(file));
%                 nscan = hdr.dime.dim(5);
%                 expand_nii_scan(char(file),1:nscan);
%             P{j}=char(expand_path([functional_dirs{j} '[files]']));
%             end
%             for ii=1:length(P{j})
%                 swfunc{j}(ii,:)=[P{j}(ii,:) ',1'];
%             end
%         end
%         data.swfunc=swfunc;
%         
%         %pass these experimental design information to data
%         data.conditions=conditions;
%         data.onsets=onsets;
%         data.dur=dur;
%         
        %run the firstlevel modeling and estimation (with deweighting)
%         mat=firstlevel(data, out_path, TR, model_deweight_path);
        origmat=[out_path '/SPM.mat'];
        mat=[model_deweight_path '/SPM.mat'];
        %run the contrasts
        more_contrast(origmat,contrasts,weights);
        more_contrast(mat,contrasts,weights);
        
    end
catch e
    rethrow(e)
    %display the error messages
end