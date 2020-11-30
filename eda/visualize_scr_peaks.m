% ind = 1;
% 
% filepath = 'C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part';
% load('C:\Users\BIOPACMan\Documents\Zhang\HOME\support\buttonPressTimes.mat');
% counter = 1;
% mult = 199998;
% features_by_trial = {zeros(12,1)};
% for id=201
% 
%     
%    id = string(id); 
%    
%    %Process ECG
%    raw_eda_features = load(strcat(filepath,id,'\EDA data by trial.csv'));
%    
%    for j=(1:12)
%     features_by_trial{j} = [raw_eda_features((j - 1)*mult+1:j*mult, 2) raw_eda_features((j - 1)*mult+1:j*mult, 6)];
%    end
%    
%    counter = counter + 1;
% 
% end

blues_by_trial= {zeros(12,1)};
fig = figure('units','normalized','outerposition',[0 0 1 1]);
greens_by_trial= {zeros(12,1)};

for id=1
    blue = blueRingCaught{id,1};
    green = greenRingCaught{id,1};
    
    for j=(1:12)
        blues_by_trial{j} = blue{j};
        
        greens_by_trial{j} = green{j};
    end
end

x_axis = linspace(0,50,length(features_by_trial{1,1})/2+1);

for id=1
    for j=(1:12)
        %figure
        subplot(3, 4,j)
        title(string(j));
        hold on;
        clean = features_by_trial{1,j}(:,1);
        lin1=plot(x_axis, clean(1:100000),'DisplayName','Clean EDA'); %plot cleaned data
        
        %plot scr peaks
        scr_peaks = features_by_trial{1,j}(:,2);
        line2=plot(x_axis, scr_peaks(99999:end).*max(clean),'DisplayName','Possible SCR Peak'); 
        
        %plot blue lines
        if (length(blues_by_trial{j}) > 0)
            for x=(1:length(blues_by_trial{j}))
               hold on;
               line3 = xline(blues_by_trial{j}(x),'b','LineWidth',3,'DisplayName','Blue Button Press'); 
            end
        end
            
        %plot green lines
        if (length(greens_by_trial{j}) > 0)
            for x=(1:length(greens_by_trial{j}))
               hold on;
               line4 = xline(greens_by_trial{j}(x),'g','LineWidth',3,'DisplayName','Green Button Press'); 
            end
        end
        
        
    end
    
end
legend([lin1,line2,line3,line4],{'Clean EDA Signal','Possible SCR Peak','Blue Button Press','Green Button Press'},'Position',[.005 .2 .1 .1])