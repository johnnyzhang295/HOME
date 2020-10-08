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

xfit = linspace(0,10);
subplot(2,3,1)
scatter(wl_201,HFn_201,20,'r','filled','DisplayName','Part 201')
p = polyfit(wl_201,HFn_201,1);
hold on
yfit = polyval(p,xfit);
plot(xfit,yfit,'r','HandleVisibility','off');
hold off
legend('Location','southeast')
ylabel('Normalized HF')
xlabel('Subjective Workload Rating')
grid on
grid minor


subplot(2,3,2)
hold on;
scatter(wl_202,HFn_202,20,'b','filled','DisplayName','Part 202')
p2 = polyfit(wl_202,HFn_202,1);
yfit2 = polyval(p2,xfit);
plot(xfit,yfit2,'b','HandleVisibility','off');
hold off
legend('Location','southeast')
ylabel('Normalized HF')
xlabel('Subjective Workload Rating')
grid on
grid minor
ylim([.9,1])
xlim([1,6])

subplot(2,3,3)
hold on;
scatter(wl_203,HFn_203,20,'m','filled','DisplayName','Part 203')
p3 = polyfit(wl_203,HFn_203,1);
yfit3 = polyval(p3,xfit);
plot(xfit,yfit3,'m','HandleVisibility','off');
hold off
ylim([.9,1])
xlim([1,6])
legend('Location','southeast')
ylabel('Normalized HF')
xlabel('Subjective Workload Rating')
grid on
grid minor

subplot(2,3,4)
hold on;
scatter(wl_208,HFn_208,20,'c','filled','DisplayName','Part 208')
p4 = polyfit(wl_208,HFn_208,1);
yfit4 = polyval(p4,xfit);
plot(xfit,yfit4,'c','HandleVisibility','off');
hold off
legend('Location','southeast')
ylabel('Normalized HF')
xlabel('Subjective Workload Rating')
grid on
grid minor
ylim([.7,1])
xlim([2,10])

subplot(2,3,5)
hold on;
scatter(wl_211,HFn_208,20,'k','filled','DisplayName','Part 211')
p5 = polyfit(wl_211,HFn_208,1);
yfit5 = polyval(p5,xfit);
plot(xfit,yfit5,'k','HandleVisibility','off');
hold off
legend('Location','southeast')
ylabel('Normalized HF')
xlabel('Subjective Workload Rating')
grid on
grid minor
ylim([.7,1])
xlim([0,8])

subplot(2,3,6)
hold on;
scatter(wl_213, HFn_213,20,'g','filled','DisplayName','Part 213')
p6 = polyfit(wl_213, HFn_213,1);
yfit6 = polyval(p6,xfit);
plot(xfit,yfit6,'g','HandleVisibility','off');
hold off
ylim([.8,1])
xlim([2,8])

legend('Location','southeast')
ylabel('Normalized HF')
xlabel('Subjective Workload Rating')
grid on
grid minor


suptitle('Individual Plots Workload vs Normalized HF');