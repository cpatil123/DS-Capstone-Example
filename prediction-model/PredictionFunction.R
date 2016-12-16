### PredictionFunction.R
# This is the main prediction function. Testing results showed high accuracy for casual terms, like "I love" will predict the next word "you".
# Considerations: There are a few improvements that can happen. One is to access a singular NGram dataframe, this can remove the need for an If N == ? loop. This has been implemented in ImprovedPredictionFunction.R
################################################################################
# Set working directory
setwd("C://Users//Yanal Kashou//Data Science//Projects//R//DataScienceCapstone//cache")

# Load .RData file(s)
load("TwoGram.df.RData")
load("ThreeGram.df.RData")
load("FourGram.df.RData")
load("FiveGram.df.RData")
load("SixGram.df.RData")

# libraries
library(dplyr)
library(stringr)
library(stringi)
################################################################################
# Function of Functions, the Prediction Meta-Function
PredictionFunction <- function(InputText) {
        
        # Start Timer
        ptm <- proc.time()
        
        # Run Functions
        f.clean(InputText)
        f.count(CleanText)
        f.N(M)
        f.search(NGram.df)
        f.handler_1(NGram.df)
        f.handler_2(NGram.df)
        f.sort(SearchText)
        f.join(SortText)
        f.select(JoinText)
        f.predict(SelectText)
        
        #Print Results
        print(paste("Your top predictions are:"))
        print(unique(head(PredictText, 3)))
        
        # Stop Timer
        proc.time() - ptm
}
################################################################################
f.clean <- function(InputText) {
        CleanText <<- tolower(InputText)
        CleanText <<- gsub("[^[:alnum:][:space:]]", "", CleanText)
}
################################################################################
f.count <- function(CleanText) {
        N <<- sapply(gregexpr("\\S+", CleanText), length)
        M <<- N + 1
        L <<- N + 2
        K <<- N + 3
}
################################################################################
f.N <- function(M) {
        if (M >= 6) {
                NGram.df <<- SixGram.df
        }
        else if (M == 5) {
                NGram.df <<- FiveGram.df
        }
        else if (M == 4) {
                NGram.df <<- FourGram.df
        }
        else if (M == 3) {
                NGram.df <<- ThreeGram.df
        }
        else if (M == 2) {
                NGram.df <<- TwoGram.df
        }
}
################################################################################
f.search <- function(NGram.df) {
        SearchText <<- NGram.df %>%
                filter(str_detect(Terms, CleanText))
        if (nrow(SearchText) == 0) {
                M <<- M + 1
        }
}
################################################################################

f.handler <- function(NGram.df) {
        f.handler_1(NGram.df)
        
}

f.handler_1 <- function(NGram.df) {
        f.N(M)
        SearchText <<- NGram.df %>% 
                filter(str_detect(Terms, CleanText))
        if (nrow(SearchText) == 0) {
                M <<- M + 1
        }
}
f.handler_2 <- function(NGram.df) {
        f.N(M)
        SearchText <<- NGram.df %>% 
                filter(str_detect(Terms, CleanText))
}

################################################################################
f.sort <- function(SearchText) {
        SortText <<- SearchText[order(-SearchText$Probability),]
}
################################################################################
f.join <- function(SortText) {
        JoinText <<- SortText
        JoinText$Extract <<- gsub("\\s*\\w*$", "", JoinText$Terms)
}
################################################################################
f.select <- function(JoinText) {
        SelectText <<- JoinText %>%
                filter(str_detect(Extract, CleanText))
}
################################################################################
f.predict <- function(SelectText) {
        PredictText <<- select(SelectText, Terms, Probability)
        
        for (i in seq_len(nrow(PredictText))) {
                PredictText$Prediction <<- str_extract(PredictText$Terms, '\\w*$')
        }
}
################################################################################
