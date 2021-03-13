library(R.matlab)
library(ordinal)
library(MASS)
library(boot)
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

#finalOrdModel <- clm(resp ~ HR + V2 + V3 + V4 + V6 + V7 + V8 + V9 + V10 + V12 + V13 + V14 + V16 + V17 + V18 + V19 + V20 + V21 + V22 + V3:V9 + V16:V21 + V12:V19 + V10:V14 + V18:V22 + V19:V20 + V12:V16, data=predictors)
#stepwise fit according to AIC
finalOrdModel <- stepAIC(ordModel, scope=list(upper=~.*., lower=~1),direction = c("both"), steps=20)
#show resulting model terms
summary(finalOrdModel)
#Find pseudo-Rsquareds
nagelkerke(finalOrdModel, null = NULL, restrictNobs = FALSE)
#Calculate probabilities for Bedford ratings on each trial
a<-predict(finalOrdModel,predictors)
#Plot trial 15 probabilities
barplot(a$fit[15,1:10])
#Compare to actual trial 15 Bedford rating
matlabData$bigY[15]
#Save .mat for Matlab use
writeMat('test.mat',a = a)


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
  prediction <-predict(finalOrdModel,predictors[out,1:22])
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
