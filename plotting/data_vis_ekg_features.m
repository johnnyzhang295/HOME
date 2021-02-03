clear all; clear workspace;
load('raw data.mat')
load('baseline data.mat')

% %% plot baseline stuff first
% set(groot,'defaultAxesTickLabelInterpreter','none');  
% figure('units','normalized','outerposition',[0 0 1 1]);
% boxchart(baseline_data{:,:})
% xticklabels(baseline_data.Properties.VariableNames);
% title('Baseline EKG Features Cohort');
% saveas(gcf, 'C:\Users\BIOPACMan\Documents\Zhang\HOME\data vis\ekg\baseline all boxplot.jpg');


%% Plot Experiment data

% for i = (1:15)
%     colData = raw_data(:,i);
%     figure('units','normalized','outerposition',[0 0 1 1]);
%     boxchart(raw_data.ID, colData{:,1});
%     title(colData.Properties.VariableNames, 'Interpreter','none');
%     xlabel('Subject ID');
%     
%     fn = strcat('C:\Users\BIOPACMan\Documents\Zhang\HOME\data vis\ekg\',colData.Properties.VariableNames,'.jpg');
%     saveas(gcf, fn{:});
%     close();
% end
% figure('units','normalized','outerposition',[0 0 1 1]);
% for i = (1:15)
%     subplot(3, 5, i);
%     colData = raw_data(:,i);
%     
%     boxchart(raw_data.ID, colData{:,1});
%     title(colData.Properties.VariableNames, 'Interpreter','none');
%     xlabel('Subject ID');
% end

% %Workload
% figure('units','normalized','outerposition',[0 0 1 1]);
% for i = (1:15)
%     subplot(3, 5, i);
%     colData = raw_data(:,i);
%     
%     boxchart(raw_data.Workload, colData{:,1});
%     title(colData.Properties.VariableNames, 'Interpreter','none');
%     xlabel('Workload');
% end
% fn = strcat('C:\Users\BIOPACMan\Documents\Zhang\HOME\data vis\ekg\workload ekg features.jpg');
% saveas(gcf, fn);

%SART
figure('units','normalized','outerposition',[0 0 1 1]);
for i = (1:15)
    subplot(3, 5, i);
    colData = raw_data(:,i);
    
    binEdges = 0:5:50;
    bins = {'0-5', '5-10', '10-15', '15-20','20-25','25-30','30-35','35-40','40-45','45-50'};
    groupSart = discretize(raw_data.SART, binEdges, 'categorical', bins');
    
    
    
    boxchart(groupSart, colData{:,1});
    title(colData.Properties.VariableNames, 'Interpreter','none');
    xlabel('SART');
end
fn = strcat('C:\Users\BIOPACMan\Documents\Zhang\HOME\data vis\ekg\sart ekg features.jpg');
saveas(gcf, fn);

%TL
figure('units','normalized','outerposition',[0 0 1 1]);
for i = (1:15)
    subplot(3, 5, i);
    colData = raw_data(:,i);
    
    boxchart(raw_data.Taskload, colData{:,1});
    title(colData.Properties.VariableNames, 'Interpreter','none');
    xlabel('Taskload');
    xticklabels({'', 'Low', 'Medium', 'High'});
end
fn = strcat('C:\Users\BIOPACMan\Documents\Zhang\HOME\data vis\ekg\taskload ekg features.jpg');
saveas(gcf, fn);
% 
% %Trial
% figure('units','normalized','outerposition',[0 0 1 1]);
% for i = (1:15)
%     subplot(3, 5, i);
%     colData = raw_data(:,i);
%     
%     boxchart(raw_data.TrialOrder, colData{:,1});
%     title(colData.Properties.VariableNames, 'Interpreter','none');
%     xlabel('Trial');
% end
% fn = strcat('C:\Users\BIOPACMan\Documents\Zhang\HOME\data vis\ekg\trial order ekg features.jpg');
% saveas(gcf, fn);