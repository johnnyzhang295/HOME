clear all;





myPlot(1,0,0)
myPlot(1,0,1)

%data_index 1=rate mean, 2=RMSSD, 4=SDNN, 12=PNN50
%Set normalize to 1 if you want to nomralize, 0 if you want it raw, 2 for change scores
%set tl_bool to 1 if you want taskload, 0 if you want workload, 2 if you want both
function fig = myPlot(data_index, normalize, tl_bool)
    fig = figure;
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

    wl201= workload(2:end,1);
    wl202= workload(2:end,2);
    wl203= workload(2:end,3);
    wl204= workload(2:end,4);
    wl205= workload(2:end,5);
    wl206= workload(2:end,6);
    wl208= workload(2:end,8);
    wl209= workload(2:end,9);
    wl211= workload(2:end,11);
    wl212= workload(2:end,12);
    wl213= workload(2:end,13);
    wl215= workload(2:end,15);

    rmssd201 = hrv201(:,data_index);
    rmssd202 = hrv202(:,data_index);
    rmssd203 = hrv203(:,data_index);
    rmssd204 = hrv204(:,data_index);
    rmssd205 = hrv205(:,data_index);
    rmssd206 = hrv206(:,data_index);
    rmssd208 = hrv208(:,data_index);
    rmssd209 = hrv209(:,data_index);
    rmssd211 = hrv211(:,data_index);
    rmssd212 = hrv212(:,data_index);
    rmssd213 = hrv213(:,data_index);
    rmssd215 = hrv215(:,data_index);

    hold on


    if (normalize==1)
        rmssd201 = hrv201(:,data_index)/b201(data_index);
        rmssd202 = hrv202(:,data_index)/b202(data_index);
        rmssd203 = hrv203(:,data_index)/b203(data_index);
        rmssd204 = hrv204(:,data_index)/b204(data_index);
        rmssd205 = hrv205(:,data_index)/b205(data_index);
        rmssd206 = hrv206(:,data_index)/b206(data_index);
        rmssd208 = hrv208(:,data_index)/b208(data_index);
        rmssd209 = hrv209(:,data_index)/b209(data_index);
        rmssd211 = hrv211(:,data_index)/b211(data_index);
        rmssd212 = hrv212(:,data_index)/b212(data_index);
        rmssd213 = hrv213(:,data_index)/b213(data_index);
        rmssd215 = hrv215(:,data_index)/b215(data_index);


    end

    if (normalize==2)
        rmssd201 = hrv201(:,data_index)-b201(data_index);
        rmssd202 = hrv202(:,data_index)-b202(data_index);
        rmssd203 = hrv203(:,data_index)-b203(data_index);
        rmssd204 = hrv204(:,data_index)-b204(data_index);
        rmssd205 = hrv205(:,data_index)-b205(data_index);
        rmssd206 = hrv206(:,data_index)-b206(data_index);
        rmssd208 = hrv208(:,data_index)-b208(data_index);
        rmssd209 = hrv209(:,data_index)-b209(data_index);
        rmssd211 = hrv211(:,data_index)-b211(data_index);
        rmssd212 = hrv212(:,data_index)-b212(data_index);
        rmssd213 = hrv213(:,data_index)-b213(data_index);
        rmssd215 = hrv215(:,data_index)-b215(data_index);


    end

    rm_wl = [wl201 rmssd201;
        wl202 rmssd202;
        wl203 rmssd203;
        wl204 rmssd204;
        wl205 rmssd205;
        wl206 rmssd206;
        wl208 rmssd208;
        wl209 rmssd209;
        wl211 rmssd211;
        wl212 rmssd212;
        wl213 rmssd213;
        wl215 rmssd215;];

    rm_wl_t = [wl201' rmssd201';
        wl202' rmssd202';
        wl203' rmssd203';
        wl204' rmssd204';
        wl205' rmssd205';
        wl206' rmssd206';
        wl208' rmssd208';
        wl209' rmssd209';
        wl211' rmssd211';
        wl212' rmssd212';
        wl213' rmssd213';
        wl215' rmssd215';];

    tl_vs_data = [taskload(1,:) rmssd201';
        taskload(2,:) rmssd202';
        taskload(3,:) rmssd203';
        taskload(4,:) rmssd204';
        taskload(5,:) rmssd205';
        taskload(6,:) rmssd206';
        taskload(8,:) rmssd208';
        taskload(9,:) rmssd209';
        taskload(11,:) rmssd211';
        taskload(12,:) rmssd212';
        taskload(13,:) rmssd213';
        taskload(15,:) rmssd215';];


    xfit = [1,2,3,4,5,6,7,8,9,10,11,12];
    pnums = ['201';'202';'203';'204';'205';'206';'208';'209';'211';'212';'213';'215'];


    xs = 1:12;
    x_axis = repmat(xs,1,12);


    for i=1:12

        g = {tl_vs_data(i,1:12),rm_wl_t(i,1:12)};
        subplot(2,6,i)
        xlim([1,12])
        hold on; %This hold on must come AFTER the subplot
        p = polyfit(xfit', rm_wl_t(i,13:24)',1);
        yfit = polyval(p,xfit);
        plot(xfit,yfit,'HandleVisibility','off');
        if (tl_bool==1)
           
            gscatter(xfit,rm_wl_t(i,13:24),tl_vs_data(i,1:12));
        elseif (tl_bool==3)
            gscatter(xfit,rm_wl_t(i,13:24),g);
        else
            gscatter(xfit,rm_wl_t(i,13:24),rm_wl_t(i,1:12));
        end
        
        xlabel('Trial Order')
        if (normalize == 0)

            ylabel('Raw Values')
        elseif (normalize == 1)

            ylabel('Normalized')
        else
            ylabel('Change Score')        
        end

        grid on;
        grid minor;
        titl = strcat('Part',{' '},pnums(i,:),newline);
        title(titl);
        legend('Location','best')
        hold off;
    end
    titl = 'Individual ';
    if (normalize == 0)
        titl = strcat(titl, ' Raw Trial Order vs ');
    elseif (normalize == 1)

        titl = strcat(titl, ' Normalized Trial Order vs ');
    else
        titl = strcat(titl, ' Change Score Trial Order vs ');   
    end
    
    if (data_index == 1)
        titl = strcat(titl,' HR');
    elseif (data_index==2)
        titl = strcat(titl,' RMSSD');
    elseif(data_index==4)
        titl = strcat(titl,' SDNN');
    else
        titl = strcat(titl,' pNN50');
    end
    
        
    if (tl_bool ==1)
        titl = strcat(titl,' grouped by Taskload');
    elseif(tl_bool==0)
        titl = strcat(titl,' grouped by Workload');
    else
        titl=strcat(titl,' grouped by TL, WL');
    end
    
        
    suptitle(titl);


    
end



