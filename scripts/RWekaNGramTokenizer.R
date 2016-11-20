options(java.parameters = "-Xmx4g" )
library(RWeka)

# Unigram
UnigramTokenizer <- function(x) NGramTokenizer(x, Weka_control(min = 1, max = 1))
Unigram.tdm <- TermDocumentMatrix(FinalCorpus, control = list(tokenize = UnigramTokenizer))
inspect(Unigram.tdm[100:110, ])
Unigram.stdm <- removeSparseTerms(Unigram.tdm, 0.01)
inspect(Unigram.stdm)

# Top 5 Most Frequent Unigrams
Unigram.m <- as.matrix(Unigram.stdm)
Unigram.f <- sort(rowSums(Unigram.m), decreasing=TRUE)
head(Unigram.f, 5)

# Bigram
BigramTokenizer <- function(x) NGramTokenizer(x, Weka_control(min = 2, max = 2))
Bigram.tdm <- TermDocumentMatrix(FinalCorpus, control = list(tokenize = BigramTokenizer))
inspect(Bigram.tdm[100:110, ])
Bigram.stdm <- removeSparseTerms(Bigram.tdm, 0.01)
inspect(Bigram.stdm)

# Top 5 Most Frequent Bigrams
Bigram.m <- as.matrix(Bigram.stdm)
Bigram.f <- sort(rowSums(Bigram.m), decreasing=TRUE)
head(Bigram.f, 5)

# Trigram
TrigramTokenizer <- function(x) NGramTokenizer(x, Weka_control(min = 3, max = 3))
Trigram.tdm <- TermDocumentMatrix(FinalCorpus, control = list(tokenize = TrigramTokenizer))
inspect(Trigram.tdm[1:15,])
Trigram.stdm <- removeSparseTerms(Trigram.tdm, 0.01)
inspect(Trigram.stdm)

# Top 5 Most Frequent Trigrams
Trigram.m <- as.matrix(Trigram.stdm)
Trigram.f <- sort(rowSums(Trigram.m), decreasing=TRUE)
head(Trigram.f, 5)

# Fourgram +
FourgramTokenizer <- function(x) NGramTokenizer(x, Weka_control(min = 4, max = 4))
Fourgram.tdm <- TermDocumentMatrix(FinalCorpus, control = list(tokenize = FourgramTokenizer))
inspect(Fourgram.tdm[1:15,])

# Top 5 Most Frequent Fourgrams
Fourgram.m <- as.matrix(Fourgram.stdm)
Fourgram.f <- sort(rowSums(Fourgram.m), decreasing=TRUE)
head(Fourgram.f, 5)




topfeatures(NewsDFM)
topfeatures(TwitterDFM)