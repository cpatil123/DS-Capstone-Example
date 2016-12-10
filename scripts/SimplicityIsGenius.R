# SimplicityIsGenius.R
###############################################################################

# Set working directory
setwd("C://Users//Yanal Kashou//Data Science//Projects//R//DataScienceCapstone//cache")

# Variables
load("FinalCorpus.RData")

load("NGram.2.RData")
load("NGram.3.RData")
load("NGram.4.RData")
load("NGram.5.RData")
load("NGram.6.RData")

# Increase Java Memory Heap Size
options(java.parameters = "-Xmx6144m" )

# Load libraries
library(RWeka)
library(dplyr)
library(grid)
library(gridExtra)
library(ggplot2)
library(tm)

#NGram Model
###############################################################################
# from N=2 to N=6

N_GramTokenizer <- function(x) NGramTokenizer(x, Weka_control(min = 2, max = 6))
N_Gram.tdm <- TermDocumentMatrix(FinalCorpus, control = list(tokenize = N_GramTokenizer))
inspect(N_Gram.tdm[1:50, ])
N_Gram.stdm <- removeSparseTerms(N_Gram.tdm, 0.1)
inspect(N_Gram.stdm[100:200, ])

N_Gram.m <- as.matrix(N_Gram.stdm)
N_Gram.f <- sort(rowSums(N_Gram.m), decreasing=TRUE)
head(N_Gram.f, 50)

N_Gram.wf <- data.frame(word = names(N_Gram.f), freq = N_Gram.f)

plot.N_Gram <- subset(N_Gram.wf, freq>= (N_Gram.wf$freq[5])) %>% 
        ggplot(aes(word, freq)) +
        geom_bar(stat="identity", fill="darkgreen") +
        ggtitle("N_Gram (From N = 2 to N = 6)") +
        ylab("Frequency") + 
        theme(axis.text.x=element_text(angle=45, hjust=1),
              axis.title.x=element_blank(),
              panel.background = element_blank())

N_Gram.df <- as.data.frame(N_Gram.m)
N_Gram.df$Count <- rowSums(N_Gram.df[1:3])
N_Gram.df <- setNames(cbind(rownames(N_Gram.df), N_Gram.df, row.names = NULL),
         c("Terms", "x", "x1", "x2", "Count"))
NGram <- N_Gram.df[, !(colnames(N_Gram.df) %in% c("x","x1","x2"))]
head(NGram)

save(NGram, file="NGram.RData")

# Probabilities
###############################################################################
# from N=2 to N=6
x <- sapply(gregexpr("\\S+", NGram), length)


# Interactive function
###############################################################################
f1 <- function(y) {
        x <- sapply(gregexpr("\\S+", y), length)
                if (x >= 6 ) {
                        print("Choosing N-Gram model for N >= 6, please wait while I find the most probable 6-Gram matches...")
                }
                else if (x == 5) {
                        print("Choosing N-Gram model for N = 5, please wait while I find the most probable 5-Gram matches...")
                }
                else if (x == 4) {
                        print("Choosing N-Gram model for N = 4, please wait while I find the most probable 3-Gram matches...")
                }
                else if (x == 3) {
                        print("Choosing N-Gram model for N = 3, please wait while I find the most probable 3-Gram matches...")
                }
                else if (x <= 2) {
                        print("Choosing N-Gram model for N = 2, please wait while I find the most probable 2-Gram matches from the following list")
                        head(NGram.2, 10)
                        print(pmatch(y, NGram.2$Terms, nomatch = NA_integer_, duplicates.ok = FALSE))
                        
                }
}

# N-Gram extraction function
###############################################################################
