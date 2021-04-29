clear all;
clear workspace;

load('raw data.mat');



X = raw_data(:,[1:20 23] );
Y = raw_data.Workload;

Mdl = fitcknn(X,Y,'NumNeighbors',4)

y_hat = predict(Mdl, X(6,:))
figure;
plot(Y(6,:), y_hat,'o');