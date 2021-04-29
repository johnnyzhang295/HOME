
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


% Type 1 Model
formula_1 = ...
"SART ~ 1 + ECG_Rate_Mean*HRV_MeanNN + ECG_Rate_Mean*RSP_Amplitude + HRV_RMSSD:HRV_pNN50 + HRV_RMSSD*RSP_Rate + HRV_RMSSD*MeanPupilDiameter + HRV_MeanNN:HRV_pNN50 + HRV_SDNN:HRV_TINN + HRV_SDNN:RSP_Rate + HRV_pNN50:MeanPupilDiameter";
mdl_1 = fitglm(data_without_TL, formula_1);
formula_2 = ...
'SART~ 1 + ECG_Rate_Mean + MeanPupilDiameter -HRV_pNN50 -Taskload + HRV_MeanNN*HRV_SDNN + HRV_MeanNN*HRV_pNN50 + HRV_MeanNN*TrialOrder + HRV_SDNN*HRV_pNN50 + HRV_SDNN*RSP_Amplitude + HRV_CVNN*RSP_Amplitude + HRV_CVNN*TrialOrder + HRV_TINN:Taskload + RSP_Rate:MeanPupilDiameter + RSP_Rate:Taskload'
mdl_2 = fitglm(data_without_demographics, formula_2);
% Type 3 Model
formula_3 = ...
    'SART~ 1 -TrialOrder - Taskload  + ECG_Rate_Mean*TrialOrder + HRV_MeanNN*RSP_Amplitude + RSP_Rate*Taskload + RSP_Rate*TrialOrder + Sex*Taskload'
mdl_3 = fitglm(data_without_ID,formula_3);
formula_4 = ...
    'SART~1 + HRV_RMSSD + HRV_SDSD + ID + HRV_SDNN:MeanPupilDiameter + RSP_Rate:MeanPupilDiameter + HRV_RMSSD:Taskload + RSP_Rate:Taskload + HRV_RMSSD:TrialOrder + HRV_SDSD:TrialOrder'
mdl_4 = fitglm(data,formula_4 );
formula_5 = ...
    'SART~ 1 + HRV_TINN + TrialOrder + ID*Taskload'
 mdl_5 = fitglm(data,formula_5 );
 
 
 fig = figure('units','normalized','outerposition',[0 0 1 1]);
 
 plotMdl(mdl_1, data, 'Type 1', 0)
 plotMdl(mdl_2, data, 'Type 2', 1)
 plotMdl(mdl_3, data, 'Type 3', 2)
 plotMdl(mdl_4, data, 'Type 4', 3)
 plotMdl(mdl_5, data, 'Type 5', 4)
 
 sgtitle('SA Model Performance','FontSize',16)
 function [] = plotMdl(mdl, data, type, offset)
 
 j=1;
 pos = j + offset;
for i=1:60:180
    global ColOrd;
    subplot(3,5,pos);
    hold on;
    plot(data.SART(i:i+11),mdl.Fitted.Response(i:i+11),'o','Color',ColOrd(j,:), 'HandleVisibility','off');

    p = polyfit(data.SART(i:i+11),mdl.Fitted.Response(i:i+11),1);
    yfit = polyval(p,data.SART(i:i+11));

    plot([0,46],[0,46],'-', 'Color', ColOrd(j,:));

    if (pos == 1)
        legend("Ideal Relationship");
    end
    
    ylim([0,46])
    xlim([0,46])
    
    if (pos == 6)
    ylabel('Model Response');
    end
    if (pos == 13)
    xlabel('SART Score');
    end
    if (j == 1)
         title([type strcat('Subject ',{' '},string(j))]);
    else
        title(strcat('Subject ', {' '},string(j)));
    end
    j = j+5;
    
    pos = j + offset;
    grid on;
    grid minor
    ax = gca;
    ax.FontSize = 16;
    xticks([0:10:40]);
    
    yticks([0:10:40]);
end
 end