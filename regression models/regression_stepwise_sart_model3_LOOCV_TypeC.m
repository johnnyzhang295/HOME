%% Setup 
clear all;
clear workspace;
ColOrd = [0.634197879289704,0.598590500684565,0.335478586307354;0.141323291186943,0.668487146264776,0.619568612502970;0.0793022450665238,0.894564090918275,0.992885717464124;0.876145347529076,0.0873355239070054,0.648005694952403;0.420428701240150,0.539010349313424,0.539775820318468;0.487663607210372,0.428449936007297,0.232254753050780;0.460325494339181,0.617153494459035,0.739832227063707;0.515677249607505,0.558875876956837,0.888992345152850;0.271994390193763,0.225850688199737,0.859807625912606;0.231579838051303,0.104519529950634,0.597060788610351;0.899534076872039,0.00997765604969036,0.654752143480193;0.908697326644413,0.0591533040753343,0.915013993756726;0.603642852234244,0.322652370507717,0.433183080639157;0.365236483082946,0.779476506848221,0.289760755842240;0.634197879289704,0.598590500684565,0.335478586307354];

load('scaled centered normalized data.mat');

data.pNN50(isnan(data.pNN50)) = 0;
data.Workload = [];
data_without_ID = data;
data_without_ID.ID = [];

%STEP ONE: Use stepwise to determine starting model
%mdl = stepwiseglm(data_without_ID,'linear','Criterion','aic');

%STEP TWO: Extract formula from stepwise
from_stepwise = strcat('SART ~ 1 + TrialOrder + HR*RspRate + RMSSD*Age + RMSSD*Sex',...
          '+ RMSSD*Taskload + SDNN*pNN50 + RspAmp*RspRate',...
          '+ SCBlinkCount*Age + Age*Sex + Sex*Taskload');
          
manual_fitting = strcat(from_stepwise);
%STEP THREE: Add manual terms from correlation plot and evaluate
mdl = fitglm(data_without_ID,manual_fitting);

%STEP FOUR: Do leave one data point out leave out cross validation
%Go to line 50+


%% Step Three Plotting

figure('units','normalized','outerposition',[0 0 1 1]);
j=1;
for i=1:12:180
    subplot(3,5,j); 
    hold on;
    plot(data.SART(i:i+11),mdl.Fitted.Response(i:i+11),'o','Color',ColOrd(j,:));
    p = polyfit(data.SART(i:i+11),mdl.Fitted.Response(i:i+11),1);
    yfit = polyval(p,data.SART(i:i+11));
    %plot(sart(i:i+11),yfit,'-','Color',ColOrd(j,:),'HandleVisibility','off');
    plot([0,46],[0,46],'-', 'Color', ColOrd(j,:));
    ylim([0,46])
    xlim([0,46])
    ylabel('Model Response');
    xlabel('SART Score');
    title(string(j));
    j = j+1;
    grid on;
    
end
formula="";
topTitle = formula;
topTitle = strcat(formula, sprintf('\n Type 3 SA Psychophysiological Regression Model Performance \nAIC = %4.2f BIC = %4.2f R^{2} = %4.2f adjR^{2} = %4.2f',mdl.ModelCriterion.AIC,mdl.ModelCriterion.BIC,mdl.Rsquared.Ordinary,mdl.Rsquared.Adjusted));

suptitle(topTitle);
fn = 'Type 3 SA Psychophysiological Regression Model Performance';
saveas(gcf,strcat('C:\Users\BIOPACMan\Documents\Zhang\HOME\regression models\type3 models\',fn,'.jpg'));


%% Step Four plotting
%STEP FOUR: Do leave one data point out leave out cross validation
mdls = {};
all_ys = zeros(180,1);
all_xs = zeros(180,1);
q_sqs = [];
numerators = [];
denoms = [];
figure('units','normalized','outerposition',[0 0 1 1]);
for j = (1:180)
    %LOO_data should include the workload/sa value
    LOO_data = data(j,:);

    CV_data = data;
    CV_data(j,:) = [];

    %Fit a generalized linear model
    mdl = fitglm(CV_data,manual_fitting);
    mdls(j) = {mdl};
    y = mdl.predict(LOO_data(1, 1:end-1));
    all_ys(j) = y;
    all_xs(j) = LOO_data.SART;
    hold on;
    plot(LOO_data.SART, y,'o');
    plot([0,46],[0,46],'-');
    ylim([0,46])
    xlim([0,46])
    ylabel('Predicted SA Response');
    xlabel('Subject SART Score');
    %title(string(j));
    grid on;
    
    [q_sqs(j), numerators(j), denoms(j)] = calculate_q_sq(LOO_data,CV_data,mdl);
end

p = polyfit(all_xs,all_ys,1);
yfit = polyval(p,(0:46));
plot((0:46),yfit,'-','HandleVisibility','off');
    
mdls = mdls';
q_sqs = q_sqs';

overall_q_sq = 1 - (sum(numerators) / sum(denoms));

topTitle = sprintf('LOOCV Type C For SA \nQ^{2} = %4.2f ',overall_q_sq);

suptitle(topTitle);
filename = 'LOOCV Type C for SA';
saveas(gcf,strcat('C:\Users\BIOPACMan\Documents\Zhang\HOME\regression models\type3 models\',filename,'.jpg'));

%LOO_data should include the workload/SA value
function [q_sq, term_1, term_2] = calculate_q_sq(LOO_data, CV_data, mdl)
   
    
    Y = LOO_data{:, end};
    Y_hat_miss_i = mdl.predict(LOO_data(:, 1:end -1));
    
    Y_bar_miss_i = mean(CV_data{:,end});
    
    term_1 = sum((Y - Y_hat_miss_i).^2);
    term_2 = sum((Y - Y_bar_miss_i).^2);
    
    q_sq = 1 - (term_1/term_2);
        
        

end