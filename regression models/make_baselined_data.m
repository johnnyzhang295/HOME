clear all; clear workspace;
load('raw data.mat');
load('rsp_baseline.mat')
load('ekg_baseline.mat')
load('ekg_experiment.mat');


%% Fix old data cause ur so stupid
% r201 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part201\RSP data by trial.csv');
% r202 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part202\RSP data by trial.csv');
% r203 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part203\RSP data by trial.csv');
% r204 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part204\RSP data by trial.csv');
% r205 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part205\RSP data by trial.csv');
% r206 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part206\RSP data by trial.csv');
% r207 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part207\RSP data by trial.csv');
% r208 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part208\RSP data by trial.csv');
% r209 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part209\RSP data by trial.csv');
% r210 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part210\RSP data by trial.csv');
% r211 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part211\RSP data by trial.csv');
% r212 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part212\RSP data by trial.csv');
% r213 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part213\RSP data by trial.csv');
% r214 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part214\RSP data by trial.csv');
% r215 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part215\RSP data by trial.csv');
% 
% r201 = r201(1:2:end,:);
% r202 = r202(1:2:end,:);
% r203 = r203(1:2:end,:);
% r204 = r204(1:2:end,:);
% r205 = r205(1:2:end,:);
% r206 = r206(1:2:end,:);
% r207 = r207(1:2:end,:);
% r208 = r208(1:2:end,:);
% r209 = r209(1:2:end,:);
% r210 = r210(1:2:end,:);
% r211 = r211(1:2:end,:);
% r212 = r212(1:2:end,:);
% r213 = r213(1:2:end,:);
% r214 = r214(1:2:end,:);
% r215 = r215(1:2:end,:);
% 
% rsp = [r201; r202; r203; r204; r205; r206; r207; r208; r209; r210; r211; r212; r213; r214; r215;];


% Fix old data
% data{:,'RspAmp'} = rsp(:,3);
% data{:,'RspRate'} = rsp(:,4);

% Add RMSSD Cause you are stupid
%data = addvars(data,ekg_exptable{:,'HRV_RMSSD'},'After','HR');
%data.Properties.VariableNames{'Var2'} = 'RMSSD';

%save('raw data.mat','data');

%% subtract out baseline
%EKG Features
ekg_features_baseline_index = [1 2 4 12];
ekg_features_baseline = ekg_table(:,ekg_features_baseline_index);
ekg_features_baseline = ...
[repmat(ekg_table(1,ekg_features_baseline_index),[12,1]);
 repmat(ekg_table(2,ekg_features_baseline_index),[12,1]);
 repmat(ekg_table(3,ekg_features_baseline_index),[12,1]);
 repmat(ekg_table(4,ekg_features_baseline_index),[12,1]);
 repmat(ekg_table(5,ekg_features_baseline_index),[12,1]);
 repmat(ekg_table(6,ekg_features_baseline_index),[12,1]);
 repmat(ekg_table(7,ekg_features_baseline_index),[12,1]);
 repmat(ekg_table(8,ekg_features_baseline_index),[12,1]);
 repmat(ekg_table(9,ekg_features_baseline_index),[12,1]);
 repmat(ekg_table(10,ekg_features_baseline_index),[12,1]);
 repmat(ekg_table(11,ekg_features_baseline_index),[12,1]);
 repmat(ekg_table(12,ekg_features_baseline_index),[12,1]);
 repmat(ekg_table(13,ekg_features_baseline_index),[12,1]);
 repmat(ekg_table(14,ekg_features_baseline_index),[12,1]);
 repmat(ekg_table(15,ekg_features_baseline_index),[12,1]);
];
raw_data{:,1:length(ekg_features_baseline_index)} - ekg_features_baseline{:,:};

%RSP Features
rsp_features_baseline_index = [3 4];
rsp_features_baseline = rsp_table(:,rsp_features_baseline_index);
rsp_features_baseline = ...
[repmat(rsp_table(1,rsp_features_baseline_index),[12,1]);
 repmat(rsp_table(2,rsp_features_baseline_index),[12,1]);
 repmat(rsp_table(3,rsp_features_baseline_index),[12,1]);
 repmat(rsp_table(4,rsp_features_baseline_index),[12,1]);
 repmat(rsp_table(5,rsp_features_baseline_index),[12,1]);
 repmat(rsp_table(6,rsp_features_baseline_index),[12,1]);
 repmat(rsp_table(7,rsp_features_baseline_index),[12,1]);
 repmat(rsp_table(8,rsp_features_baseline_index),[12,1]);
 repmat(rsp_table(9,rsp_features_baseline_index),[12,1]);
 repmat(rsp_table(10,rsp_features_baseline_index),[12,1]);
 repmat(rsp_table(11,rsp_features_baseline_index),[12,1]);
 repmat(rsp_table(12,rsp_features_baseline_index),[12,1]);
 repmat(rsp_table(13,rsp_features_baseline_index),[12,1]);
 repmat(rsp_table(14,rsp_features_baseline_index),[12,1]);
 repmat(rsp_table(15,rsp_features_baseline_index),[12,1]);
];
raw_data{:,5:6} - rsp_features_baseline{:,:};

baselined_data = raw_data;
baselined_data{:,1:4} = raw_data{:,1:length(ekg_features_baseline_index)} - ekg_features_baseline{:,:};
baselined_data{:,5:6} = raw_data{:,5:6} - rsp_features_baseline{:,:};

%save('baselined data.mat','baselined_data');

%% Make baseline data set

control_features = [ekg_table(:,ekg_features_baseline_index) rsp_table(:,rsp_features_baseline_index)]
%save('control data.mat', 'control_features');


%% Make normalized data
control_means = mean(control_features{:,:}, 1);
control_stddev = std(control_features{:,:}); %For some reason, you don't use dim =1 here.

% do a z-transform on raw data EKG, RSP data using control (baseline)
% mean/stddev
% TODO: Make sure indexing is right
raw_features = raw_data(:, 1:6);
z_transform_data = (raw_features{:,:} - control_means)./control_stddev;

% Do a z-transform on raw EYE data using low WL mean/stddev
eye_raw = raw_data(:,[7 8 12]);
lowTL_eye_raw = eye_raw(eye_raw{:,3} == 2, [1 2]);
lowTL_eye_means = mean(lowTL_eye_raw{:,:},1);
lowTL_eye_stddev = std(lowTL_eye_raw{:,:});

z_eye = (eye_raw{:,1:2} - lowTL_eye_means)./lowTL_eye_stddev;

%%
normalized_data = raw_data;
normalized_data{:,1:6} = z_transform_data;
normalized_data{:,7:8} = z_eye;
%save('normalized data.mat', 'normalized_data');