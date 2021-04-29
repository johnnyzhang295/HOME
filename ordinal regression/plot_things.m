clear all;
clear workspace;
ColOrd = [0.634197879289704,0.598590500684565,0.335478586307354;0.141323291186943,0.668487146264776,0.619568612502970;0.0793022450665238,0.894564090918275,0.992885717464124;0.876145347529076,0.0873355239070054,0.648005694952403;0.420428701240150,0.539010349313424,0.539775820318468;0.487663607210372,0.428449936007297,0.232254753050780;0.460325494339181,0.617153494459035,0.739832227063707;0.515677249607505,0.558875876956837,0.888992345152850;0.271994390193763,0.225850688199737,0.859807625912606;0.231579838051303,0.104519529950634,0.597060788610351;0.899534076872039,0.00997765604969036,0.654752143480193;0.908697326644413,0.0591533040753343,0.915013993756726;0.603642852234244,0.322652370507717,0.433183080639157;0.365236483082946,0.779476506848221,0.289760755842240;0.634197879289704,0.598590500684565,0.335478586307354];

num_types = 5;

mse = [];
mse2 = [];

    load('../regression models/raw data.mat');

for type = 3:3

    fn = strcat('type_'+string(type)+'_model_wl_predictions.mat');
    load(fn);
    fn = strcat('type_'+string(type)+'__LOOCV_B_predictions.mat');
    load(fn);
    fn = strcat('type_'+string(type)+'__LOOCV_C_predictions.mat');
    load(fn);

    model_response = double(model_response);

    LOOCV_B= double(LOOCV_B);
    LOOCV_C = double(LOOCV_C);
    
    data = raw_data;

    fig = figure('units','normalized','outerposition',[0 0 1 1]);
    j=1;
    for i=1:12:180
        subplot(3,5,j);
        hold on;
        plot(data.Workload(i:i+11),model_response(i:i+11),'o','Color',ColOrd(j,:), 'HandleVisibility','off');

        p = polyfit(data.Workload(i:i+11),model_response(i:i+11),1);
        yfit = polyval(p,data.Workload(i:i+11));

        plot([0,11],[0,11],'-', 'Color', ColOrd(j,:));
        if (j == 1)
        legend("Ideal Relationship", 'FontSize', 14);
        end
        %plot(sart(i:i+11),yfit,'-','Color',ColOrd(j,:),'HandleVisibility','off');
        ylim([0,11])
        xlim([0,11])
         yticks([01:10])
          xticks([01:10])
        ylabel('Model Response');
        xlabel('Workload Score');
        title(strcat('Subject', {' '}, string(j)));
        j = j+1;
        grid on;
        ax  = gca;
        ax.FontSize =14;

    end
    topTitle = strcat( 'Type ',{' '},string(type),newline,sprintf(' Workload Ordinal Regression Model Performance'));

    suptitle(topTitle);

    savePlots(fig, type, '0');

    %%%%%%%%%%LOOCV B plottings
    fig = figure('units','normalized','outerposition',[0 0 1 1]);
    j=1;
    for i=1:12:180
        subplot(3,5,j);
        hold on;
        plot(data.Workload(i:i+11),LOOCV_B(i:i+11),'o','Color',ColOrd(j,:));

        p = polyfit(data.Workload(i:i+11),LOOCV_B(i:i+11),1);
        yfit = polyval(p,data.Workload(i:i+11));

        plot([0,11],[0,11],'-', 'Color', ColOrd(j,:));

        %plot(sart(i:i+11),yfit,'-','Color',ColOrd(j,:),'HandleVisibility','off');
        ylim([0,11])
        xlim([0,11])
         yticks([01:10])
          xticks([01:10])
        ylabel('Model Response');
        xlabel('Subject Workload Response');
        title(strcat('Subject', {' '},string(j)));
        j = j+1;
        grid on;
        if (j-1 == 1)
        legend({"Predicted Subject", "Ideal Relationship"}, 'FontSize',14);
        end
        ax = gca;
        ax.FontSize = 14;
    end

    topTitle = strcat( 'Type ',{' '},string(type),newline,sprintf(' Leave One Subject Out CV for WL'));

    suptitle(topTitle);
    
    savePlots(fig, type, 'B');
    
    
end

xx = 5;
    fig = figure('units','normalized','outerposition',[0 0 1 1]);
    pos = 2;
for type = 1:3
%% plot C
fn = strcat('type_'+string(type)+'_model_wl_predictions.mat');
    load(fn);
    fn = strcat('type_'+string(type)+'__LOOCV_B_predictions.mat');
    load(fn);
    fn = strcat('type_'+string(type)+'__LOOCV_C_predictions.mat');
    load(fn);

    model_response = double(model_response);

    LOOCV_B= double(LOOCV_B);
    LOOCV_C = double(LOOCV_C);
    
    data = raw_data;
   %type = type - 2; % only for 4/5 nonsense
    
   subplot(2,4,pos);
   
   pos = pos + 1;
    plot(data.Workload,LOOCV_C,'o','Color','r')
        
    ylim([0,11])
    xlim([0,11])
     yticks([1:10])
      xticks([01:10])
      
     
     if type == 2
         
     xlabel('Subject Workload Response');
     end
    grid on;
    hold on;
    
    p = polyfit(data.Workload,LOOCV_C,1);
    yfit = polyval(p,(0:11));
    plot((0:11),yfit,'-','Color','r');
    plot([0,11],[0,11],'-','Color','b');
    ax = gca;
    ax.FontSize = 14;
    if pos == 3
        ylabel('Predicted WL Response');
        xlabel('Subject WL Score');
        legend({'Predicted Trial Value', 'Line of Best Fit', 'Ideal Relationship'}, 'FontSize', 14, 'Location', 'northwest' )

    end
    
 if type == 2
          
    ylabel('Predicted WL Response');
    %
 end
      %type = type + 2; % more 4/5 nonsense
    topTitle =strcat('Type',{' '},string(type));
    title(topTitle);
end
type = 4;
sgtitle("Exhaustive Leave One Trial Out Cross Validation");
savePlots(fig, type, 'C');

%% make some pies
mdl_1_coeffs = {
'HRV_HR',
'HRV_RMSSD',
'HRV_MeanNN',
'HRV_SDNN',
'HRV_SDSD',
'HRV_CVNN',
'HRV_CVSD',
'HRV_MedianNN',
'HRV_MadNN',
'HRV_MCVNN',
'HRV_IQRNN',
'HRV_pNN50',
'HRV_pNN20',
'HRV_TINN',
'HRV_HTI',
'RSP_Amplitude',
'MeanPupilDiameter',
'BlinkCount',
'HRV_CVNN x HRV_TINN',
'HRV_pNN50 x RSP_Amplitude',
'HRV_pNN50 x HRV_HTI',
'HRV_IQRNN x HRV_HTI',
'MeanPupilDiameter x BlinkCount',
'HRV_HR x HRV_HTI',
'HRV_HR x HRV_CVNN',
'HRV_MeanNN x HRV_pNN50',
'HRV_HR x HRV_pNN50'}';
pie_1 = pieChartModel(mdl_1_coeffs)
savePlots(pie_1, 1, 'p')

mdl_2_coeffs = {
'HRV_HR',
'HRV_RMSSD',
'HRV_MeanNN',
'HRV_SDNN',
'HRV_SDSD',
'HRV_CVNN',
'HRV_CVSD',
'HRV_MedianNN',
'HRV_MadNN',
'HRV_MCVNN',
'HRV_IQRNN',
'HRV_pNN50',
'HRV_pNN20',
'HRV_TINN',
'HRV_HTI',
'RSP_Amplitude',
'RSP_Rate',
'MeanPupilDiameter',
'BlinkCount',
'Taskload',
'TrialOrder',
'HRV_MadNN x BlinkCount',
'MeanPupilDiameter x TrialOrder',
'RSP_Amplitude x Taskload',
'HRV_MeanNN x MadNN',
}'
pie_2 = pieChartModel(mdl_2_coeffs)
savePlots(pie_2, 2, 'p')

mdl_3_coeffs = {
'HRV_HR',
'HRV_RMSSD',
'HRV_MeanNN',
'HRV_SDNN',
'HRV_CVNN',
'HRV_CVSD',
'HRV_MedianNN',
'HRV_MadNN',
'HRV_MCVNN',
'HRV_pNN50',
'HRV_pNN20',
'HRV_TINN',
'RSP_Amplitude',
'RSP_Rate',
'MeanPupilDiameter',
'BlinkCount',
'Age',
'Taskload',
'TrialOrder',
'HRV_MeanNN x HRV_MadNN',
'RSP_Amplitude x Taskload',
'HRV_MCVNN x HRV_TINN',
'MeanPupilDiameter x TrialOrder',
'BlinkCount x Age',
'HRV_pNN50 x RSP_Amplitude',
'RSP_Amplitude x RSP_Rate',
'Age x TrialOrder',
'HRV_pNN20 x MeanPupilDiameter',
'HRV_MedianNN x Age',
'HRV_HR x Age',
'Age x Taskload',
'HRV_CVNN x HRV_pNN20',
'HRV_MeanNN x MeanPupilDiameter',
'HRV_MedianNN x MeanPupilDiameter',

}'
pie_3 = pieChartModel(mdl_3_coeffs)
savePlots(pie_3, 3, 'p')

mdl_4_coeffs  = {
'HRV_HR',
'HRV_RMSSD',
'HRV_MeanNN',
'HRV_SDNN',
'HRV_SDSD',
'HRV_CVNN',
'HRV_CVSD',
'HRV_MedianNN',
'HRV_MadNN',
'HRV_MCVNN',
'HRV_pNN50',
'HRV_pNN20',
'HRV_TINN',
'RSP_Amplitude',
'RSP_Rate',
'MeanPupilDiameter',
'Taskload',
'TrialOrder',
'BlinkCount',
'HRV_MeanNN:HRV_MadNN',
'RSP_Amplitude:Taskload',
'HRV_MCVNN:HRV_TINN',
'MeanPupilDiameter:TrialOrder',
'HRV_pNN50:RSP_Amplitude',
'RSP_Amplitude:RSP_Rate',
'HRV_pNN20:MeanPupilDiameter'
'HRV_CVNN:HRV_pNN20',
'HRV_MeanNN:MeanPupilDiameter',
'HRV_MedianNN:MeanPupilDiameter',
'HRV_MCVNN:HRV_TINN'

}';
pie_4 = pieChartModel(mdl_4_coeffs);
savePlots(pie_4, 4, 'p');

mdl_5_coeffs  = {
'HRV_HR',
'HRV_RMSSD',
'HRV_MeanNN',
'HRV_SDNN',
'HRV_CVNN',
'HRV_MedianNN',
'HRV_MadNN',
'HRV_MCVNN',
'HRV_IQRNN',
'HRV_pNN50',
'HRV_pNN20',
'HRV_TINN',
'HRV_HTI',
'RSP_Amplitude',
'RSP_Rate',
'MeanPupilDiameter',
'BlinkCount',
'Taskload',
'TrialOrder',
'MeanPupilDiameter x TrialOrder',
'HRV_MadNN x ID',
'HRV_pNN20 x MeanPupilDiameter',
'RSP_Amplitude:RSP_Rate',
'HRV_SDNN:BlinkCount',
'HRV_MCVNN:HRV_HTI',
'HRV_MadNN:HRV_pNN20',
'MeanPupilDiameter:BlinkCount'
'HRV_HTI:RSP_Rate',
'HRV_HTI:TrialOrder'
}';
pie_5 = pieChartModel(mdl_5_coeffs);
savePlots(pie_5, 5, 'p');

%% end of pies, start of helpers
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
       if contains(coeffs{1,i}, ["Age","Sex_0"])
          demo_count = demo_count + 1; 
       end

    end
    pie_data = [ekg_count, rsp_count, eye_count, observable_count, demo_count];
    
    labels(find(~pie_data)) = [];
    
    pie_data = nonzeros(pie_data)';
    
    
    p = pie(pie_data, labels);
    
    for (i = 2:2:length(p))
        p(i).FontSize = 30;
        
    end
    title('Feature Breakdown By Source', 'FontSize', 30);
    
    
end
function [] = savePlots(fig, type, LOOCV)
%LOOCV = 0, normal fit, =1, B, =2, =C
    
    path = 'C:\Users\BIOPACMan\Documents\Zhang\HOME\ordinal regression\figures\';
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