clear all;
clear workspace;

%This file is generated from eye/workload modeling
load('raw data.mat');

phys_measures = data{:,1:5};

scn_data = [zeros(180,5)];
individ_phys = {};
j=1;
for i=(1:12:180)
    individ_phys(j,1) = {normalize(phys_measures(i:i+11,:))};
    
    scn_data(i:i+11,:) = individ_phys{j,1};
    
    j=j+1;
    
end

data{:,1:5} = scn_data;
%save('scaled centered data.mat');


