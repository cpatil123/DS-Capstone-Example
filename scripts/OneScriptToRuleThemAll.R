### Load necessary libraries
#library(openNLP)
#library(NLP)
library(tm)
library(quanteda)
library(SnowballC)

### Set working directory (Raw Data - Windows OS)
setwd("C://Users//Yanal Kashou//Data Science//Projects//R//DataScienceCapstone//data//raw_data")

### Create Corpus 
TextCorpus <- Corpus(DirSource(getwd()))

### Set working directory (Banned Words - Windows OS)
setwd("C://Users//Yanal Kashou//Data Science//Projects//R//DataScienceCapstone//data//banned_words")

# Open file connection
con <- file("banned-words.txt", "r")
BannedWords <- readLines(con)
BannedWords

# Close file connection
close(con)

# Trim whitespace at the end of the word
trim.ending <- function (x)
        sub("\\s+$", "", x)
trim.ending(BannedWords)

# [PENDING ]Remove words from tokenized text 
inspect(TextCorpus)
CleanCorpus <- tm_map(TextCorpus, removePunctuation)
CleanCorpus <- tm_map(CleanCorpus, stripWhitespace)
CleanCorpus <- tm_map(CleanCorpus, removeNumbers)
CleanCorpus <- tm_map(CleanCorpus, removeWords, stopwords("english"))
inspect(CleanCorpus)

# Convert to lower case
CleanCorpus <- tm_map(CleanCorpus, content_transformer(tolower))

# Stem the documents
StemmedCorpus <- tm_map(CleanCorpus, stemDocument)
inspect(StemmedCorpus)

# Remove Profanity
PoliteCorpus <- tm_map(StemmedCorpus, removeWords, BannedWords)
inspect(PoliteCorpus)

# Term Document Matrix
PoliteCorpusTDM <- TermDocumentMatrix(PoliteCorpus)

