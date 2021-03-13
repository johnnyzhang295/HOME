library(R.matlab)
library(ordinal)
library(MASS)
library(boot)
library(plotly)
library(rcompanion)
#the directory where your .mat file is
setwd("~/Zhang/HOME/ordinal regression") 
# a .mat file with 2 matrices: one with predictors and one with Bedford scores
matlabData <- (readMat("workloadData.mat")) 
#matlabData$bigX is your matlab matrix containing predictor variables
predictors <- as.data.frame(matlabData$bigX[1:180,1:22]) 
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

#matlabData$bigY is your matlab matrix containing Bedford scores
resp <- factor(matlabData$bigY[1:180], ordered=TRUE)
#start with model including all terms and 2nd order interactions
ordModel <- clm(resp ~ ., data = predictors)

finalOrdModel <- clm(resp ~ HR + RMSSD + MeanNN + SDNN + CVNN + CVSD + MedianNN + 
                       MadNN + MCVNN + pNN50 + pNN20 + TINN + RSP_Amplitude + RSP_Rate + 
                       MeanPupilDiameter + BlinkCount + Age + Taskload + TrialOrder + 
                       MeanNN:MadNN + RSP_Amplitude:Taskload + MCVNN:TINN + MeanPupilDiameter:TrialOrder + 
                       BlinkCount:Age + pNN50:RSP_Amplitude + RSP_Amplitude:RSP_Rate + 
                       Age:TrialOrder + pNN20:MeanPupilDiameter + MedianNN:Age + 
                       HR:Age + Age:Taskload + CVNN:pNN20 + MeanNN:MeanPupilDiameter + 
                       MedianNN:MeanPupilDiameter, data=predictors)
  
  #stepwise fit according to AIC
#finalOrdModel <- stepAIC(ordModel, scope=list(upper=~.*., lower=~1),direction = c("both"), steps=20)
#show resulting model terms
summary(finalOrdModel)
#Find pseudo-Rsquareds
nagelkerke(finalOrdModel, null = NULL, restrictNobs = FALSE)


#initialize 
predictedBedfordAll <- c()

for (out in c(1:180)){
  
  #predict left out observation
  prediction <-predict(finalOrdModel,predictors[out,1:22])
  predictedBedford <- which.max(prediction$fit)
  #record in vector
  predictedBedfordAll <- c(predictedBedfordAll,predictedBedford)
}

writeMat('type_3_ModelWorkloadPredictions.mat', model_response=predictedBedfordAll)

resp_og = resp;

#true Bedford ratings
bigYold<-resp

#initialize
predictedBedfordAll <- c()

for (out in c(1:180)){
  bigXnew <- predictors
  #remove observation being left out
  bigXnew <- bigXnew[-out,1:22]
  resp <- bigYold
  #remove true Bedford rating being left out
  resp <- resp[-out]
  #refit coefficients using existing formula
  newMod <- clm(finalOrdModel$formula,data = bigXnew)
  #predict left out observation
  prediction <-predict(newMod,predictors[out,1:22])
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


#Do some ploting
plot(bigYold, predictedBedfordAll, main='Workload Ordinal Regression\nModel Type 3\n Leave One Trial Out Cross Validation',
     xlab='Subject Workload Score', ylab='Predicted Workload Response', col='red')
abline(lm(predictedBedfordAll~bigYold), col='red')
abline(0,1, col='blue',)
axis(side=1, at=c(1,2,3,4,5,6,7,8,9,10))
axis(side=2, at=c(1,2,3,4,5,6,7,8,9,10))
legend('topleft', legend = c('Predicted Trial Value','Line of Best Fit','Ideal Relationship'), 
       col=c('red','red','blue'), lty=1:2)



bigYold<-resp_og;
#initialize
LOOCV_B_predictedBedfordAll <- c()

for (out in seq(1,180,12)){
  bigXnew <- predictors
  #remove observation being left out
  start = out;
  stop = out + 11;
  
  bigXnew <- bigXnew[-c(start:stop),1:22]
  resp <- bigYold
  #remove true Bedford rating being left out
  resp <- resp[-c(start:stop)]
  #refit coefficients using existing formula
  newMod <- clm(finalOrdModel$formula,data = bigXnew)
  #predict left out observation
  prediction <-predict(newMod,predictors[c(start:stop),1:22])
  predictedBedford <- c();
  for (out2 in c(1:12))
    predictedBedford[out2] <- which.max(prediction$fit[out2,])
  
  #record in vector
  LOOCV_B_predictedBedfordAll <- c(LOOCV_B_predictedBedfordAll,predictedBedford)
}

#Do some ploting
plot(bigYold, LOOCV_B_predictedBedfordAll, main='Workload Ordinal Regression\nModel Type 3\n Leave One Subject Out Cross Validation',
     xlab='Subject Workload Score', ylab='Predicted Workload Response', col='red')
abline(lm(LOOCV_B_predictedBedfordAll~bigYold), col='red')
abline(0,1, col='blue',)
axis(side=1, at=c(1,2,3,4,5,6,7,8,9,10))
axis(side=2, at=c(1,2,3,4,5,6,7,8,9,10))
legend('topleft', legend = c('Predicted Trial Value','Line of Best Fit','Ideal Relationship'), 
       col=c('red','red','blue'), lty=1:2)


writeMat('type_3_workload_loocvB.mat', LOOCV_B=LOOCV_B_predictedBedfordAll)