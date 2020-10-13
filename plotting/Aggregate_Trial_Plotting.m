clear all;
clear workspace;
p213 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part213\HRV_HFn.csv');
p201 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part201\HRV_HFn.csv');
p202 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part202\HRV_HFn.csv');
p203 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part203\HRV_HFn.csv');
p208 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part208\HRV_HFn.csv');
p211 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part211\HRV_HFn.csv');

data_index = 4;
trials = [1;2;3;4;5;6;7;8;9;10;11;12];
data_201 = p201(:,data_index);
data_202 = p202(:,data_index);
data_203 = p203(:,data_index);
data_208 = p208(:,data_index);
data_211 = p211(:,data_index);
data_213 = p213(:,data_index);

y = [data_201,data_202,data_203,data_208,data_211,data_213];

figure;
hold on;
pnums = ['201';'202';'203';'208';'213';'211'];
for i=1:6
    name=strcat('Part',(' '),pnums(i,:));
    scatter(trials,y(:,i),'filled','DisplayName',name);
    xlabel('Trial No')
    ylabel('HF [ms^2]')
    titl = ('Trial vs HF');
    title(titl);
end
xfit = [1,2,3,4,5,6,7,8,9,10,11,12];
p = polyfit(xfit,mean(y'),1);
hold on
yfit = polyval(p,xfit);
plot(xfit,yfit,'r','HandleVisibility','off');
xlim([1,12])
legend('Location','northeast')
suptitle('Aggregate Trial Number vs HF');
grid on
grid minor