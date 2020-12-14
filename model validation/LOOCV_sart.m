clear all;
clear workspace;
ColOrd = [0.634197879289704,0.598590500684565,0.335478586307354;0.141323291186943,0.668487146264776,0.619568612502970;0.0793022450665238,0.894564090918275,0.992885717464124;0.876145347529076,0.0873355239070054,0.648005694952403;0.420428701240150,0.539010349313424,0.539775820318468;0.487663607210372,0.428449936007297,0.232254753050780;0.460325494339181,0.617153494459035,0.739832227063707;0.515677249607505,0.558875876956837,0.888992345152850;0.271994390193763,0.225850688199737,0.859807625912606;0.231579838051303,0.104519529950634,0.597060788610351;0.899534076872039,0.00997765604969036,0.654752143480193;0.908697326644413,0.0591533040753343,0.915013993756726;0.603642852234244,0.322652370507717,0.433183080639157;0.365236483082946,0.779476506848221,0.289760755842240;0.634197879289704,0.598590500684565,0.335478586307354];

load('C:\Users\BIOPACMan\Documents\Zhang\HOME\regression models\scaled centered normalized data.mat');

data.pNN50(isnan(data.pNN50)) = 0;
data.Workload = [];
%Define model formula here
formula = 'SART ~ 1 + HR*pNN50 + SDNN*pNN50 + SDNN*SCMeanPupilDiameter + SDNN*ID + HR*Taskload+ HR:TrialOrder + Taskload:TrialOrder + ID:Taskload';
          
figure('units','normalized','outerposition',[0 0 1 1]);
mdls = {};
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
    subplot(3,5,j);
    hold on;
    plot(LOO_data.SART, y,'o','Color',ColOrd(j,:));
    plot([0,46],[0,46],'-', 'Color', ColOrd(j,:));
    ylim([0,46])
    xlim([0,46])
    ylabel('Model Response');
    xlabel('SART Score');
    title(string(j));
    grid on;
end

mdls = mdls';