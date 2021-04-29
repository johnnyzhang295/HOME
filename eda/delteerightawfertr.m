load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part201\eda\EDA Pilot Interval Trial 6.csv');

x_axis = linspace(0,50,length(EDA_Pilot_Interval_Trial_6));


y = EDA_Pilot_Interval_Trial_6(:,2);
figure;

% Find change points
[changeIndices,segmentSlope,segmentIntercept] = ischange(cleanedData2,'linear',...
    'Threshold',500);

% Display results
clf
plot(cleanedData2,'Color',[109 185 226]/255,'DisplayName','Input data')
hold on
inds = find(changeIndices);
% Plot segments between change points
means = segmentSlope(:).*(1:numel(cleanedData2))'+segmentIntercept(:);
plot(segmentSlope(:).*(1:numel(cleanedData2))'+segmentIntercept(:),...
    'Color',[64 64 64]/255,'DisplayName','Linear regime')

% Plot change points
x = repelem(find(changeIndices),3);
y2 = repmat([ylim(gca) NaN]',nnz(changeIndices),1);
plot(x,y2,'Color',[51 160 44]/255,'LineWidth',1,'DisplayName','Change points')
title(['Number of change points: ' num2str(nnz(changeIndices))])

hold off
legend
clear segmentSlope segmentIntercept x y2




% 
% fill_methods = ["center","nearest","linear","spline"];
% find_methods = ["movmedian","movmean"];
% rate = 2000;
% window_sizes = [1.8 *rate; 2*rate; 2.2*rate; 2.5*rate; 1.6*rate];
% threshold_factors = [.5;.25;.75;.6;.4];
% 
% for i=(1)
%     fill_method = fill_methods(i);
%     
%     for j=(2)
%         
%         find_method = find_methods(j);
%        
%         
%         
%         for k=(1:5)
%             window_size = window_sizes(k);
%             
%             
%             
%             for l=(1:5)
%                 threshold = threshold_factors(l);
%                 
%                 
%                 y_filtered = filloutliers(y,fill_method,find_method,window_size,'ThresholdFactor',threshold);
%                 
%                 figure;
%                 plot(x_axis,y_filtered);
%                 title1 = strcat(fill_method,' + ', find_method, ' + Window size is ',string(window_size), ' + threshold index is ', string(l));
%                 title(title1);
%                 fn = strcat('C:\Users\BIOPACMan\Documents\Zhang\HOME\eda\filtering plots2\',title1,'.jpg');
%                 saveas(gcf,fn);
%                 close();
%             end
%         end
%     end
% end
% 
% % figure;
% % y_filtered = filloutliers(y,'nearest','movmean',4000,'ThresholdFactor',.5);
% % plot(x_axis,y_filtered);