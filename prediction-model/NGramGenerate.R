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
# Generate N-Grams
# N = 2
TwoGramTokenizer <- function(x) NGramTokenizer(x, Weka_control(min = 2, max = 2))
TwoGram.tdm <- TermDocumentMatrix(FinalCorpus, control = list(tokenize = TwoGramTokenizer))
TwoGram.stdm <- removeSparseTerms(TwoGram.tdm, 0.5)
inspect(TwoGram.stdm[10:25, ])

# Save .RData file(s)
save(TwoGram.stdm, file="TwoGram.RData")

# N = 3
ThreeGramTokenizer <- function(x) NGramTokenizer(x, Weka_control(min = 3, max = 3))
ThreeGram.tdm <- TermDocumentMatrix(FinalCorpus, control = list(tokenize = ThreeGramTokenizer))
ThreeGram.stdm <- removeSparseTerms(ThreeGram.tdm, 0.6)
inspect(ThreeGram.stdm[1:25, ])

# Save .RData file(s)
save(ThreeGram.stdm, file="ThreeGram.RData")

# N = 4, Sparsity chosen at 67% due to limited number of possibilities with lower sparsity level. 
FourGramTokenizer <- function(x) NGramTokenizer(x, Weka_control(min = 4, max = 4))
FourGram.tdm <- TermDocumentMatrix(FinalCorpus, control = list(tokenize = FourGramTokenizer))
FourGram.stdm <- removeSparseTerms(FourGram.tdm, 0.67)
inspect(FourGram.stdm[1:25, ])

# Save .RData file(s)
save(FourGram.stdm, file="FourGram.RData")

# N = 5 
FiveGramTokenizer <- function(x) NGramTokenizer(x, Weka_control(min = 5, max = 5))
FiveGram.tdm <- TermDocumentMatrix(FinalCorpus, control = list(tokenize = FiveGramTokenizer))
FiveGram.stdm <- removeSparseTerms(FiveGram.tdm, 0.7)
inspect(FiveGram.stdm[1:25, ])

# Save .RData file(s)
save(FiveGram.stdm, file="FiveGram.RData")

# N = 6 
SixGramTokenizer <- function(x) NGramTokenizer(x, Weka_control(min = 6, max = 6))
SixGram.tdm <- TermDocumentMatrix(FinalCorpus, control = list(tokenize = SixGramTokenizer))
SixGram.stdm <- removeSparseTerms(SixGram.tdm, 0.7)
inspect(SixGram.stdm[1:50, ])

# Save .RData file(s)
save(SixGram.stdm, file="SixGram.RData")
################################################################################
NGram.Tokenizer <- function(x) NGramTokenizer(x, Weka_control(min = 2, max = ))
NGram.tdm <- TermDocumentMatrix(FinalCorpus, control = list(tokenize = NGram.Tokenizer))
NGram.stdm <- removeSparseTerms(NGram.tdm, 0.7)
inspect(NGram.stdm[1:50, ])

# Save .RData file(s)
save(NGram.tdm, file="NGram.RData")
save(NGram.stdm, file="NGramRST.RData")
