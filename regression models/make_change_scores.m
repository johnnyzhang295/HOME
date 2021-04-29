clear all; clear workspace;
load('raw data.mat');
load('baseline data.mat');

%Make into 180 x N table
repeated_baseline = repelem(baseline_data, 12, 1);

%This is just type =  doubles
change_values = raw_data{:,1:17} - repeated_baseline{:,1:17};

%We want them in table format
change_scores = raw_data;
change_scores{:,1:17} = change_values;