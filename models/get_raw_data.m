clear all;
clear workspace;

b201 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part201\Baseline Time Based HRV Analyses By Trial.csv');
b202 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part202\Baseline Time Based HRV Analyses By Trial.csv');
b203 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part203\Baseline Time Based HRV Analyses By Trial.csv');
b204 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part204\Baseline Time Based HRV Analyses By Trial.csv');
b205 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part205\Baseline Time Based HRV Analyses By Trial.csv');
b206 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part206\Baseline Time Based HRV Analyses By Trial.csv');
b207 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part207\Baseline Time Based HRV Analyses By Trial.csv');
b208 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part208\Baseline Time Based HRV Analyses By Trial.csv');
b209 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part209\Baseline Time Based HRV Analyses By Trial.csv');
b210 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part210\Baseline Time Based HRV Analyses By Trial.csv');
b211 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part211\Baseline Time Based HRV Analyses By Trial.csv');
b212 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part212\Baseline Time Based HRV Analyses By Trial.csv');
b213 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part213\Baseline Time Based HRV Analyses By Trial.csv');
b214 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part214\Baseline Time Based HRV Analyses By Trial.csv');
b215 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part215\Baseline Time Based HRV Analyses By Trial.csv');

rsp_base_201 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part201\RSP baseline.csv');
rsp_base_202 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part202\RSP baseline.csv');
rsp_base_203 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part203\RSP baseline.csv');
rsp_base_204 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part204\RSP baseline.csv');
rsp_base_205 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part205\RSP baseline.csv');
rsp_base_206 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part206\RSP baseline.csv');
rsp_base_207 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part207\RSP baseline.csv');
rsp_base_208 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part208\RSP baseline.csv');
rsp_base_209 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part209\RSP baseline.csv');
rsp_base_210 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part210\RSP baseline.csv');
rsp_base_211 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part211\RSP baseline.csv');
rsp_base_212 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part212\RSP baseline.csv');
rsp_base_213 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part213\RSP baseline.csv');
rsp_base_214 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part214\RSP baseline.csv');
rsp_base_215 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part215\RSP baseline.csv');

r201 = [rsp_base_201(1,:) rsp_base_201(2,:)];
r202 = [rsp_base_202(1,:) rsp_base_202(2,:)];
r203 = [rsp_base_203(1,:) rsp_base_203(2,:)];
r204 = [rsp_base_204(1,:) rsp_base_204(2,:)];
r205 = [rsp_base_205(1,:) rsp_base_205(2,:)];
r206 = [rsp_base_206(1,:) rsp_base_206(2,:)];
r207 = [rsp_base_207(1,:) rsp_base_207(2,:)];
r208 = [rsp_base_208(1,:) rsp_base_208(2,:)];
r209 = [rsp_base_209(1,:) rsp_base_209(2,:)];
r210 = [rsp_base_210(1,:) rsp_base_210(2,:)];
r211 = [rsp_base_211(1,:) rsp_base_211(2,:)];
r212 = [rsp_base_212(1,:) rsp_base_212(2,:)];
r213 = [rsp_base_213(1,:) rsp_base_213(2,:)];
r214 = [rsp_base_214(1,:) rsp_base_214(2,:)];
r215 = [rsp_base_215(1,:) rsp_base_215(2,:)];

data_names = {'ECG_Rate_Mean','HRV_RMSSD','HRV_MeanNN','HRV_SDNN','HRV_SDSD','HRV_CVNN','HRV_CVSD','HRV_MedianNN','HRV_MadNN','HRV_MCVNN','HRV_IQRNN','HRV_pNN50','HRV_pNN20','HRV_TINN','HRV_HTI','HRV_ULF','HRV_VLF','HRV_LF','HRV_HF','HRV_VHF','HRV_LFHF','HRV_LFn','HRV_HFn','HRV_LnHF','HRV_SD1','HRV_SD2','HRV_SD1SD2','HRV_S','HRV_CSI','HRV_CVI','HRV_CSI_Modified','HRV_PIP','HRV_IALS','HRV_PSS','HRV_PAS','HRV_GI','HRV_SI','HRV_AI','HRV_PI','HRV_C1d','HRV_C1a','HRV_SD1d','HRV_SD1a','HRV_C2d','HRV_C2a','HRV_SD2d','HRV_SD2a','HRV_Cd','HRV_Ca','HRV_SDNNd','HRV_SDNNa','HRV_ApEn','HRV_SampEn'};
ekg_baseline = [b201; b202; b203; b204; b205; b206; b207; b208; b209; b210; b211; b212; b213; b214; b215;];


ekg_table = array2table(ekg_baseline);
ekg_table.Properties.VariableNames = {'ECG_Rate_Mean','HRV_RMSSD','HRV_MeanNN','HRV_SDNN','HRV_SDSD','HRV_CVNN','HRV_CVSD','HRV_MedianNN','HRV_MadNN','HRV_MCVNN','HRV_IQRNN','HRV_pNN50','HRV_pNN20','HRV_TINN','HRV_HTI','HRV_ULF','HRV_VLF','HRV_LF','HRV_HF','HRV_VHF','HRV_LFHF','HRV_LFn','HRV_HFn','HRV_LnHF','HRV_SD1','HRV_SD2','HRV_SD1SD2','HRV_S','HRV_CSI','HRV_CVI','HRV_CSI_Modified','HRV_PIP','HRV_IALS','HRV_PSS','HRV_PAS','HRV_GI','HRV_SI','HRV_AI','HRV_PI','HRV_C1d','HRV_C1a','HRV_SD1d','HRV_SD1a','HRV_C2d','HRV_C2a','HRV_SD2d','HRV_SD2a','HRV_Cd','HRV_Ca','HRV_SDNNd','HRV_SDNNa','HRV_ApEn','HRV_SampEn'};

names = {'RSP_Raw','RSP_Clean','RSP_Amplitude','RSP_Rate','RSP_Phase','RSP_Phase_Completion','RSP_Peaks','RSP_Troughs','stddev_RSP_Raw','stddev_RSP_Clean','stddev_RSP_Amplitude','stddev_RSP_Rate','stddev_RSP_Phase','stddev_RSP_Phase_Completion','stddev_RSP_Peaks','stddev_RSP_Troughs'};
rsp_baseline = [r201; r202; r203; r204; r205; r206; r207; r208; r209; r210; r211; r212; r213; r214; r215;];

rsp_table = array2table(rsp_baseline);
rsp_table.Properties.VariableNames = names;

hrv201 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part201\Time Based HRV Analyses By Trial.csv');
hrv202 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part202\Time Based HRV Analyses By Trial.csv');
hrv203 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part203\Time Based HRV Analyses By Trial.csv');
hrv204 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part204\Time Based HRV Analyses By Trial.csv');
hrv205 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part205\Time Based HRV Analyses By Trial.csv');
hrv206 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part206\Time Based HRV Analyses By Trial.csv');
hrv207 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part207\Time Based HRV Analyses By Trial.csv');
hrv208 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part208\Time Based HRV Analyses By Trial.csv');
hrv209 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part209\Time Based HRV Analyses By Trial.csv');
hrv210 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part210\Time Based HRV Analyses By Trial.csv');
hrv211 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part211\Time Based HRV Analyses By Trial.csv');
hrv212 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part212\Time Based HRV Analyses By Trial.csv');
hrv213 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part213\Time Based HRV Analyses By Trial.csv');
hrv214 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part214\Time Based HRV Analyses By Trial.csv');
hrv215 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part215\Time Based HRV Analyses By Trial.csv');

ekg_exp = [hrv201; hrv202; hrv203; hrv204; hrv205; hrv206; hrv207; hrv208; hrv209; hrv210; hrv211; hrv212; hrv213; hrv214; hrv215;];
ekg_exptable = array2table(ekg_exp);
ekg_exptable.Properties.VariableNames = {'ECG_Rate_Mean','HRV_RMSSD','HRV_MeanNN','HRV_SDNN','HRV_SDSD','HRV_CVNN','HRV_CVSD','HRV_MedianNN','HRV_MadNN','HRV_MCVNN','HRV_IQRNN','HRV_pNN50','HRV_pNN20','HRV_TINN','HRV_HTI','HRV_ULF','HRV_VLF','HRV_LF','HRV_HF','HRV_VHF','HRV_LFHF','HRV_LFn','HRV_HFn','HRV_LnHF','HRV_SD1','HRV_SD2','HRV_SD1SD2','HRV_S','HRV_CSI','HRV_CVI','HRV_CSI_Modified','HRV_PIP','HRV_IALS','HRV_PSS','HRV_PAS','HRV_GI','HRV_SI','HRV_AI','HRV_PI','HRV_C1d','HRV_C1a','HRV_SD1d','HRV_SD1a','HRV_C2d','HRV_C2a','HRV_SD2d','HRV_SD2a','HRV_Cd','HRV_Ca','HRV_SDNNd','HRV_SDNNa','HRV_ApEn','HRV_SampEn'};

%save('rsp_baseline.mat','rsp_table');
%save('ekg_baseline.mat','ekg_table');
%save('ekg_exp.mat','ekg_exptable');