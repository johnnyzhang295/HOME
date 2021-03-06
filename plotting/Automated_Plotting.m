clear all;

donk = [1 2 4 12];

%Scatterplots
% for d=donk
%     myPlot(d,0,0,1,0);
%     myPlot(d,0,1,1,0);
%     myPlot(d,0,2,1,0);
%     myPlot(d,1,0,1,0);
%     myPlot(d,1,1,1,0);
%     myPlot(d,1,2,1,0);
%     
%     myPlot(d,0,0,1,1);
%     myPlot(d,0,1,1,1);
%     myPlot(d,0,2,1,1);
%     myPlot(d,1,0,1,1);
%     myPlot(d,1,1,1,1);
%     myPlot(d,1,2,1,1);
% end

%Boxplots
for d=donk
    myPlot(d,0,0,1,0,1);
    myPlot(d,0,1,1,0,1);
end



%set data_index 1=rate mean, 2=RMSSD, 4=SDNN, 12=PNN50
%Set normalize to 1 if you want to nomralize, 0 if you want it raw, 2 for change scores
%set tl_bool to 1 if you want taskload, 0 if you want workload, 2 if you want both
%set save to 1 if you want to save, 0 for no save and mostly debugging
%set on to 1 if you want aggregate on, 0 for indivdiual plot
%set boxplot to 1 if you want boxplots
function fig = myPlot(data_index, normalize, tl_bool, save, on, boxplot_bool)
    fig = figure('units','normalized','outerposition',[0 0 1 1]);
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

    trial_ord = [1;2;3;4;5;6;7;8;9;10;11;12];
    trial_vs_data = [trial_ord rmssd201;
        trial_ord rmssd202;
        trial_ord rmssd203;
        trial_ord rmssd204;
        trial_ord rmssd205;
        trial_ord rmssd206;
        trial_ord rmssd208;
        trial_ord rmssd209;
        trial_ord rmssd211;
        trial_ord rmssd212;
        trial_ord rmssd213;
        trial_ord rmssd215;];
    
    if (boxplot_bool == 1 && on == 1)
       myBoxplot;
       
    else
    
        for i=1:12

            g = {tl_vs_data(i,1:12),rm_wl_t(i,1:12)};
            if (on ==0)

                subplot(2,6,i)
            end
            xlim([1,12])
            hold on; %This hold on must come AFTER the subplot
            p = polyfit(xfit', rm_wl_t(i,13:24)',1);
            yfit = polyval(p,xfit);
            if (on ==0 && boxplot_bool == 0)
                plot(xfit,yfit,'HandleVisibility','off');
            end
            if (tl_bool==1)
                if (boxplot_bool == 1)
                    boxplot(tl_vs_data(i,13:24),tl_vs_data(i,1:12));
                else
                    gscatter(xfit,rm_wl_t(i,13:24),tl_vs_data(i,1:12));
                end
            elseif (tl_bool==2)
                
                gscatter(xfit,rm_wl_t(i,13:24),g);
                
            else
                if (boxplot_bool == 1)
                    boxplot(rm_wl_t(i,13:24),rm_wl_t(i,1:12));
                    
                else
                    gscatter(xfit,rm_wl_t(i,13:24),rm_wl_t(i,1:12));
                end
            end

            xlabel('Trial Order')
            if (boxplot_bool ==1)
                if (tl_bool == 0)
                    xlabel('Workload Rating');
                else
                    xlabel('Taskload Level');
                end
            end
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
            if (on == 0)
                title(titl);
            end
            if (boxplot_bool == 0)
                legend('Location','best')
            end
            hold off;
        end
    end
    if (on == 0)
        titl = 'Individual ';
    else
        titl= 'Aggregate ';
    end
    if (normalize == 0)
        titl = strcat(titl, ' Trial Order vs Raw ');
    elseif (normalize == 1)

        titl = strcat(titl, ' Trial Order vs Normalized ');
    
    else
        titl = strcat(titl, ' Trial Order vs Change Score ');   
    end
    if (boxplot_bool ==1)
        if (tl_bool == 0)
            titl = ('Individual Workload Rating vs ');
        else
            titl = ('Indivdual Taskload Level vs ');
        end
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
    
    if (boxplot_bool ==1)
        titl = strcat(titl,' boxplotted');
    elseif(boxplot_bool==0)
        titl = strcat(titl,' boxplotted');
    else
        titl=strcat(titl,' boxplotted');
    end
    
        
    suptitle(titl);
    if (on == 1 && boxplot_bool == 0 )
        hold on;
        p = polyfit(trial_vs_data(:,1), trial_vs_data(:,2),1);
        yfit = polyval(p,xfit);
        plot(xfit,yfit,'HandleVisibility','off');
        
    end
    if (save==1)
        saveas(gcf,strcat('C:\Users\BIOPACMan\Documents\Zhang\HOME\figures\automated plots\',titl,'.jpg'));
    end
    
    
    function myBoxplot
        data = [taskload(1,:)' rmssd201;
        taskload(2,:)' rmssd202;
        taskload(3,:)' rmssd203;
        taskload(4,:)' rmssd204;
        taskload(5,:)' rmssd205;
        taskload(6,:)' rmssd206;
        taskload(8,:)' rmssd208;
        taskload(9,:)' rmssd209;
        taskload(11,:)' rmssd211;
        taskload(12,:)' rmssd212;
        taskload(13,:)' rmssd213;
        taskload(15,:)' rmssd215;];
        x=data(:,2);
        g=data(:,1);
        fig = boxplot(x,g);

    end
end




