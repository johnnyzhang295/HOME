clear all;
clear workspace;

taskload = load('taskload.txt');

subject_id = [201; 202; 203; 204; 205; 206; 207; 208; 209; 210; 211; 212; 213; 214; 215;];


d = readmatrix('sectionData.csv');
sync = readmatrix('Part201_BiopacLSLTimes.csv');


sync = sync(:,2);

timestamps = d(:,1);
diameters = d(:,3);
group = d(:,2);
confidences = d(:,4);

data = {[timestamps diameters group confidences] sync};

data{1,1} = ...
    data{1,1}(diameters > 1 & diameters < 10 & confidences > .8,:);


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

data_by_trial = {
    data{1,1}(timestamps > t1(1) & timestamps < t1(2),:); %This is indexing the data by providing a lower bound and upper bound
    data{1,1}(timestamps > t2(1) & timestamps < t2(2),:); %Each row is each trial so we have to change the t# variable
    data{1,1}(timestamps > t3(1) & timestamps < t3(2),:);
    data{1,1}(timestamps > t4(1) & timestamps < t4(2),:);
    data{1,1}(timestamps > t5(1) & timestamps < t5(2),:);
    data{1,1}(timestamps > t6(1) & timestamps < t6(2),:);
    data{1,1}(timestamps > t7(1) & timestamps < t7(2),:);
    data{1,1}(timestamps > t8(1) & timestamps < t8(2),:);
    data{1,1}(timestamps > t9(1) & timestamps < t9(2),:);
    data{1,1}(timestamps > t10(1) & timestamps < t10(2),:);
    data{1,1}(timestamps > t11(1) & timestamps < t11(2),:);
    data{1,1}(timestamps > t12(1) & timestamps < t12(2),:);
};

filtered_data_by_trial = {};

figure;
%i represents each trial number, i=1 is trial 1.
for i=1:12
   subplot(3, 4,i) %This makes 1 big plot and creates a matrix of 3x4 subplots we can use
   hold on;
   xyz = data_by_trial{i,1}; %Get the data from trial based on trial number (i)
   Timestamp = xyz(:,1); %Get timestamp, it is always the 1st index
   PupilDiameter = xyz(:,2); %get diameters, it is always the 2nd index
   eyeID = xyz(:,3); %Get eye ID, it is always the 3rd index, but double check these
   
   mad_dia = mad(PupilDiameter); %Calculates the median absolute deviation from pupil diameter
   median_dia = median(PupilDiameter,'omitnan'); %Calculates the median, not including NaN values. 
   %This way it won't return a NaN as the median, which is possible.
   
   lower_threshold = median_dia - 3*mad_dia; %This math never changes
   upper_threshold = median_dia + 3*mad_dia; %This math never changes
   
   %Again, use same technique as in data_by_trial to index into data based
   %on upper and lower bounds
   filtered_xyz = xyz(PupilDiameter > lower_threshold & PupilDiameter < upper_threshold,:);
   filtered_data_by_trial{i} = filtered_xyz;
   %Use gscatter because we want to group by eye ID.
   
   length = size(filtered_xyz);
   length = length(1);
   
   x_axis = linspace(0,50,length);
   
   gscatter(filtered_xyz(:,1),filtered_xyz(:,2), filtered_xyz(:,3));
   title(strcat('Trial # ',string(i)));
   legend({'Left Eye','Right Eye'},'Location','best');
   
   xlabel('Time (s)');
   ylabel('Diameter (mm)');
end
suptitle('Participant 201');
filtered_data_by_trial = filtered_data_by_trial'; %Transpose to Nx1 column vector;

subject_taskload_index = 1;
subject_taskload = taskload(subject_taskload_index,:);

trial_nums = 1:12;

low_tl_indexes = trial_nums(subject_taskload == 2); %Get the trial numbers where subject taskload was == 2
med_tl_indexes = trial_nums(subject_taskload == 3);
hi_tl_indexes = trial_nums(subject_taskload == 4);

low_tl_data = filtered_data_by_trial{low_tl_indexes}; %Get the data by the indexes
med_tl_data = filtered_data_by_trial{med_tl_indexes};
hi_tl_data = filtered_data_by_trial{hi_tl_indexes};

