# Prediction Model
################################################################################
library(ANLP)
library(stringi)
options(java.parameters = "-Xmx6144m" )

setwd("C://Users//Yanal Kashou//Data Science//Projects//R//DataScienceCapstone//cache")
load("FinalCorpus.RData")
load("Xcorpus.RData")

## ANLP specific cleaning
Xcorpus <- cleanTextData(FinalCorpus)

### Term-Document Matrix for each N-Gram where 1 <= N <= 5

tdm_N2 <- generateTDM(FinalCorpus, 2, isTrace = T)
save(tdm_N2, file="tdm_N2.RData")
tdm_N3 <- generateTDM(FinalCorpus, 3, isTrace = T)
save(tdm_N3, file="tdm_N3.RData")
tdm_N4 <- generateTDM(FinalCorpus, 4, isTrace = T)
save(tdm_N4, file="tdm_N4.RData")
tdm_N5 <- generateTDM(FinalCorpus, 5, isTrace = T)
save(tdm_N5, file="tdm_N5.RData")
tdm_N6 <- generateTDM(FinalCorpus, 6, isTrace = T)
save(tdm_N6, file="tdm_N6.RData")
tdm.list <- list(tdm_N2, tdm_N3, tdm_N4, tdm_N5, tdm_N6)

NGramList <- list(N_Gram.df)
# Next Word Prediction using Backoff Algorithm (It works but it sucks. Inaccurate.)
predict_Backoff(test01, NGramList)

# Save data cache
save(Xcorpus, file="Xcorpus.RData")
save.image(file="PredictionModel.RData")

#
