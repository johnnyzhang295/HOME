
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

x = [];
for type = 1:5

    fn = strcat('type_'+string(type)+'_model_wl_predictions.mat');
    load(fn);
    model_response = double(model_response);
    x(:,type) = model_response;
end

mdl_1 = x(:,1);
mdl_2 = x(:,2);
mdl_3 = x(:,3);
mdl_4 = x(:,4);
mdl_5 = x(:,5);

 
 fig = figure('units','normalized','outerposition',[0 0 1 1]);
 
 plotMdl(mdl_1, raw_data, 'Type 1', 0)
 plotMdl(mdl_2, raw_data, 'Type 2', 1)
 plotMdl(mdl_3, raw_data, 'Type 3', 2)
 plotMdl(mdl_4, raw_data, 'Type 4', 3)
 plotMdl(mdl_5, raw_data, 'Type 5', 4)
 
 sgtitle('WL Model Performance','FontSize',16)
 function [] = plotMdl(mdl, data, type, offset)
 
 j=1;
 pos = j + offset;
for i=1:60:180
    global ColOrd;
    subplot(3,5,pos);
    hold on;
    plot(data.Workload(i:i+11),mdl(i:i+11),'o','Color',ColOrd(j,:), 'HandleVisibility','off');

    p = polyfit(data.Workload(i:i+11),mdl(i:i+11),1);
    yfit = polyval(p,data.Workload(i:i+11));

    plot([0,46],[0,46],'-', 'Color', ColOrd(j,:));

    if (pos == 1)
        legend("Ideal Relationship");
    end
    
    ylim([0,11])
        xlim([0,11])
    if (pos == 6)
    ylabel('Model Response');
    end
    if (pos == 13)
    xlabel('WL Score');
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
         yticks([01:3:10])
          xticks([01:3:10])
end
 end