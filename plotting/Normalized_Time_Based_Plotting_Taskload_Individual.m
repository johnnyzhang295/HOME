clear workspace;
clear all;
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
taskload = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\support\taskload settings\taskload settings.csv');
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
normalize=0; %Set normalize to 1 if you want to nomralize, 0 if you want raw
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

rm_wl = [taskload(1,:) rmssd201';
    taskload(2,:) rmssd202';
    taskload(3,:) rmssd203';
    taskload(4,:) rmssd204';
    taskload(5,:) rmssd205';
    taskload(6,:) rmssd206';
    taskload(8,:) rmssd208';
    taskload(9,:) rmssd209';
    taskload(11,:) rmssd211';
    taskload(12,:) rmssd212';
    taskload(13,:) rmssd213';
    taskload(15,:) rmssd215';];

 
tl2_count = 0;
tl3_count = 0;
tl4_count = 0;
group_by_exposure = zeros([1 12]);

data = rm_wl(1,1:12);
for i=1:12
    if (data(i) ==2)
        tl2_count = tl2_count + 1;
        group_by_exposure(i) = tl2_count;
    elseif(data(i)==3)
        tl3_count = tl3_count + 1;
        group_by_exposure(i) = tl3_count;
    else
        tl4_count = tl4_count + 1;
        group_by_exposure(i) = tl4_count;
    end
end


g={1:12};
xfit = linspace(2,4);
pnums = ['201';'202';'203';'204';'205';'206';'208';'209';'211';'212';'213';'215'];
for i=1:12
      
    subplot(3,4,i)
    hold on; %This hold on must come AFTER the subplot
    p = polyfit(rm_wl(i,1:12)', rm_wl(i,13:24)',1);
    yfit = polyval(p,xfit);
    plot(xfit,yfit,'HandleVisibility','off');
    gscatter(rm_wl(i,1:12),rm_wl(i,13:24),g,'rkgb','o*',8,'on','TL');
    xlabel('Taskload Level')
    ylabel('Normalized pNN50')
    grid on;
    grid minor;
    titl = strcat('Part',{' '},pnums(i,:),newline);
    title(titl);
    hold off;
end

suptitle('Individual Normalized Aggregate Taskload Level vs pNN50 ')