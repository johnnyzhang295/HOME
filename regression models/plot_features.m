clear all; clear workspace;
load('raw data.mat');
load('rsp_baseline.mat')
load('ekg_baseline.mat')
load('ekg_experiment.mat');

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

baseline = [ekg_features_baseline rsp_features_baseline];

change_scores = abs(raw_data{:,1:6} - baseline{:,:});

std_exp = [];
mean_exp = [];
std_sart = [];
mean_sart =[];

std_wl = [];
mean_wl = [];
j = 1;
for i=(1:12:180)
    std_exp(j,:) = std((change_scores(i:i+11,1:6)));
    mean_exp(j,:) = mean((change_scores(i:i+11,1:6)));
    
    std_sart(j,:) = std(raw_data{i:i+11, 14});
    
    mean_sart(j,:) = mean(raw_data{i:i+11, 14});
    
        std_wl(j,:) = std(raw_data{i:i+11, 15});
    
    mean_wl(j,:) = mean(raw_data{i:i+11, 15});
    
    j = j+1;
end

coeffs = std_exp./mean_exp;
coeffs_sart = std_sart./mean_sart;

coeffs_wl = std_wl ./ mean_wl;

corr_coefs = [coeffs coeffs_sart];

std_changescore_eye = [];
change_scores_eye = [];
mean_changescore_eye = [];
j = 1;

for i = (1:12:180)
    med_dia = median(raw_data.MeanPupilDiameter(i:i+11));
    med_bc = median(raw_data.BlinkCount(i:i+11));
    change_scores_eye(i:i+11,1) = abs(raw_data.MeanPupilDiameter(i:i+11) - med_dia);
    change_scores_eye(i:i+11,2) = abs(raw_data.BlinkCount(i:i+11) - med_bc);
    
    std_changescore_eye(j,:) = std(change_scores_eye(i:i+11,:));
    mean_changescore_eye(j,:) = mean(change_scores_eye(i:i+11,:));
    
    j = j + 1;
end


CV_eye = std_changescore_eye ./ mean_changescore_eye;

%% Plots
figure;
subplot(3,2,1)
scatter(coeffs(:,1), coeffs_sart)
ylim([0 1.5])
xlim([0 1.5])
yticks(0:.25:1.5)
xticks(0:.25:1.5)
grid on;
grid minor;
xlabel('CV \DeltaHR');
ylabel('CV Raw SART');
title('CV Correlation for \DeltaHR, SART');

subplot(3,2,2)
scatter(coeffs(:,2), coeffs_sart)
ylim([0 1.5])
xlim([0 1.5])
yticks(0:.25:1.5)
xticks(0:.25:1.5)
grid on;
grid minor;
xlabel('CV \DeltaRMSSD');
ylabel('CV Raw SART');
title('CV Correlation for \DeltaRMSSD, SART');

subplot(3,2,3)
scatter(coeffs(:,3), coeffs_sart)
ylim([0 1.5])
xlim([0 1.5])
yticks(0:.25:1.5)
xticks(0:.25:1.5)
grid on;
grid minor;
xlabel('CV \DeltaSDNN');
ylabel('CV Raw SART');
title('CV Correlation for \DeltaSDNN, SART');

subplot(3,2,4)
scatter(coeffs(:,4), coeffs_sart)
ylim([0 1.5])
xlim([0 1.5])
yticks(0:.25:1.5)
xticks(0:.25:1.5)
grid on;
grid minor;
xlabel('CV \DeltapNN50');
ylabel('CV Raw SART');
title('CV Correlation for \DeltapNN50, SART');

subplot(3,2,5)
scatter(coeffs(:,5), coeffs_sart)
ylim([0 1.5])
xlim([0 1.5])
yticks(0:.25:1.5)
xticks(0:.25:1.5)
grid on;
grid minor;
xlabel('CV \DeltaRspAmp');
ylabel('CV Raw SART');
title('CV Correlation for \DeltaRspAmp, SART');

subplot(3,2,6)
scatter(coeffs(:,6), coeffs_sart)
ylim([0 1.5])
xlim([0 1.5])
yticks(0:.25:1.5)
xticks(0:.25:1.5)
grid on;
grid minor;
xlabel('CV \DeltaRspRate');
ylabel('CV Raw SART');
title('CV Correlation for \DeltaRspRate, SART');

%% Plot 2
figure;
subplot(3,2,1)
scatter(coeffs(:,1), coeffs_wl)
ylim([0 1.5])
xlim([0 1.5])
yticks(0:.25:1.5)
xticks(0:.25:1.5)
grid on;
grid minor;
xlabel('CV \DeltaHR');
ylabel('CV Raw Workload');
title('CV Correlation for \DeltaHR, Workload');

subplot(3,2,2)
scatter(coeffs(:,2), coeffs_wl)
ylim([0 1.5])
xlim([0 1.5])
yticks(0:.25:1.5)
xticks(0:.25:1.5)
grid on;
grid minor;
xlabel('CV \DeltaRMSSD');
ylabel('CV Raw Workload');
title('CV Correlation for \DeltaRMSSD, Workload');

subplot(3,2,3)
scatter(coeffs(:,3), coeffs_wl)
ylim([0 1.5])
xlim([0 1.5])
yticks(0:.25:1.5)
xticks(0:.25:1.5)
grid on;
grid minor;
xlabel('CV \DeltaSDNN');
ylabel('CV Raw Workload');
title('CV Correlation for \DeltaSDNN, Workload');

subplot(3,2,4)
scatter(coeffs(:,4), coeffs_wl)
ylim([0 1.5])
xlim([0 1.5])
yticks(0:.25:1.5)
xticks(0:.25:1.5)
grid on;
grid minor;
xlabel('CV \DeltapNN50');
ylabel('CV Raw Workload');
title('CV Correlation for \DeltapNN50, Workload');

subplot(3,2,5)
scatter(coeffs(:,5), coeffs_wl)
ylim([0 1.5])
xlim([0 1.5])
yticks(0:.25:1.5)
xticks(0:.25:1.5)
grid on;
grid minor;
xlabel('CV \DeltaRspAmp');
ylabel('CV Raw Workload');
title('CV Correlation for \DeltaRspAmp, Workload');

subplot(3,2,6)
scatter(coeffs(:,6), coeffs_wl)
ylim([0 1.5])
xlim([0 1.5])
yticks(0:.25:1.5)
xticks(0:.25:1.5)
grid on;
grid minor;
xlabel('CV \DeltaRspRate');
ylabel('CV Raw Workload');
title('CV Correlation for \DeltaRspRate, Workload');


% 
% 
% gscatter(baseline{:,2}, change_scores(:,2), raw_data.ID)
% %mdl = fitlm(baseline.ECG_Rate_Mean, change_scores(:,1));
% %plot(mdl)
% xlabel('Baseline RMSSD');
% ylabel('Change Score');
% title('RMSSD Change Score Residual Plot');
% 
% figure;
% gscatter(baseline{:,3}, change_scores(:,3), raw_data.ID)
% %mdl = fitlm(baseline.ECG_Rate_Mean, change_scores(:,1));
% %plot(mdl)
% xlabel('Baseline SDNN');
% ylabel('Change Score');
% title('SDNN Change Score Residual Plot');
% 
% figure;
% gscatter(baseline{:,4}, change_scores(:,4), raw_data.ID)
% %mdl = fitlm(baseline.ECG_Rate_Mean, change_scores(:,1));
% %plot(mdl)
% xlabel('Baseline pNN50');
% ylabel('Change Score');
% title('pNN50 Change Score Residual Plot');
% 
% figure;
% gscatter(baseline{:,5}, change_scores(:,5), raw_data.ID)
% %mdl = fitlm(baseline.ECG_Rate_Mean, change_scores(:,1));
% %plot(mdl)
% xlabel('Baseline Rsp Amp');
% ylabel('Change Score');
% title('Rsp Amp Change Score Residual Plot');
% 
% figure
% gscatter(baseline{:,6}, change_scores(:,6), raw_data.ID)
% %mdl = fitlm(baseline.ECG_Rate_Mean, change_scores(:,1));
% %plot(mdl)
% xlabel('Baseline Rsp Rate');
% ylabel('Change Score');
% title('Rsp Rate Change Score Residual Plot');
% 
% close('all');
% 

%% Plot 3 
figure;
subplot(2,1,1)
scatter(CV_eye(:,1), coeffs_wl)
ylim([0 1.5])
xlim([0 1.5])
yticks(0:.25:1.5)
xticks(0:.25:1.5)
grid on;
grid minor;
xlabel('CV \DeltaPupil Diameter');
ylabel('CV Raw Workload');
title('CV Correlation for \DeltaPupil Diameter, Workload');

subplot(2,1,2)
scatter(CV_eye(:,2), coeffs_wl)
ylim([0 1.5])
xlim([0 1.5])
yticks(0:.25:1.5)
xticks(0:.25:1.5)
grid on;
grid minor;
xlabel('CV \DeltaBlink Count');
ylabel('CV Raw Workload');
title('CV Correlation for \DeltaBlink Count, Workload');

figure;
subplot(2,1,1)
scatter(CV_eye(:,1), coeffs_sart)
ylim([0 1.5])
xlim([0 1.5])
yticks(0:.25:1.5)
xticks(0:.25:1.5)
grid on;
grid minor;
xlabel('CV \DeltaPupil Diameter');
ylabel('CV Raw SART');
title('CV Correlation for \DeltaPupil Diameter, SART');

subplot(2,1,2)
scatter(CV_eye(:,2), coeffs_sart)
ylim([0 1.5])
xlim([0 1.5])
yticks(0:.25:1.5)
xticks(0:.25:1.5)
grid on;
grid minor;
xlabel('CV \DeltaBlink Count');
ylabel('CV Raw SART');
title('CV Correlation for \DeltaBlink Count, SART');