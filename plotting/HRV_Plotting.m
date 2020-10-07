clear all;
clear workspace;
p213 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part213\HRV_HFn.csv');
p201 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part201\HRV_HFn.csv');
p202 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part202\HRV_HFn.csv');
p203 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part203\HRV_HFn.csv');
p208 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part208\HRV_HFn.csv');
p211 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part211\HRV_HFn.csv');
workload = load('C:\Users\BIOPACMan\Documents\Zhang\workloads.csv');
wl_201 = workload(1:12);
wl_202 = workload(13:24);
wl_203 = workload(25:36);
wl_208 = workload(37:48);
wl_211 = workload(49:60);
wl_213 = workload(61:72);
HFn_201 = p201(:,8);
HFn_202 = p202(:,8);
HFn_203 = p203(:,8);
HFn_208 = p208(:,8);
HFn_211 = p211(:,8);
HFn_213 = p213(:,8);
figure;
scatter(HFn_201,wl_201,80,'r','filled','DisplayName','Part 201')
p = polyfit(HFn_201,wl_201,1);
hold on
xfit = linspace(.65,1);
yfit = polyval(p,xfit);
plot(xfit,yfit,'r','HandleVisibility','off');

scatter(HFn_202,wl_202,80,'b','filled','DisplayName','Part 202')
p2 = polyfit(HFn_202,wl_202,1);
yfit2 = polyval(p2,xfit);
plot(xfit,yfit2,'b','HandleVisibility','off');

scatter(HFn_203,wl_203,80,'m','filled','DisplayName','Part 203')
p3 = polyfit(HFn_203,wl_203,1);
yfit3 = polyval(p3,xfit);
plot(xfit,yfit3,'m','HandleVisibility','off');

scatter(HFn_208,wl_208,80,'c','filled','DisplayName','Part 208')
p4 = polyfit(HFn_208,wl_208,1);
yfit4 = polyval(p4,xfit);
plot(xfit,yfit4,'c','HandleVisibility','off');

scatter(HFn_211,wl_211,80,'k','filled','DisplayName','Part 211')
p5 = polyfit(HFn_211,wl_211,1);
yfit5 = polyval(p5,xfit);
plot(xfit,yfit5,'k','HandleVisibility','off');

scatter(HFn_213,wl_213,80,'g','filled','DisplayName','Part 213')
p6 = polyfit(HFn_213,wl_213,1);
yfit6 = polyval(p6,xfit);
plot(xfit,yfit6,'g','HandleVisibility','off');


legend('Location','northwest')
xlabel('Normalized HF')
ylabel('Subjective Workload Rating')
title('Workload Rating vs Normalized HF')
xlim([.65,1])
ylim([0,10])
grid on
grid minor