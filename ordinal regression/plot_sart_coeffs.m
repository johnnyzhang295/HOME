% convention is :
% [model_1_coefficient, model_1_tstat
%  model_2_coefficient, model_2_tstat
%  model_3_coefficient, model_3_stat]
size = 25;
HR = [-2.3, -1.05;
    2.23, 2.88;
    -.80, -2.9;];

Mean_NN = [-.3, -4;
    .22, 2.25;
    -.09, -2.90;];

RSP_Amplitude = [-5.5, -2.3;
    -1.7, -3.6;    
    5.75, 3.36;];
    fig = figure('units','normalized','outerposition',[0 0 1 1]);

t = tiledlayout(3,2,'TileSpacing','Compact');

% Tile 1
nexttile
bar(HR(:,1));
ylabel('HR');
ax = gca;
ax.FontSize = size;


nexttile
yticks([]);
yyaxis right;
bar(HR(:,2));
yline(1.96, '--', 'Critical Value', 'FontSize',20, 'LineWidth', 2)
yline(-1.96, '--', 'LineWidth', 2)
ylabel('tStat');

ax = gca;
ax.FontSize = size;

nexttile
bar(Mean_NN(:,1));
ylabel('Mean NN');

ax = gca;
ax.FontSize = size;

nexttile
yticks([]);
yyaxis right;
bar(Mean_NN(:,2));
yline(1.96, '--',  'FontSize',20, 'LineWidth', 2)
yline(-1.96, '--', 'LineWidth', 2)
ylabel('tStat');

ax = gca;
ax.FontSize = size;
nexttile
bar(RSP_Amplitude(:,1));
ylabel('RSP Amplitude');

ax = gca;
ax.FontSize = size;
nexttile
yticks([]);
yyaxis right;
bar(RSP_Amplitude(:,2));
yline(1.96, '--',  'FontSize',20, 'LineWidth', 2)
yline(-1.96, '--', 'LineWidth', 2)
ylabel('tStat');

ax = gca;
ax.FontSize = size;
title(t,'Model Types 1 - 3 Coefficients and t-Statistics', 'FontSize',size)
xlabel(t,'Model Type','FontSize',size)
ylabel(t,'Predictor Coefficients','FontSize',size)

ax = gca;
ax.FontSize = size;
yyaxis right;
%text(4.55,10.3, 't-Statistic', 'Rotation', -90, 'FontSize', 12, 'Color', 'Red')
%%
size = 23;
    fig = figure('units','normalized','outerposition',[0 0 1 1]);

t = tiledlayout(5,2,'TileSpacing','Compact');
% convention is :
% [model_1_coefficient, model_1_tstat
%  model_2_coefficient, model_2_tstat
%  model_3_coefficient, model_3_stat]
%  model_4_coefficient, model_4_stat]
%  model_5_coefficient, model_5_stat]

HR = [-.77, -1.56;
    -.38, -1.23;
    3.92, 2.90;
    -.55, -1.46;
    .62, 1.53;];

Mean_NN = [-.11, -1.72;
    -.20, -2.32;
    -.83, -4.20;
    -.54, -2.4;
    0.019, .33;];
    
RSP_Amplitude = [-.14, -1.1;
   1.01, 3.78;   
    4.09, 4.31;
    1.3, 1.1;
    4.5, 3.0;
    ];

pupil_diameter = [.52, 1.64;
    .75, 1.89;    
    -6.36, -2.17;
    -6.5, -1.5;
    10.31, 5.2];

blink_count = [.23, 2.46;
    -0.09, -2.28;    
    .79, 3.94;
    0.05, 1.11;
    1.23, 3.56
    ];

nexttile;

bar(HR(:,1));
ylabel('HR');
ax = gca;
ax.FontSize = size;
nexttile;
yticks([]);
yyaxis right;
bar(HR(:,2));
yline(1.96, '--', 'LineWidth', 2)
yline(-1.96, '--', 'Critical Value', 'FontSize',20, 'LineWidth', 2)
ylabel('tStat');

ax = gca;
ax.FontSize = size;

nexttile;
bar(Mean_NN(:,1));
ylabel('Mean NN');

ax = gca;
ax.FontSize = size;
nexttile;
yticks([]);
yyaxis right;
bar(Mean_NN(:,2));
yline(1.96, '--', 'FontSize',20, 'LineWidth', 2)
yline(-1.96, '--', 'LineWidth', 2)
ylabel('tStat');

ax = gca;
ax.FontSize = size;
nexttile;
bar(RSP_Amplitude(:,1));
ylabel({'RSP', 'Amplitude'});


ax = gca;
ax.FontSize = size;

nexttile;
yticks([]);
yyaxis right;
bar(RSP_Amplitude(:,2));
yline(1.96, '--', 'FontSize',20, 'LineWidth', 2)
yline(-1.96, '--', 'LineWidth', 2)
ylabel('tStat');
ax = gca;
ax.FontSize = size;
nexttile;
bar(pupil_diameter(:,1));
ylabel({'Pupil' ,'Diameter'});

ax = gca;
ax.FontSize = size;


nexttile;
yticks([]);
yyaxis right;
bar(pupil_diameter(:,2));
yline(1.96, '--', 'FontSize',20, 'LineWidth', 2)
yline(-1.96, '--', 'LineWidth', 2)
ylabel('tStat');

ax = gca;
ax.FontSize = size;

nexttile;
bar(blink_count(:,1));
ylabel({'Blink', 'Count'});






ax = gca;
ax.FontSize = size;


nexttile;
yticks([]);
yyaxis right;
bar(blink_count(:,2));
ax = gca;
ax.FontSize = size;
yline(1.96, '--', 'FontSize',20, 'LineWidth', 2)
yline(-1.96, '--', 'LineWidth', 2)
ylabel('tStat', 'FontSize',size);
sgtitle('Model Types 1 - 5 Coefficients and tStat','FontSize',size);

title(t,'Model Types 1 - 5 Coefficients and t-Statistics','FontSize',size)
xlabel(t,'Model Type','FontSize',size)
ylabel(t,'Predictor Coefficients','FontSize',size)

yyaxis right;
%text(6.7, 22, 't-Statistic', 'Rotation', -90, 'FontSize', size, 'Color', 'Red')

%%

size = 23;
    fig = figure('units','normalized','outerposition',[0 0 1 1]);

t = tiledlayout(2,2,'TileSpacing','Compact');
% convention is :
% [model_1_coefficient, model_1_tstat
%  model_2_coefficient, model_2_tstat
%  model_3_coefficient, model_3_stat]
%  model_4_coefficient, model_4_stat]
%  model_5_coefficient, model_5_stat]

RMSSD = [-32, 14; -24, 18];

SDSD = [32, 14; 24, 18.9];

nexttile;

bar(RMSSD(:,1));
ylabel('RMSSD');
ax = gca;

xticklabels([4 5]);
ax.FontSize = size;

nexttile;
yticks([]);
yyaxis right;
bar(RMSSD(:,2));
yline(1.96, '--', 'Critical Value', 'FontSize',20, 'LineWidth', 2)
ylabel('tStat');

xticklabels([4 5]);
ax = gca;
ax.FontSize = size;

nexttile;
bar(SDSD(:,1));
ylabel('SDSD');

xticklabels([4 5]);
ax = gca;
ax.FontSize = size;
nexttile;
yticks([]);

yyaxis right;
bar(SDSD(:,2));

xticklabels([4 5]);
yline(1.96, '--', 'FontSize',20, 'LineWidth', 2)
ylabel('tStat');

ax = gca;
ax.FontSize = size;
title(t,'Model Types 4 - 5 Coefficients and t-Statistics','FontSize',size)
xlabel(t,'Model Type','FontSize',size)
ylabel(t,'Predictor Coefficients','FontSize',size+5)
