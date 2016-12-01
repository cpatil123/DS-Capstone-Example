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

tdm_N1 <- generateTDM(FinalCorpus, 1, isTrace = T)
save(tdm_N1, file="tdm_N1.RData")
tdm_N2 <- generateTDM(FinalCorpus, 2, isTrace = T)
save(tdm_N2, file="tdm_N2.RData")
tdm_N3 <- generateTDM(FinalCorpus, 3, isTrace = T)
save(tdm_N3, file="tdm_N3.RData")
tdm_N4 <- generateTDM(FinalCorpus, 4, isTrace = T)
save(tdm_N4, file="tdm_N4.RData")
tdm_N5 <- generateTDM(FinalCorpus, 5, isTrace = T)
save(tdm_N5, file="tdm_N5.RData")
tdm.list <- list(tdm_N1, tdm_N2, tdm_N3, tdm_N4, tdm_N5)

# TEST LINES - Quiz 2 Questions
testline1 <- "The guy in front of me just bought a pound of bacon, a bouquet, and a case of"
test <- "a case of"
testline2 <- "You're the reason why I smile everyday. Can you follow me please? It would mean the"
testline3 <- "Hey sunshine, can you follow me and make me the"
testline4 <- "Very early observations on the Bills game: Offense still struggling but the"
testline5 <- "Go on a romantic date at the"
testline6 <- "Well I'm pretty sure my granny has some old bagpipes in her garage I'll dust them off and be on my"
testline7 <- "Ohhhhh #PointBreak is on tomorrow. Love that film and haven't seen it in quite some"
testline8 <- "After the ice bucket challenge Louis will push his long wet hair out of his eyes with his little"
testline9 <- "Be grateful for the good times and keep the faith during the"
testline10 <- "If this isn't the cutest thing you've ever seen, then you must be"

testline.list <- list(testline1, testline2, testline3, testline4, testline5, testline6, testline7, testline8, testline9, testline10)

# Next Word Prediction using Backoff Algorithm (It works but it sucks. Inaccurate.)
predict_Backoff(testline1, tdm.list)


# Save data cache
save(Xcorpus, file="Xcorpus.RData")
save.image(file="PredictionModel.RData")

#
pmatch(x, table, nomatch = NA_integer_, duplicates.ok = FALSE)