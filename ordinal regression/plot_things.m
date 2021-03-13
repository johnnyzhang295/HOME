clear all;
clear workspace;
ColOrd = [0.634197879289704,0.598590500684565,0.335478586307354;0.141323291186943,0.668487146264776,0.619568612502970;0.0793022450665238,0.894564090918275,0.992885717464124;0.876145347529076,0.0873355239070054,0.648005694952403;0.420428701240150,0.539010349313424,0.539775820318468;0.487663607210372,0.428449936007297,0.232254753050780;0.460325494339181,0.617153494459035,0.739832227063707;0.515677249607505,0.558875876956837,0.888992345152850;0.271994390193763,0.225850688199737,0.859807625912606;0.231579838051303,0.104519529950634,0.597060788610351;0.899534076872039,0.00997765604969036,0.654752143480193;0.908697326644413,0.0591533040753343,0.915013993756726;0.603642852234244,0.322652370507717,0.433183080639157;0.365236483082946,0.779476506848221,0.289760755842240;0.634197879289704,0.598590500684565,0.335478586307354];

type=2
load('type_2_model_wl_predictions.mat');
load('type_2__LOOCV_B_predictions.mat');
model_response = double(model_response);
load('../regression models/raw data.mat');

LOOCV_B= double(LOOCV_B);
data = raw_data;


fig = figure('units','normalized','outerposition',[0 0 1 1]);
j=1;
for i=1:12:180
    subplot(3,5,j);
    hold on;
    plot(data.Workload(i:i+11),model_response(i:i+11),'o','Color',ColOrd(j,:), 'HandleVisibility','off');

    p = polyfit(data.Workload(i:i+11),model_response(i:i+11),1);
    yfit = polyval(p,data.Workload(i:i+11));

    plot([0,10],[0,10],'-', 'Color', ColOrd(j,:));

    legend("Ideal Relationship");
    %plot(sart(i:i+11),yfit,'-','Color',ColOrd(j,:),'HandleVisibility','off');
    ylim([0,10])
    xlim([0,10])
     yticks([0:10])
      xticks([0:10])
    ylabel('Model Response');
    xlabel('Workload Score');
    title(string(j));
    j = j+1;
    grid on;

end
topTitle = strcat( 'Type ',{' '},string(type),newline,sprintf(' Workload Ordinal Regression Model Performance'));

suptitle(topTitle);


%%%%%%%%%%LOOCV B plottings
fig = figure('units','normalized','outerposition',[0 0 1 1]);
j=1;
for i=1:12:180
    subplot(3,5,j);
    hold on;
    plot(data.Workload(i:i+11),LOOCV_B(i:i+11),'o','Color',ColOrd(j,:));

    p = polyfit(data.Workload(i:i+11),LOOCV_B(i:i+11),1);
    yfit = polyval(p,data.Workload(i:i+11));

    plot([0,10],[0,10],'-', 'Color', ColOrd(j,:));

    %plot(sart(i:i+11),yfit,'-','Color',ColOrd(j,:),'HandleVisibility','off');
    ylim([0,10])
    xlim([0,10])
     yticks([0:10])
      xticks([0:10])
    ylabel('Model Response');
    xlabel('Predicted Workload Response');
    title(string(j));
    j = j+1;
    grid on;

    legend({"Predicted Subject", "Ideal Relationship"});
end

topTitle = strcat( 'Type ',{' '},string(type),newline,sprintf(' LOOCV B for Workload'));

suptitle(topTitle);