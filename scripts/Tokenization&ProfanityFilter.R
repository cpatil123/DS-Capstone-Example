### Load necessary libraries
#library(openNLP)
#library(NLP)
library(tm)
library(quanteda)
library(SnowballC)

### Set working directory (Windows OS)
setwd("C://Users//Yanal Kashou//Data Science//Projects//R//DataScienceCapstone//data")

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
close(con)

### Create Corpus
TwitterCorpus <- Corpus(VectorSource(RawTwitterText))
BlogsCorpus <- Corpus(VectorSource(RawBlogsText))
NewsCorpus <- Corpus(VectorSource(RawNewsText))

### 
TwitterDocTermMatrix <- DocumentTermMatrix(TwitterCorpus) 
BlogsDocTermMatrix <- DocumentTermMatrix(BlogsCorpus)
NewsDocTermMatrix <- DocumentTermMatrix(NewsCorpus)

inspect(TwitterDocTermMatrix)



# Profanity Filtering 
##[Remove unwanted words]