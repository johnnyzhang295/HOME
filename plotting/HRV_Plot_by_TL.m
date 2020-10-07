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
HFn_201 = p201(:,8);
HFn_202 = p202(:,8);
HFn_203 = p203(:,8);
HFn_208 = p208(:,8);
HFn_211 = p211(:,8);
HFn_213 = p213(:,8);

low_213 = mean(HFn_213(1:4));
med_213 = mean(HFn_213(5:8));
hi_213 = mean(HFn_213(9:12));

low_201 = mean(HFn_201(1:4));
med_201 = mean(HFn_201(5:8));
hi_201 = mean(HFn_201(9:12));

low_208 = mean(HFn_208(1:4));
med_208 = mean(HFn_208(5:8));
hi_208 = mean(HFn_208(9:12));
tls = ['Low TL','Medium TL', 'High TL'];
tlx = [1,2,3];
y=[low_213,med_213,hi_213];
err = [std(HFn_213(1:4)) std(HFn_213(5:8)) std(HFn_213(9:12))];
figure
errorbar(tlx,y,err,'o');
%scatter(tlx,[low_213,med_213,hi_213],100,'filled');
xticks(0:1:4);
xlim([0 4])