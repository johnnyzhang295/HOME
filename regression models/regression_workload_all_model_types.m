%% Setup 
clear all;
clear workspace;
global ColOrd;
ColOrd = [0.634197879289704,0.598590500684565,0.335478586307354;0.141323291186943,0.668487146264776,0.619568612502970;0.0793022450665238,0.894564090918275,0.992885717464124;0.876145347529076,0.0873355239070054,0.648005694952403;0.420428701240150,0.539010349313424,0.539775820318468;0.487663607210372,0.428449936007297,0.232254753050780;0.460325494339181,0.617153494459035,0.739832227063707;0.515677249607505,0.558875876956837,0.888992345152850;0.271994390193763,0.225850688199737,0.859807625912606;0.231579838051303,0.104519529950634,0.597060788610351;0.899534076872039,0.00997765604969036,0.654752143480193;0.908697326644413,0.0591533040753343,0.915013993756726;0.603642852234244,0.322652370507717,0.433183080639157;0.365236483082946,0.779476506848221,0.289760755842240;0.634197879289704,0.598590500684565,0.335478586307354];

load('baselined_data.mat');
data = baselined_data;

data.pNN50(isnan(data.pNN50)) = 0;
data.SART = [];
data_without_ID = data;
data_without_ID.ID = [];

data_without_demographics = data;
data_without_demographics.ID = [];
data_without_demographics.Age = [];
data_without_demographics.Sex = [];
data_without_TL = data_without_demographics;
data_without_TL.Taskload = [];

%% Type 1 Model
formula_1 = ...
"Workload ~ 1 + HR*RspAmp + HR*MeanPupilDiameter + RMSSD*SDNN + RMSSD*RspRate + SDNN*RspRate"+...
         " + SDNN*MeanPupilDiameter + RspAmp*MeanPupilDiameter";
mdl_1 = stepwiseglm(data_without_TL, formula_1,'Criterion','aic');
%mdl_1 = fitglm(data_without_TL, formula_1);
type_1_f1 = plotMdl(mdl_1,data_without_TL, 1);
[type_1_f2, type_1_q_sq_B] = LOOCV_B(mdl_1,data, 1, formula_1); %This is not a typo! LOOCV_B needs the ID
[type_1_f3, type_1_q_sq_C] = LOOCV_C(mdl_1,data_without_TL, 1, formula_1);

%% Type 2 Model
formula_2 = ...
    "Workload ~ 1 + MeanPupilDiameter + TrialOrder + RMSSD*Taskload + SDNN*pNN50"+...
          "+ pNN50*RspRate + RspAmp*RspRate + RspAmp*Taskload + RspRate*Taskload";
mdl_2 = stepwiseglm(data_without_demographics, formula_2,'Criterion','aic');
%mdl_2 = fitglm(data_without_demographics, formula_2);
type_2_f1 = plotMdl(mdl_2,data_without_demographics, 2);
[type_2_f2, type_2_q_sq_B] = LOOCV_B(mdl_2,data, 2, formula_2); %This is not a typo! LOOCV_B needs the ID
[type_2_f3, type_2_q_sq_C] = LOOCV_C(mdl_2,data_without_demographics, 2, formula_2);

%% Type 3 Model
formula_3 = ...
    "Workload ~ 1 + HR*TrialOrder + RMSSD*Age + RMSSD*Sex + RMSSD*Taskload + RMSSD*TrialOrder"+...
          "+ SDNN*MeanPupilDiameter + pNN50*Sex + RspRate*BlinkCount + RspRate*Age"+...
          "+ RspRate*Taskload + MeanPupilDiameter*Age + MeanPupilDiameter*Sex"+...
          "+ BlinkCount*Age + BlinkCount*Sex + BlinkCount*TrialOrder + Age*Sex" +...
          "+ Sex*Taskload";
mdl_3 = stepwiseglm(data_without_ID,formula_3,'Criterion','aic');
%mdl_3 = fitglm(data_without_ID,formula_3);
type_3_f1 = plotMdl(mdl_3,data_without_ID, 3);
[type_3_f2, type_3_q_sq_B] = LOOCV_B(mdl_3,data, 3, formula_3); %This is not a typo! LOOCV_B needs the ID
[type_3_f3, type_3_q_sq_C] = LOOCV_C(mdl_3,data_without_ID, 3, formula_3);

%% Type 4 Model

formula_4 = ...
    "Workload ~ 1 + ID + HR + SDNN  + Taskload + TrialOrder + HR:pNN50 + HR:RspRate " +...
          "+ RMSSD:Taskload + HR:TrialOrder + RMSSD:TrialOrder";      
      
mdl_4 = stepwiseglm(data,formula_4,'Criterion','aic');
%mdl_4 = fitglm(data,formula_4 );
type_4_f1 = plotMdl(mdl_4,data, 4);
% We cannot do LOOCV_B for Model types 4 and 5
[type_4_f3, type_4_q_sq_C] = LOOCV_C(mdl_4,data, 4, formula_4);

%% Save models
%Save Figs
% savePlots(type_1_f1, 1, '0');
% savePlots(type_1_f2, 1, 'B');
% savePlots(type_1_f3, 1, 'C');
% 
% savePlots(type_2_f1, 2, '0');
% savePlots(type_2_f2, 2, 'B');
% savePlots(type_2_f3, 2, 'C');
% 
% savePlots(type_3_f1, 3, '0');
% savePlots(type_3_f2, 3, 'B');
% savePlots(type_3_f3, 3, 'C');
% 
% savePlots(type_4_f1, 4, '0');
% savePlots(type_4_f3, 4, 'C');
% 
% %Save Coeffs
% saveCoeffs(mdl_1, 1);
% saveCoeffs(mdl_2,2);
% saveCoeffs(mdl_3,3);
% saveCoeffs(mdl_4,4);



%% Helper Functions
%LOO_data should include the workload/SA value
function [q_sq, term_1, term_2] = calculate_q_sq(LOO_data, CV_data, mdl)
   
    
    Y = LOO_data{:, end};
    Y_hat_miss_i = mdl.predict(LOO_data(:, 1:end -1));
    
    Y_bar_miss_i = mean(CV_data{:,end});
    
    term_1 = sum((Y - Y_hat_miss_i).^2);
    term_2 = sum((Y - Y_bar_miss_i).^2);
    
    q_sq = 1 - (term_1/term_2);
        
        

end

function fig = plotMdl(mdl, data, type)
    global ColOrd;
    fig = figure('units','normalized','outerposition',[0 0 1 1]);
    j=1;
    for i=1:12:180
        subplot(3,5,j);
        hold on;
        plot(data.Workload(i:i+11),mdl.Fitted.Response(i:i+11),'o','Color',ColOrd(j,:));
        p = polyfit(data.Workload(i:i+11),mdl.Fitted.Response(i:i+11),1);
        yfit = polyval(p,data.Workload(i:i+11));
        %plot(sart(i:i+11),yfit,'-','Color',ColOrd(j,:),'HandleVisibility','off');
        plot([0,10],[0,10],'-', 'Color', ColOrd(j,:));
        ylim([0,10])
        xlim([0,10])
        ylabel('Model Response');
        xlabel('SART Score');
        title(string(j));
        j = j+1;
        grid on;

    end
    formula="";
    topTitle = formula;
    topTitle = strcat(formula,sprintf('\n'), 'Type ',{' '},string(type),sprintf(' Workload Psychophysiological Regression Model Performance \nAIC = %4.2f BIC = %4.2f R^{2} = %4.2f adjR^{2} = %4.2f',mdl.ModelCriterion.AIC,mdl.ModelCriterion.BIC,mdl.Rsquared.Ordinary,mdl.Rsquared.Adjusted));

    suptitle(topTitle);

end

function [fig, overall_q_sq] = LOOCV_B(mdl,data,type, formula)
    global ColOrd;
    
    fig = figure('units','normalized','outerposition',[0 0 1 1]);
    mdls = {};
    q_sqs = [];
    numerators = [];
    denoms = [];
    for j = (1:15)
        if (j < 10)
            LOO_id = strcat('20',string(j));
        else
            LOO_id = strcat('2',string(j));
        end

        LOO_data = data(data.ID == LOO_id,:);
        CV_data = data(data.ID ~= LOO_id,:);

        %Fit a generalized linear model
        mdl = fitglm(CV_data,formula);
        mdls(j) = {mdl};
        y = mdl.predict(LOO_data);
        subplot(3, 5,j);
        hold on;
        plot(LOO_data.Workload, y,'o','Color',ColOrd(j,:));
        plot([0,10],[0,10],'-', 'Color', ColOrd(j,:));
        ylim([0,10])
        xlim([0,10])
        ylabel('Predicted Workload Response');
        xlabel('Workload Score');
        title(string(j));
        grid on;

        [q_sqs(j), numerators(j), denoms(j)] = calculate_q_sq(LOO_data,CV_data,mdl);
    end
    mdls = mdls';
    q_sqs = q_sqs';

    overall_q_sq = 1 - (sum(numerators) / sum(denoms));
    topTitle =strcat('Type',{' '},string(type), sprintf('\nLOOCV Type B For Workload \nQ^{2} = %4.2f ',overall_q_sq));

    suptitle(topTitle);
end

function [fig, overall_q_sq] = LOOCV_C(mdl, data, type, formula)
    mdls = {};
    all_ys = zeros(180,1);
    all_xs = zeros(180,1);
    q_sqs = [];
    global ColOrd;
    numerators = [];
    denoms = [];
    fig = figure('units','normalized','outerposition',[0 0 1 1]);
    for j = (1:180)
        %LOO_data should include the workload/sa value
        LOO_data = data(j,:);

        CV_data = data;
        CV_data(j,:) = [];

        %Fit a generalized linear model
        mdl = fitglm(CV_data,formula);
        mdls(j) = {mdl};
        y = mdl.predict(LOO_data(1, 1:end-1));
        all_ys(j) = y;
        all_xs(j) = LOO_data.Workload;
        hold on;
        plot(LOO_data.Workload, y,'o','Color','r');
        plot([0,10],[0,10],'-','Color','b');
        ylim([0,10])
        xlim([0,10])
        ylabel('Predicted Workload Response');
        xlabel('Subject Workload Score');
        %title(string(j));
        grid on;

        [q_sqs(j), numerators(j), denoms(j)] = calculate_q_sq(LOO_data,CV_data,mdl);
    end

    p = polyfit(all_xs,all_ys,1);
    yfit = polyval(p,(0:10));
    plot((0:10),yfit,'-','Color','r','HandleVisibility','off');

    mdls = mdls';
    q_sqs = q_sqs';

    overall_q_sq = 1 - (sum(numerators) / sum(denoms));

    topTitle =strcat('Type',{' '},string(type), sprintf('\nLOOCV Type C For Workload \nQ^{2} = %4.2f ',overall_q_sq));

    suptitle(topTitle);
end

function [] = savePlots(fig, type, LOOCV)
%LOOCV = 0, normal fit, =1, B, =2, =C
    
    path = 'C:\Users\BIOPACMan\Documents\Zhang\HOME\regression models\all model figurs\';
    if (LOOCV == '0')
        saveas(fig, strcat(path,'Type',string(type),'.jpg'));
        return;
    end
    saveas(fig, strcat(path,'Type',string(type),' LOOCV',string(LOOCV),'.jpg'));
end

function [] = saveCoeffs(mdl, type)
%LOOCV = 0, normal fit, =1, B, =2, =C
    coeffs = mdl.Coefficients;
    path = 'C:\Users\BIOPACMan\Documents\Zhang\HOME\regression models\all model coeffs\';
   
    writetable(coeffs, strcat(path,'Type',string(type),' Coeffs.csv'),'WriteRowNames',true);
        
end