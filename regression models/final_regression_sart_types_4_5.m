%% Setup 
clear all;
clear workspace;
global ColOrd;
ColOrd = [0.634197879289704,0.598590500684565,0.335478586307354;0.141323291186943,0.668487146264776,0.619568612502970;0.0793022450665238,0.894564090918275,0.992885717464124;0.876145347529076,0.0873355239070054,0.648005694952403;0.420428701240150,0.539010349313424,0.539775820318468;0.487663607210372,0.428449936007297,0.232254753050780;0.460325494339181,0.617153494459035,0.739832227063707;0.515677249607505,0.558875876956837,0.888992345152850;0.271994390193763,0.225850688199737,0.859807625912606;0.231579838051303,0.104519529950634,0.597060788610351;0.899534076872039,0.00997765604969036,0.654752143480193;0.908697326644413,0.0591533040753343,0.915013993756726;0.603642852234244,0.322652370507717,0.433183080639157;0.365236483082946,0.779476506848221,0.289760755842240;0.634197879289704,0.598590500684565,0.335478586307354];

load('raw data.mat');
data = raw_data;

data.HRV_pNN50(isnan(data.HRV_pNN50)) = 0;
data.Workload = [];
data_without_ID = data;
data_without_ID.ID = [];

data_without_demographics = data;
data_without_demographics.ID = [];
data_without_demographics.Age = [];
data_without_demographics.Sex = [];
data_without_TL = data_without_demographics;
data_without_TL.Taskload = [];


%% Type 4 Model
formula_4 = ...
    'SART~1 + HRV_RMSSD + HRV_SDSD + ID + HRV_SDNN:MeanPupilDiameter + RSP_Rate:MeanPupilDiameter + HRV_RMSSD:Taskload + RSP_Rate:Taskload + HRV_RMSSD:TrialOrder + HRV_SDSD:TrialOrder'

formula_D = ...
    'SART~ 1 -TrialOrder - Taskload  + ECG_Rate_Mean*TrialOrder + HRV_MeanNN*RSP_Amplitude + RSP_Rate*Taskload + RSP_Rate*TrialOrder + Sex*Taskload'

%mdl_4 = stepwiseglm(data,formula_4);
mdl_4 = fitglm(data,formula_4 );
type_4_f1 = plotMdl(mdl_4,data, 4);
%pie_4 = pieChartModel(mdl_4.CoefficientNames);
% We cannot do LOOCV_B for Model types 4 and 5
%[type_4_f2, type_4_q_sq_B] = LOOCV_B(mdl_4,data, 4, formula_4)
%[type_4_f3, type_4_q_sq_C] = LOOCV_C(mdl_4,data, 4, formula_4, "", 1);
%[type_4_f5, type_4_q_sq_D] = LOOCV_D(data, 4, formula_4, '+ID') %You need to feed a model 3 formula into LOOCV D
% type_4_f4 = plotRes(mdl_4);

%% Type 5 Model
formula_5 = ...
    'SART~ 1 + HRV_TINN + TrialOrder + ID*Taskload'
%mdl_5 = stepwiseglm(data);
 mdl_5 = fitglm(data,formula_5 );
 %[type_5_f2, type_5_q_sq_B] = LOOCV_B(mdl_5,data, 5, formula_5)
type_5_f1 = plotMdl(mdl_5,data, 5);
% %pie_5 = pieChartModel(mdl_5.CoefficientNames);
% % We cannot do LOOCV_B for Model types 4 and 5
% %[type_5_f3, type_5_q_sq_C] = LOOCV_C(mdl_5,data, 5, formula_5, type_4_f3, 2);
% %[type_5_f5, type_5_q_sq_D] =LOOCV_D(data, 5, formula_5, '+ID*Taskload') %You need to feed a model 3 formula into LOOCV D
% 
% type_5_f4 = plotRes(mdl_5);




%% Save models
%Save Figs
save = 1;
if (save == 1)

    savePlots(type_4_f1, 4, '0');
    %savePlots(type_4_f3, 4, 'C');
    %savePlots(type_4_f4, 4, 'R');
    %savePlots(type_4_f5, 4, 'D');
    %savePlots(pie_4, 4, 'p')

    savePlots(type_5_f1, 5, '0');
    %savePlots(type_5_f3, 5, 'C');
    %savePlots(type_5_f4, 5, 'R');
    %savePlots(type_5_f5, 5, 'D');
    %savePlots(pie_5, 5, 'p')

    saveCoeffs(mdl_4,4);
    saveCoeffs(mdl_5,5);
end


%% Helper Functions
function [y_int,SSR] = find_y_intercept(survey_scores, model_predictions)
    actual_sart_scores = survey_scores; 
    model_values = model_predictions;

    initial_params = [5]; 
    [y_int,SSR] = fminsearch(@(y_int) model_fun(y_int,actual_sart_scores,model_values), initial_params);
%     %% plot
%     ColOrd = rand(15,3);
%     figure; 
%     subplot(1,2,1)
%     scatter(actual_sart_scores,model_values)
%     xlim([0 46])
%     ylim([0 46])
%     hold on
%     plot([0,46],[0,46],'-')
%     subplot(1,2,2)
%     fitted = model_values + y_int;
%     hold on;
%     plot(actual_sart_scores, fitted, 'o', 'Color', ColOrd(2,:))
%     xlim([0 46])
%     ylim([0 46])
%     plot([0,46],[0,46],'-')
    %% end plot

    function SSR = model_fun(y_int, actual_score, yhat)

        Y = actual_score; % the measurements

        [rows, cols] = size(Y);

        Yhat_with_estimate = zeros(rows, cols);
        for i = 1:rows
            Yhat_with_estimate(i) = y_int + yhat(i);
        end

        SSR = sum((Y-Yhat_with_estimate).^2);

    end
end

function fig = plotRes(mdl)
    fig = figure('units','normalized','outerposition',[0 0 1 1]);
    
    subplot(1,3,1)
    plotResiduals(mdl);
    subplot(1,3,2)
    plotResiduals(mdl,'probability','ResidualType','Pearson')
    subplot(1,3,3)
    plotResiduals(mdl,'fitted','ResidualType','Pearson')
    
    sgtitle('Residual Analysis')
end

function fig = pieChartModel(coeffs)

    fig = figure('units','normalized','outerposition',[0 0 1 1]);
    ekg_count = 0;
    rsp_count = 0;
    eye_count = 0;
    demo_count = 0;
    observable_count = 0;
    
    size = length(coeffs);
    labels = {'EKG','RSP','EYE','OBSERVABLES','DEMOGRAPHICS'};
    pie_data = [];
    
    for (i=1:size)
       if contains(coeffs{1,i}, ["HRV","ECG"])
          ekg_count = ekg_count + 1; 
          
       end
       if contains(coeffs{1,i}, "RSP")
          rsp_count = rsp_count + 1;
       end
       if contains(coeffs{1,i}, ["BlinkCount","Pupil"])
          eye_count = eye_count + 1; 
       end
       if contains(coeffs{1,i}, ["Taskload","TrialOrder"])
          observable_count = observable_count + 1; 
       end
       if contains(coeffs{1,i}, ["Age","Sex_0","ID"])
          demo_count = demo_count + 1; 
       end

    end
    pie_data = [ekg_count, rsp_count, eye_count, observable_count, demo_count];
    
    labels(find(~pie_data)) = [];
    
    pie_data = nonzeros(pie_data)';
    
    
    pie(pie_data, labels);
    title('Feature Breakdown By Source');
    
    
end

%LOO_data should include the either workload or SA value
function [q_sq, term_1, term_2] = calculate_q_sq(LOO_data, CV_data, mdl)
   
    
    Y = LOO_data{:, end};
    Y_hat_miss_i = mdl.predict(LOO_data(:, 1:end -1));
    
    Y_bar_miss_i = mean(CV_data{:,end});
    
    term_1 = sum((Y - Y_hat_miss_i).^2);
    term_2 = sum((Y - Y_bar_miss_i).^2);
    
    q_sq = 1 - (term_1/term_2);
        
        

end

%LOO_data should include the either workload or SA value
function [q_sq, term_1, term_2] = calculate_q_sq_LOOCV_B(LOO_data, CV_data, mdl, y_int)
   
    
    Y = LOO_data{:, end};
    Y_hat_miss_i = mdl.predict(LOO_data(:, 1:end -1)) + y_int;
    
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
        plot(data.SART(i:i+11),mdl.Fitted.Response(i:i+11),'o','Color',ColOrd(j,:), 'HandleVisibility','off');
        
        p = polyfit(data.SART(i:i+11),mdl.Fitted.Response(i:i+11),1);
        yfit = polyval(p,data.SART(i:i+11));
        
        plot([0,46],[0,46],'-', 'Color', ColOrd(j,:));
        
        if (j == 1)
            legend("Ideal Relationship");
        end
        %plot(sart(i:i+11),yfit,'-','Color',ColOrd(j,:),'HandleVisibility','off');
        ylim([0,46])
        xlim([0,46])
        ylabel('Model Response');
        xlabel('SART Score');
        title(strcat('Subject ', {' '},string(j)));
        j = j+1;
        grid on;
        ax = gca;
        ax.FontSize = 14;
        xticks([0:10:40]);
    end
        
    formula="";
    topTitle = formula;
    topTitle = strcat(formula,sprintf('\n'), 'Type ',{' '},string(type),sprintf(' SA Psychophysiological Regression Model Performance \nAIC = %4.2f adjR^{2} = %4.2f',mdl.ModelCriterion.AIC,mdl.Rsquared.Adjusted));

    suptitle(topTitle);

end

function [fig, overall_q_sq] = LOOCV_B(mdl,data,type, formula)
    global ColOrd;
    
    fig = figure('units','normalized','outerposition',[0 0 1 1]);
    set(fig,'Position', [0.0026   -0.7870    0.7917    0.7083]);

    mdls = {};
    q_sqs = [];
    numerators = [];
    denoms = [];
    
    total_ssr = 0;
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
        
        
        [y_int, SSR] = find_y_intercept(LOO_data.SART, y);
        
        y = y + y_int;
        total_ssr = total_ssr + SSR;
        
        subplot(3, 5,j);
        hold on;
        plot(LOO_data.SART, y,'o','Color',ColOrd(j,:));
        
        ylim([0,46])
        xlim([0,46])
        ylabel('Predicted SA Response');
        xlabel('SART Score');
        
        plot([0,46],[0,46],'-', 'Color', ColOrd(j,:));
        legend("Predicted Subject", "Ideal Relationship");
        
        title(string(j));
        grid on;

        %We pass in the new Y-intercept for LOOCV_B
        [q_sqs(j), numerators(j), denoms(j)] = calculate_q_sq_LOOCV_B(LOO_data,CV_data,mdl, y_int);
    end
    mdls = mdls';
    q_sqs = q_sqs';

    
    
    overall_q_sq = 1 - (sum(numerators) / sum(denoms));
    topTitle =strcat('Type',{' '},string(type), sprintf('\nLOOCV Type B For SA \nQ^{2} = %4.2f, Total SSR = %4.2f ',overall_q_sq, total_ssr));

    sgtitle(topTitle);
end

function [fig, overall_q_sq] = LOOCV_C(mdl, data, type, formula, fig, subplot_position)
    mdls = {};
    all_ys = zeros(180,1);
    all_xs = zeros(180,1);
    q_sqs = [];
    global ColOrd;
    numerators = [];
    denoms = [];
    
    if (fig == "")
        fig = figure('units','normalized','outerposition',[0 0 1 1]);
        subplot(1,2,subplot_position)
    else
        figure(fig);
        subplot(1,2, subplot_position);
    end
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
        all_xs(j) = LOO_data.SART;
        hold on;
        
        plot(LOO_data.SART, y,'o','Color','r','HandleVisibility','off');
        if (j == 180)
            
            plot(LOO_data.SART, y,'o','Color','r');
        end
        
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
    plot((0:46),yfit,'-','Color','r');
    plot([0,46],[0,46],'-','Color','b');
        
    legend('Predicted Trial Value', 'Line of Best Fit', 'Ideal Relationship');
    mdls = mdls';
    q_sqs = q_sqs';

    overall_q_sq = 1 - (sum(numerators) / sum(denoms));

    topTitle =strcat('Type',{' '},string(type), sprintf('\nLOOCV Type C For SA \nQ^{2} = %4.2f ',overall_q_sq));

    title(topTitle);
    
    sgtitle("Exhaustive Leave One Trial Out Cross Validation");
    
end

%There is a bug in this code, the 'mdls' object keeps getting over
%written. To fix this, implement a new counter for mdls.
function [fig, overall_q_sq] = LOOCV_D(data, type, formula, personalized_terms)
    global ColOrd;
    
    fig = figure('units','normalized','outerposition',[0 0 1 1]);
    mdls = {};
    q_sqs = [];
    numerators = [];
    denoms = [];
    
    i = 1;
    for j = (1:15)
        if (j < 10)
            LOO_id = strcat('20',string(j));
        else
            LOO_id = strcat('2',string(j));
        end

        LOO_data = data(data.ID == LOO_id,:);
        CV_data = data(data.ID ~= LOO_id,:);

        %Fit a generalized linear model
        mdl = fitglm(CV_data,formula); %Type 3 model is created here
        mdls(j) = {mdl};
        subplot(3,5,j);
     
        for k = (1:12)
            %LOO_data should include the workload/sa value
            test_data = LOO_data(k,:);

            new_data = LOO_data(LOO_data.TrialOrder ~= k, :);
            
            combined_data = [new_data; CV_data];
            
            %Fit a generalized linear model
            formula = strcat(formula, personalized_terms);
            mdl = fitglm(combined_data,formula);
            mdls(k) = {mdl};
            y = mdl.predict(test_data(:, 1:end-1));
            all_ys(k) = y;
            all_xs(k) = test_data.SART;
            hold on;
            plot(test_data.SART, y,'o','Color','r','HandleVisibility','off');
            if (k == 12)

                plot(test_data.SART, y,'o','Color','r');
            end

            ylim([0,46])
            xlim([0,46])
            ylabel('Predicted SA Response');
            xlabel('Subject SART Score');
            %title(string(j));
            grid on;
            
            [q_sqs(i), numerators(i), denoms(i)] = calculate_q_sq(test_data,combined_data,mdl);
            
            i = i + 1;
        end
        p = polyfit(all_xs,all_ys,1);
        yfit = polyval(p,(0:46));
        plot((0:46),yfit,'-','Color','r');
        plot([0,46],[0,46],'-','Color','b');
        title(LOO_id)
        legend({'Predicted Trial Value', 'Line of Best Fit', 'Ideal Relationship'},'FontSize',6,'Location','southeast');
    end
    mdls = mdls';
    q_sqs = q_sqs';

    
    
    overall_q_sq = 1 - (sum(numerators) / sum(denoms));
    topTitle =strcat('Type',{' '},string(type), sprintf('\nLOOCV Type D For SA \nQ^{2} = %4.2f ',overall_q_sq));

    sgtitle(topTitle);

end

function [] = savePlots(fig, type, LOOCV)
%LOOCV = 0, normal fit, =1, B, =2, =C
    
    path = 'C:\Users\BIOPACMan\Documents\Zhang\HOME\regression models\final model figurs\';
    if (LOOCV == '0')
        saveas(fig, strcat(path,'Type',string(type),'.jpg'));
        return;
    end
    
     if (LOOCV == 'p')
        saveas(fig, strcat(path,'pie chart ', string(type), '.jpg'));
        return;
     end
     
     if (LOOCV == 'R')
        saveas(fig, strcat(path,'Residuals for Model  ', string(type), '.jpg'));
        return;
     end
     
    saveas(fig, strcat(path,'Type',string(type),' LOOCV',string(LOOCV),'.jpg'));
end

function [] = saveCoeffs(mdl, type)
%LOOCV = 0, normal fit, =1, B, =2, =C
    coeffs = mdl.Coefficients;
    path = 'C:\Users\BIOPACMan\Documents\Zhang\HOME\regression models\final model coeffs\';
   
    writetable(coeffs, strcat(path,'Type',string(type),' Coeffs.csv'),'WriteRowNames',true);
        
end