clear all;
clear workspace;

% load ('transformed raw data.mat')

% transformed_raw_data = raw_data;
% transformed_raw_data.ECG_Rate_Mean = log(transformed_raw_data.ECG_Rate_Mean);
% transformed_raw_data.RSP_Amplitude = log(transformed_raw_data.RSP_Amplitude);
% transformed_raw_data.BlinkCount = sqrt(transformed_raw_data.BlinkCount);
% transformed_raw_data.HRV_pNN50 = sqrt(transformed_raw_data.HRV_pNN50);
% save('transformed raw data.mat', 'transformed_raw_data');
%stan = x - mu / sigma

%perform standardization within subjects
% standardized_raw_data = raw_data;
% for (i=1:12:180)
%     standardized_raw_data(i:i+11,1:19) = normalize(raw_data(i:i+11,1:19));
% end
% save('standardized raw data.mat', 'standardized_raw_data')

% standardized_transformed_raw_data = transformed_raw_data;
% for (i=1:12:180)
%     standardized_transformed_raw_data(i:i+11,1:19) = normalize(transformed_raw_data(i:i+11,1:19));
% end
% save('standardized and transformed raw data.mat', 'standardized_transformed_raw_data')