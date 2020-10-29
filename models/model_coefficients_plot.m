clear workspace;
clear all;
p201 = readtable('C:\Users\BIOPACMan\Documents\Zhang\HOME\models\model coefficeints\combinedCoeffs.csv');

data = [NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN];

p_vals = p201{:,6};
for i=1:11:132
    
    appen = [];
    appen(1) = p_vals(i);
    appen(2) = p_vals(i+1);
    appen(3) = p_vals(i+2);
    appen(4) = p_vals(i+3);
    appen(5) = p_vals(i+4);
    appen(6) = p_vals(i+5);
    appen(7) = p_vals(i+6);
    appen(8) = p_vals(i+7);
    appen(9) = p_vals(i+8);
    appen(10) = p_vals(i+9);
    appen(11) = p_vals(i+10);
    
    data = [data; appen];
end

figure('units','normalized','outerposition',[0 0 1 1]);

for j=1:11
    subplot(3,4,j);
    grid on;
    grid minor;
    hold on;
    histogram(data(:,j),10)
    title(p201{j,2});
    xlabel('P-Value');
end

suptitle('Distribution of P-Values for Predictor Variables');