%% Code to extract 'total number' of participants who completed Phon and Sem tasks at 2 sessions from Good Data in ELP project.
% Created by AM, May4, 2023 
% MATLAB 2019A

% Open Excel Files. 
filepath = '/gpfs51/dors2/gpc/JamesBooth/JBooth-Lab/BDL/AM_ELP/Conn_PhonSem_AM_7_9/preprocessed';
% Sheet 1 - Excel file consisting of participant details
[num1,txt1,raw1] = xlsread(strcat(filepath,'/','Subject_selection.xlsx'),'P_Details');
% Sheet 2 - Excel sheet with list of good runs - estimated on the basis - Movement and accuracy
[num2,txt2,raw2] = xlsread(strcat(filepath,'/','Subject_selection.xlsx'),'GoodData');

SID = raw1(2:end,1); % Get the subject numbers
TC = raw1(1,13:20); % Get session and task column details 
run = {'run-01'};
% If run is present in sheet 2  then mark 1 in sheet 1 (P_Details)
% columns otherwise mark 0.
for n = 1:length(SID)
    for j = 1:4 % first 4 task conditions for run01
        for r_num = 1:length(run)
sub = SID(n,1);
task = TC(1,j);
task = erase(task,'_run-01');
task = erase(task,'_run-02');
% Generates a logical 
TF1 = startsWith(txt2,strcat(sub,'_',task)); %  Subject and task present
TF2 = contains(txt2(TF1),run(r_num)); % Run Present

A = TF1(:,:) == 1;% find 1s Subject and task present
B = TF1(A); 
C = TF2(B);% logical for run present
c = any(C(:) > 0);
% c = isempty(C); % logical if B is empty
if c==1
  raw1(n+1,12+j) = cellstr('1');
else
  raw1(n+1,12+j) = cellstr('0'); 
end   

         end
    end   
end

run = {'run-02'};
for n = 1:length(SID)
    for j = 5:8 % first 4 task conditions for run02
        for r_num = 1:length(run)
sub = SID(n,1);
task = TC(1,j);
task = erase(task,'_run-01');
task = erase(task,'_run-02');
% Generates a logical 
TF1 = startsWith(txt2,strcat(sub,'_',task)); %  Subject and task present
TF2 = contains(txt2(TF1),run(r_num)); % Run Present

A = TF1(:,:) == 1;% find 1s Subject and task present
B = TF1(A); 
C = TF2(B);% logical for run present
c = any(C(:) > 0);
% c = isempty(C); % logical if B is empty
if c==1
  raw1(n+1,12+j) = cellstr('1');
else
  raw1(n+1,12+j) = cellstr('0'); 
end   

         end
    end   
end

writecell(raw1(:,13:20),'/gpfs51/dors2/gpc/JamesBooth/JBooth-Lab/BDL/AM_ELP/Conn_PhonSem_AM_7_9/preprocessed/Subject_selection.xlsx','Sheet','P_Details','Range','M1:T83');

%%
SID_Phon_Sem_7_9 = {}; % Partticipants who have both good Phon and sem task runs at 7 and 9

for n = 1:length(SID)
if (raw1{n+1,13}=='1') && (raw1{n+1,14}=='1') && (raw1{n+1,15}=='1') && (raw1{n+1,16}=='1') && (raw1{n+1,17}=='1') && (raw1{n+1,18}=='1') && (raw1{n+1,19}=='1') && (raw1{n+1,20}=='1') 
    SID_Phon_Sem_7_9{n,1} = raw1{n+1,1};
end
end
Count_SID_Phon_Sem_7_9=sum(~cellfun(@isempty, SID_Phon_Sem_7_9),2);
N_SID_Phon_Sem_7_9=sum(Count_SID_Phon_Sem_7_9,1);

% Create a list of good runs for good subjects
temp = {}; % LIst 
run = {'run-01';'run-02'};
for r_num = 1:numel(run)
TF2 = contains(txt2,run(r_num)); % RUN present
for n = 1:length(SID_Phon_Sem_7_9)
     sub = SID_Phon_Sem_7_9(n,1);
    for j = 1:4 % first 4 task conditions for run02   
        task = TC(1,j);
        task = erase(task,'_run-01');
        task = erase(task,'_run-02');
        % Generates a logical 
        TF1 = startsWith(txt2,strcat(sub,'_',task));%  Subject and task present
        TF =logical(TF1.*TF2); % Multiply Logicals
        temp = [temp;txt2(TF)];
    end
end   
end



writecell(temp(:,1),'/gpfs51/dors2/gpc/JamesBooth/JBooth-Lab/BDL/AM_ELP/Conn_PhonSem_AM_7_9/preprocessed/Subject_selection.xlsx','Sheet','GoodRuns_Selected');


