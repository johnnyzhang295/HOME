clear all; clear workspace;
load('raw data.mat');

medians = [];
j = 1;

change_scores = [];

for i = (1:12:180)
    medians(j,1) = median(raw_data.MeanPupilDiameter(i:i+11));
    medians(j,2) = median(raw_data.BlinkCount(i:i+11));
    
    j = j + 1;
end

%% stupid
eye = ...
[repmat(medians(1,1:2),[12,1]);
repmat(medians(2,1:2),[12,1]);
repmat(medians(3,1:2),[12,1]);
repmat(medians(4,1:2),[12,1]);
repmat(medians(5,1:2),[12,1]);
repmat(medians(6,1:2),[12,1]);
repmat(medians(7,1:2),[12,1]);
repmat(medians(8,1:2),[12,1]);
repmat(medians(9,1:2),[12,1]);
repmat(medians(10,1:2),[12,1]);
repmat(medians(11,1:2),[12,1]);
repmat(medians(12,1:2),[12,1]);
repmat(medians(13,1:2),[12,1]);
repmat(medians(14,1:2),[12,1]);
repmat(medians(15,1:2),[12,1]);
];

%% 
change_scores = [raw_data.MeanPupilDiameter raw_data.BlinkCount] - eye;
figure;
gscatter(raw_data.MeanPupilDiameter(:), change_scores(:,1), raw_data.ID)
xlabel('Experiment Pupil Diameter');
ylabel('Change Score');
title('Change Score Residual for Pupil Diameter');

figure;
gscatter(raw_data.BlinkCount(:), change_scores(:,2), raw_data.ID)
xlabel('Experiment Blink Count');
ylabel('Change Score');
title('Change Score Residual for Blink Count');

%%

std_exp2 = [];
mean_exp2 = [];
j = 1;
for i=(1:12:180)
    std_exp2(j,:) = std(raw_data{i:i+11,7:8});
    mean_exp2(j,:) = mean(raw_data{i:i+11,7:8});
   
    
    j = j+1;
end


coefz = std_exp2./mean_exp2;