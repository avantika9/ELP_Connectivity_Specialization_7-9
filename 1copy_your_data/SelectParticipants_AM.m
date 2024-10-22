%% Code to extract 'total number' of participants who completed different tasks at 2 sessions from ELP project.
% Give paticipant details and number for paticipants who have completed tasks at 5 and 7. tasks at 7 and 9. 
% Created by AM, May4, 2023

% Open Excel File. 

filepath = '/Users/avantika/Box/BDL/Member_Folders/Avantika/05ELP_Project';
[num1,txt1,raw1] = xlsread(strcat(filepath,'/','P_Details.xlsx'),'ParticipantDetails_ST');
[num2,txt2,raw2] = xlsread(strcat(filepath,'/','P_Details.xlsx'),'InScan');

SID = raw1(2:end,1); % Get the subject numbers
TC = raw1(1,13:24); % Get session and task column details 

% If subId_task string is present in sheet 2 ('Inscan') then mark 1 in sheet 1 (ParticipantDetails_ST)
% columns otherwise mark 0.
for n = 1:length(SID)
    for j = 1:length(TC)
sub = SID(n,1);
task = TC(1,j);

% Generates a logical 
TF = startsWith(txt2,strcat(sub,'_',task));

A = TF(:,:) == 1;% find 1
B = TF(A);
c = isempty(B); % logical if B is empty

if c==0
  raw1(n+1,12+j) = cellstr('1');
else
  raw1(n+1,12+j) = cellstr('0'); 
end   

    end
end    

%writecell(raw1,strcat(filepath,'PDetails.xls'))

%%
SID_Phon_5_7 = {}; % Partticipants who completed Phon task at 5 and 7

for n = 1:length(SID)
if (raw1{n+1,13}=='1') && (raw1{n+1,14}=='1')
    SID_Phon_5_7{n,1} = raw1{n+1,1};
end
end
Count_SID_Phon_5_7=sum(~cellfun(@isempty,SID_Phon_5_7),2);
N_SID_Phon_5_7=sum(Count_SID_Phon_5_7,1);


SID_Phon_7_9 = {}; % Partticipants who completed Phon task at 7 and 9

for n = 1:length(SID)
if (raw1{n+1,14}=='1') && (raw1{n+1,15}=='1')
    SID_Phon_7_9{n,1} = raw1{n+1,1};
end
end
Count_SID_Phon_7_9=sum(~cellfun(@isempty,SID_Phon_7_9),2);
N_SID_Phon_7_9=sum(Count_SID_Phon_7_9,1);

SID_Phon_5_7_9 = {}; % Partticipants who completed Phon task at 5 and 7 and 9

for n = 1:length(SID)
if (raw1{n+1,13}=='1') && (raw1{n+1,14}=='1') && (raw1{n+1,15}=='1')
    SID_Phon_5_7_9{n,1} = raw1{n+1,1};
end
end
Count_SID_Phon_5_7_9=sum(~cellfun(@isempty,SID_Phon_5_7_9),2);
N_SID_Phon_5_7_9=sum(Count_SID_Phon_5_7_9,1);
%%
SID_Sem_5_7 = {}; % Partticipants who completed Phon task at 5 and 7

for n = 1:length(SID)
if (raw1{n+1,16}=='1') && (raw1{n+1,17}=='1')
    SID_Sem_5_7{n,1} = raw1{n+1,1};
end
end
Count_SID_Sem_5_7=sum(~cellfun(@isempty,SID_Sem_5_7),2);
N_SID_Sem_5_7=sum(Count_SID_Sem_5_7,1);


SID_Sem_7_9 = {}; % Partticipants who completed Phon task at 7 and 9

for n = 1:length(SID)
if (raw1{n+1,17}=='1') && (raw1{n+1,18}=='1')
    SID_Sem_7_9{n,1} = raw1{n+1,1};
end
end
Count_SID_Sem_7_9=sum(~cellfun(@isempty,SID_Sem_7_9),2);
N_SID_Sem_7_9=sum(Count_SID_Sem_7_9,1);

SID_Sem_5_7_9 = {}; % Partticipants who completed Phon task at 5 and 7 and 9

for n = 1:length(SID)
if (raw1{n+1,16}=='1') && (raw1{n+1,17}=='1') && (raw1{n+1,18}=='1')
    SID_Sem_5_7_9{n,1} = raw1{n+1,1};
end
end
Count_SID_Sem_5_7_9=sum(~cellfun(@isempty,SID_Sem_5_7_9),2);
N_SID_Sem_5_7_9=sum(Count_SID_Sem_5_7_9,1);

%%
SID_Gram_5_7 = {}; % Partticipants who completed Phon task at 5 and 7

for n = 1:length(SID)
if (raw1{n+1,19}=='1') && (raw1{n+1,20}=='1')
    SID_Gram_5_7{n,1} = raw1{n+1,1};
end
end
Count_SID_Gram_5_7=sum(~cellfun(@isempty,SID_Gram_5_7),2);
N_SID_Gram_5_7=sum(Count_SID_Gram_5_7,1);


SID_Gram_7_9 = {}; % Partticipants who completed Phon task at 7 and 9

for n = 1:length(SID)
if (raw1{n+1,20}=='1') && (raw1{n+1,21}=='1')
    SID_Gram_7_9{n,1} = raw1{n+1,1};
end
end
Count_SID_Gram_7_9=sum(~cellfun(@isempty,SID_Gram_7_9),2);
N_SID_Gram_7_9=sum(Count_SID_Gram_7_9,1);

SID_Gram_5_7_9 = {}; % Partticipants who completed Phon task at 5 and 7 and 9

for n = 1:length(SID)
if (raw1{n+1,19}=='1') && (raw1{n+1,20}=='1') && (raw1{n+1,21}=='1')
    SID_Gram_5_7_9{n,1} = raw1{n+1,1};
end
end
Count_SID_Gram_5_7_9=sum(~cellfun(@isempty,SID_Gram_5_7_9),2);
N_SID_Gram_5_7_9=sum(Count_SID_Gram_5_7_9,1);

%%
SID_Plaus_5_7 = {}; % Partticipants who completed Phon task at 5 and 7

for n = 1:length(SID)
if (raw1{n+1,22}=='1') && (raw1{n+1,23}=='1')
    SID_Plaus_5_7{n,1} = raw1{n+1,1};
end
end
Count_SID_Plaus_5_7=sum(~cellfun(@isempty,SID_Plaus_5_7),2);
N_SID_Plaus_5_7=sum(Count_SID_Plaus_5_7,1);


SID_Plaus_7_9 = {}; % Partticipants who completed Phon task at 7 and 9

for n = 1:length(SID)
if (raw1{n+1,23}=='1') && (raw1{n+1,24}=='1')
    SID_Plaus_7_9{n,1} = raw1{n+1,1};
end
end
Count_SID_Plaus_7_9=sum(~cellfun(@isempty,SID_Plaus_7_9),2);
N_SID_Plaus_7_9=sum(Count_SID_Plaus_7_9,1);

SID_Plaus_5_7_9 = {}; % Partticipants who completed Phon task at 5 and 7 and 9

for n = 1:length(SID)
if (raw1{n+1,22}=='1') && (raw1{n+1,23}=='1') && (raw1{n+1,24}=='1')
    SID_Plaus_5_7_9{n,1} = raw1{n+1,1};
end
end
Count_SID_Plaus_5_7_9=sum(~cellfun(@isempty,SID_Plaus_5_7_9),2);
N_SID_Plaus_5_7_9=sum(Count_SID_Plaus_5_7_9,1);

%%
writecell(raw1(:,13:24),'/Users/avantika/Box/BDL/Member_Folders/Avantika/05ELP_Project/P_Details.xlsx','Sheet',1,'Range','M1:X323')
writecell(SID_Phon_5_7,'/Users/avantika/Box/BDL/Member_Folders/Avantika/05ELP_Project/P_Details.xlsx','Sheet',1,'Range','Y2:Y323')
writecell(SID_Phon_7_9,'/Users/avantika/Box/BDL/Member_Folders/Avantika/05ELP_Project/P_Details.xlsx','Sheet',1,'Range','Z2:Z323')
writecell(SID_Phon_5_7_9,'/Users/avantika/Box/BDL/Member_Folders/Avantika/05ELP_Project/P_Details.xlsx','Sheet',1,'Range','AA2:AA323')

writecell(SID_Sem_5_7,'/Users/avantika/Box/BDL/Member_Folders/Avantika/05ELP_Project/P_Details.xlsx','Sheet',1,'Range','AB2:AB323')
writecell(SID_Sem_7_9,'/Users/avantika/Box/BDL/Member_Folders/Avantika/05ELP_Project/P_Details.xlsx','Sheet',1,'Range','AC2:AC323')
writecell(SID_Sem_5_7_9,'/Users/avantika/Box/BDL/Member_Folders/Avantika/05ELP_Project/P_Details.xlsx','Sheet',1,'Range','AD2:AD323')

writecell(SID_Gram_5_7,'/Users/avantika/Box/BDL/Member_Folders/Avantika/05ELP_Project/P_Details.xlsx','Sheet',1,'Range','AE2:AE323')
writecell(SID_Gram_7_9,'/Users/avantika/Box/BDL/Member_Folders/Avantika/05ELP_Project/P_Details.xlsx','Sheet',1,'Range','AF2:AF323')
writecell(SID_Gram_5_7_9,'/Users/avantika/Box/BDL/Member_Folders/Avantika/05ELP_Project/P_Details.xlsx','Sheet',1,'Range','AG2:AG323')

writecell(SID_Plaus_5_7,'/Users/avantika/Box/BDL/Member_Folders/Avantika/05ELP_Project/P_Details.xlsx','Sheet',1,'Range','AH2:AH323')
writecell(SID_Plaus_7_9,'/Users/avantika/Box/BDL/Member_Folders/Avantika/05ELP_Project/P_Details.xlsx','Sheet',1,'Range','AI2:AI323')
writecell(SID_Plaus_5_7_9,'/Users/avantika/Box/BDL/Member_Folders/Avantika/05ELP_Project/P_Details.xlsx','Sheet',1,'Range','AJ2:AJ323')
