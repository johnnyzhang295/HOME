%%  Load and Setup data

clear workspace;
clear all;

ColOrd = [0.634197879289704,0.598590500684565,0.335478586307354;0.141323291186943,0.668487146264776,0.619568612502970;0.0793022450665238,0.894564090918275,0.992885717464124;0.876145347529076,0.0873355239070054,0.648005694952403;0.420428701240150,0.539010349313424,0.539775820318468;0.487663607210372,0.428449936007297,0.232254753050780;0.460325494339181,0.617153494459035,0.739832227063707;0.515677249607505,0.558875876956837,0.888992345152850;0.271994390193763,0.225850688199737,0.859807625912606;0.231579838051303,0.104519529950634,0.597060788610351;0.899534076872039,0.00997765604969036,0.654752143480193;0.908697326644413,0.0591533040753343,0.915013993756726;0.603642852234244,0.322652370507717,0.433183080639157;0.365236483082946,0.779476506848221,0.289760755842240;0.634197879289704,0.598590500684565,0.335478586307354];
workload = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\support\Workload.csv');
taskload = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\support\taskload settings\taskload settings.csv');
sart = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\support\SARTScores.txt');
sex_age = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\support\sex_age.txt');
trial_order = (1:12)';
filepath = 'C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part';

data_types = {'double','double','double','double',...
    'double','double','double','double',...
    'categorical','double','categorical','double'};
data_names = {'Taskload','TrialOrder','HR','SDNN','pNN50',...
    'RspAmp','RspRate','Age','Sex',...
    'PupilDiameter','ID','Workload'};
data = table('Size',[24 length(data_types)],'VariableTypes',data_types,'VariableNames',data_names);

ecg_feature_indexes = [1 4 12];
ind = 1;
counter = 1;
for id=201:215
   id = string(id); 
   %Process ECG
   raw_ecg_features = load(strcat(filepath,id,'\Time Based HRV Analyses By Trial.csv'));
   baseline_ecg_features = load(strcat(filepath,id,'\Baseline Time Based HRV Analyses By Trial.csv'));
   normalized_ecg_features = raw_ecg_features ./ baseline_ecg_features;
   normalized_ecg_features = normalized_ecg_features(:,ecg_feature_indexes);
   %Process RSP
   raw_rsp_features = load(strcat(filepath,id,'\RSP data by trial.csv'));
   baseline_rsp_features = load(strcat(filepath,id,'\RSP baseline.csv'));
   normalized_rsp_features = raw_rsp_features(:,1:8)/baseline_rsp_features;
   normalized_rsp_features = normalized_rsp_features(1:2:end,:);
   %Process EYE
   raw_eye_features = load(strcat(filepath,id,'\eye_features_pilot_interval_summary_table.mat'));
   
   
   data.HR(ind:ind+11) = normalized_ecg_features(:,1);
   data.SDNN(ind:ind+11) = normalized_ecg_features(:,2);
   data.pNN50(ind:ind+11) = normalized_ecg_features(:,3);
   data.RspAmp(ind:ind+11) = normalized_rsp_features(:,1);
   data.RspRate(ind:ind+11) = normalized_rsp_features(:,2);
   data.PupilDiameter(ind:ind+11) = raw_eye_features.summary_table.Median;
   data.Workload(ind:ind+11) = workload(2:end,counter);
   data.Taskload(ind:ind+11) = taskload(counter,:)';
   data.TrialOrder(ind:ind+11) = trial_order;
   data.ID(ind:ind+11) = categorical(repmat(id,[12 1]));
   data.Age(ind:ind+11) = repmat(sex_age(counter,2), [12 1]);
   data.Sex(ind:ind+11) = categorical(repmat(sex_age(counter,1), [12 1]));
   
   
   ind = ind + 12; %still a very hacky way of getting this done
   counter = counter + 1; %yes very hacky indeed
end

data(isinf(data{:,5}),5) = {0};

%%  Do something useful
stepwise_formula_x = ...
    'Workload ~ 1 + TrialOrder + Taskload + HR+RspAmp+ RspRate+PupilDiameter +pNN50+SDNN ';
%mdl = stepwiseglm(data,stepwise_formula_x,'Criterion','aic');
%['1 + Taskload*ID + TrialOrder*ID + SDNN*RspRate']
%['1 + Taskload*RspAmp + Taskload*ID + TrialOrder*ID + HR*RspAmp + SDNN*RspRate + pNN50*PupilDiameter']
%from_stepwise = 'Workload~1+TrialOrder*Taskload * HR*SDNN*pNN50+ HR*PupilDiameter* RspAmp*RspRate +ID ';
%very_manual = 'Workload~1+TrialOrder+Taskload+HR+SDNN+pNN50+PupilDiameter+RspAmp+RspRate+ID+Taskload:TrialOrder+TrialOrder:HR+TrialOrder:SDNN+TrialOrder:pNN50+HR:pNN50+SDNN:pNN50+HR:RspAmp+HR:RspRate+HR:PupilDiameter+RspRate:PupilDiameter+RspAmp:PupilDiameter+Taskload:TrialOrder:HR:pNN50+TrialOrder:HR:SDNN';
formula = 'Workload ~ 1 + TrialOrder+SDNN*RspRate+RspAmp+RspRate*Age+ID+Taskload*HR + PupilDiameter + HR:PupilDiameter';
mdl = fitglm(data,formula);
figure('units','normalized','outerposition',[0 0 1 1]);
    
j=1;
for i=1:12:180
    subplot(3,5,j); 
    hold on;
    plot(workload(i:i+11),mdl.Fitted.Response(i:i+11),'o','Color',ColOrd(j,:));
    p = polyfit(workload(i:i+11),mdl.Fitted.Response(i:i+11),1);
    yfit = polyval(p,workload(i:i+11));
    %plot(sart(i:i+11),yfit,'-','Color',ColOrd(j,:),'HandleVisibility','off');
    plot([1,10],[1,10],'-', 'Color', ColOrd(j,:));
    ylim([1,10])
    xlim([1,10])
    ylabel('Model Response');
    xlabel('Reported Workload');
    j = j+1;
    grid on;
    
end
topTitle = sprintf('Workload Psychophysiological Regression Model Performance \nAIC = %4.2f BIC = %4.2f R^{2} = %4.2f adjR^{2} = %4.2f',mdl.ModelCriterion.AIC,mdl.ModelCriterion.BIC,mdl.Rsquared.Ordinary,mdl.Rsquared.Adjusted);

suptitle(topTitle);
fn = 'Workload Psychophysiological Regression Model Performance';
%saveas(gcf,strcat('C:\Users\BIOPACMan\Documents\Zhang\HOME\models\model figures\automated plots\',fn,'.jpg'));