

ids= 201:215;

ids = 203;

ExtractRawFeatures(ids);

function ExtractRawFeatures(x)

filepath = strcat('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part',string(x),'\');
in_filename = 'pupil_positions.csv';

raw_data = readmatrix(strcat(filepath, in_filename));

timestamps = raw_data(:,1);
diameters = raw_data(:,14);
group = raw_data(:,3);
confs = raw_data(:,4);

raw_features = table(timestamps, diameters, group, confs, ...
    'VariableNames', {'Timestamps','Diameters','ID','Confidence'});

out_filename = 'eye_raw_features.mat';
out_filepath = strcat(filepath,out_filename);

save(out_filepath,'raw_features');

end




