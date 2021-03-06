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
pnums = ['201';'202';'203';'204';'205';'206'; '207';'208';'209';'210';'211';'212';'213';'214';'215'];
pnumz= [' 0';' 1';' 2';' 3';' 4';' 5';];
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

leaveout = 5;

wl = zeros(12,15);
tl = zeros(12,15);
x_ax = zeros(10,15);
t = zeros(12,15);
subj_data = zeros(12, 6);
for z=1:15
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


tabl = table(t,tl,data(:,1),data(:,2),data(:,3),wl,...
    'VariableNames',{'TrialOrder','Taskload','HR','SDNN','pNN50','wl'});
%HR*HFn+SDNN*pNN50+HR:pNN50+SDNN:HFn+pNN50:HFn+SDNN:pNN50:HFn+TrialOrder+Taskload
% mdl = fitglm(tabl,...,
%     'wl~1 + TrialOrder*Taskload + TrialOrder*HR + Taskload*HR + TrialOrder*SDNN + Taskload*SDNN + HR*SDNN + TrialOrder*pNN50 + Taskload*pNN50 + HR*pNN50 + SDNN*pNN50 + TrialOrder:Taskload:SDNN + TrialOrder:HR:SDNN + Taskload:HR:SDNN + TrialOrder:Taskload:pNN50 + TrialOrder:HR:pNN50 + TrialOrder:SDNN:pNN50 + Taskload:SDNN:pNN50 + HR:SDNN:pNN50 + TrialOrder:Taskload:SDNN:pNN50 + TrialOrder:HR:SDNN:pNN50',...,
%     'ResponseVar','wl','Intercept',true);


%Code for randomization here
rng(leaveout,'twister');
miss_data_inds = randi([1 180],36,1); %Randomly determine 20 data points
miss_data = tabl(miss_data_inds,:); %Grab the 20% data
tabl(miss_data_inds,:) = []; %Remove the 20% data from original variable


mdl = fitglm(tabl,...,
    'wl ~ 1 + TrialOrder*HR + Taskload*HR + SDNN*pNN50',...,
    'ResponseVar','wl','Intercept', true);


figure('units','normalized','outerposition',[0 0 1 1]);
scatter(tabl{:,6},mdl.Fitted.Response);
ylim([1 10]);
hold on;

%title({mdl.Formula.LinearPredictor(1:end/2+2),mdl.Formula.LinearPredictor(155:end),'Adj Rsq: .27, Rsq: .38'});
xlabel('Subjective Workload')
ylabel('Model Response')

p = polyfit(tabl{:,6},mdl.Fitted.Response,1);
yfit = polyval(p,tabl{:,6});
plot(tabl{:,6},yfit,'-r','HandleVisibility','off');
grid on;
grid minor;

title_1  = strcat('20% Any Data LOOCV Random Gen Seed ',{' '},string(pnumz(leaveout,:)));
title(strcat(title_1,' Adj. R-Sq: ',string(mdl.Rsquared.Adjusted),'     BIC: ', string(mdl.ModelCriterion.BIC)));
saveas(gcf,strcat('C:\Users\BIOPACMan\Documents\Zhang\HOME\models\model figures\automated plots\',title_1,'.jpg'));
    
fn = strcat('C:\Users\BIOPACMan\Documents\Zhang\HOME\models\model coefficeints\LOOCV coefficients\',title_1,'modelCoefficients.txt');
writetable(mdl.Coefficients, fn, 'WriteRowNames',true);

figure('units','normalized','outerposition',[0 0 1 1]);
hold on;
x = miss_data{:,6};
y = mdl.predict(miss_data{:,1:5});
scatter(x, y,80,'filled');
xlabel('Subjective Workload')
ylabel('Model Response')
p = polyfit(x,y,1);
grid on;
grid minor;
yfit = polyval(p, x);
plot(x, yfit,'-r','HandleVisibility','off');

diff = x-y;
mean_err = mean(diff);
std_err = std(diff);
title_2 = strcat('20% Any Data Model Prediction for Rand Gen Seed ',{' '},string(pnumz(leaveout,:)));

se = sse(diff);
title(strcat(title_2,' Mean Err: ',string(mean_err), ' StdDev Err: ',string(std_err),' SSE: ',string(se)));
saveas(gcf,strcat('C:\Users\BIOPACMan\Documents\Zhang\HOME\models\model figures\automated plots\',title_2,'.jpg'));


mdl
display(mean_err);
display(std_err);
display(se);