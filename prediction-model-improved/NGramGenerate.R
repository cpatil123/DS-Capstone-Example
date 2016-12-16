### NGramGenerate.R
################################################################################
# Set working directory
setwd("C://Users//Yanal Kashou//Data Science//Projects//R//DataScienceCapstone//cache")

# Load .RData file(s)
load("FinalCorpus.RData")

# Increase Java Memory Heap Size
options(java.parameters = "-Xmx6144m" )

# Load libraries
library(RWeka)
library(tm)

################################################################################
NGram.Tokenizer <- function(x) NGramTokenizer(x, Weka_control(min = 2, max = ))
NGram.tdm <- TermDocumentMatrix(FinalCorpus, control = list(tokenize = NGram.Tokenizer))
NGram.stdm <- removeSparseTerms(NGram.tdm, 0.7)
inspect(NGram.stdm[1:50, ])

# Save .RData file(s)
save(NGram.tdm, file="NGram.RData")
save(NGram.stdm, file="NGramRST.RData")
