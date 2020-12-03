clear all;
clear workspace;

workload = zeros(12,15);
taskload = zeros(12,15);
sart = zeros(12,15);

for id=(201:215) %change to 215

    try
        display(strcat("PROCESSING...",string(id)));
    id = string(id);
    filepath = 'C:\Users\BIOPACMan\Documents\Zhang\HOME\data\part';
    
    load(strcat(filepath,id,'\part',id,'EmbeddedMeasuresAndScores.mat'));
    
    i = double(id)-200;
    workload(:,i) = (Workload.Bedford)';
    
    taskload(:,i) = (Workload.taskloadSetting12Runs)';
    
    sart(:,i) = (SA.SART10D)';
    
    catch ERR
        display(ERR.message);
        
    end
    
end

writematrix(workload,'workload.csv')
writematrix(taskload,'taskload.csv')
writematrix(sart,'sart.csv')