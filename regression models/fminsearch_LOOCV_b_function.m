
survey_scores = [21 21 22 23 24 28 33 33 33 34 35 36]'; 
model_predictions = [25 25 28 23 28 28 36 37 36 37 38 38]';

[y_int,SSR] = find_y_intercept(survey_scores,model_predictions)


function [y_int,SSR] = find_y_intercept(survey_scores, model_predictions)
    actual_sart_scores = survey_scores; 
    model_values = model_predictions;

    initial_params = [5]; 
    [y_int,SSR] = fminsearch(@(y_int) model_fun(y_int,actual_sart_scores,model_values), initial_params);
%     %% plot
%     ColOrd = rand(15,3);
%     figure; 
%     subplot(1,2,1)
%     scatter(actual_sart_scores,model_values)
%     xlim([0 46])
%     ylim([0 46])
%     hold on
%     plot([0,46],[0,46],'-')
%     subplot(1,2,2)
%     fitted = model_values + y_int;
%     hold on;
%     plot(actual_sart_scores, fitted, 'o', 'Color', ColOrd(2,:))
%     xlim([0 46])
%     ylim([0 46])
%     plot([0,46],[0,46],'-')
    %% end plot

    function SSR = model_fun(y_int, actual_score, yhat)

        Y = actual_score; % the measurements

        [rows, cols] = size(Y);

        Yhat_with_estimate = zeros(rows, cols);
        for i = 1:rows
            Yhat_with_estimate(i) = y_int + yhat(i);
        end

        SSR = sum((Y-Yhat_with_estimate).^2);

    end
end