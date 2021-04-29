clear all;
load fisheriris
sp = categorical(species);
[B,dev,stats] = mnrfit(meas,sp)


load('raw data.mat');

wl = categorical(raw_data.Workload)
wl = categorical(wl,{'1','2','3','4','5','6','7','8','9','10'},'Ordinal',true);

[B,dev,stats] = mnrfit(raw_data{:,1:19},wl,'model','ordinal');