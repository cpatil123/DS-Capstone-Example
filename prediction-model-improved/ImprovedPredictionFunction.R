### ImprovedPredictionFunction.R
# ################################################################################
# # Set working directory
# setwd("C://Users//Yanal Kashou//Data Science//Projects//R//DataScienceCapstone//cache")
# 
# # Load .RData file(s)
# # N-Grams from 2 to Infinity
# load("NGram.df.RData")
# 
# # libraries
# library(dplyr)
# library(stringr)
# library(stringi)
################################################################################
f.clean <- function(InputText1) {
        CleanText <<- tolower(InputText1)
        CleanText <<- gsub("[^[:alnum:][:space:]]", "", CleanText)
        N <<- sapply(gregexpr("\\S+", CleanText), length)
        
        while (N > 5) {
                CleanText <<- gsub("^\\s*\\w*", "", CleanText)
                N <<- sapply(gregexpr("\\S+", CleanText), length)
                CleanText <<- gsub("^\\s", "",CleanText)
        }
}
################################################################################
f.search <- function(NGram.df) {
        SearchText <<- NGram.df %>%
                filter(str_detect(Terms, CleanText))
        # if (nrow(SearchText) == 0) {
        #         M <<- M + 1
        # }
}
################################################################################
f.N <- function(M) {
        M <<- N + 1
        if (M >= 6) {
                f.search(NGram.df)
                if (nrow(SearchText) == 0) {
                        CleanText <<- gsub("^\\s*\\w*", "", CleanText)
                        CleanText <<- gsub("^\\s", "",CleanText)
                        f.search(NGram.df)
                        if (nrow(SearchText) == 0) {
                                CleanText <<- gsub("^\\s*\\w*", "", CleanText)
                                CleanText <<- gsub("^\\s", "",CleanText)
                                f.search(NGram.df)
                                if (nrow(SearchText) == 0) {
                                        CleanText <<- gsub("^\\s*\\w*", "", CleanText)
                                        CleanText <<- gsub("^\\s", "",CleanText)
                                        f.search(NGram.df)
                                        if (nrow(SearchText) == 0) {
                                                CleanText <<- gsub("^\\s*\\w*", "", CleanText)
                                                CleanText <<- gsub("^\\s", "",CleanText)
                                                f.search(NGram.df)
                                        }
                                        else {
                                                
                                        }
                                }
                                else {
                                        
                                }
                        }
                        else {
                                
                        }
                }
                else {
                        
                }
        }
        else if (M == 5) {
                f.search(NGram.df)
                if (nrow(SearchText) == 0) {
                        CleanText <<- gsub("^\\s*\\w*", "", CleanText)
                        CleanText <<- gsub("^\\s", "",CleanText)
                        f.search(NGram.df)
                        if (nrow(SearchText) == 0) {
                                CleanText <<- gsub("^\\s*\\w*", "", CleanText)
                                CleanText <<- gsub("^\\s", "",CleanText)
                                f.search(NGram.df)
                                if (nrow(SearchText) == 0) {
                                        CleanText <<- gsub("^\\s*\\w*", "", CleanText)
                                        CleanText <<- gsub("^\\s", "",CleanText)
                                        f.search(NGram.df)
                                }
                                else {
                                        
                                }
                        }
                        else {
                                
                        }
                }
                else {
                        
                }
        }
        else if (M == 4) {
                f.search(NGram.df)
                if (nrow(SearchText) == 0) {
                        CleanText <<- gsub("^\\s*\\w*", "", CleanText)
                        CleanText <<- gsub("^\\s", "",CleanText)
                        f.search(NGram.df)
                        if (nrow(SearchText) == 0) {
                                CleanText <<- gsub("^\\s*\\w*", "", CleanText)
                                CleanText <<- gsub("^\\s", "",CleanText)
                                f.search(NGram.df)      
                        }
                        else {
                                
                        }
                }
                else {
                        
                }
        }
        else if (M == 3) {
                f.search(NGram.df)
                if (nrow(SearchText) == 0) {
                        CleanText <<- gsub("^\\s*\\w*", "", CleanText)
                        CleanText <<- gsub("^\\s", "",CleanText)
                        f.search(NGram.df)        
                }
                else {
                        
                }
        }
        else if (M == 2) {
                f.search(NGram.df)
        }
}
################################################################################
f.sort <- function(SearchText) {
        SortText <<- SearchText[order(-SearchText$Probability),]
        SortText$Extract <<- gsub("\\s*\\w*$", "", SortText$Terms)
        SelectText <<- SortText %>%
                filter(str_detect(Extract, CleanText))
}
################################################################################
f.predict <- function(SelectText) {
        Prediction.1 <<- select(SelectText, Terms, Probability)
        
        for (i in seq_len(nrow(Prediction.1))) {
                Prediction.1$Prediction <<- str_extract(Prediction.1$Terms, '\\w*$')
        }
        
}
################################################################################
# Function of Functions, the Prediction Meta-Function
ImprovedPredictionFunction <- function(InputText1) {
        tic()
        # Start Timer
        ptm <- proc.time()
        
        # Run Functions
        f.clean(InputText1)
        f.N(M)
        f.sort(SearchText)
        f.predict(SelectText)
        
        #Print Results
        print(paste("Your top predictions are:"))
        print(unique(head(Prediction.1$Prediction, 10)))
        
        # Stop Timer
        t1 <<- proc.time() - ptm
        ttoc <<- toc()
        time1 <<- ttoc$toc - ttoc$tic
}