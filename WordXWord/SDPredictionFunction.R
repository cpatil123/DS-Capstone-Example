# SDPredictionFunction
# NOTES
# SDPredictionFunction is a Search and Destroy function, it uses grep to match text from the raw data set first, and then works on cleaning, sorting and associating the correct probabilities, unlike PredictionFunction.R and ImprovedPredictionFunction.R, the idea is based on the fact that cleaning data and generating N-Gram models causes a less accurate algorithm. With accuracy being the target, as long as the operation takes less than 5 seconds, SDPredictionFunction may prove to be better.
################################################################################
#setwd("C://Users//Yanal Kashou//Data Science//Projects//R//DataScienceCapstone//cache")

#load("Raw.RData")
#library(dplyr)
#library(plyr)
#library(tm)
#library(RWeka)
#library(stringr)

################################################################################
# Clean the text from non-alphanumeric characters, keep last 5 words, if sentence is longer.

f.clean <- function(InputText2) {
        CleanText <<- tolower(InputText2)
        CleanText <<- gsub("[^[:alnum:][:space:]]", "", CleanText)
        N <<- sapply(gregexpr("\\S+", CleanText), length)
        
        while (N > 5) {
                CleanText <<- gsub("^\\s*\\w*", "", CleanText)
                N <<- sapply(gregexpr("\\S+", CleanText), length)
                CleanText <<- gsub("^\\s", "",CleanText)
        }
}
################################################################################
f.Xstrip <- function(CleanText) {
        N <<- sapply(gregexpr("\\S+", CleanText), length)
        
        ########################################################################
        if (N == 5) {
                Xe <<- CleanText
                Xd <<- gsub("^\\s*\\w*", "", Xe)
                Xd <<- gsub("^\\s", "", Xd)
                Xc <<- gsub("^\\s*\\w*", "", Xd)
                Xc <<- gsub("^\\s", "", Xc)
                Xb <<- gsub("^\\s*\\w*", "", Xc)
                Xb <<- gsub("^\\s", "", Xb)
                Xa <<- gsub("^\\s*\\w*", "", Xb)
                Xa <<- gsub("^\\s", "", Xa)
                
                N_e <<- sapply(gregexpr("\\S+", Xe), length)
                N_d <<- sapply(gregexpr("\\S+", Xd), length)
                N_c <<- sapply(gregexpr("\\S+", Xc), length)
                N_b <<- sapply(gregexpr("\\S+", Xb), length)
                N_a <<- sapply(gregexpr("\\S+", Xa), length)
                
                Grep_e <<- grep(as.String(Xe), Raw)
                Grep_d <<- grep(as.String(Xd), Raw)
                Grep_c <<- grep(as.String(Xc), Raw)
                Grep_b <<- grep(as.String(Xb), Raw)
                Grep_a <<- grep(as.String(Xa), Raw)
        }
        ########################################################################
        else if (N == 4) {
                Xe <<- CleanText
                Xd <<- gsub("^\\s*\\w*", "", Xe)
                Xd <<- gsub("^\\s", "", Xd)
                Xc <<- gsub("^\\s*\\w*", "", Xd)
                Xc <<- gsub("^\\s", "", Xc)
                Xb <<- gsub("^\\s*\\w*", "", Xc)
                Xb <<- gsub("^\\s", "", Xb)
                
                N_e <<- sapply(gregexpr("\\S+", Xe), length)
                N_d <<- sapply(gregexpr("\\S+", Xd), length)
                N_c <<- sapply(gregexpr("\\S+", Xc), length)
                N_b <<- sapply(gregexpr("\\S+", Xb), length)

                Grep_e <<- grep(as.String(Xe), Raw)
                Grep_d <<- grep(as.String(Xd), Raw)
                Grep_c <<- grep(as.String(Xc), Raw)
                Grep_b <<- grep(as.String(Xb), Raw)
        }
        ########################################################################
        else if (N == 3) {
                Xe <<- CleanText
                Xd <<- gsub("^\\s*\\w*", "", Xe)
                Xd <<- gsub("^\\s", "", Xd)
                Xc <<- gsub("^\\s*\\w*", "", Xd)
                Xc <<- gsub("^\\s", "", Xc)
                
                N_e <<- sapply(gregexpr("\\S+", Xe), length)
                N_d <<- sapply(gregexpr("\\S+", Xd), length)
                N_c <<- sapply(gregexpr("\\S+", Xc), length)
                
                Grep_e <<- grep(as.String(Xe), Raw)
                Grep_d <<- grep(as.String(Xd), Raw)
                Grep_c <<- grep(as.String(Xc), Raw)
        }
        ########################################################################
        else if (N == 2) {
                Xe <<- CleanText
                Xd <<- gsub("^\\s*\\w*", "", Xe)
                Xd <<- gsub("^\\s", "", Xd)
                
                N_e <<- sapply(gregexpr("\\S+", Xe), length)
                N_d <<- sapply(gregexpr("\\S+", Xd), length)
                
                Grep_e <<- grep(as.String(Xe), Raw)
                Grep_d <<- grep(as.String(Xd), Raw)
                
        }
        ########################################################################
        else {
                Xe <<- CleanText
                
                N_e <<- sapply(gregexpr("\\S+", Xe), length)
                
                Grep_e <<- grep(as.String(Xe), Raw)
        }
        ########################################################################
        if (length(Grep_e) == 0) {
                if (length(Grep_d) == 0) {
                        if (length(Grep_c) == 0) {
                                if (length(Grep_b) == 0) {
                                        if (length(Grep_a) == 0) {
                                        }
                                        else {
                                                Grep <<- Grep_a
                                                CleanText <<- Xa
                                        }
                                }
                                else {
                                        Grep <<- Grep_b
                                        CleanText <<- Xb
                                }
                        }
                        else {
                                Grep <<- Grep_c
                                CleanText <<- Xc
                        }
                }
                else {
                        Grep <<- Grep_d
                        CleanText <<- Xd
                }
        }
        else {
                Grep <<- Grep_e
                CleanText <<- Xe
        }
}
################################################################################
f.grep <- function(CleanText) {
        
        ReCleanText <<- CleanText
        "%b/w%" <- function(x, ends) x >= ends[1] & x <= ends[2]
}        
        
################################################################################
f.corpus <- function(Grep) {
        GrepText <<- Raw[Grep]
        CorpusText <<- Corpus(VectorSource(as.data.frame(GrepText))) 
}
################################################################################
f.N <- function(M) {
        # N is number of words in CleanText
        N <<- sapply(gregexpr("\\S+", ReCleanText), length)
        M <<- N + 1
        CorpusTokenizer <<- function(x) NGramTokenizer(x, Weka_control(min = M, max =  M))
        CorpusTDM <<- TermDocumentMatrix(CorpusText, control = list(tokenize = CorpusTokenizer))
}
################################################################################
f.convert <- function(CorpusTDM) {
        N.df <<- as.data.frame(as.matrix(CorpusTDM))
        N.df <<- setNames(cbind(rownames(N.df), N.df, row.names = NULL),
                c("Terms", "Count"))
        N.df$Probability <<- N.df$Count/sum(N.df$Count)
}
################################################################################
f.select <- function(N.df) {
        SelectText <<- N.df %>% 
                filter(str_detect(Terms, ReCleanText))
        
        # Remove terms ending with the input
        a <- word(ReCleanText, -1)
        b <- word(SelectText$Terms,-1)
        SelectText <<- SelectText[-c(which(a == b)),]
        SelectText <<- SelectText[order(-SelectText$Probability),]
        
}#
################################################################################
f.predict <- function(SelectText) {
        PredictText <<- select(SelectText, Terms, Probability)
        
        for (i in seq_len(nrow(PredictText))) {
                PredictText$Prediction <<- str_extract(PredictText$Terms, '\\w*$')
        }
        Prediction.2 <<- head(select(PredictText, Prediction, Probability), 10)
        Prediction.2$Probability <<- sprintf("%.7f", Prediction.2$Probability)
}

################################################################################
SDPredictionFunction <- function(InputText2) {
        # Start Timer
        ptm <- proc.time()
        
        f.clean(InputText2)
        f.Xstrip(CleanText)
        f.grep(CleanText)
        f.corpus(Grep)
        f.N(M)
        f.convert(CorpusTDM)
        f.select(N.df)
        f.predict(SelectText)
        # Stop Timer
        t2 <<- proc.time() - ptm
}