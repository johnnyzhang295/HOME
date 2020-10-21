clear workspace;
clear all;
workload = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\support\workload.csv');
taskload = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\support\taskload settings\taskload settings.csv');
trial_order = [1 2 3 4 5 6 7 8 9 10 11 12]';


X_wl = [
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

X_tl = [
    trial_order taskload(1,:)';
    trial_order taskload(2,:)';
    trial_order taskload(3,:)';
    trial_order taskload(4,:)';
    trial_order taskload(5,:)';
    trial_order taskload(6,:)';
    trial_order taskload(8,:)';
    trial_order taskload(9,:)';
    trial_order taskload(11,:)';
    trial_order taskload(12,:)';
    trial_order taskload(13,:)';
    trial_order taskload(15,:)';
    ];

X_wl_and_tl = [X_wl X_tl(:,2)];

myModel(X_wl,1,0,1,1,1);
myModel(X_tl,1,1,0,1,1);
myModel(X_wl_and_tl,1,1,1,1,1);
myModel(X_wl(:,1),1,0,0,1,1);


%data_index is 1=rate mean, 2=RMSSD, 4=SDNN, 12=PNN50
%tl_bool set to 1 if taskload included as predictor variable
%wl_bool set to 1 if workload included as predictor variable
%save set to 1 if you want to save figure, 0 is for debugging
%trial_bool set to 1 if trial order included as predictor variable
function mdl = myModel(X,data_index,tl_bool,wl_bool,save,trial_bool)

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

    j = 1;
    pnums = ['201';'202';'203';'204';'205';'206';'208';'209';'211';'212';'213';'215'];
    figure('units','normalized','outerposition',[0 0 1 1]);


    for i=1:12:144
        subplot(3,4,j);
        mdl = fitglm(X(i:i+11,:),y(i:i+11));
        y_resp = predict(mdl,[X(i:i+11,:)]);
        hold on;
        p = polyfit(y(i:i+11),y_resp,1);
        yfit = polyval(p,y(i:i+11));
        plot(y(i:i+11),yfit,'--r','HandleVisibility','off');
        scatter(y(i:i+11),y_resp);
        title(strcat('Part',{' '},pnums(j,:)));
        %xlim([min(y)-5 max(y)+5]); %makes equal spaceing
        %ylim([min(y)-5 max(y)+5]); %makes equal spacing
        axis equal;  %If undo above 2, comment this line out you idoit!
        grid on
        grid minor
        xlabel('Subject Data');
        ylabel('Model Response');
        j = j+1;
    end
    titl = '';
    if (trial_bool==1)
        titl = ' Trial';
    end
    if (tl_bool==1)
        titl = strcat(titl,' Taskload');
    end
    if (wl_bool ==1)
        titl = strcat(titl, ' Workload');
    end
    if (data_index == 1)
        titl = strcat(titl,' Model HR Response');
    elseif (data_index==2)
        titl = strcat(titl, ' Model RMSSD Response');
    elseif (data_index == 4)
        titl = strcat(titl, ' Model SDNN Response');
    else
        titl = strcat(titl, ' Model pNN50 Response');
    end
    
    suptitle(titl);
    
    if (save==1)
        saveas(gcf,strcat('C:\Users\BIOPACMan\Documents\Zhang\HOME\figures\automated plots\',titl,'.jpg'));
    end

end

