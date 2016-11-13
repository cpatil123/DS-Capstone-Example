### Load necessary libraries
#library(openNLP)
#library(NLP)
library(tm)
library(quanteda)
library(SnowballC)

### Set working directory (Raw Data - Windows OS)
RawDataDirectory <- setwd("C://Users//Yanal Kashou//Data Science//Projects//R//DataScienceCapstone//data//raw_data")

# Tokenization
## From file to tokenized file [Identify words, punctuation and numbers]

### Reading in the raw data
con1 <- file("en_US.twitter.txt", "r") 
con2 <- file("en_US.blogs.txt", "r")
con3 <- file("en_US.news.txt", "r")

RawTwitterText <- readLines(con1)
RawBlogsText <- readLines(con2)
RawNewsText <- readLines(con3)

LengthOfTwitterText <- length(RawTwitterText)
LengthOfBlogsText <- length(RawBlogsText)
LengthOfNewsText <- length(RawNewsText)

### Tokenize the text
TokenizedTwitterText <- tokenize(RawTwitterText)
TokenizedBlogsText <- tokenize(RawBlogsText)
TokenizedNewsText <- tokenize(RawNewsText)

### Create Corpus 
TextCorpus <- Corpus(DirSource(RawDataDirectory))

### 
TwitterDocTermMatrix <- DocumentTermMatrix(TwitterCorpus) 
BlogsDocTermMatrix <- DocumentTermMatrix(BlogsCorpus)
NewsDocTermMatrix <- DocumentTermMatrix(NewsCorpus)

inspect(TwitterDocTermMatrix)


close(con1, con2, con3)

