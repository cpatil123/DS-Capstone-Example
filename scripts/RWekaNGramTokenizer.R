# Increase Java Memory Heap Size
options(java.parameters = "-Xmx6144m" )
library(RWeka)
library(dplyr)
library(grid)
library(gridExtra)
library(ggplot2)

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

Unigram.wf <- data.frame(word = names(Unigram.f), freq = Unigram.f)

plot.unigram <- subset(Unigram.wf, freq>= (Unigram.wf$freq[5])) %>% 
        ggplot(aes(word, freq)) +
        geom_bar(stat="identity", fill="darkgreen") +
        ggtitle("Unigrams (N=1)") +
        ylab("Frequency") + 
        theme(axis.text.x=element_text(angle=45, hjust=1),
              axis.title.x=element_blank(),
              panel.background = element_blank())
Unigram.df <- as.data.frame(Unigram.m)
###########################################################################################

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

Bigram.wf <- data.frame(word = names(Bigram.f), freq = Bigram.f)

plot.bigram <- subset(Bigram.wf, freq>= (Bigram.wf$freq[5])) %>% 
        ggplot(aes(word, freq)) +
        geom_bar(stat="identity", fill="black") +
        ggtitle("Bigrams (N=2)") +
        ylab("Frequency") + 
        theme(axis.text.x=element_text(angle=45, hjust=1),
              axis.title.x=element_blank(),
              panel.background = element_blank())
Bigram.df <- as.data.frame(Bigram.m)
###########################################################################################

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

Trigram.wf <- data.frame(word = names(Trigram.f), freq = Trigram.f)

plot.trigram <- subset(Trigram.wf, freq>= (Trigram.wf$freq[5])) %>% 
        ggplot(aes(word, freq)) +
        geom_bar(stat="identity", fill="darkred") +
        ggtitle("Trigrams (N=3)") +
        ylab("Frequency") + 
        theme(axis.text.x=element_text(angle=45, hjust=1),
              axis.title.x=element_blank(),
              panel.background = element_blank())
Trigram.df <- as.data.frame(Trigram.m)
###########################################################################################

# Fourgram +
FourgramTokenizer <- function(x) NGramTokenizer(x, Weka_control(min = 4, max = 4))
Fourgram.tdm <- TermDocumentMatrix(FinalCorpus, control = list(tokenize = FourgramTokenizer))
inspect(Fourgram.tdm[1:15,])
Fourgram.stdm <- removeSparseTerms(Fourgram.tdm, 0.90)

# Top 5 Most Frequent Fourgrams
Fourgram.m <- as.matrix(Fourgram.stdm)
Fourgram.f <- sort(rowSums(Fourgram.m), decreasing=TRUE)
head(Fourgram.f, 5)

Fourgram.wf <- data.frame(word = names(Fourgram.f), freq = Fourgram.f)
Fourgram.sorted <- sort(Fourgram.wf$freq, decreasing = TRUE)
Fourgram.sorted.subset <- Fourgram.sorted[1:5]

plot.fourgram <- subset(Fourgram.wf, freq>=(Fourgram.wf$freq[5])) %>% 
        ggplot(aes(word, freq)) +
        geom_bar(stat="identity", fill="navy") +
        ggtitle("Fourgrams (N=4)") +
        ylab("Frequency") + 
        theme(axis.text.x=element_text(angle=45, hjust=1),
              axis.title.x=element_blank(),
              panel.background = element_blank())
Fourgram.df <- as.data.frame(Fourgram.m)
###########################################################################################
plot.title = textGrob("Most Frequent N-Grams", gp=gpar(fontface="bold"))
grid.arrange(plot.unigram, plot.bigram, plot.trigram, plot.fourgram, nrow = 2, top = plot.title)
grid.arrange(plot.unigram, plot.bigram, nrow = 1, top = plot.title)
grid.arrange(plot.trigram, plot.fourgram, nrow= 1) 

g <- arrangeGrob(plot.unigram, plot.bigram, plot.trigram, plot.fourgram, nrow=2, top = plot.title) #generates g
ggsave(file="n-grams.png", g)

setwd("C://Users//Yanal Kashou//Data Science//Projects//R//DataScienceCapstone//cache")
save.image(file="RWekaNGramTokenizer.RData")
