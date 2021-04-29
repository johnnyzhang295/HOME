
    load('../regression models/raw data.mat');
    pos  = 1
    
    fig = figure('units','normalized','outerposition',[0 0 1 1]);
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
    
   subplot(1,3,pos);
   
   pos = pos + 1;
    plot(data.Workload,LOOCV_C,'o','Color','r')
        
     
     if type == 2
         
        xlabel('Subject WL Score');
     end
    grid on;
    hold on;
    
    p = polyfit(data.Workload,LOOCV_C,1);
    yfit = polyval(p,(-5:15));
    plot((-5:15),yfit,'-','Color','r');
    plot([0,11],[0,11],'-','Color','b');
    ax = gca;
    ax.FontSize = 25;
    
    axis equal
    ax.XLim = [0,11];
    ylim([0,11])
    yticks([1:10])
    xticks([01:10])
      
    if pos == 2
        ylabel('Predicted WL Response');
        legend({'Predicted Trial Value', 'Line of Best Fit', 'Ideal Relationship'}, 'FontSize', 14, 'Location', 'northwest' )

    end
    
      %type = type + 2; % more 4/5 nonsense
    topTitle =strcat('Type',{' '},string(type));
    title(topTitle);
end
type = 4;
sgtitle("Exhaustive Leave One Trial Out Cross Validation",'FontSize',25);