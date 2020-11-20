clear workspace;
clear all;

data = readmatrix('sectionData.csv');
sync = readmatrix('Part201_BiopacLSLTimes.csv');
taskload = load('taskload.txt');

sync = sync(:,2);
timestamps = data(:,1);
diameters = data(:,3);
group = data(:,2);
confs = data(:,4);

filtered_diameter = [];

j=1;
for d=diameters'
    if (d > 1 && d < 10 && data(j,4) > 0.8)
        filtered_diameter(j) = d;
    else
        filtered_diameter(j) = NaN;
    end
    j= j+1;
end

filtered_diameter = filtered_diameter'; %Transpose this to make it a N x 1 column vector

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


data_to_be_filtered = [timestamps filtered_diameter group confs]; %I put all the pupillabs data into one data structure
% so that it can be easily modified, shown below.

data_by_trial = {
    data_to_be_filtered(timestamps > t1(1) & timestamps < t1(2),:); %This is indexing the data by providing a lower bound and upper bound
    data_to_be_filtered(timestamps > t2(1) & timestamps < t2(2),:); %Each row is each trial so we have to change the t# variable
    data_to_be_filtered(timestamps > t3(1) & timestamps < t3(2),:);
    data_to_be_filtered(timestamps > t4(1) & timestamps < t4(2),:);
    data_to_be_filtered(timestamps > t5(1) & timestamps < t5(2),:);
    data_to_be_filtered(timestamps > t6(1) & timestamps < t6(2),:);
    data_to_be_filtered(timestamps > t7(1) & timestamps < t7(2),:);
    data_to_be_filtered(timestamps > t8(1) & timestamps < t8(2),:);
    data_to_be_filtered(timestamps > t9(1) & timestamps < t9(2),:);
    data_to_be_filtered(timestamps > t10(1) & timestamps < t10(2),:);
    data_to_be_filtered(timestamps > t11(1) & timestamps < t11(2),:);
    data_to_be_filtered(timestamps > t12(1) & timestamps < t12(2),:);
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
   
   gscatter(x_axis,filtered_xyz(:,2), filtered_xyz(:,3));
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

save 'C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part201\filtered_pilotinterval_pupil_positions.mat' filtered_data_by_trial
