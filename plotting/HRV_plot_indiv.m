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

xfit = linspace(.65,1);

figure;
hold on;
scatter(HFn_202,wl_202,80,'b','filled','DisplayName','Part 202')
p2 = polyfit(HFn_202,wl_202,1);
yfit2 = polyval(p2,xfit);
plot(xfit,yfit2,'b','HandleVisibility','off');
legend('Location','northwest')
xlabel('Normalized HF')
ylabel('Subjective Workload Rating')
title('Workload Rating vs Normalized HF')
xlim([.9,1])
ylim([1,6])
yticks(1:1:6)
grid on
grid minor
hold off;


figure;
hold on;
scatter(HFn_208,wl_208,80,'c','filled','DisplayName','Part 208')
p4 = polyfit(HFn_208,wl_208,1);
yfit4 = polyval(p4,xfit);
plot(xfit,yfit4,'c','HandleVisibility','off');

legend('Location','northwest')
xlabel('Normalized HF')
ylabel('Subjective Workload Rating')
title('Workload Rating vs Normalized HF')
xlim([.75,1])
ylim([2,10])
yticks(2:1:10)
grid on
grid minor
hold off;

figure;
hold on;
scatter(HFn_213,wl_213,80,'g','filled','DisplayName','Part 213')
p6 = polyfit(HFn_213,wl_213,1);
yfit6 = polyval(p6,xfit);
plot(xfit,yfit6,'g','HandleVisibility','off');

legend('Location','northwest')
xlabel('Normalized HF')
ylabel('Subjective Workload Rating')
title('Workload Rating vs Normalized HF')
xlim([.8,1])
ylim([2,8])
yticks(2:1:8)
grid on
grid minor
hold off;