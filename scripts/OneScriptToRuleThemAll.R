### Load necessary libraries
#library(openNLP)
#library(NLP)
library(tm)
library(quanteda)
library(SnowballC)

### Set seed for reproducibility
set.seed(0)

### Set working directory (Raw Data - Windows OS)
setwd("C://Users//Yanal Kashou//Data Science//Projects//R//DataScienceCapstone//data//raw_data")

# Open file connections
con1 <- file("en_US.twitter.txt", "r") 
con2 <- file("en_US.blogs.txt", "r")
con3 <- file("en_US.news.txt", "r")

RawTwitterText <- readLines(con1)
RawBlogsText <- readLines(con2)
RawNewsText <- readLines(con3)

LengthOfTwitterText <- length(RawTwitterText)
LengthOfBlogsText <- length(RawBlogsText)
LengthOfNewsText <- length(RawNewsText)

# Close file connections
close(con1, con2, con3)

# Sample 15% of the data
SampledTwitterText <- RawTwitterText[rbinom(LengthOfTwitterText*.15, LengthOfTwitterText, .5)]
SampledBlogsText <- RawBlogsText[rbinom(LengthOfBlogsText*.15, LengthOfBlogsText, .5)]
SampledNewsText <- RawNewsText[rbinom(LengthOfNewsText*.15, LengthOfNewsText, .5)]

### Set working directory (processed_data)
setwd("C://Users//Yanal Kashou//Data Science//Projects//R//DataScienceCapstone//data//processed_data")

# Export sampled text to .txt files
con4 <- file("sampled.twitter.txt")
writeLines(SampledTwitterText, con4)
con5 <- file("sampled.blogs.txt")
writeLines(SampledBlogsText, con5)
con6 <- file("sampled.news.txt")
writeLines(SampledNewsText, con6)
close(con4, con5, con6)

### Create Corpus 
TextCorpus <- Corpus(DirSource(directory = getwd(), pattern="sampled.*.txt|sampled.*.txt"))
inspect(TextCorpus)
str(TextCorpus)

### Set working directory (Banned Words - Windows OS)
setwd("C://Users//Yanal Kashou//Data Science//Projects//R//DataScienceCapstone//data//banned_words")

# Open file connection
con7 <- file("banned-words.txt", "r")
BannedWords <- readLines(con7)
BannedWords

# Close file connection
close(con7)

# Trim whitespace at the end of the word
trim.ending <- function (x)
        sub("\\s+$", "", x)
trim.ending(BannedWords)

### Set working directory (processed_data)
setwd("C://Users//Yanal Kashou//Data Science//Projects//R//DataScienceCapstone//data//processed_data")

# Remove punctuation, whitespace, numbers, stopwords from text and convert to lower case 
inspect(TextCorpus)
CleanCorpus <- tm_map(TextCorpus, removePunctuation)
CleanCorpus <- tm_map(CleanCorpus, stripWhitespace)
CleanCorpus <- tm_map(CleanCorpus, removeNumbers)
CleanCorpus <- tm_map(CleanCorpus, removeWords, stopwords("english"))
CleanCorpus <- tm_map(CleanCorpus, content_transformer(tolower))
inspect(CleanCorpus)

writeLines(as.character(CleanCorpus[[1]]), con="cleaned.twitter.txt")
writeLines(as.character(CleanCorpus[[2]]), con="cleaned.blogs.txt")
writeLines(as.character(CleanCorpus[[3]]), con="cleaned.news.txt")

# Stem the documents
#StemmedCorpus <- tm_map(CleanCorpus, stemDocument)
#inspect(StemmedCorpus)
#writeLines(as.character(StemmedCorpus[[1]]), con="stemmed.twitter.txt")
#writeLines(as.character(StemmedCorpus[[2]]), con="stemmed.blogs.txt")
#writeLines(as.character(StemmedCorpus[[3]]), con="stemmed.news.txt")

# Remove Profanity
PoliteCorpus <- tm_map(StemmedCorpus, removeWords, BannedWords)
inspect(PoliteCorpus)

writeLines(as.character(PoliteCorpus[[1]]), con="polite.twitter.txt")
writeLines(as.character(PoliteCorpus[[2]]), con="polite.blogs.txt")
writeLines(as.character(PoliteCorpus[[3]]), con="polite.news.txt")

# Create char length dataframe
#"Post-Stemming" = c(21415989, 1564823, 17116878)

CharLengthDF <- data.frame("Original" = c(31521201, 2248401, 24324928), "Post-Cleaning" = c(23806006, 1750801, 18672851), "Post-Profanity-Removal" = c(21385469, 1563741, 17030475))

# Divide char length by 10^6 to appear in millions
CharLengthDF <- CharLengthDF[1:3, ]/10^6
View(CharLengthDF)

# Final Corpus and export to txt
FinalCorpus <- tm_map(PoliteCorpus, PlainTextDocument)

writeLines(as.character(FinalCorpus[[1]]), con="final.twitter.txt")
writeLines(as.character(FinalCorpus[[2]]), con="final.blogs.txt")
writeLines(as.character(FinalCorpus[[3]]), con="final.news.txt")

FinalTwitterText <- readLines(con = "final.twitter.txt")
FinalBlogsText <- readLines(con = "final.blogs.txt")
FinalNewsText <- readLines(con = "final.news.txt")

# [PENDING] Document Term Matrix
#dfm(con = "polite.twitter.txt", ignoredFeatures = stopwords("english"), stem = TRUE)
TwitterDFM <- dfm(FinalTwitterText, stem = TRUE)
BlogsDFM <- dfm(FinalBlogsText, stem = TRUE)
NewsDFM <- dfm(FinalTwitterText, stem = TRUE)
