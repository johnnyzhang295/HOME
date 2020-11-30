clear workspace;
clear all;

for idnum=13:15 %Change to 1:15
try
    if (idnum>9)
        id = strcat('2',string(idnum));
    else
        id = strcat('20',string(idnum));
    end
display(strcat('NOW PROCESSING ...',string(id)));
filepath = strcat('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part',id,'\');
fn = 'eye_raw_features.mat';
load(strcat(filepath,fn)); 
%raw_features is a N x 4 table of pupil labs exported data
%col 1 is Timestamps
%col 2 is Diameters
%col 3 is ID (0 is right, 1 is left)
%col 4 is Confidence

sync_data = readmatrix(strcat(filepath,'Part',id,'_BiopacLSLTimes.csv'));
taskload = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\support\taskload settings.csv');
blinks_timestamps = load(strcat(filepath,'blinks_timestamps.csv'));
sync = sync_data(:,2);

filter_indexes = (raw_features{:,2} > 1 & raw_features{:,2} < 10 & raw_features{:,4} > .8);
filtered_features = raw_features(filter_indexes,:);

%% Piloting Intervals
t1 = sync(2:3,:);
t2 = sync(6:7,:);
t3 = sync(10:11,:);
t4 = sync(14:15,:);
t5 = sync(18:19,:);
t6 = sync(22:23,:);
t7 = sync(26:27,:);
t8 = sync(30:31,:);
t9 = sync(34:35,:);
t10 = sync(38:39,:);
t11 = sync(42:43,:);
t12 = sync(46:47,:);

timestamps = filtered_features{:,1};
blinks_by_trial = {
    blinks_timestamps(blinks_timestamps> t1(1) & blinks_timestamps < t1(2));
    blinks_timestamps(blinks_timestamps> t2(1) & blinks_timestamps < t2(2));
    blinks_timestamps(blinks_timestamps > t3(1) & blinks_timestamps < t3(2),:);
    blinks_timestamps(blinks_timestamps > t4(1) & blinks_timestamps < t4(2),:);
    blinks_timestamps(blinks_timestamps > t5(1) & blinks_timestamps < t5(2),:);
    blinks_timestamps(blinks_timestamps > t6(1) & blinks_timestamps < t6(2),:);
    blinks_timestamps(blinks_timestamps > t7(1) & blinks_timestamps < t7(2),:);
    blinks_timestamps(blinks_timestamps > t8(1) & blinks_timestamps < t8(2),:);
    blinks_timestamps(blinks_timestamps > t9(1) & blinks_timestamps < t9(2),:);
    blinks_timestamps(blinks_timestamps > t10(1) & blinks_timestamps < t10(2),:);
    blinks_timestamps(blinks_timestamps > t11(1) & blinks_timestamps < t11(2),:);
    blinks_timestamps(blinks_timestamps > t12(1) & blinks_timestamps < t12(2),:);
    };

data_by_trial = {
    filtered_features(timestamps > t1(1) & timestamps < t1(2),:);%This is indexing the data by providing a lower bound and upper bound
    filtered_features(timestamps > t2(1) & timestamps < t2(2),:); %Each row is each trial so we have to change the t# variable
    filtered_features(timestamps > t3(1) & timestamps < t3(2),:);
    filtered_features(timestamps > t4(1) & timestamps < t4(2),:);
    filtered_features(timestamps > t5(1) & timestamps < t5(2),:);
    filtered_features(timestamps > t6(1) & timestamps < t6(2),:);
    filtered_features(timestamps > t7(1) & timestamps < t7(2),:);
    filtered_features(timestamps > t8(1) & timestamps < t8(2),:);
    filtered_features(timestamps > t9(1) & timestamps < t9(2),:);
    filtered_features(timestamps > t10(1) & timestamps < t10(2),:);
    filtered_features(timestamps > t11(1) & timestamps < t11(2),:);
    filtered_features(timestamps > t12(1) & timestamps < t12(2),:);
};

filtered_features_by_trial = {zeros(12,1)};
means = zeros(12,1);
medians = zeros(12,1);
blink_count = zeros(12,1);
figure('units','normalized','outerposition',[0 0 1 1]);
%i represents each trial number, i=1 is trial 1.
for i=1:12
   subplot(3, 4,i) %This makes 1 big plot and creates a matrix of 3x4 subplots we can use
   hold on;
   xyz = data_by_trial{i,1}; %Get the data from trial based on trial number (i)
   Timestamp = xyz{:,1}; %Get timestamp, it is always the 1st index
   PupilDiameter = xyz{:,2}; %get diameters, it is always the 2nd index
   eyeID = xyz{:,3}; %Get eye ID, it is always the 3rd index, but double check these
   
   mad_dia = mad(PupilDiameter); %Calculates the median absolute deviation from pupil diameter
   median_dia = median(PupilDiameter,'omitnan'); %Calculates the median, not including NaN values. 
   %This way it won't return a NaN as the median, which is possible.
   
   lower_threshold = median_dia - 3*mad_dia; %This math never changes
   upper_threshold = median_dia + 3*mad_dia; %This math never changes
   
   %Again, use same technique as in data_by_trial to index into data based
   %on upper and lower bounds
   filtered_xyz = xyz(PupilDiameter > lower_threshold & PupilDiameter < upper_threshold,:);
   filtered_features_by_trial{i} = filtered_xyz;
   %Use gscatter because we want to group by eye ID.
   medians(i) = median(filtered_xyz{:,2});
   means(i) = mean(filtered_xyz{:,2});
   blink_count(i) = length(blinks_by_trial{i});
   
   start_time = filtered_xyz{1,1};
   times = filtered_xyz{:,1} - start_time;
   ylim([1 10]);
   grid on;
   grid minor;
   gscatter(times,filtered_xyz{:,2}, filtered_xyz{:,3});
   title(strcat('Trial # ',string(i)));
   legend({'Right Eye','Left Eye'},'Location','best');
   
   xlabel('Time (s)');
   ylabel('Diameter (mm)');
end
fig_title = strcat('Participant ',id,' EYE Filtered Data by Trial');
suptitle(fig_title);
filtered_features_by_trial = filtered_features_by_trial'; %Transpose to Nx1 column vector;

subject_taskload_index = idnum;
subject_taskload = taskload(subject_taskload_index,:)';

trial_nums = 1:12;

low_tl_indexes = trial_nums(subject_taskload == 2); %Get the trial numbers where subject taskload was == 2
med_tl_indexes = trial_nums(subject_taskload == 3);
hi_tl_indexes = trial_nums(subject_taskload == 4);

low_tl_data = filtered_features_by_trial{low_tl_indexes}; %Get the data by the indexes
med_tl_data = filtered_features_by_trial{med_tl_indexes};
hi_tl_data = filtered_features_by_trial{hi_tl_indexes};
workload = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\support\workload.csv');
subject_workload = workload(2:end,idnum);
taskload_workload_table = table(subject_taskload, subject_workload, medians, means, blink_count, 'VariableNames',{'Taskload','Workload','Median','Mean','Blink Count'});

filtered_features_by_trial(:,2) = {taskload_workload_table};

out_file = strcat(filepath,'filtered_pilot_interval_pupil_positions.mat');
save(out_file,'filtered_features_by_trial');
out_figure = strcat('C:\Users\BIOPACMan\Documents\Zhang\HOME\figures\automated plots\',fig_title,'.jpg');
saveas(gcf,out_figure);

%% Plots

figure('units','normalized','outerposition',[0 0 1 1]);
plot(subject_taskload, medians,'o','MarkerSize',10,'MarkerFaceColor','blue');
xlabel('Taskload')
ylabel('Median Diameters (mm)')
grid on;
grid minor;
xlim([2 4]);
t1 = strcat('Participant ',id,' Taskload x Median Diameter');
title(t1);
out_figure = strcat('C:\Users\BIOPACMan\Documents\Zhang\HOME\figures\automated plots\',t1,'.jpg');
saveas(gcf,out_figure);

figure('units','normalized','outerposition',[0 0 1 1]);
plot(subject_taskload, blink_count,'o','MarkerSize',10,'MarkerFaceColor','blue');
xlabel('Taskload')
ylabel('Blink Count')
xlim([2 4]);
grid on;
grid minor;
t1 = strcat('Participant ',id,' Taskload x Blink Count');
title(t1);
out_figure = strcat('C:\Users\BIOPACMan\Documents\Zhang\HOME\figures\automated plots\',t1,'.jpg');
saveas(gcf,out_figure);

figure('units','normalized','outerposition',[0 0 1 1]);
plot(subject_workload, medians,'o','MarkerSize',10,'MarkerFaceColor','blue');
ylabel('Median Diameters (mm)')
t1 = strcat('Participant ',id,' Workload x Median Diameter');
title(t1);
grid on;
grid minor;
out_figure = strcat('C:\Users\BIOPACMan\Documents\Zhang\HOME\figures\automated plots\',t1,'.jpg');
saveas(gcf,out_figure);

figure('units','normalized','outerposition',[0 0 1 1]);
plot(subject_workload, blink_count,'o','MarkerSize',10,'MarkerFaceColor','blue');
ylabel('Blink Count')
t1 = strcat('Participant ',id,' Workload x Blink Count');
title(t1);
grid on;
grid minor;
out_figure = strcat('C:\Users\BIOPACMan\Documents\Zhang\HOME\figures\automated plots\',t1,'.jpg');
saveas(gcf,out_figure);


catch ERR
    display(ERR.message);
    display(strcat("Occurs on Line: ",ERR.stack.line));
end
end