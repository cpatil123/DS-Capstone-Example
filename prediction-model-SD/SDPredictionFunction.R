# SDPredictionFunction
# NOTES
# SDPredictionFunction is a Search and Destroy function, it uses grep to match text from the raw data set first, and then works on cleaning, sorting and associating the correct probabilities, unlike PredictionFunction.R and ImprovedPredictionFunction.R, the idea is based on the fact that cleaning data and generating N-Gram models causes a less accurate algorithm. With accuracy being the target, as long as the operation takes less than 5 seconds, SDPredictionFunction may prove to be better.
################################################################################
setwd("C://Users//Yanal Kashou//Data Science//Projects//R//DataScienceCapstone//cache")

load("Raw.RData")
library(plyr)
library(tm)
library(RWeka)
library(stringr)
################################################################################
SDPredictionFunction <- function(InputText) {
        # Start Timer
        ptm <- proc.time()
        
        f.clean(InputText)
        f.grep(CleanText)
        f.corpus(GrepText)
        
        f.N(M)
        
        f.convert(CorpusTDM)
        f.select(N.df)
        f.predict(SelectText)
        
        print(Prediction)
        # Stop Timer
        proc.time() - ptm
}
################################################################################
f.clean <- function(InputText) {
        CleanText <<- tolower(InputText)
        CleanText <<- gsub("[^[:alnum:][:space:]]", "", CleanText)
        N <<- sapply(gregexpr("\\S+", CleanText), length)
}
################################################################################
f.grep <- function(CleanText) {
        Grep <<- grep(as.String(CleanText), Raw)
        grepped.df <<- data.frame()
        grepped.df <<- as.data.frame(Grep)
        grepped.df <<- rename(grepped.df, grepID = Grep)
}
################################################################################
f.corpus <- function(GrepText) {
        GrepText <<- Raw[Grep]
        CorpusText <<- Corpus(VectorSource(as.data.frame(GrepText))) 
}
################################################################################
f.N <- function(M) {
        # N is number of words in CleanText
        N <<- sapply(gregexpr("\\S+", CleanText), length)
        M <<- N + 1
        CorpusTokenizer <<- function(x) NGramTokenizer(x, Weka_control(min = M, max =  M))
        CorpusTDM <<- TermDocumentMatrix(CorpusText, control = list(tokenize = CorpusTokenizer))
}
################################################################################
f.convert <- function(CorpusTDM) {
        N.df <<- as.data.frame(as.matrix(CorpusTDM))
        #N.df$Count <<- rowSums(N.df[1:3])
        N.df <<- setNames(cbind(rownames(N.df), N.df, row.names = NULL),
                c("Terms", "Count"))
        N.df$Probability <<- N.df$Count/sum(N.df$Count)
}
################################################################################
f.select <- function(N.df) {
        SelectText <<- N.df %>% 
                filter(str_detect(Terms, CleanText))
        if (is.null(SelectText)) {
                # Delete first word from string
                CleanText <<- gsub("^\\s*\\w*", "", CleanText)
                SelectText <<- N.df %>% 
                        filter(str_detect(Terms, CleanText))
        }
        if(is.null(SelectText)) {
                # Delete first word from string again
                CleanText <<- gsub("^\\s*\\w*", "", CleanText)
                SelectText <<- N.df %>% 
                        filter(str_detect(Terms, CleanText))
        }
        # Remove terms ending with the input
        a <- word(CleanText, -1)
        b <- word(SelectText$Terms,-1)
        SelectText <<- SelectText[-c(which(a == b)),]
        SelectText <<- SelectText[order(-SelectText$Probability),]
        
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
        Prediction <<- head(select(PredictText, Prediction, Probability), 3)
}
