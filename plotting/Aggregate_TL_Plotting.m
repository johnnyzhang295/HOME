clear all;
clear workspace;
p213 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part213\HRV_HFn.csv');
p201 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part201\HRV_HFn.csv');
p202 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part202\HRV_HFn.csv');
p203 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part203\HRV_HFn.csv');
p208 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part208\HRV_HFn.csv');
p211 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part211\HRV_HFn.csv');
taskload = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\support\taskload settings\taskload settings.csv');
tl_201 = taskload(1,:)';
tl_202 = taskload(2,:)';
tl_203 = taskload(3,:)';
tl_208 = taskload(8,:)';
tl_211 = taskload(11,:)';
tl_213 = taskload(13,:)';

data_index = 4;

HFn_201 = p201(:,data_index);
HFn_202 = p202(:,data_index);
HFn_203 = p203(:,data_index);
HFn_208 = p208(:,data_index);
HFn_211 = p211(:,data_index);
HFn_213 = p213(:,data_index);

low_213 = mean(HFn_213(1:4));
med_213 = mean(HFn_213(5:8));
hi_213 = mean(HFn_213(9:12));

low_201 = mean(HFn_201(1:4));
med_201 = mean(HFn_201(5:8));
hi_201 = mean(HFn_201(9:12));

low_202 = mean(HFn_202(1:4));
med_202 = mean(HFn_202(5:8));
hi_202 = mean(HFn_202(9:12));

low_203 = mean(HFn_203(1:4));
med_203 = mean(HFn_203(5:8));
hi_203 = mean(HFn_203(9:12));

low_211 = mean(HFn_211(1:4));
med_211 = mean(HFn_211(5:8));
hi_211 = mean(HFn_211(9:12));

low_208 = mean(HFn_208(1:4));
med_208 = mean(HFn_208(5:8));
hi_208 = mean(HFn_208(9:12));

tls = ['Low TL','Medium TL', 'High TL'];
tlx = [1,2,3];
y=[mean([low_213,low_211,low_201,low_202,low_203,low_208]),...
    mean([med_213,med_211,med_201,med_202,med_203,med_208]),...
    mean([hi_213,hi_211,hi_201,hi_202,hi_203,hi_208])];

e1 = [HFn_213(1:4);HFn_211(1:4);HFn_201(1:4);HFn_202(1:4);HFn_203(1:4);HFn_208(1:4)];
e2 = [HFn_213(5:8);HFn_211(5:8);HFn_201(5:8);HFn_202(5:8);HFn_203(5:8);HFn_208(5:8)];
e3 = [HFn_213(9:12);HFn_211(9:12);HFn_201(9:12);HFn_202(9:12);HFn_203(9:12);HFn_208(9:12)];

err = [std(e1) std(e2) std(e3)];
figure
e=errorbar(tlx,y,err,'o');
e.MarkerSize=10;
e.MarkerFaceColor='b';
refresh;
%scatter(tlx,[low_213,med_213,hi_213],100,'filled');
xticks(0:1:4);
xlim([0 4])

xlabel('Taskload Level')
ylabel('HF [ms^2]')
title('Taskload Level vs HF')
grid on
grid minor
suptitle('Aggregate Taskload vs HF');