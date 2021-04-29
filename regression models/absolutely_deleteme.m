savePlots(pie_1, 1, 'p')

savePlots(pie_2, 2, 'p')

savePlots(pie_3, 3, 'p')

savePlots(pie_4, 4, 'p')

function [] = savePlots(fig, type, LOOCV)
%LOOCV = 0, normal fit, =1, B, =2, =C
    
    path = 'C:\Users\BIOPACMan\Documents\Zhang\HOME\regression models\final model figurs\';
    if (LOOCV == '0')
        saveas(fig, strcat(path,'Type',string(type),'.jpg'));
        return;
    end
    
     if (LOOCV == 'p')
        saveas(fig, strcat(path,'pie chart ', string(type), '.jpg'));
        return;
     end
     
    saveas(fig, strcat(path,'Type',string(type),' LOOCV',string(LOOCV),'.jpg'));
end
