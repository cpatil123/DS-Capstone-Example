# SDPredictionFunction
# NOTES
# SDPredictionFunction is a Search and Destroy function, it uses grep to match text from the raw data set first, and then works on cleaning, sorting and associating the correct probabilities, unlike PredictionFunction.R and ImprovedPredictionFunction.R, the idea is based on the fact that cleaning data and generating N-Gram models causes a less accurate algorithm. With accuracy being the target, as long as the operation takes less than 5 seconds, SDPredictionFunction may prove to be better.
################################################################################
setwd("C://Users//Yanal Kashou//Data Science//Projects//R//DataScienceCapstone//cache")

load("Final.RData")
library(plyr)
library(tm)
library(RWeka)
################################################################################
SDPredictionFunction <- function(InputText) {
        # Start Timer
        ptm <- proc.time()
        f.clean(InputText)
        f.grep(CleanText)
        f.grepDF(grepped)
        f.corpus(grepped)
        f.tmclean(dfCorpus)
        f.N(M)
        #f.tokenize(dfCorpus)
        f.convert(grep.tdm)
        f.select(N.df)
        f.if(SelectText)
        #f.predict(SelectText)
        # Stop Timer
        proc.time() - ptm
}
################################################################################
f.clean <- function(InputText) {
        CleanText <<- tolower(InputText)
        CleanText <<- gsub("[^[:alnum:][:space:]]", "", CleanText)
        # N is number of words in CleanText
        N <<- sapply(gregexpr("\\S+", CleanText), length)
}
################################################################################
f.grep <- function(CleanText) {
        grepped <<- grep(as.String(CleanText), c(FinalTwitterText, FinalBlogsText, FinalNewsText))
}
################################################################################
f.grepDF <- function(grepped) {
        grepped.df <<- data.frame()
        grepped.df <<- as.data.frame(grepped)
        grepped.df <<- rename(grepped.df, c("grepped"="grepID"))
}
################################################################################
f.corpus <- function(grepped) {
        grepped.text <<- FinalTwitterText[grepped]
        dfCorpus <<- Corpus(VectorSource(as.data.frame(grepped.text))) 
}
################################################################################
f.tmclean <- function(dfCorpus) {
        dfCorpus <<- tm_map(dfCorpus, removePunctuation)
        dfCorpus <<- tm_map(dfCorpus, stripWhitespace)
        dfCorpus <<- tm_map(dfCorpus, removeNumbers)
        dfCorpus <<- tm_map(dfCorpus, content_transformer(tolower))
        removeAlpha <<- content_transformer(function(dfCorpus, pattern) gsub(pattern, "", dfCorpus))
        dfCorpus <- tm_map(dfCorpus, removeAlpha, "[^a-zA-Z0-9[:space:]']")
       
}
################################################################################
f.N <- function(M) {
        M <<- N + 1
        if (M >= 6) {
                #NGram.df <<- SixGram.df
        }
        else if (M == 5) {
                #NGram.df <<- FiveGram.df
        }
        else if (M == 4) {
                #NGram.df <<- FourGram.df
                grepTokenizer <<- function(x) NGramTokenizer(x, Weka_control(min = 4, max = 4))
                grep.tdm <<- TermDocumentMatrix(dfCorpus, control = list(tokenize = grepTokenizer))
        }
        else if (M == 3) {
                #NGram.df <<- ThreeGram.df
        }
        else if (M == 2) {
                #NGram.df <<- TwoGram.df
        }
}
################################################################################
f.tokenize <- function(dfCorpus) {
        grepTokenizer <<- function(x) NGramTokenizer(x, Weka_control(min = 2, max = 6))
        grep.tdm <<- TermDocumentMatrix(dfCorpus, control = list(tokenize = grepTokenizer))
}
################################################################################
f.convert <- function(grep.tdm) {
        N.df <<- as.data.frame(as.matrix(grep.tdm))
        #N.df$Count <<- rowSums(N.df[1:3])
        N.df <<- setNames(cbind(rownames(N.df), N.df, row.names = NULL),
                c("Terms", "Count"))
        N.df$Probability <<- N.df$Count/sum(N.df$Count)
}
################################################################################
f.select <- function(N.df) {
        SelectText <<- N.df %>% 
                filter(str_detect(Terms, CleanText))
        SelectText$Split <<- strsplit(as.character(SelectText$Terms), " ")
        str1 <- SelectText$Split
        str2 <- CleanText
        setdiff(str1, str2) 
}
################################################################################
f.if <- function(SelectText) {
        # X is number of words in SelectText
        X <<- sapply(gregexpr("\\S+", SelectText$Terms), length)
        if (N == X) {
                -which(N == X)
        }
        
}
################################################################################
f.predict <- function(SelectText) {
        PredictText <<- select(SelectText, Terms, Probability)
        
        for (i in seq_len(nrow(PredictText))) {
                PredictText$Prediction <<- str_extract(PredictText$Terms, '\\w*$')
        }
        
}




