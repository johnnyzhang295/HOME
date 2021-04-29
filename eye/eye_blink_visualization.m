clear workspace;
clear all;
filepath = 'C:\Users\BIOPACMan\Documents\Zhang\HOME\support\Blink Count - All subjects 1 page.csv';
raw_blink_data = load(filepath);
ColOrd = [0.634197879289704,0.598590500684565,0.335478586307354;0.141323291186943,0.668487146264776,0.619568612502970;0.0793022450665238,0.894564090918275,0.992885717464124;0.876145347529076,0.0873355239070054,0.648005694952403;0.420428701240150,0.539010349313424,0.539775820318468;0.487663607210372,0.428449936007297,0.232254753050780;0.460325494339181,0.617153494459035,0.739832227063707;0.515677249607505,0.558875876956837,0.888992345152850;0.271994390193763,0.225850688199737,0.859807625912606;0.231579838051303,0.104519529950634,0.597060788610351;0.899534076872039,0.00997765604969036,0.654752143480193;0.908697326644413,0.0591533040753343,0.915013993756726;0.603642852234244,0.322652370507717,0.433183080639157;0.365236483082946,0.779476506848221,0.289760755842240;0.634197879289704,0.598590500684565,0.335478586307354];
all_marks = {'o','+','*','.','_','|','x','s','d','^','v','>','<','p','h'};


%figure('units','normalized','outerposition',[0 0 1 1]);
fp = 'C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part';
data_types = {'double','double','double','double',...
    'double','double','double','double','double'};
data_names = {'Taskload','Workload','Median','Mean','BC',...
    'Trial','Normalized BC','Normalized Mean','PD_STD'};

data = table('Size',[180 length(data_types)],'VariableTypes',data_types,'VariableNames',data_names);
ind = 1;
for id=201:215
   counter = id - 200;
   id = string(id); 
   
   %Process EYE
   raw_eye_features = load(strcat(fp,id,'\eye_features_pilot_interval_summary_table.mat'));
   
   data.Taskload(ind:ind+11) = raw_eye_features.summary_table.Taskload;
   data.Workload(ind:ind+11) = raw_eye_features.summary_table.Workload;
   data.Median(ind:ind+11) = raw_eye_features.summary_table.Median;
   data.Mean(ind:ind+11) = raw_eye_features.summary_table.Mean;
   data.BC(ind:ind+11) = raw_eye_features.summary_table.("Blink Count");
   data.Trial(ind:ind+11) = raw_eye_features.summary_table.TrialOrder;
   data.("Normalized BC")(ind:ind+11) = raw_eye_features.summary_table.NormalizedBC;
   data.("Normalized Mean")(ind:ind+11) = raw_eye_features.summary_table.NormalizedMean;
   ind = ind + 12;
end

doyadirty(data);

function [] = doyadirty(data)
figure('units','normalized','outerposition',[0 0 1 1]);
hold on;
gscatter(data.Workload, data.("Normalized BC"), data.Taskload);

p = polyfit((1:60)',data.("Normalized BC")(data.Taskload == 2,:),1);
yfit = polyval(p,(1:60)');
plot((1:60)',yfit,'-r','HandleVisibility','off');

p = polyfit((1:60)',data.("Normalized BC")(data.Taskload == 3,:),1);
yfit = polyval(p,(1:60)');
plot((1:60)',yfit,'-g','HandleVisibility','off');

p = polyfit((1:60)',data.("Normalized BC")(data.Taskload == 4,:),1);
yfit = polyval(p,(1:60)');
plot((1:60)',yfit,'-b','HandleVisibility','off');
legend({'Low','Medium','High'})
xlabel('Workload');
ylabel('Normalized Blink Count');
title('Normalized BC vs Workload Grouped with TL');



figure('units','normalized','outerposition',[0 0 1 1]);
hold on;
gscatter(data.Workload, data.("Normalized Mean"), data.Taskload);

p = polyfit((1:60)',data.("Normalized Mean")(data.Taskload == 2,:),1);
yfit = polyval(p,(1:60)');
plot((1:60)',yfit,'-r','HandleVisibility','off');

p = polyfit((1:60)',data.("Normalized Mean")(data.Taskload == 3,:),1);
yfit = polyval(p,(1:60)');
plot((1:60)',yfit,'-g','HandleVisibility','off');

p = polyfit((1:60)',data.("Normalized Mean")(data.Taskload == 4,:),1);
yfit = polyval(p,(1:60)');
plot((1:60)',yfit,'-b','HandleVisibility','off');


legend({'Low','Medium','High'})
xlabel('Workload');
ylabel('Normalized Pupil Diameter');
title('Normalized PD vs Workload Grouped with TL');
end
function [] = TLandWL()
figure('units','normalized','outerposition',[0 0 1 1]);
boxplot(data.("Normalized BC"), data.Taskload);
xlabel('Low Med High Taskload');
ylabel('Normalized BC');
title('Normalized BC vs Taskload');

figure('units','normalized','outerposition',[0 0 1 1]);
boxplot(data.("Normalized BC"), data.Workload);
xlabel('Workload');
ylabel('Normalized BC');
title('Normalized BC vs Workload');

figure('units','normalized','outerposition',[0 0 1 1]);
boxplot(data.("Normalized Mean"), data.Workload);
xlabel('Workload');
ylabel('Normalized Pupil Diameter');
title('Normalized PD vs Workload');

figure('units','normalized','outerposition',[0 0 1 1]);
boxplot(data.("Normalized Mean"), data.Taskload);
xlabel('Taskload');
ylabel('Normalized Pupil Diameter');
title('Normalized PD vs Taskload');
end

function [] = BasicVis()

figure('units','normalized','outerposition',[0 0 1 1]);

histogram(raw_blink_data);
ylabel('Count');
xlabel('Value');
title('Raw Blink Count Distribution');

figure('units','normalized','outerposition',[0 0 1 1]);
histogram(var(raw_blink_data));
title('Variance BC Distribution');
xlabel('Value');
ylabel('Count');


figure('units','normalized','outerposition',[0 0 1 1]);
histogram(std(raw_blink_data));
title('Std Dev. BC Distribution');
xlabel('Value');
ylabel('Count');


normalized_blink_data = zeros(12,15);
for i=(1:15)
   normalized_blink_data(:,i) = raw_blink_data(:,i) / mean(raw_blink_data(:,i));
end

figure('units','normalized','outerposition',[0 0 1 1]);
histogram(normalized_blink_data);
ylabel('Count');
xlabel('Value');
title('Normalized  Blink Count Distribution');

figure('units','normalized','outerposition',[0 0 1 1]);
histogram(var(normalized_blink_data));
title('Normalized Variance BC Distribution');
xlabel('Value');
ylabel('Count');


figure('units','normalized','outerposition',[0 0 1 1]);
histogram(std(normalized_blink_data));
title('Normalized Std Dev. BC Distribution');
xlabel('Value');
ylabel('Count');

figure('units','normalized','outerposition',[0 0 1 1]);
plot(x,'o');
hold on;
p = polyfit((1:180)',x,1);
yfit = polyval(p,(1:180)');
plot((1:180)',yfit,'-','HandleVisibility','off');
xlabel('All Data Points');
ylabel('Normalized BC');
title('Normalized BC');
end

