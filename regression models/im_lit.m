x = [50:.1:180];
y = normpdf(x,107,14);
figure;

plot(x,y)

xline(107,'-or', 'LineWidth',3);
xline(107+14.7309,'color','Red', 'LineWidth',3)

xline(107+2*14.7309,'color','Red', 'LineWidth',3)

xline(107,'color','Red', 'LineWidth',3);
xline(107-14.7309,'color','Red', 'LineWidth',3)

xline(107-2*14.7309,'color','Red', 'LineWidth',3)

xline(150, 'color','Green','LineWidth',2)

figure;
load('C:\Users\BIOPACMan\Documents\Zhang\HOME\plotting\clean.txt')

load('C:\Users\BIOPACMan\Documents\Zhang\HOME\plotting\r_peaks.txt')
 x =(0.0005:.0005:50)';
plot(x,clean)
hold on;
g = 1 - (r_peaks (r_peaks==1) - clean(r_peaks == 1));
r_peaks(r_peaks==1) = g;
r_peaks(r_peaks ==0) = NaN;
plot(x, r_peaks, 'o','MarkerSize',10,'MarkerFaceColor','r')
legend({'ECG Recording','Detected R-Peak'})
xlabel('Seconds')
ylabel('mV')
ac = gca;
ac.FontSize= 25;
ColOrd = [0.634197879289704,0.598590500684565,0.335478586307354;0.141323291186943,0.668487146264776,0.619568612502970;0.0793022450665238,0.894564090918275,0.992885717464124;0.876145347529076,0.0873355239070054,0.648005694952403;0.420428701240150,0.539010349313424,0.539775820318468;0.487663607210372,0.428449936007297,0.232254753050780;0.460325494339181,0.617153494459035,0.739832227063707;0.515677249607505,0.558875876956837,0.888992345152850;0.271994390193763,0.225850688199737,0.859807625912606;0.231579838051303,0.104519529950634,0.597060788610351;0.899534076872039,0.00997765604969036,0.654752143480193;0.908697326644413,0.0591533040753343,0.915013993756726;0.603642852234244,0.322652370507717,0.433183080639157;0.365236483082946,0.779476506848221,0.289760755842240;0.634197879289704,0.598590500684565,0.335478586307354];

figure;
hold on;
x = [7 5 7 6 6 7 4 4 4 4 7 7 6]';
y = [7
     5
     7
     7
     6
     5
     5
     6
     5
     6
     7
     5];
 y = x
markers = ['+','*','.','h','o','s','d','^','v','>','<','p'];

markers = ['o','s','o','o','o','s','o','o','o','o','o','o'];
for i=1:12
    plot(x(i), y(i),'o','MarkerSize',20,'LineWidth',3,'MarkerFaceColor',ColOrd(7,:),'MarkerEdgeColor',ColOrd(7,:));
end
xlabel('Workload Score')
ylabel('Model Response')
ac = gca;
title('Subject 14')
grid on;
plot([0,11],[0,11],'-', 'Color',ColOrd(7,:), 'LineWidth',3);
xlim([0 11])
ylim([0 11])
xticks(1:10)
yticks(1:10)
ac.FontSize= 25;