clear workspace;
clear all;



figure('units','normalized','outerposition',[0 0 1 1]);

data_index = [1 4 12];
[trial_order, tl,y,wl,age_sex] = loadData(data_index);


save=0;

pnums = ['201';'202';'203';'204';'205';'206';'207';'208';'209';'210';'211';'212';'213';'214';'215'];
j = 1;
sum_aic =0;
sum_bic = 0;
for i=1:12:180

    MakeGraphPretty(j);
    dataTable = table(trial_order, tl(i:i+11), y(i:i+11, 1),...
        y(i:i+11, 2), y(i:i+11, 3), y(i:i+11,4), y(i:i+11,5), age_sex(i:i+11,1), age_sex(i:i+11,2),wl(i:i+11), 'VariableNames',...
        {'TrialOrder','Taskload','HR','SDNN','pNN50','RSP_Amplitude','RSP_Rate','Age','Sex','Workload'});
    mdl = fitglm(dataTable,'Workload~TrialOrder + Taskload +HR + SDNN + pNN50 + RSP_Amplitude+RSP_Rate+Age+Sex',...
       'ResponseVar','Workload','Intercept',true);

    scatter(wl(i:i+11),mdl.Fitted.Response);
    p = polyfit(wl(i:i+11),mdl.Fitted.Response,1);
    yfit = polyval(p,wl(i:i+11));
    plot(wl(i:i+11),yfit,'-r','HandleVisibility','off');

    [aic,bic] = aicbic(mdl.LogLikelihood,mdl.NumEstimatedCoefficients,mdl.NumObservations);
    sum_aic = sum_aic + aic;
    sum_bic = sum_bic + bic;

    if (save == 1)
       saveCoeff(); 
    end

    r_sq = char(string(mdl.Rsquared.Adjusted));
    r_sq = r_sq(1:5);
    title(strcat('Part',{' '},pnums(j,:),' Adj R-Squared: ',r_sq));



    j = j+1;
end

titl='';
%MakeBigGraphPretty();
if (save==1)
    saveGraph()
end
%All formating related shit goes here
function MakeGraphPretty(j)
    subplot(3,5,j);
    grid on;
    grid minor;
    hold on;

    xlabel('Subject Workload');
    ylabel('Model Response');
    axis equal;
end
function MakeBigGraphPretty()
    titl = 'WL ~ B0 + TrialOrd * TL + HR * SDNN * pNN50    Model';
    aic_label = char(string(sum_aic));
    aic_label = aic_label(1:end-2);
    bic_label = char(string(sum_bic));
    bic_label = bic_label(1:end-2);
    aicbic_vals = strcat('     AIC:',aic_label,'     BIC:',bic_label);
    titl2 = strcat(titl,aicbic_vals);
    suptitle(titl2);

end
function [trial_order,tl,y,wl,age_sex] = loadData(data_index)

    workload = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\support\workload.csv');
    taskload = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\support\taskload settings\taskload settings.csv');
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
    
    cmaawards = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\support\sex_age.txt');
    %r_201 is formatted as odds: mean, evens: std dev
    r_201 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part201\RSP data by trial.csv');
    r_202 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part202\RSP data by trial.csv');
    r_203 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part203\RSP data by trial.csv');
    r_204 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part204\RSP data by trial.csv');
    r_205 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part205\RSP data by trial.csv');
    r_206 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part206\RSP data by trial.csv');
    r_207 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part207\RSP data by trial.csv');
    r_208 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part208\RSP data by trial.csv');
    r_209 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part209\RSP data by trial.csv');
    r_210 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part210\RSP data by trial.csv');
    r_211 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part211\RSP data by trial.csv');
    r_212 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part212\RSP data by trial.csv');
    r_213 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part213\RSP data by trial.csv');
    r_214 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part214\RSP data by trial.csv');
    r_215 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part215\RSP data by trial.csv');
    
    r_201 = r_201(:,3:4);
    r_201 = r_201(1:2:end,:); %need to skip every other because of format
    r_202 = r_202(:,3:4);
    r_202 = r_202(1:2:end,:);
    r_203 = r_203(:,3:4);
    r_203 = r_203(1:2:end,:);
    r_204 = r_204(:,3:4);
    r_204 = r_204(1:2:end,:);
    r_205 = r_205(:,3:4);
    r_205 = r_205(1:2:end,:);
    r_206 = r_206(:,3:4);
    r_206 = r_206(1:2:end,:);
    r_207 = r_207(:,3:4);
    r_207 = r_207(1:2:end,:);
    r_208 = r_208(:,3:4);
    r_208 = r_208(1:2:end,:);
    r_209 = r_209(:,3:4);
    r_209 = r_209(1:2:end,:);
    r_210 = r_210(:,3:4);
    r_210 = r_210(1:2:end,:);
    r_211 = r_211(:,3:4);
    r_211 = r_211(1:2:end,:);
    r_212 = r_212(:,3:4);
    r_212 = r_212(1:2:end,:);
    r_213 = r_213(:,3:4);
    r_213 = r_213(1:2:end,:);
    r_214 = r_214(:,3:4);
    r_214 = r_214(1:2:end,:);
    r_215 = r_215(:,3:4);
    r_215 = r_215(1:2:end,:);
    
    trial_order = [1 2 3 4 5 6 7 8 9 10 11 12]';
    age_sex = zeros(180,2);
    age_sex = ...
    [repmat(cmaawards(1,:),[12,1]);
     repmat(cmaawards(2,:),[12,1]);
     repmat(cmaawards(3,:),[12,1]);
     repmat(cmaawards(4,:),[12,1]);
     repmat(cmaawards(5,:),[12,1]);
     repmat(cmaawards(6,:),[12,1]);
     repmat(cmaawards(7,:),[12,1]);
     repmat(cmaawards(8,:),[12,1]);
     repmat(cmaawards(9,:),[12,1]);
     repmat(cmaawards(10,:),[12,1]);
     repmat(cmaawards(11,:),[12,1]);
     repmat(cmaawards(12,:),[12,1]);
     repmat(cmaawards(13,:),[12,1]);
     repmat(cmaawards(14,:),[12,1]);
     repmat(cmaawards(15,:),[12,1]);
    ];

    wl = [
         workload(2:end,1);
         workload(2:end,2);
         workload(2:end,3);
         workload(2:end,4);
         workload(2:end,5);
         workload(2:end,6);
         workload(2:end,7);
         workload(2:end,8);
         workload(2:end,9);
         workload(2:end,10);
         workload(2:end,11);
         workload(2:end,12);
         workload(2:end,13);
         workload(2:end,14);
         workload(2:end,15);
        ];

    tl = [
         taskload(1,:)';
         taskload(2,:)';
         taskload(3,:)';
         taskload(4,:)';
         taskload(5,:)';
         taskload(6,:)';
         taskload(7,:)';
         taskload(8,:)';
         taskload(9,:)';
         taskload(10,:)';
         taskload(11,:)';
         taskload(12,:)';
         taskload(13,:)';
         taskload(14,:)';
         taskload(15,:)';
        ];


    data201 = hrv201(:,data_index);
    data202 = hrv202(:,data_index);
    data203 = hrv203(:,data_index);
    data204 = hrv204(:,data_index);
    data205 = hrv205(:,data_index);
    data206 = hrv206(:,data_index);
    data207 = hrv207(:,data_index);
    data208 = hrv208(:,data_index);
    data209 = hrv209(:,data_index);

    data210 = hrv210(:,data_index);
    data211 = hrv211(:,data_index);
    data212 = hrv212(:,data_index);
    data213 = hrv213(:,data_index);

    data214 = hrv214(:,data_index);
    data215 = hrv215(:,data_index); 
    t = [trial_order;
    trial_order;
    trial_order;
    trial_order;
    trial_order;
    trial_order;
    trial_order;
    trial_order;
    trial_order;
    trial_order;
    trial_order;
    trial_order;
    trial_order;
    trial_order;
    trial_order;];
    y = [
    data201 r_201;
    data202 r_202;
    data203 r_203;
    data204 r_204;
    data205 r_205;
    data206 r_206;
    data207 r_207;
    data208 r_208;
    data209 r_209;
    data210 r_210;
    data211 r_211;
    data212 r_212;
    data213 r_213;
    data214 r_214;
    data215 r_215;
    ];
end
function saveGraph()
    saveas(gcf,strcat('C:\Users\BIOPACMan\Documents\Zhang\HOME\figures\automated plots\',titl,'.jpg'));

end
function saveCoeff()
   fn = strcat('C:\Users\BIOPACMan\Documents\Zhang\HOME\models\model coefficeints\',...
       pnums(j,:),'modelCoefficients.txt');
   writetable(mdl.Coefficients, fn, 'WriteRowNames',true);

end
