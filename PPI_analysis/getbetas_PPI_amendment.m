%%Script to get beta values for each condition for each trial in a given
%%ROI. Written by Chris McNorgan many moons ago (as far as JY knows)
%% AM - changed the ROI filepath in the code to meet the PPI file structure
%%%%%%%%%%%%%%%%%%%%%%%%%
% None of this works without Marsbar being turned on
%%%%%%%%%%%%%%%%%%%%%%%%%
%initialize SPM and path
%parpool;
addpath(genpath('/gpfs51/dors2/gpc/JamesBooth/JBooth-Lab/BDL/AM/ELP/Scripts_AM/spm12_elp'));
addpath('/gpfs51/dors2/gpc/JamesBooth/JBooth-Lab/BDL/AM/ELP/Scripts_AM/spm12_elp/toolbox');
addpath(genpath('/gpfs51/dors2/gpc/JamesBooth/JBooth-Lab/BDL/LabTools'));
addpath('/gpfs51/dors2/gpc/JamesBooth/JBooth-Lab/BDL/AM/ELP/Conn_PhonSem_AM_7_9');
marsbar('on');

% What directory has all your subject folders? We assume that in each subject folder is
% a folder containing the SPM.mat file for that subject's 1st level analysis
rootDIR  = '/gpfs51/dors2/gpc/JamesBooth/JBooth-Lab/BDL/AM/ELP/Conn_PhonSem_AM_7_9/preprocessed';

% Where do you want the text file containing the betas to be written?
writeDIR  = rootDIR;

%How are your ROIs kept?
%1 = Everyone uses same ROI located in one location as is the case for
%standard analysis
%2= Everyone has their own ROI that is in a subject folder within a folder
%named with that ROI as is the case if paramObject was used
%3 = Everyone has their own ROI that is kept in the Analysis folder of the
%subject folders as is the case if PeakROI script is used
roistore = 2;

% If ROI store = 1 or 2, What directory has all your ROIS?
%roi_file_root = '/gpfs51/dors2/gpc/JamesBooth/JBooth-Lab/BDL/AM/ELP/Conn_PhonSem_AM_7_9/preprocessed/AM_ROIs/ROIs_amendment/ses7_phon_specialization';
 roi_file_root = '/gpfs51/dors2/gpc/JamesBooth/JBooth-Lab/BDL/AM/ELP/Conn_PhonSem_AM_7_9/preprocessed/AM_ROIs/ROIs_amendment/ses7_sem_specialization';

%what is your model directory?
%PPImodelDIR = ['PPI_VOI_l_pSTG_gPPI'];
PPImodelDIR = ['PPI_VOI_l_pMTG_gPPI'];

% Cahnging for every subject

% make sure the scriptdir is in the path
addpath(pwd);

% set parameters

%namerois = {'l_aTemporal_onsetrhyme_vs_perceptual_p1_k1000_roi_PPI_onsetrhyme_vs_perceptual_p1_k100'};
%namerois = {'l_IFG_onsetrhyme_vs_perceptual_p1_k1000_roi_PPI_onsetrhyme_vs_perceptual_p1_k100'};
%namerois = {'l_Parietal_onsetrhyme_vs_perceptual_p1_k1000_roi_PPI_onsetrhyme_vs_perceptual_p1_k100'};
%namerois = {'l_aTemporal_weakstrong_vs_perceptual_p1_k1000_roi_PPI_lowhigh_vs_perceptual_p1_k100'};
%namerois = {'l_IFG_weakstrong_vs_perceptual_p1_k1000_roi_PPI_lowhigh_vs_perceptual_p1_k100'};
namerois = {'l_Parietal_weakstrong_vs_perceptual_p1_k1000_roi_PPI_lowhigh_vs_perceptual_p1_k100'};




%put the name of the roi files here, omitting the '_rot.mat' part

%list all the subjects here
% subjects={'506' '508' '510' '513' '529' '534' '535' '541' '542' '546' '550' '555' '557' '559' '564' '579' '580' '603' '605' '609' '612' '614' '615' '620' '625' '659' '671' '675' '717' '721'};
%subjects={'sub-5008'};
subjects = {};
data_info='/gpfs51/dors2/gpc/JamesBooth/JBooth-Lab/BDL/AM/ELP/Conn_PhonSem_AM_7_9/preprocessed/Subject_selection.xlsx';
if isempty(subjects)
    M=readtable(data_info);
    subjects=M.Subjects;
end

%%%%%%%%%%%%%%
%%% ALERT!!!!
%%%%%%%%%%%%%%
%are you using a .nii or _roi.mat file? If using ROI location 3, assume
%.img file instead of .nii
roi_is_image=1; %1 if using .nii file, 0 if using _roi.mat file

%name all conditions that were modeled. You must name (and get the results
%from) all conditions, whether you're interested in them or not. Edit your
%text file to show the info you're interested in. This must match what is
%listed in the SPM.xX.name variable (found in the model dir for each
%subject)
% nameconditions={'Sn(1) seed'  'Sn(1) Lex_Null'  'Sn(1) seedxLex_Null' ...
%                 'Sn(2) seed'  'Sn(2) Lex_Null'  'Sn(2) seedxLex_Null' ...
%                 'Sn(3) seed'  'Sn(3) Lex_Null'  'Sn(3) seedxLex_Null' ...
%                 'Sn(4) seed'  'Sn(4) Lex_Null'  'Sn(4) seedxLex_Null' ...
%                 'Sn(5) seed'  'Sn(5) Lex_Null'  'Sn(5) seedxLex_Null' ...
%                 'Sn(6) seed'  'Sn(6) Lex_Null'  'Sn(6) seedxLex_Null' ...
%                 'Sn(7) seed'  'Sn(7) Lex_Null'  'Sn(7) seedxLex_Null' ...
%                 'Sn(8) seed'  'Sn(8) Lex_Null'  'Sn(8) seedxLex_Null' };

 
%  nameconditions = {'Sn(1) P_C*bf(1)' 'Sn(1) P_O*bf(1)' 'Sn(1) P_R*bf(1)' 'Sn(1) P_U*bf(1)' ...
%  'Sn(1) PPI_P_C' 'Sn(1) PPI_P_O' 'Sn(1) PPI_P_R' 'Sn(1) PPI_P_U' 'Sn(1) VOI_l_pSTG_gPPI_seedtc' ...
%  'Sn(1) m1' 'Sn(1) m2' 'Sn(1) m3' 'Sn(1) m4' 'Sn(1) m5' 'Sn(1) m6'  ...
%  'Sn(2) P_C*bf(1)' 'Sn(2) P_O*bf(1)' 'Sn(2) P_R*bf(1)' 'Sn(2) P_U*bf(1)'...
%  'Sn(2) PPI_P_C' 'Sn(2) PPI_P_O' 'Sn(2) PPI_P_R' 'Sn(2) PPI_P_U' 'Sn(2) VOI_l_pSTG_gPPI_seedtc' ...
%  'Sn(2) m1' 'Sn(2) m2' 'Sn(2) m3' 'Sn(2) m4' 'Sn(2) m5' 'Sn(2) m6' ...
%  'Sn(3) S_C*bf(1)' 'Sn(3) S_H*bf(1)' 'Sn(3) S_L*bf(1)' 'Sn(3) S_U*bf(1)' ...
%  'Sn(3) PPI_S_C' 'Sn(3) PPI_S_H' 'Sn(3) PPI_S_L' 'Sn(3) PPI_S_U' 'Sn(3) VOI_l_pSTG_gPPI_seedtc' ...
%  'Sn(3) m1' 'Sn(3) m2' 'Sn(3) m3' 'Sn(3) m4' 'Sn(3) m5' 'Sn(3) m6' ...
%  'Sn(4) S_C*bf(1)' 'Sn(4) S_H*bf(1)' 'Sn(4) S_L*bf(1)' 'Sn(4) S_U*bf(1)' ...
%  'Sn(4) PPI_S_C' 'Sn(4) PPI_S_H' 'Sn(4) PPI_S_L' 'Sn(4) PPI_S_U' 'Sn(4) VOI_l_pSTG_gPPI_seedtc' ...
%  'Sn(4) m1' 'Sn(4) m2' 'Sn(4) m3' 'Sn(4) m4' 'Sn(4) m5' 'Sn(4) m6' ...
%  'Sn(1) constant' 'Sn(2) constant' 'Sn(3) constant' 'Sn(4) constant'};

nameconditions = {'Sn(1) P_C*bf(1)' 'Sn(1) P_O*bf(1)' 'Sn(1) P_R*bf(1)' 'Sn(1) P_U*bf(1)' ...
 'Sn(1) PPI_P_C' 'Sn(1) PPI_P_O' 'Sn(1) PPI_P_R' 'Sn(1) PPI_P_U' 'Sn(1) VOI_l_pMTG_gPPI_seedtc' ...
 'Sn(1) m1' 'Sn(1) m2' 'Sn(1) m3' 'Sn(1) m4' 'Sn(1) m5' 'Sn(1) m6'  ...
 'Sn(2) P_C*bf(1)' 'Sn(2) P_O*bf(1)' 'Sn(2) P_R*bf(1)' 'Sn(2) P_U*bf(1)'...
 'Sn(2) PPI_P_C' 'Sn(2) PPI_P_O' 'Sn(2) PPI_P_R' 'Sn(2) PPI_P_U' 'Sn(2) VOI_l_pMTG_gPPI_seedtc' ...
 'Sn(2) m1' 'Sn(2) m2' 'Sn(2) m3' 'Sn(2) m4' 'Sn(2) m5' 'Sn(2) m6' ...
 'Sn(3) S_C*bf(1)' 'Sn(3) S_H*bf(1)' 'Sn(3) S_L*bf(1)' 'Sn(3) S_U*bf(1)' ...
 'Sn(3) PPI_S_C' 'Sn(3) PPI_S_H' 'Sn(3) PPI_S_L' 'Sn(3) PPI_S_U' 'Sn(3) VOI_l_pMTG_gPPI_seedtc' ...
 'Sn(3) m1' 'Sn(3) m2' 'Sn(3) m3' 'Sn(3) m4' 'Sn(3) m5' 'Sn(3) m6' ...
 'Sn(4) S_C*bf(1)' 'Sn(4) S_H*bf(1)' 'Sn(4) S_L*bf(1)' 'Sn(4) S_U*bf(1)' ...
 'Sn(4) PPI_S_C' 'Sn(4) PPI_S_H' 'Sn(4) PPI_S_L' 'Sn(4) PPI_S_U' 'Sn(4) VOI_l_pMTG_gPPI_seedtc' ...
 'Sn(4) m1' 'Sn(4) m2' 'Sn(4) m3' 'Sn(4) m4' 'Sn(4) m5' 'Sn(4) m6' ...
 'Sn(1) constant' 'Sn(2) constant' 'Sn(3) constant' 'Sn(4) constant'};

%These entries correspond to the condition names in nameconditions. I'd like to use these for column headings.
% friendlyconditions=	{'T1_nw_1_seed' 'T1_nw_vv_1_contrast' 'T1_nw_vv_1_interaction'...
%                      'T1_nw_vv_2_seed' 'T1_nw_vv_2_contrast' 'T1_nw_vv_2_interaction'...
%                      'T1_w_vv_1_seed' 'T1_w_vv_1_contrast' 'T1_w_vv_1_interaction'...
%                      'T1_w_vv_2_seed' 'T1_w_vv_2_contrast' 'T1_w_vv_2_interaction'...
%                      'T2_nw_vv_1_seed' 'T2_nw_vv_1_contrast' 'T2_nw_vv_1_interaction'...
%                      'T2_nw_vv_2_seed' 'T2_nw_vv_2_contrast' 'T2_nw_vv_2_interaction'...
%                      'T2_w_vv_1_seed' 'T2_w_vv_1_contrast' 'T2_w_vv_1_interaction'...
%                      'T2_w_vv_2_seed' 'T2_w_vv_2_contrast' 'T2_w_vv_2_interaction'};

%  friendlyconditions= {'P_C_contrast' 'P_O_contrast' 'P_R_contrast' 'P_U_contrast' ...
%  'PPI_P_C' 'PPI_P_O' 'PPI_P_R' 'PPI_P_U' 'VOI_l_pSTG_gPPI_seed' ...
%  'm1' 'm2' 'm3' 'm4' 'm5' 'm6'  ...
%  'P_C_contrast' 'P_O_contrast' 'P_R_contrast' 'P_U_contrast'...
%  'PPI_P_C' 'PPI_P_O' 'PPI_P_R' 'PPI_P_U' 'VOI_l_pSTG_gPPI_seed' ...
%  'm1' 'm2' 'm3' 'm4' 'm5' 'm6' ...
%  'S_C_contrast' 'S_H_contrast' 'S_L_contrast' 'S_U_contrast' ...
%  'PPI_S_C' 'PPI_S_H' 'PPI_S_L' 'PPI_S_U' 'VOI_l_pSTG_gPPI_seed' ...
%  'm1' 'm2' 'm3' 'm4' 'm5' 'm6' ...
%  'S_C_contrast' 'S_H_contrast' 'S_L_contrast' 'S_U_contrast' ...
%  'PPI_S_C' 'PPI_S_H' 'PPI_S_L' 'PPI_S_U' 'VOI_l_pSTG_gPPI_seed' ...
%  'm1' 'm2' 'm3' 'm4' 'm5' 'm6' ...
%  'constant1' 'constant2' 'constant3' 'constant4'};

 friendlyconditions= {'P_C_contrast' 'P_O_contrast' 'P_R_contrast' 'P_U_contrast' ...
 'PPI_P_C' 'PPI_P_O' 'PPI_P_R' 'PPI_P_U' 'VOI_l_pMTG_gPPI_seed' ...
 'm1' 'm2' 'm3' 'm4' 'm5' 'm6'  ...
 'P_C_contrast' 'P_O_contrast' 'P_R_contrast' 'P_U_contrast'...
 'PPI_P_C' 'PPI_P_O' 'PPI_P_R' 'PPI_P_U' 'VOI_l_pMTG_gPPI_seed' ...
 'm1' 'm2' 'm3' 'm4' 'm5' 'm6' ...
 'S_C_contrast' 'S_H_contrast' 'S_L_contrast' 'S_U_contrast' ...
 'PPI_S_C' 'PPI_S_H' 'PPI_S_L' 'PPI_S_U' 'VOI_l_pMTG_gPPI_seed' ...
 'm1' 'm2' 'm3' 'm4' 'm5' 'm6' ...
 'S_C_contrast' 'S_H_contrast' 'S_L_contrast' 'S_U_contrast' ...
 'PPI_S_C' 'PPI_S_H' 'PPI_S_L' 'PPI_S_U' 'VOI_l_pMTG_gPPI_seed' ...
 'm1' 'm2' 'm3' 'm4' 'm5' 'm6' ...
 'constant1' 'constant2' 'constant3' 'constant4'};




    %If doing PPI analysis, these should look something like this
%nameconditions={'Sn(1) seed','Sn(1) Oplus_vs_Ominus','Sn(1) seedxOplus_vs_Ominus','Sn(2) seed','Sn(2) Oplus_vs_Ominus','Sn(2) seedxOplus_vs_Ominus'};
%friendlyconditions=	{'T1_seed', 'T1_contrast' 'T1_interaction' 'T2_seed', 'T2_contrast' 'T2_interaction' };

%What do you want the prefix of the text file to be? Text file will be your
%prefix+the roi name
fprefix='betas_'; %it's also possible to make our results file have a prefix.


%%%%%%%%%%%%%%%%%%should not need to edit below this line 

numsubjects = length(subjects);
numconditions = length(nameconditions);

    %create an roi loop
roi = 1:length(namerois);
for w = roi
    thisroi = namerois(w);
    cd(writeDIR);

    fextension='.txt'; %our results file will have a .txt extension
    writefile=char([char(fprefix) char(thisroi) char(fextension)]); %our results file will be named after the ROI associated with the betas it contains.

    delete(writefile); %deletes the data results file if it already exists (i.e., if you ran this script once already and made a whoopsie)
    headings=sprintf('%s\t',friendlyconditions{:}); % making a tab-delimited string of the condition headings in the order the betas are collected
    headings = ['ID	' headings];%We also need a column for the Subject ID
    fid=fopen(writefile, 'w');
    fprintf(fid,'%s',headings); %Now this results file has a header line containing human-readable condition names.	
    fprintf(fid,'\n');%we need a trailing newline character so our betas start on the next line. 
    % create a subject loop
    subj = 1:length(subjects);
    for x = subj
    thisguy = subjects(x);
    
    D=[];
    R=[];
    Y=[];
    xCON=[];
    E=[];
        fprintf('Working on participant %s for ROI %s\n', char(thisguy), char(thisroi));
	
        if roistore == 1
            if (roi_is_image)
            roi_file = char([char(roi_file_root) filesep char(thisguy) char('/ROIs_connected_top100/') char(thisguy) filesep char(thisroi) char('_roi.nii')]);  %IF .NII FILE
            R = maroi_image(roi_file);
            else
        	roi_file = char([char(roi_file_root) filesep char(thisguy) char('/ROIs_connected_top100/') char(thisguy) filesep char(thisroi) char('_roi.mat')]); %IF .MAT FILE
            R  = maroi(roi_file);
		
            end
        elseif roistore== 2
            if (roi_is_image)
            roi_file = char([char(roi_file_root) filesep char(thisguy) char('/ROIs_connected_top100/') char(thisguy) filesep char(thisroi) char('_roi.nii')]);  %IF .NII FILE
            R = maroi_image(roi_file);
            else
            roi_file = char([char(roi_file_root) filesep char(thisguy) char('/ROIs_connected_top100/') char(thisguy) filesep char(thisroi) char('_roi.mat')]); %IF .MAT FILE
            R  = maroi(roi_file);	
            end
        elseif roistore ==3
            roi_file = char([char(roi_file_root) filesep char(thisguy) char('/ROIs_connected_top100/') char(thisguy) filesep char(thisroi) char('_roi.img')]); % ROI path
            R = maroi_image(roi_file);
        end

	
    
      % piece together the name of the subject directory containing the SPM.mat file
       % swd = [rootDIR filesep char(subjects(x)) filesep modelDIR];
        %change to the subjects directory
        swd = fullfile(rootDIR,char(thisguy),'ses7_analysis/deweight',PPImodelDIR); 
        cd(swd);

    %try
    spm_name=load(fullfile(swd,'SPM.mat'));
    load('SPM.mat');
    cnames = transpose(SPM.xX.name); %get the condition names	

    % Make marsbar design object
    D  = mardo(spm_name);
   

    % Fetch data into marsbar data object
    Y  = get_marsy(R, D, 'mean');

    % Estimate design on ROI data
    E = estimate(D, Y);

    % get design betas
    B = betas(E);

    %catch
    %    fprintf('Encountered an error for participant %s for ROI %s\n', char(thisguy), char(thisroi));
	
%	B=zeros(1,length(cnames));
 %   end

    C=[];
    %for each condition
    %average the B value across runs
    for c = 1:(numconditions)
        betasum = 0;
        ctr = 0; %count number of betas you've grabbed for this condition. Initialize to zero because we haven't started grabbing them just yet.
        thiscondition = char(nameconditions(c));%get name of the condition as a character array
        for bindex = 1:length(B)
        %go through cnames vector
            betaname = cnames(bindex);
            found = strfind(cnames(bindex), thiscondition); %looking for whether this beta matches thiscondition
            found = length(found{1,1});
            if found > 0 %condition matches
                betasum = betasum + B(bindex); %tack on the beta for this condition, which is a Run1 beta
		ctr = ctr+1; %increment the ctr
		%If you look at the SPM.xX.name vector, you will see that the Run2 entries are 6 entries after
		%the corresponding Run1 entry. That's because there are 6 regressors per condition in the model 
		%betasum = betasum + B(bindex+6); %add on the corresponding Run2 beta, which is 6 entries further on (bindex+6)
		%ctr = ctr+1; %increment the ctr. We grabbed 2 betas, so the counter should now be at 2.                
            end
        end
    
	C(length(C)+1)=betasum/ctr;%store average value for this condition
    end

    C = [str2num(char(thisguy)) C]; %tack on thisguy's subject ID at the beginning of line
    
    cd(writeDIR);
       fmt=['%d\t', repmat('%f\t', 1, (size(C, 2)-1)), '\n'];
       fprintf(fid, fmt, transpose(C));
   % dlmwrite(writefile, C, 'delimiter', '\t', '-append');
    end
    fclose(fid);
end


