ecgsig = load('trial7part212.csv');
tm = load('time.csv');
qrsEx = ecgsig(17200:18200);
% [mpdict,~,~,longs] = wmpdictionary(numel(qrsEx),'lstcpt',{{'sym4',3}});
% figure
% plot(qrsEx)
% hold on
% plot(mpdict(:,57),'r')
% axis tight
% legend('QRS Complex','Sym4 Wavelet')
% title('Comparison of Sym4 Wavelet and QRS Complex')



[cA,cD] = dwt(qrsEx,'sym4');
figure;
xrec = idwt(cA,zeros(size(cA)),'sym4');
plot(xrec);