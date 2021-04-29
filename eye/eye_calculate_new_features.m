clear all;
clear workspace;
filepath = 'C:\Users\BIOPACMan\Documents\Zhang\HOME\support\Blink Count - All subjects 1 page.csv';
raw_blink_data = load(filepath);



for id=(201:215) %change to 215
    try
        display(strcat("PROCESSING...",string(id)));
id = string(id);
filepath = 'C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part';
in_filename = '\filtered_pilot_interval_pupil_positions.mat';
load(strcat(filepath, id, in_filename));


data = filtered_features_by_trial(:,1);

total_diameter = 0;
total_len = 0;
pd_std = zeros(12,1);
for i=1:12
    total_diameter = total_diameter + sum(data{i}{:,2});
    total_len = total_len + length(data{i}{:,2});
    pd_std(i) = std(data{i,1}.Diameters);
end

mean_pupil_dia = total_diameter / total_len;

summary_table = filtered_features_by_trial{1,2};

summary_table.TrialOrder = (1:12)';
summary_table.('Blink Count') = raw_blink_data(:,double(id)-200);

summary_table.NormalizedBC = normalize(summary_table.('Blink Count'));

summary_table.NormalizedMean = normalize(summary_table.Mean);

out_filename = '\eye_features_pilot_interval_summary_table.mat';
save(strcat(filepath,id,out_filename),'summary_table');

    catch ERR
        display(ERR.message);
        
        display(strcat("Occurs on Line: ",string(ERR.stack.line)));
    end
end