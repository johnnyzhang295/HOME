library(R.matlab)
library(ordinal)
library(MASS)
library(boot)
library(plotly)
library(rcompanion)
library(sure)
#the directory where your .mat file is
setwd("~/Zhang/HOME/ordinal regression") 


make_models <- function(type, size) {
  
  # a .mat file with 2 matrices: one with predictors and one with Bedford scores
  matlabData <- (readMat("workloadData.mat")) 
  sex_id <- readMat('sex_id.mat')
  sex_id <- sex_id$add;
  
  x = factor(sex_id[,2]);
  y =  factor(matlabData$bigY[1:180], ordered=TRUE)
  
  sex_id[,1] <- factor(sex_id[,1])
  
  sex_id[,2] <- factor(sex_id[,2])
  
#matlabData$bigX is your matlab matrix containing predictor variables
predictors <- as.data.frame(matlabData$bigX[1:180,]) 
  predictors <-  cbind(predictors, sex_id)
colnames(predictors)[1] = 'HR';
colnames(predictors)[2] = 'RMSSD';
colnames(predictors)[3] = 'MeanNN';
colnames(predictors)[4] = 'SDNN';
colnames(predictors)[5] = 'SDSD';
colnames(predictors)[6] = 'CVNN';
colnames(predictors)[7] = 'CVSD';
colnames(predictors)[8] = 'MedianNN';
colnames(predictors)[9] = 'MadNN';
colnames(predictors)[10] = 'MCVNN';
colnames(predictors)[11] = 'IQRNN';
colnames(predictors)[12] = 'pNN50';
colnames(predictors)[13] = 'pNN20';
colnames(predictors)[14] = 'TINN';
colnames(predictors)[15] = 'HTI';
colnames(predictors)[16] = 'RSP_Amplitude';
colnames(predictors)[17] = 'RSP_Rate';
colnames(predictors)[18] = 'MeanPupilDiameter';
colnames(predictors)[19] = 'BlinkCount';
colnames(predictors)[20] = 'Age';
colnames(predictors)[21] = 'Taskload';
colnames(predictors)[22] = 'TrialOrder';

colnames(predictors)[23] = 'Sex';
predictors[,23] = factor(predictors[,23]);

colnames(predictors)[24] = 'ID';

predictors = predictors[1:180, -23]; # for model type 4/5
predictors = predictors[1:180, -20]; # for model type 2/4/5

predictors[,22] = factor(predictors[,22])

predictors <<- as.data.frame(predictors)
#predictors = predictors[1:180, ,]; # for model types 1,3
#matlabData$bigY is your matlab matrix containing Bedford scores
resp <- factor(matlabData$bigY[1:180], ordered=TRUE)
#start with model including all terms and 2nd order interactions
ordModel <- clm(resp ~ ., data = predictors)

if (type == "3"){

finalOrdModel <- clm(resp ~ HR + RMSSD + MeanNN + SDNN + CVNN + CVSD + MedianNN +
                       MadNN + MCVNN + pNN50 + pNN20 + TINN + RSP_Amplitude + RSP_Rate +
                       MeanPupilDiameter + BlinkCount + Age + Taskload + TrialOrder +
                       MeanNN:MadNN + RSP_Amplitude:Taskload + MCVNN:TINN + MeanPupilDiameter:TrialOrder +
                       BlinkCount:Age + pNN50:RSP_Amplitude + RSP_Amplitude:RSP_Rate +
                       Age:TrialOrder + pNN20:MeanPupilDiameter + MedianNN:Age +
                       HR:Age + Age:Taskload + CVNN:pNN20 + MeanNN:MeanPupilDiameter +
                       MedianNN:MeanPupilDiameter, data=predictors)
} else if (type == "2"){
  
  finalOrdModel <- clm(resp ~ HR + RMSSD + MeanNN + SDNN + SDSD + CVNN + CVSD + MedianNN + MadNN + MCVNN + IQRNN + pNN50 + pNN20 + TINN + HTI + RSP_Amplitude + RSP_Rate + MeanPupilDiameter + BlinkCount + Taskload + TrialOrder + 
                         MadNN:BlinkCount + MeanPupilDiameter:TrialOrder + RSP_Amplitude:Taskload + MeanNN:MadNN, data=predictors)

} else if (type == "1"){
  finalOrdModel <- clm(resp ~ HR + RMSSD + MeanNN + SDNN + SDSD + CVNN + CVSD + MedianNN + MadNN + MCVNN + IQRNN + pNN50 + pNN20 + TINN + HTI + RSP_Amplitude + MeanPupilDiameter + BlinkCount + CVNN:TINN + pNN50:RSP_Amplitude + pNN50:HTI + IQRNN:HTI + MeanPupilDiameter:BlinkCount + HR:HTI + HR:CVNN + MeanNN:pNN50 + HR:pNN50
                       , data=predictors)

}  else if (type == "4")
{
  finalOrdModel <- clm(resp ~ HR + RMSSD + MeanNN + SDNN + CVNN + CVSD + MedianNN +
                         MadNN + MCVNN + pNN50 + pNN20 + TINN + RSP_Amplitude + RSP_Rate +
                         MeanPupilDiameter + BlinkCount  + Taskload + TrialOrder +
                         MeanNN:MadNN + RSP_Amplitude:Taskload + MCVNN:TINN + MeanPupilDiameter:TrialOrder +
                        pNN50:RSP_Amplitude + RSP_Amplitude:RSP_Rate +
                          pNN20:MeanPupilDiameter + 
                          CVNN:pNN20 + MeanNN:MeanPupilDiameter + ID + 
                         MedianNN:MeanPupilDiameter, data=predictors)

  #finalOrdModel <- stepAIC(ordModel, scope=list(upper=~.*., lower=~1),direction = c("backward"), steps=10)
  
} else if (type == "5"){
  
  
  finalOrdModel <- clm(resp ~ HR + RMSSD + MeanNN + SDNN + CVNN + MedianNN + MadNN + 
                         MCVNN + IQRNN + pNN50 + pNN20 + TINN + HTI + RSP_Amplitude + 
                         RSP_Rate + MeanPupilDiameter + BlinkCount + Taskload + TrialOrder + 
                         ID + Taskload:ID + MeanPupilDiameter:TrialOrder + MadNN:pNN50 + 
                         IQRNN:pNN20 + pNN20:MeanPupilDiameter + MadNN:ID + RSP_Amplitude:RSP_Rate + 
                         SDNN:BlinkCount + MCVNN:HTI + MadNN:pNN20 + MeanPupilDiameter:BlinkCount + 
                         HTI:RSP_Rate + HTI:TrialOrder, data=predictors)
  
  #finalOrdModel <- clm(resp ~ HR + RMSSD + MeanNN + SDNN + SDSD + CVNN + CVSD + MedianNN + MadNN + MCVNN + IQRNN + pNN50 + pNN20 + TINN + HTI + RSP_Amplitude + RSP_Rate + MeanPupilDiameter + BlinkCount + Taskload + TrialOrder + ID + SDSD:BlinkCount + MeanPupilDiameter:TrialOrder + pNN20:ID + RSP_Amplitude:Taskload + pNN50:RSP_Amplitude + MadNN:pNN50 + MeanNN:MeanPupilDiameter + MadNN:ID + pNN20:MeanPupilDiameter + IQRNN:pNN20 + SDNN:MCVNN + HR:IQRNN + MadNN:pNN20
  #                     ,data=predictors)
}

  
#stepwise fit according to AIC
#finalOrdModel <- stepAIC(ordModel, scope=list(upper=~.*., lower=~1),direction = c("both"), steps=4)
#show resulting model terms
print(summary(finalOrdModel))
#Find pseudo-Rsquareds
print(nagelkerke(finalOrdModel, null = NULL, restrictNobs = FALSE))


#initialize 
predictedBedfordAll <- c()

for (out in c(1:180)){
  
  #predict left out observation
  prediction <-predict(finalOrdModel,predictors[out,])
  predictedBedford <- which.max(prediction$fit)
  #record in vector
  predictedBedfordAll <- c(predictedBedfordAll,predictedBedford)
}

fn = paste("type",type, "model_wl_predictions.mat",sep = '_')
writeMat(fn, model_response=predictedBedfordAll)

resp_og = resp;

residuals = resp_og - predictedBedfordAll

#true Bedford ratings
bigYold<-resp

#initialize
predictedBedfordAll <- c()

for (out in c(1:180)){
  bigXnew <- predictors
  #remove observation being left out
  bigXnew <- bigXnew[-out,]
  resp <- bigYold
  #remove true Bedford rating being left out
  resp <- resp[-out]
  #refit coefficients using existing formula
  newMod <- clm(finalOrdModel$formula,data = bigXnew)
  #predict left out observation
  prediction <-predict(newMod,predictors[out,])
  predictedBedford <- which.max(prediction$fit)
  #record in vector
  predictedBedfordAll <- c(predictedBedfordAll,predictedBedford)
}

#initialize accuracy counters
ACC0 <- 0
ACC1 <- 0
ACC2 <- 0
#convert to integer for comparisons
bigYold <- as.integer(bigYold)

#calculate accuracy metrics
for (out in c(1:180)){
  if(predictedBedfordAll[out]==bigYold[out]){
    ACC0 <- ACC0+1 
  }
}
for (out in c(1:180)){
  if(predictedBedfordAll[out]==bigYold[out] | abs(predictedBedfordAll[out]-bigYold[out])==1){
    ACC1 <- ACC1+1 
  }
}
for (out in c(1:180)){
  if(predictedBedfordAll[out]==bigYold[out] | abs(predictedBedfordAll[out]-bigYold[out])==2|
     abs(predictedBedfordAll[out]-bigYold[out])==1){
    ACC2 <- ACC2+1 
  }
}



fn2 = paste("type",type, "_LOOCV_C_predictions.mat",sep = '_')
writeMat(fn2, LOOCV_C=predictedBedfordAll)


#Do some ploting

title = paste('Workload Ordinal Regression\nModel Type ', type, '\n Leave One Trial Out Cross Validation')
plot(bigYold, predictedBedfordAll, main=title,
     xlab='Subject Workload Score', ylab='Predicted Workload Response', col='red', ylim = c(1,10),
     xlim = c(1,10))
abline(lm(predictedBedfordAll~bigYold), col='red')
abline(0,1, col='blue',)
axis(side=1, at=c(1,2,3,4,5,6,7,8,9,10))

axis(side=2, at=c(1,2,3,4,5,6,7,8,9,10))
legend('topleft', legend = c('Predicted Trial Value','Line of Best Fit','Ideal Relationship'), 
       col=c('red','red','blue'), lty=1:2)

if (type != "4" || "5"){

bigYold<-resp_og;
#initialize
LOOCV_B_predictedBedfordAll <- c()

for (out in seq(1,180,12)){
  bigXnew <- predictors
  #remove observation being left out
  start = out;
  stop = out + 11;
  
  bigXnew <- bigXnew[-c(start:stop),]
  resp <- bigYold
  #remove true Bedford rating being left out
  resp <- resp[-c(start:stop)]
  #refit coefficients using existing formula
  newMod <- clm(finalOrdModel$formula,data = bigXnew)
  #predict left out observation
  prediction <-predict(newMod,predictors[c(start:stop),])
  predictedBedford <- c();
  for (out2 in c(1:12))
    predictedBedford[out2] <- which.max(prediction$fit[out2,])
  
  #record in vector
  LOOCV_B_predictedBedfordAll <- c(LOOCV_B_predictedBedfordAll,predictedBedford)
}

#initialize accuracy counters
B_ACC0 <- 0
B_ACC1 <- 0
B_ACC2 <- 0
#convert to integer for comparisons
bigYold <- as.integer(bigYold)

#calculate accuracy metrics
for (out in c(1:180)){
  if(LOOCV_B_predictedBedfordAll[out]==bigYold[out]){
    B_ACC0 <- B_ACC0+1 
  }
}
for (out in c(1:180)){
  if(LOOCV_B_predictedBedfordAll[out]==bigYold[out] | abs(LOOCV_B_predictedBedfordAll[out]-bigYold[out])==1){
    B_ACC1 <- B_ACC1+1 
  }
}
for (out in c(1:180)){
  if(LOOCV_B_predictedBedfordAll[out]==bigYold[out] | abs(LOOCV_B_predictedBedfordAll[out]-bigYold[out])==2|
     abs(LOOCV_B_predictedBedfordAll[out]-bigYold[out])==1){
    B_ACC2 <- B_ACC2+1 
  }
}
B_rmse = 1/180 * sum((LOOCV_B_predictedBedfordAll - bigYold)^2)
print(B_rmse)
#Do some ploting

title = paste('Workload Ordinal Regression\nModel Type ', type, '\n Leave One Subject Out Cross Validation')
plot(bigYold, LOOCV_B_predictedBedfordAll, main=title,
     xlab='Subject Workload Score', ylab='Predicted Workload Response', col='red')
abline(lm(LOOCV_B_predictedBedfordAll~bigYold), col='red')
abline(0,1, col='blue',)
axis(side=1, at=c(1,2,3,4,5,6,7,8,9,10))
axis(side=2, at=c(1,2,3,4,5,6,7,8,9,10))

legend('topleft', legend = c('Predicted Trial Value','Line of Best Fit','Ideal Relationship'), 
       col=c('red','red','blue'), lty=1:2)
ylim(1,10)
xlim(1,10)

fn2 = paste("type",type, "_LOOCV_B_predictions.mat",sep = '_')
writeMat(fn2, LOOCV_B=LOOCV_B_predictedBedfordAll)
}

}

#make_models("5", 24)
make_models("4", 24)
#make_models("1", 22)
#make_models("2", 22)
#make_models("3", 22)