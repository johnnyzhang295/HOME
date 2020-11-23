clear all;
clear workspace;



for id=201:201 %change to 215
id = string(id);
filepath = 'C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part';
in_filename = '\filtered_pilot_interval_pupil_positions.mat';
load(strcat(filepath, id, in_filename));


data = filtered_features_by_trial(:,1);

total_diameter = 0;
total_len = 0;
for i=1:12
    total_diameter = total_diameter + sum(data{i}{:,2});
    total_len = total_len + length(data{i}{:,2});
end

mean_pupil_dia = total_diameter / total_len;

summary_table = filtered_features_by_trial{1,2};

summary_table.MPDC = summary_table.Mean - mean_pupil_dia;
summary_table.TrialOrder = (1:12)';

out_filename = '\eye_features_pilot_interval_summary_table.mat';
save(strcat(filepath,id,out_filename),'summary_table');

end