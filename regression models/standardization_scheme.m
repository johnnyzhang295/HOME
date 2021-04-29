clear all;
clear workspace;

load('raw data.mat');
load('baseline data.mat');

baseline_HR = baselined_data.ECG_Rate_mean;

HR = raw_data.ECG_Rate_Mean;

b_201 = baseline_HR(1);

HR_201 = HR(1:12);
