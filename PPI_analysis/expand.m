  %%
%this code is for expanding the 3d vs6_wtask*.nii
%files if you used my firstlevel analysis code before July 3rd, 2019
%This is used before getbetas. Otherwise getbetas will fail.

global CCN

subjects={'5004' '5005' '5007' '5008' '5009' '5010' '5011' '5015' '5018' '5020' '5022' '5023' '5024' '5025' '5029' '5031' '5032' '5033' '5034' '5040' '5043' '5045' '5047' '5048' '5054' '5055' '5057' '5058' '5065' '5069' '5070' '5074' '5075' '5077' '5091' '5094' '5099' '5102' '5103' '5104' '5109' '5110' '5120' '5121' '5125' '5126' '5136' '5137' '5139' '5140' '5141' '5143' '5149' '5151' '5153' '5154' '5157' '5158' '5159' '5160' '5161' '5162' '5163' '5166' '5167' '5173' '5179' '5185' '5186' '5194' '5199' '5201' '5211' '5215' '5216' '5224' '5226' '5231' '5233' '5242' '5244' '5250' '5252' '5258' '5259' '5260' '5274' '5286' '5295' '5300' '5302' '5304' '5307' '5308' '5311' '5317' '5330' '5332' '5334' '5338' '5342' '5344' '5355' '5357' '5365' '5367' '5369' '5371' '5374' '5378' '5379' '5388' '5389' '5391' '5393' '5400' '5404' '5406' '5414' '5417' '5430' '5438' '5439' '5443' '5445' '5448' '5452' '5457' '5460' '5463' '5468' '5474' '5475' '5478' '5479' '5480' '5492' '5495' '5508' '5510' '5526'}; % your subjects

%'5003'
root='/dors/gpc/JamesBooth/JBooth-Lab/BDL/jinwang/ReadingSkill_JW_7-8/preprocessed/';
CCN.session='ses-T1';
CCN.func_pattern='T1*';
CCN.files='vs6_wtask*bold.nii';
addpath(genpath('/dors/gpc/JamesBooth/JBooth-Lab/BDL/LabCode/typical_data_analysis/preprocessing/fmri_preproc/generic_mni/nifti_tools'));

for i=1:length(subjects)
    CCN.functional_f=[root subjects{i} '/[session]/func/[func_pattern]/[files]'];
    functional_files=expand_path(CCN.functional_f);
    for d=1:length(functional_files)
        hdr = load_nii_hdr( char(functional_files{d}) );
        nscan = hdr.dime.dim(5);
        expand_nii_scan(char(functional_files{d}),1:nscan)
    end
end
