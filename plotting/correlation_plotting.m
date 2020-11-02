clear workspace;
clear all;
workload = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\support\workload.csv');
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
taskload = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\support\taskload settings\taskload settings.csv');
b201 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part201\Baseline Time Based HRV Analyses By Trial.csv');
b202 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part202\Baseline Time Based HRV Analyses By Trial.csv');
b203 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part203\Baseline Time Based HRV Analyses By Trial.csv');
b204 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part204\Baseline Time Based HRV Analyses By Trial.csv');
b205 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part205\Baseline Time Based HRV Analyses By Trial.csv');
b206 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part206\Baseline Time Based HRV Analyses By Trial.csv');
b208 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part208\Baseline Time Based HRV Analyses By Trial.csv');
b209 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part209\Baseline Time Based HRV Analyses By Trial.csv');
b211 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part211\Baseline Time Based HRV Analyses By Trial.csv');
b212 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part212\Baseline Time Based HRV Analyses By Trial.csv');
b213 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part213\Baseline Time Based HRV Analyses By Trial.csv');
b215 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part215\Baseline Time Based HRV Analyses By Trial.csv');

X = [
  hrv201(:,1) hrv201(:,2) hrv201(:,4) hrv201(:,12);  
  hrv202(:,1) hrv202(:,2) hrv202(:,4) hrv202(:,12);  
  hrv203(:,1) hrv203(:,2) hrv203(:,4) hrv203(:,12);  
  hrv204(:,1) hrv204(:,2) hrv204(:,4) hrv204(:,12);  
  hrv205(:,1) hrv205(:,2) hrv205(:,4) hrv205(:,12);  
  hrv206(:,1) hrv206(:,2) hrv206(:,4) hrv206(:,12);  
  hrv208(:,1) hrv208(:,2) hrv208(:,4) hrv208(:,12);  
  hrv209(:,1) hrv209(:,2) hrv209(:,4) hrv209(:,12);  
  hrv211(:,1) hrv211(:,2) hrv211(:,4) hrv211(:,12);  
  hrv212(:,1) hrv212(:,2) hrv212(:,4) hrv212(:,12);  
  hrv213(:,1) hrv213(:,2) hrv213(:,4) hrv213(:,12);  
  hrv215(:,1) hrv215(:,2) hrv215(:,4) hrv215(:,12);  
];

[R,PValue] =  corrplot(X,'type','Pearson','testR','on','varNames',{'HR','RMSSD','SDNN','pNN50'},'tail','both','testR','on');


b201 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part201\Baseline Time Based HRV Analyses By Trial.csv');
b202 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part202\Baseline Time Based HRV Analyses By Trial.csv');
b203 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part203\Baseline Time Based HRV Analyses By Trial.csv');
b204 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part204\Baseline Time Based HRV Analyses By Trial.csv');
b205 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part205\Baseline Time Based HRV Analyses By Trial.csv');
b206 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part206\Baseline Time Based HRV Analyses By Trial.csv');
b208 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part208\Baseline Time Based HRV Analyses By Trial.csv');
b209 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part209\Baseline Time Based HRV Analyses By Trial.csv');
b211 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part211\Baseline Time Based HRV Analyses By Trial.csv');
b212 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part212\Baseline Time Based HRV Analyses By Trial.csv');
b213 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part213\Baseline Time Based HRV Analyses By Trial.csv');
b215 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part215\Baseline Time Based HRV Analyses By Trial.csv');



norm201 = hrv201./b201;
norm202 = hrv202./b202;
norm203 = hrv203./b203;
norm204 = hrv204./b204;
norm205 = hrv205./b205;
norm206 = hrv206./b206;
norm208 = hrv208./b208;
norm209 = hrv209./b209;
norm211 = hrv211./b211;
norm212 = hrv212./b212;
norm213 = hrv213./b213;
norm215 = hrv215./b215;
    

X_norm = [
  norm201(:,1) norm201(:,2) norm201(:,4) norm201(:,12);  
  norm202(:,1) norm202(:,2) norm202(:,4) norm202(:,12);  
  norm203(:,1) norm203(:,2) norm203(:,4) norm203(:,12);  
  norm204(:,1) norm204(:,2) norm204(:,4) norm204(:,12);  
  norm205(:,1) norm205(:,2) norm205(:,4) norm205(:,12);  
  norm206(:,1) norm206(:,2) norm206(:,4) norm206(:,12);  
  norm208(:,1) norm208(:,2) norm208(:,4) norm208(:,12);  
  norm209(:,1) norm209(:,2) norm209(:,4) norm209(:,12);  
  norm211(:,1) norm211(:,2) norm211(:,4) norm211(:,12);  
  norm212(:,1) norm212(:,2) norm212(:,4) norm212(:,12);  
  norm213(:,1) norm213(:,2) norm213(:,4) norm213(:,12);  
  norm215(:,1) norm215(:,2) norm215(:,4) norm215(:,12);  
];

[R,PValue] =  corrplot(X_norm,'type','Pearson','testR','on','varNames',{'HR','RMSSD','SDNN','pNN50'},'tail','both','testR','on');
