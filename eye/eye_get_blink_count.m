clear workspace;
clear all;

for idnum=2:2 %Change to 1:15
try
    if (idnum>9)
        id = strcat('2',string(idnum));
    else
        id = strcat('20',string(idnum));
    end
display(strcat('NOW PROCESSING ...',string(id)));
filepath = strcat('C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part',id,'\');
fn = 'eye_raw_features.mat';
load(strcat(filepath,fn)); 

blinks = raw_features(raw_features.Diameters < .1,:);
blinks_right_eye = blinks(blinks.ID == 0,:);

sync_data = readmatrix(strcat(filepath,'Part',id,'_BiopacLSLTimes.csv'));
sync = sync_data(:,2);

t1 = sync(2:3,:);
t2 = sync(6:7,:);
t3 = sync(10:11,:);
t4 = sync(14:15,:);
t5 = sync(18:19,:);
t6 = sync(22:23,:);
t7 = sync(26:27,:);
t8 = sync(30:31,:);
t9 = sync(34:35,:);
t10 = sync(38:39,:);
t11 = sync(42:43,:);
t12 = sync(46:47,:);

blinks_by_trial = {
  blinks_right_eye(blinks_right_eye.Timestamps > t1(1) & blinks_right_eye.Timestamps < t1(2),:); 
  blinks_right_eye(blinks_right_eye.Timestamps > t2(1) & blinks_right_eye.Timestamps < t2(2),:); 
  blinks_right_eye(blinks_right_eye.Timestamps > t3(1) & blinks_right_eye.Timestamps < t3(2),:); 
  blinks_right_eye(blinks_right_eye.Timestamps > t4(1) & blinks_right_eye.Timestamps < t4(2),:); 
  blinks_right_eye(blinks_right_eye.Timestamps > t5(1) & blinks_right_eye.Timestamps < t5(2),:); 
  blinks_right_eye(blinks_right_eye.Timestamps > t6(1) & blinks_right_eye.Timestamps < t6(2),:); 
  blinks_right_eye(blinks_right_eye.Timestamps > t7(1) & blinks_right_eye.Timestamps < t7(2),:); 
  blinks_right_eye(blinks_right_eye.Timestamps > t8(1) & blinks_right_eye.Timestamps < t8(2),:); 
  blinks_right_eye(blinks_right_eye.Timestamps > t9(1) & blinks_right_eye.Timestamps < t9(2),:); 
  blinks_right_eye(blinks_right_eye.Timestamps > t10(1) & blinks_right_eye.Timestamps < t10(2),:); 
  blinks_right_eye(blinks_right_eye.Timestamps > t11(1) & blinks_right_eye.Timestamps < t11(2),:); 
  blinks_right_eye(blinks_right_eye.Timestamps > t12(1) & blinks_right_eye.Timestamps < t12(2),:); 
};

catch ERR
    display(ERR.message);
end
end
