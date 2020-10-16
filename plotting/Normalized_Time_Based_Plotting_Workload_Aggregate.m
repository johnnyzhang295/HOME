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

b201 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part201\Baseline Time Based HRV Analyses By Trial.csv');
b202 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part202\Baseline Time Based HRV Analyses By Trial.csv');
b203 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part203\Baseline Time Based HRV Analyses By Trial.csv');
b204 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part204\Baseline Time Based HRV Analyses By Trial.csv');
b205 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part205\Baseline Time Based HRV Analyses By Trial.csv');
b206 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part206\Baseline Time Based HRV Analyses By Trial.csv');
b208 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part208\Baseline Time Based HRV Analyses By Trial.csv');
b209 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part209\Baseline Time Based HRV Analyses By Trial.csv');
b211 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part211\Baseline Time Based HRV Analyses By Trial.csv');
b212 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part212\Baseline Time Based HRV Analyses By Trial.csv');
b213 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part213\Baseline Time Based HRV Analyses By Trial.csv');
b215 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part215\Baseline Time Based HRV Analyses By Trial.csv');

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

data_index = 12;
normalize=1; %Set normalize to 1 if you want to nomralize, 0 if you want raw
%1=rate mean, 2=RMSSD, 4=SDNN, 12=PNN50
rmssd201 = hrv201(:,data_index);
rmssd202 = hrv202(:,data_index);
rmssd203 = hrv203(:,data_index);
rmssd204 = hrv204(:,data_index);
rmssd205 = hrv205(:,data_index);
rmssd206 = hrv206(:,data_index);
rmssd208 = hrv208(:,data_index);
rmssd209 = hrv209(:,data_index);
rmssd211 = hrv211(:,data_index);
rmssd212 = hrv212(:,data_index);
rmssd213 = hrv213(:,data_index);
rmssd215 = hrv215(:,data_index);


figure
hold on


if (normalize==1)
    rmssd201 = hrv201(:,data_index)/b201(data_index);
    rmssd202 = hrv202(:,data_index)/b202(data_index);
    rmssd203 = hrv203(:,data_index)/b203(data_index);
    rmssd204 = hrv204(:,data_index)/b204(data_index);
    rmssd205 = hrv205(:,data_index)/b205(data_index);
    rmssd206 = hrv206(:,data_index)/b206(data_index);
    rmssd208 = hrv208(:,data_index)/b208(data_index);
    rmssd209 = hrv209(:,data_index)/b209(data_index);
    rmssd211 = hrv211(:,data_index)/b211(data_index);
    rmssd212 = hrv212(:,data_index)/b212(data_index);
    rmssd213 = hrv213(:,data_index)/b213(data_index);
    rmssd215 = hrv215(:,data_index)/b215(data_index);
    
   
end

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


trial_ord = [1;2;3;4;5;6;7;8;9;10;11;12];
scatter(wl201, rmssd201,'filled','MarkerFaceColor',rand(1,3),'DisplayName','Part 201')
scatter(wl202, rmssd202,'filled','MarkerFaceColor',rand(1,3),'DisplayName','Part 202')
scatter(wl203, rmssd203,'filled','MarkerFaceColor',rand(1,3),'DisplayName','Part 203')
scatter(wl204, rmssd204,'filled','MarkerFaceColor',rand(1,3),'DisplayName','Part 204')
scatter(wl205, rmssd205,'filled','MarkerFaceColor',rand(1,3),'DisplayName','Part 205')
scatter(wl206, rmssd206,'filled','MarkerFaceColor',rand(1,3),'DisplayName','Part 206')
scatter(wl208, rmssd208,'filled','MarkerFaceColor',rand(1,3),'DisplayName','Part 208')
scatter(wl209, rmssd209,'filled','MarkerFaceColor',rand(1,3),'DisplayName','Part 209')
scatter(wl211, rmssd211,'filled','MarkerFaceColor',rand(1,3),'DisplayName','Part 211')
scatter(wl212, rmssd212,'filled','MarkerFaceColor',rand(1,3),'DisplayName','Part 212')
scatter(wl213, rmssd213,'filled','MarkerFaceColor',rand(1,3),'DisplayName','Part 213')
scatter(wl215, rmssd215,'filled','MarkerFaceColor',rand(1,3),'DisplayName','Part 215')
xfit = linspace(0,10);
grid minor
grid on
p = polyfit(rm_wl(:,1), rm_wl(:,2),1);
yfit = polyval(p,xfit);
plot(xfit,yfit,'HandleVisibility','off');
xlabel('Subjective Workload Rating')
ylabel('Normalized pNN50')
legend('Location','northwest')
title('Normalized Aggregate Subjective Workload vs pNN50 ')
hold on