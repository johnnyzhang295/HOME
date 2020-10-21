clear workspace;
clear all;
workload = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\support\workload.csv');
taskload = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\support\taskload settings\taskload settings.csv');
hrv201 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part201\Time Based HRV Analyses By Trial.csv');
hrv202 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part202\Time Based HRV Analyses By Trial.csv');
hrv203 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part203\Time Based HRV Analyses By Trial.csv');
hrv204 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part204\Time Based HRV Analyses By Trial.csv');
hrv205 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part205\Time Based HRV Analyses By Trial.csv');
hrv206 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part206\Time Based HRV Analyses By Trial.csv');
hrv208 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part208\Time Based HRV Analyses By Trial.csv');
hrv209 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part209\Time Based HRV Analyses By Trial.csv');
hrv211 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part211\Time Based HRV Analyses By Trial.csv');
hrv212 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part212\Time Based HRV Analyses By Trial.csv');
hrv213 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part213\Time Based HRV Analyses By Trial.csv');
hrv215 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part215\Time Based HRV Analyses By Trial.csv');
trial_order = [1 2 3 4 5 6 7 8 9 10 11 12]';


X = [
    trial_order workload(2:end,1);
    trial_order workload(2:end,2);
    trial_order workload(2:end,3);
    trial_order workload(2:end,4);
    trial_order workload(2:end,5);
    trial_order workload(2:end,6);
    trial_order workload(2:end,8);
    trial_order workload(2:end,9);
    trial_order workload(2:end,11);
    trial_order workload(2:end,12);
    trial_order workload(2:end,13);
    trial_order workload(2:end,15);
    ];
    
data_index = 12; %1=rate mean, 2=RMSSD, 4=SDNN, 12=PNN50
data201 = hrv201(:,data_index);
data202 = hrv202(:,data_index);
data203 = hrv203(:,data_index);
data204 = hrv204(:,data_index);
data205 = hrv205(:,data_index);
data206 = hrv206(:,data_index);
data208 = hrv208(:,data_index);
data209 = hrv209(:,data_index);
data211 = hrv211(:,data_index);
data212 = hrv212(:,data_index);
data213 = hrv213(:,data_index);
data215 = hrv215(:,data_index); 

y = [
    data201;
    data202;
    data203;
    data204;
    data205;
    data206;
    data208;
    data209;
    data211;
    data212;
    data213;
    data215;
    ];

mdl = fitglm(X(1:12,:),y(1:12));

y_resp = predict(mdl,[X(1:12,:)]);

scatter(y(1:12),y_resp);