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
#matlabData$bigY is your matlab matrix containing Bedford scores
resp <- factor(matlabData$bigY[1:180], ordered=TRUE)
#start with model including all terms and 2nd order interactions
ordModel <- clm(resp ~ ., data = predictors)
#stepwise fit according to AIC
finalOrdModel <- stepAIC(ordModel,direction = c("both"), steps=30)
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
