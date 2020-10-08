clear workspace;
workload = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\support\workload.csv');
hrv201 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part201\Time Based HRV Analyses By Trial.csv');
hrv202 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part202\Time Based HRV Analyses By Trial.csv');
hrv203 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part203\Time Based HRV Analyses By Trial.csv');
hrv204 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part204\Time Based HRV Analyses By Trial.csv');
hrv205 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part205\Time Based HRV Analyses By Trial.csv');
hrv206 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part206\Time Based HRV Analyses By Trial.csv');
hrv208 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part208\Time Based HRV Analyses By Trial.csv');
hrv209 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part209\Time Based HRV Analyses By Trial.csv');
hrv211 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part211\Time Based HRV Analyses By Trial.csv');
hrv212 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part212\Time Based HRV Analyses By Trial.csv');
hrv213 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part213\Time Based HRV Analyses By Trial.csv');
hrv215 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part215\Time Based HRV Analyses By Trial.csv');

wl201= workload(2:end,1);
wl202= workload(2:end,2);
wl203= workload(2:end,3);
wl204= workload(2:end,4);
wl205= workload(2:end,5);
wl206= workload(2:end,6);
wl208= workload(2:end,8);
wl209= workload(2:end,9);
wl211= workload(2:end,11);
wl212= workload(2:end,12);
wl213= workload(2:end,13);
wl215= workload(2:end,15);

rmssd201 = hrv201(:,2);
rmssd202 = hrv202(:,2);
rmssd203 = hrv203(:,2);
rmssd204 = hrv204(:,2);
rmssd205 = hrv205(:,2);
rmssd206 = hrv206(:,2);
rmssd208 = hrv208(:,2);
rmssd209 = hrv209(:,2);
rmssd211 = hrv211(:,2);
rmssd212 = hrv212(:,2);
rmssd213 = hrv213(:,2);
rmssd215 = hrv215(:,2);

rm_wl = [wl201 rmssd201;
    wl202 rmssd202;
    wl203 rmssd203;
    wl204 rmssd204;
    wl205 rmssd205;
    wl206 rmssd206;
    wl208 rmssd208;
    wl209 rmssd209;
    wl211 rmssd211;
    wl212 rmssd212;
    wl213 rmssd213;
    wl215 rmssd215;];
scatter(rm_wl(:,1), rm_wl(:,2),'filled')
hold on

xfit = linspace(0,10);
p = polyfit(rm_wl(:,1), rm_wl(:,2),1);
yfit = polyval(p,xfit);
plot(xfit,yfit);
xlabel('Subjective Workload Rating')
ylabel('RMSSD')
title('RMSSD vs. Subjective Workload')

hold off
figure
hold on
scatter(wl201, rmssd201,'filled','MarkerFaceColor',rand(1,3))
scatter(wl202, rmssd202,'filled','MarkerFaceColor',rand(1,3))
scatter(wl203, rmssd203,'filled','MarkerFaceColor',rand(1,3))
scatter(wl204, rmssd204,'filled','MarkerFaceColor',rand(1,3))
scatter(wl205, rmssd205,'filled','MarkerFaceColor',rand(1,3))
scatter(wl206, rmssd206,'filled','MarkerFaceColor',rand(1,3))
scatter(wl208, rmssd208,'filled','MarkerFaceColor',rand(1,3))
scatter(wl209, rmssd209,'filled','MarkerFaceColor',rand(1,3))
scatter(wl211, rmssd211,'filled','MarkerFaceColor',rand(1,3))
scatter(wl212, rmssd212,'filled','MarkerFaceColor',rand(1,3))
scatter(wl213, rmssd213,'filled','MarkerFaceColor',rand(1,3))
scatter(wl215, rmssd215,'filled','MarkerFaceColor',rand(1,3))
xfit = linspace(0,10);
p = polyfit(rm_wl(:,1), rm_wl(:,2),1);
yfit = polyval(p,xfit);
plot(xfit,yfit);
xlabel('Subjective Workload Rating')
ylabel('RMSSD')
title('RMSSD vs. Subjective Workload')
hold on