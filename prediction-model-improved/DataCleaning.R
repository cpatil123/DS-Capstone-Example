# Load libraries
library(RWeka)
library(tm)

# Set working directory (Banned Words - Windows OS)
setwd("C://Users//Yanal Kashou//Data Science//Projects//R//DataScienceCapstone//data//banned_words")

# Open file connection
con4 <- file("banned-words.txt", "r")
BannedWords <- readLines(con4)
BannedWords

# Close file connection
close(con4)

# Trim whitespace at the end of the word
trim.ending <- function (x)
        sub("\\s+$", "", x)
trim.ending(BannedWords)

# Set working directory (cache)
setwd("C://Users//Yanal Kashou//Data Science//Projects//R//DataScienceCapstone//cache")

# Load .RData file(s)
load("RawCorpus.RData")

# Remove punctuation, whitespace, numbers, stopwords from text and convert to lower case 
inspect(RawCorpus)
CleanCorpus <- tm_map(RawCorpus, removePunctuation)
CleanCorpus <- tm_map(CleanCorpus, stripWhitespace)
CleanCorpus <- tm_map(CleanCorpus, removeNumbers)
CleanCorpus <- tm_map(CleanCorpus, content_transformer(tolower))
inspect(CleanCorpus)

# Remove Profanity
PoliteCorpus <- tm_map(CleanCorpus, removeWords, BannedWords)
inspect(PoliteCorpus)

# Remove non alphabet characters
removeAlpha <- content_transformer(function(PoliteCorpus, pattern) gsub(pattern, "", PoliteCorpus))
ABCorpus <- tm_map(PoliteCorpus, removeAlpha, "[^a-zA-Z0-9[:space:]']")

# Remove non alphabet characters
removeAlpha <- content_transformer(function(PoliteCorpus, pattern) gsub(pattern, " ", PoliteCorpus))
ABCorpus <- tm_map(PoliteCorpus, removeAlpha, "[^a-zA-Z']")


# Convert Corpus Class to PlainTextDocument
FinalCorpus <- tm_map(ABCorpus, PlainTextDocument)

writeLines(as.character(FinalCorpus[[1]]))

writeLines(as.character(FinalCorpus[[1]]), con="final.blogs.txt")
writeLines(as.character(FinalCorpus[[2]]), con="final.news.txt")
writeLines(as.character(FinalCorpus[[3]]), con="final.twitter.txt")

# Open individual file connections
con1 <- file("final.blogs.txt", "r") 
con2 <- file("final.news.txt", "r")
con3 <- file("final.twitter.txt", "r")

# Read text files
FinalBlogsText <- readLines(con1)
FinalNewsText <- readLines(con2)
FinalTwitterText <- readLines(con3)
Final = c(FinalBlogsText, FinalNewsText, FinalTwitterText)

# Save .RData file(s)
save(PoliteCorpus, file="PoliteCorpus.RData")
save(FinalCorpus, file="FinalCorpus.RData")
save(Final, file = "Final.RData")
