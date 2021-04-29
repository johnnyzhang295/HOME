%close('all');
x = -2*pi:0.1:2*pi;
A = sin(x);
A(47) = 0;
A(48) =0;
A(49) = 0;
A(50) = 0;
t = datetime(2017,1,1,0,0,0) + hours(0:length(x)-1);
[B,TF,U,L,C] = filloutliers(A,'previous','movmedian',[1 10]);
figure;
plot(t,A,t,B,'o')
legend('Original Data','Filled Data')


L(TF)