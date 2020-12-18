%% load data + basic plot
clear all;
clear workspace;

participant = '201';
trialno = 8;

load(strcat('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part',...
    participant,'\eda\EDA Pilot Interval Trial ',{' '},...
    string(trialno),'.csv'));

x_axis = linspace(0,50,length(EDA_Pilot_Interval_Trial_8));
y = EDA_Pilot_Interval_Trial_8(:,2);


figure;
hold on;
subplot(3,1,1);
plot(x_axis,y);
title(strcat('Original Data Participant: ',participant,' Trial No: ',string(trialno)));

%% Change points + Plot
% Find change points

subplot(3,1,2);
[changeIndices,segmentSlope,segmentIntercept] = ischange(y,'linear',...
    'Threshold',10000);

% Display results
hold on;
plot(x_axis,y,'Color',[109 185 226]/255,'DisplayName','Input data')
ylabel('Microsiemens');

inds = find(changeIndices);
% Plot segments between change points
means = segmentSlope(:).*(1:numel(y))'+segmentIntercept(:);
plot(x_axis,segmentSlope(:).*(1:numel(y))'+segmentIntercept(:),...
    'Color',[64 64 64]/255,'DisplayName','Linear regime')

% Plot change points
x = repelem(find(changeIndices),3)/2000;
y2 = repmat([ylim(gca) NaN]',nnz(changeIndices),1);
plot(x,y2,'Color',[51 160 44]/255,'LineWidth',1,'DisplayName','Change points')
title(['Number of change points: ' num2str(nnz(changeIndices))])
xlim([x_axis(1) x_axis(end)])
legend


%% Get deltas
deltas = zeros(length(inds),1);
fixed_y = y;

subplot(3,1,3);
for i=(1:length(inds))
    deltas(i) = means(inds(i)-1) - means(inds(i));
    
    if (length(inds) > 1)
        if (i == length(inds) && deltas(i) > 0)
            fixed_y(inds(i):end) = fixed_y(inds(i):end) + deltas(i);
            
        else
            if (deltas(i) >0 && deltas(1) > 0)
                fixed_y(inds(i):inds(i+1)-1) = fixed_y(inds(i):inds(i+1)-1)  + deltas(i);
            end
            if (deltas(i) <0 && deltas(1) < 0)
                fixed_y(inds(i):inds(i+1)-1) = fixed_y(inds(i):inds(i+1)-1)  - deltas(i);
            end
        end
    else
        if (deltas(i) >0 )
            fixed_y(inds(i):end) = fixed_y(inds(i):end)  + deltas(i);
        end
        if (deltas(i) <0 )
            fixed_y(inds(i):end) = fixed_y(inds(i):end)  + deltas(i);
        end
    end
    
end
plot(x_axis, fixed_y);

title('Fixed Data');
xlabel('Seconds');