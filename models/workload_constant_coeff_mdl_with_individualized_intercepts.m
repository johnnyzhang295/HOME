clear workspace;
clear all;
figure;
for subj_index=1:12
    subplot(3,4,subj_index);
    %data = loadData(subj_index);
    [subj_data,mdl] = MakeModel(subj_index); %This model specifically does NOT have an intercept
    %[err, fitted_model] = fitIntercept(subj_data,mdl, -.5);

    x = fminsearch(@(suggested_intercept_val) fitIntercept(subj_data,mdl, suggested_intercept_val),4);
    mdl_coeffs = {
        'trial' -0.919087889
        'taskload' 5.669553729
        'hr' 6.347974589
        'sdnn' 20.52302969
        'pnn50' -1.658270901
        'rsp_amp' 2.952046888
        'rsp_rate' -1.722142018
        'sex' 9.115974125
        'age' 0.710144429
        'trial:hr' 0.928675764
        'taskload:hr' -4.799225654
        'sdnn:pnn50' 0.836340358
        'rsp_amp:rsp_rate' 1.180039501
        'rsp_amp:sex' -6.063245826
        'rsp_rate:sex' -1.505518089
        'sdnn:age' -0.851841749
        };
    subj_predictors = subj_data{:, 1:end - 1};
    subj_response = subj_data{:,end};
    
    hold on;
    predictions = [];
        for r=1:12
                tr = mdl_coeffs{1,2}*subj_predictors(r,1);
                tl = mdl_coeffs{2,2}*subj_predictors(r,2);
                hr = mdl_coeffs{3,2}*subj_predictors(r,3);
                sdnn = mdl_coeffs{4,2}*subj_predictors(r,4);
                pnn50 = mdl_coeffs{5,2}*subj_predictors(r,5);
                amp = mdl_coeffs{6,2}*subj_predictors(r,6);
                rate = mdl_coeffs{7,2}*subj_predictors(r,7);
                sex  = mdl_coeffs{8,2}*subj_predictors(r,8);
                age = mdl_coeffs{9,2}*subj_predictors(r,9);
                trial_hr = mdl_coeffs{10,2}*subj_predictors(r,1)*subj_predictors(r,3);
                tl_hr = mdl_coeffs{11,2}*subj_predictors(r,2)*subj_predictors(r,3);
                sdnn_pnn50 = mdl_coeffs{12,2}*subj_predictors(r,4)*subj_predictors(r,5);
                amp_rate = mdl_coeffs{13,2}*subj_predictors(r,6)*subj_predictors(r,7);
                amp_sex = mdl_coeffs{14,2}*subj_predictors(r,6)*subj_predictors(r,8);
                rate_sex = mdl_coeffs{15,2}*subj_predictors(r,7)*subj_predictors(r,8);
                sdnn_age = mdl_coeffs{16,2}*subj_predictors(r,4)*subj_predictors(r,9);

                prediction = tr+tl+hr+sdnn+pnn50+amp+rate+sex+age+trial_hr+tl_hr+sdnn_pnn50+amp_rate+amp_sex+rate_sex+sdnn_age - 24.35 ;
                
                scatter(subj_response(r), prediction, 'r');
                predictions(r) = prediction;
        end
    p = polyfit(subj_response,predictions,1);
    pfit = polyval(p,subj_response);
    plot(subj_response, pfit, '-b','HandleVisibility','off');
    grid on;
    grid minor;
    sse = sum((predictions - subj_response').^2);
    r_sq = corrcoef(subj_response, 
    title(strcat("Subject: ",string(subj_index)," SSE: ",string(sse)));
    % hold on;
    % subj_predictors = subj_data{:, 1:end - 1};
    % subj_response = subj_data{:,end};
    % yfit = predict(mdl,subj_predictors);
    % scatter(subj_response, yfit,'b');
    % p = polyfit(subj_response,yfit,1);
    % pfit = polyval(p,subj_response);
    % plot(subj_response,pfit,'-b','HandleVisibility','off');
    % grid on;
    % grid minor;

        
    
end
suptitle("Workload Constant Coeff, Individualized Intercepts");
function [subj_data,mdl] = MakeModel(subj_index)
        workload = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\support\Workload.csv');
        taskload = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\support\taskload settings\taskload settings.csv');
        hrv201 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part201\Time Based HRV Analyses By Trial.csv');
        hrv202 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part202\Time Based HRV Analyses By Trial.csv');
        hrv203 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part203\Time Based HRV Analyses By Trial.csv');
        hrv204 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part204\Time Based HRV Analyses By Trial.csv');
        hrv205 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part205\Time Based HRV Analyses By Trial.csv');
        hrv206 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part206\Time Based HRV Analyses By Trial.csv');

        hrv207 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part207\Time Based HRV Analyses By Trial.csv');
        hrv208 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part208\Time Based HRV Analyses By Trial.csv');
        hrv209 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part209\Time Based HRV Analyses By Trial.csv');
        hrv210 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part210\Time Based HRV Analyses By Trial.csv');
        hrv211 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part211\Time Based HRV Analyses By Trial.csv');
        hrv212 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part212\Time Based HRV Analyses By Trial.csv');
        hrv213 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part213\Time Based HRV Analyses By Trial.csv');

        hrv214 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part214\Time Based HRV Analyses By Trial.csv');
        hrv215 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part215\Time Based HRV Analyses By Trial.csv');
        trial_order = [1 2 3 4 5 6 7 8 9 10 11 12]';

        b201 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part201\Baseline Time Based HRV Analyses By Trial.csv');
        b202 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part202\Baseline Time Based HRV Analyses By Trial.csv');
        b203 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part203\Baseline Time Based HRV Analyses By Trial.csv');
        b204 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part204\Baseline Time Based HRV Analyses By Trial.csv');
        b205 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part205\Baseline Time Based HRV Analyses By Trial.csv');
        b206 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part206\Baseline Time Based HRV Analyses By Trial.csv');
        b207 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part207\Baseline Time Based HRV Analyses By Trial.csv');
        b208 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part208\Baseline Time Based HRV Analyses By Trial.csv');
        b209 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part209\Baseline Time Based HRV Analyses By Trial.csv');
        b210 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part210\Baseline Time Based HRV Analyses By Trial.csv');
        b211 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part211\Baseline Time Based HRV Analyses By Trial.csv');
        b212 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part212\Baseline Time Based HRV Analyses By Trial.csv');
        b213 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part213\Baseline Time Based HRV Analyses By Trial.csv');
        b214 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part214\Baseline Time Based HRV Analyses By Trial.csv');
        b215 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part215\Baseline Time Based HRV Analyses By Trial.csv');
        pnums = ['201';'202';'203';'204';'205';'206'; '207';'208';'209';'210';'211';'212';'213';'214';'215'];

        cmaawards = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\support\sex_age.txt');
        rsp_pilot_201 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part201\RSP data by trial.csv');
        rsp_pilot_202 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part202\RSP data by trial.csv');
        rsp_pilot_203 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part203\RSP data by trial.csv');
        rsp_pilot_204 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part204\RSP data by trial.csv');
        rsp_pilot_205 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part205\RSP data by trial.csv');
        rsp_pilot_206 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part206\RSP data by trial.csv');
        rsp_pilot_207 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part207\RSP data by trial.csv');
        rsp_pilot_208 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part208\RSP data by trial.csv');
        rsp_pilot_209 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part209\RSP data by trial.csv');
        rsp_pilot_210 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part210\RSP data by trial.csv');
        rsp_pilot_211 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part211\RSP data by trial.csv');
        rsp_pilot_212 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part212\RSP data by trial.csv');
        rsp_pilot_213 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part213\RSP data by trial.csv');
        rsp_pilot_214 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part214\RSP data by trial.csv');
        rsp_pilot_215 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part215\RSP data by trial.csv');

        rsp_base_201 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part201\RSP baseline.csv');
        rsp_base_202 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part202\RSP baseline.csv');
        rsp_base_203 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part203\RSP baseline.csv');
        rsp_base_204 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part204\RSP baseline.csv');
        rsp_base_205 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part205\RSP baseline.csv');
        rsp_base_206 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part206\RSP baseline.csv');
        rsp_base_207 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part207\RSP baseline.csv');
        rsp_base_208 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part208\RSP baseline.csv');
        rsp_base_209 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part209\RSP baseline.csv');
        rsp_base_210 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part210\RSP baseline.csv');
        rsp_base_211 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part211\RSP baseline.csv');
        rsp_base_212 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part212\RSP baseline.csv');
        rsp_base_213 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part213\RSP baseline.csv');
        rsp_base_214 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part214\RSP baseline.csv');
        rsp_base_215 = load('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part215\RSP baseline.csv');


            r_201 = rsp_pilot_201(:,1:8)/rsp_base_201;
            r_201 = r_201(1:2:end,:);
            r_202 = rsp_pilot_202(:,1:8)/rsp_base_202;
            r_202 = r_202(1:2:end,:);
            r_203 = rsp_pilot_203(:,1:8)/rsp_base_203;
            r_203 = r_203(1:2:end,:);
            r_204 = rsp_pilot_204(:,1:8)/rsp_base_204;
            r_204 = r_204(1:2:end,:);
            r_205 = rsp_pilot_205(:,1:8)/rsp_base_205;
            r_205 = r_205(1:2:end,:);
            r_206 = rsp_pilot_206(:,1:8)/rsp_base_206;
            r_206 = r_206(1:2:end,:);
            r_207 = rsp_pilot_207(:,1:8)/rsp_base_207;
            r_207 = r_207(1:2:end,:);
            r_208 = rsp_pilot_208(:,1:8)/rsp_base_208;
            r_208 = r_208(1:2:end,:);
            r_209 = rsp_pilot_209(:,1:8)/rsp_base_209;
            r_209 = r_209(1:2:end,:);
            r_210 = rsp_pilot_210(:,1:8)/rsp_base_210;
            r_210 = r_210(1:2:end,:);
            r_211 = rsp_pilot_211(:,1:8)/rsp_base_211;
            r_211 = r_211(1:2:end,:);
            r_212 = rsp_pilot_212(:,1:8)/rsp_base_212;
            r_212 = r_212(1:2:end,:);
            r_213 = rsp_pilot_213(:,1:8)/rsp_base_213;
            r_213 = r_213(1:2:end,:);
            r_214 = rsp_pilot_214(:,1:8)/rsp_base_214;
            r_214 = r_214(1:2:end,:);
            r_215 = rsp_pilot_215(:,1:8)/rsp_base_215;
            r_215 = r_215(1:2:end,:);



            cols=5;
            length=12;
            donk= [1 4 12];
            data= cell(12,1);
            data(1,:) = {[hrv201(:,donk)./b201(donk) r_201 ]};
            data(2,:) = {[hrv202(:,donk)./b202(donk) r_202]};
            data(3,:) = {[hrv203(:,donk)./b203(donk) r_203]};
            data(4,:) = {[hrv204(:,donk)./b204(donk) r_204]};
            data(5,:) = {[hrv205(:,donk)./b205(donk) r_205]};
            data(6,:) = {[hrv206(:,donk)./b206(donk) r_206]};
            data(7,:) = {[hrv207(:,donk)./b207(donk) r_207]};
            data(8,:) = {[hrv208(:,donk)./b208(donk) r_208]};
            data(9,:) = {[hrv209(:,donk)./b209(donk) r_209]};
            data(10,:) = {[hrv210(:,donk)./b210(donk) r_210]};
            data(11,:) = {[hrv211(:,donk)./b211(donk) r_211]};
            data(12,:) = {[hrv212(:,donk)./b212(donk) r_212]};
            data(13,:) = {[hrv213(:,donk)./b213(donk) r_213]};
            data(14,:) = {[hrv214(:,donk)./b214(donk) r_214]};
            data(15,:) = {[hrv215(:,donk)./b215(donk) r_215]};


            age_sex = zeros(180,2);
            age_sex = ...
            [repmat(cmaawards(1,:),[12,1]);
             repmat(cmaawards(2,:),[12,1]);
             repmat(cmaawards(3,:),[12,1]);
             repmat(cmaawards(4,:),[12,1]);
             repmat(cmaawards(5,:),[12,1]);
             repmat(cmaawards(6,:),[12,1]);
             repmat(cmaawards(7,:),[12,1]);
             repmat(cmaawards(8,:),[12,1]);
             repmat(cmaawards(9,:),[12,1]);
             repmat(cmaawards(10,:),[12,1]);
             repmat(cmaawards(11,:),[12,1]);
             repmat(cmaawards(12,:),[12,1]);
             repmat(cmaawards(13,:),[12,1]);
             repmat(cmaawards(14,:),[12,1]);
             repmat(cmaawards(15,:),[12,1]);
            ];
            leaveout = 0;
            wl = zeros(12,15);
            tl = zeros(12,15);
            x_ax = zeros(10,15);
            t = zeros(12,15);
            subj_data = zeros(12, 10);%This needs to be changed when you add extra model params
            for z=1:15
                if (z == leaveout)

                    data{z}(isinf(data{z})) = 0;
                    subj_data(:,3:7) = data{z};
                    data(z) = [];
                    subj_data(:,1) = (1:12)';
                    subj_data(:,2) = taskload(z,:)';
                    subj_data(:,8) = logical(cmaawards(z,1));
                    subj_data(:,9) = cmaawards(z,2);
                    %Add here- whenever you add extra model params
                    subj_data(:,10) = workload(2:end,z); %This needs to be changed when you add extra model params
                    continue
                end
                wl(:,z) = workload(2:end,z);
                tl(:,z) = taskload(z,:)';
                x_ax(:,z) = (1:10)';
                t(:,z) = (1:12)';
            end

            wl = wl(wl>0);
            tl = tl(tl>0);
            x_ax = x_ax(x_ax>0);
            t = t(t>0);
            data = cell2mat(data);
            data(isinf(data)) = 0;


            tabl = table(t,tl,data(:,1),data(:,2),data(:,3),data(:,4),data(:,5), age_sex(:,1), age_sex(:,2),wl,...
                'VariableNames',{'TrialOrder','Taskload','HR','SDNN','pNN50','RSP_Amp','RSP_Rate','Sex','Age','wl'});

            lower_bound = (subj_index - 1)*12 + 1;
            upper_bound = (subj_index - 1)*12 + 12;
            subj_data = tabl(lower_bound:upper_bound,:);
            mdl = fitglm(tabl,...,
                'wl ~ Sex+Age + TrialOrder*HR + Taskload*HR + SDNN*pNN50 +SDNN*Age + RSP_Amp*RSP_Rate +RSP_Amp:Sex + RSP_Rate:Sex',...,
                'ResponseVar','wl','Intercept', true);
        end

        
function total_sse = fitIntercept(subj_data, mdl, suggested_intercept_val)
            mdl_coeffs = {
            'trial' -0.919087889
            'taskload' 5.669553729
            'hr' 6.347974589
            'sdnn' 20.52302969
            'pnn50' -1.658270901
            'rsp_amp' 2.952046888
            'rsp_rate' -1.722142018
            'sex' 9.115974125
            'age' 0.710144429
            'trial:hr' 0.928675764
            'taskload:hr' -4.799225654
            'sdnn:pnn50' 0.836340358
            'rsp_amp:rsp_rate' 1.180039501
            'rsp_amp:sex' -6.063245826
            'rsp_rate:sex' -1.505518089
            'sdnn:age' -0.851841749
            };

            subj_predictors = subj_data{:, 1:end - 1};
            subj_response = subj_data{:,end};
        %     y_fit = predict(mdl,subj_predictors) + suggested_intercept_val;
        %     sse = sum((y_fit - subj_response).^2);
            total_sse = 0;
            for r=1:12
                tr = mdl_coeffs{1,2}*subj_predictors(r,1);
                tl = mdl_coeffs{2,2}*subj_predictors(r,2);
                hr = mdl_coeffs{3,2}*subj_predictors(r,3);
                sdnn = mdl_coeffs{4,2}*subj_predictors(r,4);
                pnn50 = mdl_coeffs{5,2}*subj_predictors(r,5);
                amp = mdl_coeffs{6,2}*subj_predictors(r,6);
                rate = mdl_coeffs{7,2}*subj_predictors(r,7);
                sex  = mdl_coeffs{8,2}*subj_predictors(r,8);
                age = mdl_coeffs{9,2}*subj_predictors(r,9);
                trial_hr = mdl_coeffs{10,2}*subj_predictors(r,1)*subj_predictors(r,3);
                tl_hr = mdl_coeffs{11,2}*subj_predictors(r,2)*subj_predictors(r,3);
                sdnn_pnn50 = mdl_coeffs{12,2}*subj_predictors(r,4)*subj_predictors(r,5);
                amp_rate = mdl_coeffs{13,2}*subj_predictors(r,6)*subj_predictors(r,7);
                amp_sex = mdl_coeffs{14,2}*subj_predictors(r,6)*subj_predictors(r,8);
                rate_sex = mdl_coeffs{15,2}*subj_predictors(r,7)*subj_predictors(r,8);
                sdnn_age = mdl_coeffs{16,2}*subj_predictors(r,4)*subj_predictors(r,9);

                prediction = tr+tl+hr+sdnn+pnn50+amp+rate+sex+age+trial_hr+tl_hr+sdnn_pnn50+amp_rate+amp_sex+rate_sex+sdnn_age - 24.35 ;
                prediction = prediction + suggested_intercept_val;

                sse =  (prediction - subj_response(r)).^2;
                total_sse = total_sse + sse;
            end





        end