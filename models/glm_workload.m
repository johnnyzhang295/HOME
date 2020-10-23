clear workspace;
clear all;


m = myWorkloadModel(1);

function mdl = myWorkloadModel(data_index)
    figure('units','normalized','outerposition',[0 0 1 1]);
    
    [trial_order, tl,y,wl] = loadData();

    if(data_index==1)
        feature = 'HR';
    elseif(data_index==2)
        feature='RMSSD';
    elseif(data_index==4)
        feature='SDNN';
    else
        feature='pNN50';
    end
    
        
    pnums = ['201';'202';'203';'204';'205';'206';'208';'209';'211';'212';'213';'215'];
    j = 1;
    sum_aic =0;
    sum_bic = 0;
    for i=1:12:144
        MakeGraphPretty();
        
        dataTable = table(trial_order, tl(i:i+11), y(i:i+11),wl(i:i+11), 'VariableNames',{'Trial Order','Taskload',feature,'Workload'});
        mdl = fitglm(dataTable);
        scatter(wl(i:i+11),mdl.Fitted.Response);
       
        p = polyfit(wl(i:i+11),mdl.Fitted.Response,1);
        yfit = polyval(p,wl(i:i+11));
        plot(wl(i:i+11),yfit,'-r','HandleVisibility','off');
        
        [aic,bic] = aicbic(mdl.LogLikelihood,mdl.NumEstimatedCoefficients,mdl.NumObservations);
        sum_aic = sum_aic + aic;
        sum_bic = sum_bic + bic;
        
        j = j+1;
    end
    
    MakeBigGraphPretty();
    %All formating related shit goes here
    function MakeGraphPretty()
        subplot(3,4,j);
        grid on;
        grid minor;
        hold on;
        title(strcat('Part',{' '},pnums(j,:)));
        
        xlabel('Subject Workload');
        ylabel('Model Response');
         axis equal;
    end
    function MakeBigGraphPretty()
        titl = 'Trial Order + Taskload + ';
       
        if (data_index == 1)
            titl = strcat(titl,' HR ');
        elseif (data_index==2)
            titl = strcat(titl, ' RMSSD');
        elseif (data_index == 4)
            titl = strcat(titl, ' SDNN ');
        else
            titl = strcat(titl, ' pNN50 ');
        end
        aic_label = char(string(sum_aic));
        aic_label = aic_label(1:end-2);
        bic_label = char(string(sum_bic));
        bic_label = bic_label(1:end-2);
        aicbic_vals = strcat(' Model     AIC:',aic_label,'     BIC:',bic_label);
        titl2 = strcat(titl,aicbic_vals);
        suptitle(titl2);
    
    end
    function [trial_order,tl,y,wl] = loadData()

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


        wl = [
             workload(2:end,1);
             workload(2:end,2);
             workload(2:end,3);
             workload(2:end,4);
             workload(2:end,5);
             workload(2:end,6);
             workload(2:end,8);
             workload(2:end,9);
             workload(2:end,11);
             workload(2:end,12);
             workload(2:end,13);
             workload(2:end,15);
            ];

        tl = [
             taskload(1,:)';
             taskload(2,:)';
             taskload(3,:)';
             taskload(4,:)';
             taskload(5,:)';
             taskload(6,:)';
             taskload(8,:)';
             taskload(9,:)';
             taskload(11,:)';
             taskload(12,:)';
             taskload(13,:)';
             taskload(15,:)';
            ];


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
        trial_order;];
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
    end
end
