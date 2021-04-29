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


wl = [
     workload(2:end,1);
     workload(2:end,2);
     workload(2:end,3);
     workload(2:end,4);
     workload(2:end,5);
     workload(2:end,6);
     
     workload(2:end,7);
     workload(2:end,8);
     workload(2:end,9);
     
     workload(2:end,10);
     workload(2:end,11);
     workload(2:end,12);
     workload(2:end,13);
     
     workload(2:end,14);
     workload(2:end,15);
    ];

tl = [
     taskload(1,:)';
     taskload(2,:)';
     taskload(3,:)';
     taskload(4,:)';
     taskload(5,:)';
     taskload(6,:)';
     taskload(7,:)';
     taskload(8,:)';
     taskload(9,:)';
     taskload(10,:)';
     taskload(11,:)';
     taskload(12,:)';
     taskload(13,:)';
     taskload(14,:)';
     taskload(15,:)';
    ];


x_ax= [(1:10)';
    (1:10)';
    (1:10)';
    (1:10)';
    (1:10)';
    (1:10)';
   (1:10)';
    (1:10)';
    (1:10)';
    (1:10)';
    (1:10)';
    (1:10)';
    (1:10)';
    (1:10)';
    
    (1:10)';
    ];

t = [trial_order;
trial_order;
trial_order;
trial_order;
trial_order;
trial_order;
trial_order;
trial_order;
trial_order;
trial_order;
trial_order;
trial_order;
trial_order;
trial_order;
trial_order;];

donk= [1 4 12 23];
data= [];
for d=donk
    data = horzcat(data, [hrv201(:,d)/b201(d);
    hrv202(:,d)/b202(d);
    hrv203(:,d)/b203(d);
    hrv204(:,d)/b204(d);
    hrv205(:,d)/b205(d);
    hrv206(:,d)/b206(d);
    hrv207(:,d)/b207(d);
    hrv208(:,d)/b208(d);
    hrv209(:,d)/b209(d);
    hrv210(:,d)/b210(d);
    hrv211(:,d)/b211(d);
    hrv212(:,d)/b212(d);
    hrv213(:,d)/b213(d);
    hrv214(:,d)/b214(d);
    hrv215(:,d)/b215(d);]);
end

data(isinf(data)) = 0;
%wl~1 + TrialOrder*Taskload + Taskload*SDNN + SDNN+HR:SDNN + Taskload*pNN50 + TrialOrder:Taskload:SDNN + TrialOrder:HR:SDNN + Taskload:HR:SDNN + TrialOrder:Taskload:pNN50 +  TrialOrder:SDNN:pNN50 + Taskload:SDNN:pNN50 + HR:SDNN:pNN50 + TrialOrder:Taskload:SDNN:pNN50 + TrialOrder:HR:SDNN:pNN50',...,
    

tabl = table(t,tl,data(:,1),data(:,2),data(:,3),data(:,4),wl,...
    'VariableNames',{'TrialOrder','Taskload','HR','SDNN','pNN50','HFn','wl'});
%HR*HFn+SDNN*pNN50+HR:pNN50+SDNN:HFn+pNN50:HFn+SDNN:pNN50:HFn+TrialOrder+Taskload
%HR*HFn+SDNN*pNN50+HR:pNN50+SDNN:HFn+pNN50:HFn+SDNN:pNN50:HFn+TrialOrder+Taskload
% mdl = fitglm(tabl,...,
%     'wl~1 + TrialOrder*Taskload + TrialOrder*HR + Taskload*HR + TrialOrder*SDNN + Taskload*SDNN + HR*SDNN + TrialOrder*pNN50 + Taskload*pNN50 + HR*pNN50 + SDNN*pNN50 + TrialOrder:Taskload:SDNN + TrialOrder:HR:SDNN + Taskload:HR:SDNN + TrialOrder:Taskload:pNN50 + TrialOrder:HR:pNN50 + TrialOrder:SDNN:pNN50 + Taskload:SDNN:pNN50 + HR:SDNN:pNN50 + TrialOrder:Taskload:SDNN:pNN50 + TrialOrder:HR:SDNN:pNN50',...,
%     'ResponseVar','wl','Intercept',true);

mdl = fitglm(tabl,...,
    'wl ~ 1 + TrialOrder*HR + Taskload*HR + SDNN*pNN50',...,
    'ResponseVar','wl','Intercept', true);
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