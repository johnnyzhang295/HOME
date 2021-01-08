clear all;
clear workspace;


raw = load('raw data.mat');

normalized = load('normalized data.mat');

sc_raw = load('scaled centered data.mat');

sc_norm = load('scaled centered normalized data.mat');


fig = figure('units','normalized','outerposition',[0 0 1 1]);
histogram(raw.data{:,1:7});    
xlabel('Value');
ylabel('Count');
title('Raw Data Histogram');


figure('units','normalized','outerposition',[0 0 1 1]);

normalized.data{157:168,1:5} = 0;
sc_norm.data{157:168,1:5} = 0;

histogram(normalized.data{:,1:5});
xlabel('Value');
ylabel('Count');
title('Baselined Data Histogram');

figure('units','normalized','outerposition',[0 0 1 1]);
histogram(sc_raw.data{:,1:7});
xlabel('Value');
ylabel('Count');
title('Scaled and Centered RAW Data Histogram');

figure('units','normalized','outerposition',[0 0 1 1]);
histogram(sc_norm.data{:,1:8});
xlabel('Value');
ylabel('Count');
title('Scaled and Centered and Baselined Data Histogram');