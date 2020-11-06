clear workspace;
clear all;
workload = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\support\Workload.csv');
taskload = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\support\taskload settings\taskload settings.csv');
hrv201 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part201\Time Based HRV Analyses By Trial.csv');
hrv202 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part202\Time Based HRV Analyses By Trial.csv');
hrv203 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part203\Time Based HRV Analyses By Trial.csv');
hrv204 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part204\Time Based HRV Analyses By Trial.csv');
hrv205 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part205\Time Based HRV Analyses By Trial.csv');
hrv206 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part206\Time Based HRV Analyses By Trial.csv');

hrv207 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part207\Time Based HRV Analyses By Trial.csv');
hrv208 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part208\Time Based HRV Analyses By Trial.csv');
hrv209 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part209\Time Based HRV Analyses By Trial.csv');
hrv210 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part210\Time Based HRV Analyses By Trial.csv');
hrv211 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part211\Time Based HRV Analyses By Trial.csv');
hrv212 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part212\Time Based HRV Analyses By Trial.csv');
hrv213 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part213\Time Based HRV Analyses By Trial.csv');

hrv214 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part214\Time Based HRV Analyses By Trial.csv');
hrv215 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part215\Time Based HRV Analyses By Trial.csv');
trial_order = [1 2 3 4 5 6 7 8 9 10 11 12]';

b201 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part201\Baseline Time Based HRV Analyses By Trial.csv');
b202 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part202\Baseline Time Based HRV Analyses By Trial.csv');
b203 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part203\Baseline Time Based HRV Analyses By Trial.csv');
b204 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part204\Baseline Time Based HRV Analyses By Trial.csv');
b205 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part205\Baseline Time Based HRV Analyses By Trial.csv');
b206 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part206\Baseline Time Based HRV Analyses By Trial.csv');
b207 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part207\Baseline Time Based HRV Analyses By Trial.csv');
b208 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part208\Baseline Time Based HRV Analyses By Trial.csv');
b209 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part209\Baseline Time Based HRV Analyses By Trial.csv');
b210 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part210\Baseline Time Based HRV Analyses By Trial.csv');
b211 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part211\Baseline Time Based HRV Analyses By Trial.csv');
b212 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part212\Baseline Time Based HRV Analyses By Trial.csv');
b213 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part213\Baseline Time Based HRV Analyses By Trial.csv');
b214 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part214\Baseline Time Based HRV Analyses By Trial.csv');
b215 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part215\Baseline Time Based HRV Analyses By Trial.csv');

donk= [1 4 12];
data= cell(12,1);
data(1,:) = {hrv201(:,donk)./b201(donk)};
data(2,:) = {hrv202(:,donk)./b202(donk)};
data(3,:) = {hrv203(:,donk)./b203(donk)};
data(4,:) = {hrv204(:,donk)./b204(donk)};
data(5,:) = {hrv205(:,donk)./b205(donk)};
data(6,:) = {hrv206(:,donk)./b206(donk)};
data(7,:) = {hrv207(:,donk)./b207(donk)};
data(8,:) = {hrv208(:,donk)./b208(donk)};
data(9,:) = {hrv209(:,donk)./b209(donk)};
data(10,:) = {hrv210(:,donk)./b210(donk)};
data(11,:) = {hrv211(:,donk)./b211(donk)};
data(12,:) = {hrv212(:,donk)./b212(donk)};
data(13,:) = {hrv213(:,donk)./b213(donk)};
data(14,:) = {hrv214(:,donk)./b214(donk)};
data(15,:) = {hrv215(:,donk)./b215(donk)};


wl = zeros(12,15);
tl = zeros(12,15);
x_ax = zeros(10,15);
t = zeros(12,15);
for z=1:15
    if (z == 4)
        data(z) = [];
        continue
    end
    wl(:,z) = workload(2:end,z);
    tl(:,z) = taskload(z,:)';
    x_ax(:,z) = (1:10)';
    t(:,z) = (1:12)';
end

wl = wl(wl>0);
tl = tl(tl>0);
x_ax = x_ax(x_ax>0);
t = t(t>0);
data = cell2mat(data);
data(isinf(data)) = 0;


tabl = table(t,tl,data(:,1),data(:,2),data(:,3),data(:,4),wl,...
    'VariableNames',{'TrialOrder','Taskload','HR','SDNN','pNN50','HFn','wl'});
%HR*HFn+SDNN*pNN50+HR:pNN50+SDNN:HFn+pNN50:HFn+SDNN:pNN50:HFn+TrialOrder+Taskload
mdl = fitglm(tabl,...,
    'wl~HR*HFn+SDNN*pNN50+HR:pNN50+SDNN:HFn+pNN50:HFn+SDNN:pNN50:HFn+TrialOrder+Taskload',...,
    'ResponseVar','wl','Intercept',true);
figure;
scatter(wl,mdl.Fitted.Response);
ylim([1 10]);
hold on;

%title({mdl.Formula.LinearPredictor(1:end/2+2),mdl.Formula.LinearPredictor(155:end),'Adj Rsq: .27, Rsq: .38'});
xlabel('Subjective Workload')
ylabel('Model Response')

p = polyfit(wl,mdl.Fitted.Response,1);
yfit = polyval(p,wl);
plot(wl,yfit,'-r','HandleVisibility','off');

title(strcat('Adj. R-Sq: ',string(mdl.Rsquared.Adjusted),'     BIC: ', string(mdl.ModelCriterion.BIC)));