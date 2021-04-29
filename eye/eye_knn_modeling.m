%%  Load and Setup data

clear workspace;
clear all;

ColOrd = [0.634197879289704,0.598590500684565,0.335478586307354;0.141323291186943,0.668487146264776,0.619568612502970;0.0793022450665238,0.894564090918275,0.992885717464124;0.876145347529076,0.0873355239070054,0.648005694952403;0.420428701240150,0.539010349313424,0.539775820318468;0.487663607210372,0.428449936007297,0.232254753050780;0.460325494339181,0.617153494459035,0.739832227063707;0.515677249607505,0.558875876956837,0.888992345152850;0.271994390193763,0.225850688199737,0.859807625912606;0.231579838051303,0.104519529950634,0.597060788610351;0.899534076872039,0.00997765604969036,0.654752143480193;0.908697326644413,0.0591533040753343,0.915013993756726;0.603642852234244,0.322652370507717,0.433183080639157;0.365236483082946,0.779476506848221,0.289760755842240;0.634197879289704,0.598590500684565,0.335478586307354];
workload = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\support\Workload.csv');
taskload = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\support\taskload settings.csv');
sart = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\support\SARTScores.txt');
sex_age = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\support\sex_age.txt');
trial_order = (1:12)';
filepath = 'C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part';

data_types = {'double','double','double','double',...
    'double','double','double','double',...
    'double','double','categorical','double','double'};
data_names = {'Taskload','TrialOrder','HR','SDNN','pNN50',...
    'RspAmp','RspRate','Age','Sex',...
    'PupilDiameter','ID','SART','Workload'};
data = table('Size',[24 13],'VariableTypes',data_types,'VariableNames',data_names);

ecg_feature_indexes = [1 4 12];
ind = 1;
counter = 1;
for id=201:215
   id = string(id); 
   %Process ECG
   raw_ecg_features = load(strcat(filepath,id,'\Time Based HRV Analyses By Trial.csv'));
   baseline_ecg_features = load(strcat(filepath,id,'\Baseline Time Based HRV Analyses By Trial.csv'));
   normalized_ecg_features = raw_ecg_features ./ baseline_ecg_features;
   normalized_ecg_features = normalized_ecg_features(:,ecg_feature_indexes);
   %Process RSP
   raw_rsp_features = load(strcat(filepath,id,'\RSP data by trial.csv'));
   baseline_rsp_features = load(strcat(filepath,id,'\RSP baseline.csv'));
   normalized_rsp_features = raw_rsp_features(:,1:8)/baseline_rsp_features;
   normalized_rsp_features = normalized_rsp_features(1:2:end,:);
   %Process EYE
   raw_eye_features = load(strcat(filepath,id,'\eye_features_pilot_interval_summary_table.mat'));
   
   
   data.HR(ind:ind+11) = normalized_ecg_features(:,1);
   data.SDNN(ind:ind+11) = normalized_ecg_features(:,2);
   data.pNN50(ind:ind+11) = normalized_ecg_features(:,3);
   data.RspAmp(ind:ind+11) = normalized_rsp_features(:,1);
   data.RspRate(ind:ind+11) = normalized_rsp_features(:,2);
   data.PupilDiameter(ind:ind+11) = raw_eye_features.summary_table.Median;
   data.BlinkCount(ind:ind+11) = raw_eye_features.summary_table.("Blink Count");
   data.Workload(ind:ind+11) = workload(1:end,counter);
   data.Taskload(ind:ind+11) = taskload(counter,:)';
   data.TrialOrder(ind:ind+11) = trial_order;
   data.ID(ind:ind+11) = categorical(repmat(id,[12 1]));
   data.SART(ind:ind+11) = sart(ind:ind+11);
   data.Age(ind:ind+11) = repmat(sex_age(counter,2), [12 1]);
   data.Sex(ind:ind+11) = (repmat(sex_age(counter,1), [12 1]));
   
   
   ind = ind + 12; %still a very hacky way of getting this done
   counter = counter + 1; %yes very hacky indeed
end
 
predictor_data = data(1:180,1:10); %Don't include col 12 which is ID
response_data = data(1:180,12:13);

mdl = KDTreeSearcher(predictor_data{:,:});


newpoint = data{165,1:10};
[n,d] = knnsearch(mdl,newpoint,'k',10);
tabulate(data.Workload(n))
tabulate(data.SART(n))
