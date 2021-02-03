clear all;
clear workspace;

load('raw data.mat');
load('baseline data.mat');

% baseline_data(14,:) = [];
% baseline_data(7,:) = [];
% baseline_data(10,:) = [];
% 
% raw_data(raw_data.ID == '207',:) = [];
% raw_data(raw_data.ID == '210',:) = [];
% raw_data(raw_data.ID == '214',:) = [];

baseline_HR = baseline_data.ECG_Rate_Mean;
HR = raw_data.ECG_Rate_Mean;

baseline_pNN50 = baseline_data.HRV_pNN50;
pNN50 = raw_data.HRV_pNN50;

baseline_MCVNN = baseline_data.HRV_MCVNN;
MCVNN = raw_data.HRV_MCVNN;

xprmnt_data = [HR pNN50 MCVNN];
bsln_data = [baseline_HR baseline_pNN50 baseline_MCVNN];
bsln_data = repelem(bsln_data, 12, 1);

labels = {'HR', 'pNN50', 'MCVNN'};

std_data = [];
means_std_data = [];
j = 1;
for (i=1:12:height(raw_data))
    std_data(i:i+11,:) = normalize(xprmnt_data(i:i+11,:));
    means_std_data(j,:) = mean(xprmnt_data(i:i+11,:));
    
    j = j + 1;
end


exp_means = repelem(means_std_data, 12, 1);

%%
% % for loop
% for (i = 1:3)
%     figure('units','normalized','outerposition',[0 0 1 1]);
% 
%     x = bsln_data(:,1);
%     y =  xprmnt_data(:,i);
%     z = std_data(:,i);
%     m = exp_means(:,i);
% 
%     subplot(2, 2, 1);
%     plot(x, y,'o');
%     xlabel('Baseline HR');
%     ylabel(labels(i));
%     title('Raw vs Baseline HR');
% 
%     subplot(2,2,2);
%     percent_change = (y - x) ./ x;
%     plot(x, percent_change, 'o', 'Color', 'b');
%     xlabel('Baseline HR');
%     ylabel(strcat(labels(i), ' Percent Change'));
%     title('Percent Change ((Y - X)/X) vs Baseline HR');
% 
%     subplot(2,2,3);
%     ratio = y./x;
%     plot(x, ratio, 'o', 'Color', 'b');
%     xlabel('Baseline HR');
%     ylabel(strcat(labels(i), ' Ratio'));
%     title('Ratio (Y/X) vs Baseline HR')
% 
%     subplot(2,2,4);
%     plot(m, z, 'o', 'Color', 'b');
%     xlabel('Raw Experimental Means')
%     ylabel(strcat(labels(i), ' Standardized Within Raw Exp'));
%     title('Standardized Within Exp ((Y - Mu)/Std) vs Experiment Mean');
% 
% end

%%

% for (i = 2:3)
%     y =  xprmnt_data(:,i);
% 
%     z = reshape(y, 12, 15);
%     
%     figure('units','normalized','outerposition',[0 0 1 1]);
%     for (j=1:15)
%         subplot(3, 5, j);
%         normed_z = (z(:,j) - mean(z(:,j)))/std(z(:,j));
%         [h,p] = kstest(normed_z)
%         hold on;
%         cdfplot(normed_z);
%         title(strcat('Subject ',{' '}, string(j), {' '}, labels(i), ' Empirical CDF'));
%         text(-1,.85,strcat('P-Value = ',string(p)));
%         x_values = linspace(min(normed_z),max(normed_z));
%         plot(x_values,normcdf(x_values,0,1),'r-')
%         legend('Empirical CDF','Standard Normal CDF','Location','southeast')
%     end
% 
%     normed_y = (y - mean(y))/std(y);
%     [h,p] = kstest(normed_y)
% 
%     figure('units','normalized','outerposition',[0 0 1 1]);
%     hold on;
%     cdfplot(normed_y);
%     title(strcat(labels(i), ' Empirical CDF'));
%     text(-1,.85,strcat('P-Value = ',string(p)));
%     x_values = linspace(min(normed_y),max(normed_y));
%     plot(x_values,normcdf(x_values,0,1),'r-')
%     legend('Empirical CDF','Standard Normal CDF','Location','best')
% 
% end
%% tests for normality
% 
% p_kstests = [];
% p_kstests_individual = [];
% 
% for (i = 1:19)
%     y =  raw_data{:,i};
% 
%     z = reshape(y, 12, 15);
%     
%     for (j=1:15)
%         normed_z = (z(:,j) - mean(z(:,j)))/std(z(:,j));
%         [h,p] = kstest(normed_z)
%         p_kstests_individual(j, i) = p;
%     end
% 
%     normed_y = (y - mean(y))/std(y);
%     [h,p] = kstest(normed_y)
%     
%     p_kstests(i) = p;
% 
%    
% 
% end
% 
% p_kstests = array2table(p_kstests);
% p_kstests_individual = array2table(p_kstests_individual);
% p_kstests.Properties.VariableNames = raw_data.Properties.VariableNames(1:19);
% 
% p_kstests_individual.Properties.VariableNames = raw_data.Properties.VariableNames(1:19);
% 
% %% tests for homo
% p_bftests = [];
% 
% for (i = 1:19)
%    
%     y =  raw_data{:,i};
% 
%     z = reshape(y, 12, 15); 
%     
%     p = vartestn(z,'TestType','BrownForsythe', 'Display', 'off')
%     p_bftests(i) = p;
%     
% end
% 
% vartestn(reshape(raw_data{:,10}, 12, 15),'TestType','BrownForsythe');
% 
% vartestn(reshape(raw_data{:,12}, 12, 15),'TestType','BrownForsythe');

%%
% 
% rescaled = [];
% for (i = 1:12:180)
%     y = raw_data{i:i+11,[1:19 25 26]};
%     colmin = min(y);
%     colmax  = max(y);
%     Bcol = rescale(y,'InputMin',colmin,'InputMax',colmax)
%     
%     
%     rescaled(i:i+11,:) = Bcol;
%     
% end
% % 
% % labels = raw_data.Properties.VariableNames(1:19);
% % 
% % for (i = 1:19)
% %     figure('units','normalized','outerposition',[0 0 1 1]);
% % 
% %     ids = raw_data.ID;
% %     y =  rescaled(:,i);
% %     wl = rescaled(:,end);
% %     sart = rescaled(:,end-1);
% % 
% %     xlabel('ID');
% %     ylabel(labels(i));
% %     title('DV Distribution');
% %     
% %     plot(ids,y, 'o', 'Color','b');
% %     hold on;
% %     ylabel('Scaled Axis');
% %     plot(ids, wl ,'o','Color','r');
% %     legend({labels{i}, 'Workload'},'Interpreter','none');
% %     title('Scaled DV vs Workload');
% %     [h, p] = vartest2(y, wl);
% %     text(1,.9,strcat('P-Value for F-Test: ',string(p)));
% %     saveas(gcf, strcat('C:\Users\BIOPACMan\Documents\Zhang\HOME\data vis\dv visuals\workload_',sprintf(labels{i}),'.jpg'));
% %     
% %    
% % end
% % 
% % for (i = 1:19)
% %     figure('units','normalized','outerposition',[0 0 1 1]);
% % 
% %     ids = raw_data.ID;
% %     y =  rescaled(:,i);
% %     wl = rescaled(:,end);
% %     sart = rescaled(:,end-1);
% % 
% %     xlabel('ID');
% %     ylabel(labels(i));
% %     title('DV Distribution');
% %     
% %     plot(ids,y, 'o', 'Color','b');
% %     hold on;
% %     ylabel('Scaled Axis');
% %     plot(ids, sart, 'o','Color','g');
% %     legend({labels{i}, 'SART'},'Interpreter','none');
% %     title('Scaled DV vs SART');
% %     [h, p] = vartest2(y, sart);
% %     text(1,.9,strcat('P-Value for F-Test: ',string(p)));
% %     saveas(gcf, strcat('C:\Users\BIOPACMan\Documents\Zhang\HOME\data vis\dv visuals\sart_',labels{i},'.jpg'));
% %     
% % end
% 
% p_vals_wl = [];
% p_vals_sa = [];
% for (i = 1:19)
%     
%     count = 1;
%     for (j=1:12:180)
%         
%         y =  rescaled(j:j+11,i);
%         wl = rescaled(j:j+11,end);
%         sart = rescaled(j:j+11,end-1);
%         [h1,p1] = vartest2(y, wl);
%         [h2,p2] = vartest2(y,sart);
%         p_vals_wl(count, i) = p1;
%         p_vals_sa(count,i) = p2;
%         
%         count = count + 1;
%     end
%     
%     
%     
% end
% 
% 
% for (i = 2)
%     
%     figure;
%     
%     scatter(raw_data{:,end-1}, raw_data{:,i});
%     
% end
%%

p_kstests = [];
p_kstests_individual = [];

for (i = 25:26)
    y =  raw_data{:,i};

    z = reshape(y, 12, 15);
    
    for (j=1:15)
        normed_z = (z(:,j) - mean(z(:,j)))/std(z(:,j));
        [h,p] = kstest(normed_z)
        p_kstests_individual(j, i) = p;
    end

    normed_y = (y - mean(y))/std(y);
    [h,p] = kstest(normed_y)
    
    p_kstests(i) = p;

   

end
p_kstests(:,1:24) = [];
p_kstests_individual(:,1:24) = [];
p_kstests = array2table(p_kstests);
p_kstests_individual = array2table(p_kstests_individual);
p_kstests.Properties.VariableNames = raw_data.Properties.VariableNames(25:26);

p_kstests_individual.Properties.VariableNames = raw_data.Properties.VariableNames(25:26);
