clear all;
clear workspace;
ColOrd = [0.634197879289704,0.598590500684565,0.335478586307354;0.141323291186943,0.668487146264776,0.619568612502970;0.0793022450665238,0.894564090918275,0.992885717464124;0.876145347529076,0.0873355239070054,0.648005694952403;0.420428701240150,0.539010349313424,0.539775820318468;0.487663607210372,0.428449936007297,0.232254753050780;0.460325494339181,0.617153494459035,0.739832227063707;0.515677249607505,0.558875876956837,0.888992345152850;0.271994390193763,0.225850688199737,0.859807625912606;0.231579838051303,0.104519529950634,0.597060788610351;0.899534076872039,0.00997765604969036,0.654752143480193;0.908697326644413,0.0591533040753343,0.915013993756726;0.603642852234244,0.322652370507717,0.433183080639157;0.365236483082946,0.779476506848221,0.289760755842240;0.634197879289704,0.598590500684565,0.335478586307354];

load('scaled centered normalized data.mat');

data.pNN50(isnan(data.pNN50)) = 0;

%These should always be different
sa_bool = 0;
wl_bool = 1;

if (sa_bool == 0)
    data.SART=[];
end
if (wl_bool == 0)
    data.Workload = [];
end

%mdl = stepwiseglm(data,'linear','Criterion','aic');
%formula = char(mdl.Formula);

formula = 'Workload ~ 1 + HR*SDNN + HR*SCMeanPupilDiameter + HR*Taskload + SDNN*TrialOrder + pNN50*RspRate + pNN50*Sex + pNN50*TrialOrder + RspRate*SCMeanPupilDiameter + RspRate*Age + RspRate*Sex + RspRate*Taskload + SCMeanPupilDiameter*Taskload + SCBlinkCount*Sex + Age*TrialOrder';

mdl = fitglm(data,formula);
figure('units','normalized','outerposition',[0 0 1 1]);

j=1;
for i=1:12:180
    subplot(3,5,j); 
    hold on;
    if (wl_bool == 1)
        plot(data.Workload(i:i+11),mdl.Fitted.Response(i:i+11),'o','Color',ColOrd(j,:));
        p = polyfit(data.Workload(i:i+11),mdl.Fitted.Response(i:i+11),1);
        yfit = polyval(p,data.Workload(i:i+11));
        plot([1,10],[1,10],'-', 'Color', ColOrd(j,:));
        ylim([1,10])
        xlim([1,10])
        ylabel('Model Response');
        xlabel('Reported Workload');
    end
    if (sa_bool == 1)
        plot(data.SART(i:i+11),mdl.Fitted.Response(i:i+11),'o','Color',ColOrd(j,:));
        p = polyfit(data.SART(i:i+11),mdl.Fitted.Response(i:i+11),1);
        yfit = polyval(p,data.SART(i:i+11));
        plot([0,46],[0,46],'-', 'Color', ColOrd(j,:));
        ylim([0,46])
        xlim([0,46])
        ylabel('Model Response');
        xlabel('SART Score');
    end
    
    title(string(j));
    j = j+1;
    grid on;
    
end
topTitle = formula;
if (sa_bool == 0)
    topTitle = strcat(formula, sprintf('\nWorkload Psychophysiological Regression Model Performance \nAIC = %4.2f BIC = %4.2f R^{2} = %4.2f adjR^{2} = %4.2f',mdl.ModelCriterion.AIC,mdl.ModelCriterion.BIC,mdl.Rsquared.Ordinary,mdl.Rsquared.Adjusted));
else
    topTitle = strcat(formula, sprintf('\n SA Psychophysiological Regression Model Performance \nAIC = %4.2f BIC = %4.2f R^{2} = %4.2f adjR^{2} = %4.2f',mdl.ModelCriterion.AIC,mdl.ModelCriterion.BIC,mdl.Rsquared.Ordinary,mdl.Rsquared.Adjusted));
end
suptitle(topTitle);