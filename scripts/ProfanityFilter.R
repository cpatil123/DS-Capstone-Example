# Profanity Filtering

# Source for profane dictionary / list of unwanted words:
# "http://www.freewebheaders.com/wordpress/wp-content/uploads/full-list-of-bad-words-banned-by-google-txt-file.zip"

### Set working directory (Banned Words - Windows OS)
BannedWordsDirectory <- setwd("C://Users//Yanal Kashou//Data Science//Projects//R//DataScienceCapstone//data//banned_words")

# Open file connection
con <- file("banned-words.txt", "r")
BannedWords <- readLines(con)
BannedWords

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

# Close file connection
close(con)