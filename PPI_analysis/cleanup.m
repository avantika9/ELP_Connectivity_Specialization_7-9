%%
%this code is for clean up your firstlevel expanded 3d vs6_wtask*.nii
% files if you used my firstlevel analysis code before July 3rd, 2019

global CCN

subjects={'5211' '5341' '5355' '5404' '5405' '5443' '5460' '5475'};

%'5478' '5479' '5482' '5492' '5495'};
%'5224' '5226' '5227' '5237' '5242' '5244' '5250' '5286' '5290' '5295' '5301' '5302' '5304' '5307' '5308' '5310' '5332' '5338' '5344' '5365' '5367'};    
%'5109' '5125' '5126' '5137' '5140' '5141' '5149' '5151' '5157' '5160' '5161' '5162' '5166' '5167' '5169' '5179' '5186' '5187' '5199' '5215'};    
%'5019' '5031' '5032' '5034' '5035' '5043' '5045' '5047' '5048' '5054' '5058' '5065' '5069' '5075' '5077' '5091' '5099' '5102' '5103' '5104'};
%'5163' '5256' '5270' '5274' '5312' '5330' '5342' '5357' '5362' '5369' '5371' '5389' '5435' '5480' '5503' '5005' '5007' '5008' '5009' '5015'};
%'5311' '5393' '5414' '5476' '5496' '5519' '5531' '5011' '5018' '5022' '5025' '5052' '5057' '5070' '5074' '5120' '5121' '5143' '5153' '5158'};
%'5004' '5510' '5033' '5110' '5246' '5334' '5376' '5395' '5010' '5020' '5185' '5194' '5233' '5252' '5258' '5259' '5260' '5300'};
%'5003'
root='/dors/gpc/JamesBooth/JBooth-Lab/BDL/jinwang/ReadingSkill_JW_7-8/preprocessed/';
CCN.session='ses-T1';
CCN.func_pattern='T1*';
CCN.files='vs6_wtask*bold_0*';
addpath(genpath('/dors/gpc/JamesBooth/JBooth-Lab/BDL/jinwang/ReadingSkill_JW_7-8/typical_data_analysis'));

for i=1:length(subjects)
    CCN.functional_f=[root subjects{i} '/[session]/func/[func_pattern]/[files]'];
    functional_files=expand_path(CCN.functional_f);
    for d=1:length(functional_files)
        delete(functional_files{d});
    end
end
