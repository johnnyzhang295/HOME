sub = 1; % each subject
actual_sart_scores = [21 21 22 23 24 28 33 33 33 34 35 36]';   % some independent variable that affects trust, it is different on each of the 12 trials
%IV2 = ones(12,1);   % some other IV that affects trust
model_values = [25 25 28 23 28 28 36 37 36 37 38 38]';


% simualte some trust questionnaire data. in this example, the data is a
% function of the subject themselves and the independent variables 
% (maybe analogous to a the time to respond coupled with whether there were
% incorrect suggestions before)


% these are intiial guesses for the model paramters. There are 15
% intercepts, one for each subject. We don't know what those are ahead of 
% time so we just guess the values for each are 4. Then there is one
% coefficient for the interaction term, which we guess as 0.4 (it is
% actually 0.5, but the point is we don't now that ahead of time!)
initial_params = [5]; 
fitted_params = fminsearch(@(y_int) model_fun(y_int,actual_sart_scores,model_values), initial_params);
%% plot
ColOrd = rand(15,3);
figure; 
subplot(1,2,1)
scatter(actual_sart_scores,model_values)
xlim([0 46])
ylim([0 46])
hold on
plot([0,46],[0,46],'-')
subplot(1,2,2)
fitted = model_values + fitted_params;
hold on;
plot(actual_sart_scores, fitted, 'o', 'Color', ColOrd(2,:))
xlim([0 46])
ylim([0 46])
plot([0,46],[0,46],'-')
%% end plot

function J = model_fun(y_int, actual_score, yhat)

Y = actual_score; % the measurements

[rows, cols] = size(Y);

Yhat_with_estimate = zeros(rows, cols);
for i = 1:rows
    Yhat_with_estimate(i) = y_int + yhat(i);
end

y_int;
J = sum((Y-Yhat_with_estimate).^2);

end