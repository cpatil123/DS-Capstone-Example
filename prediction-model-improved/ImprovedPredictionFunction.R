### ImprovedPredictionFunction.R
################################################################################
# Set working directory
setwd("C://Users//Yanal Kashou//Data Science//Projects//R//DataScienceCapstone//cache")

# Load .RData file(s)
load("NGram.df.RData")

# libraries
library(dplyr)
library(stringr)
library(stringi)

# Function of Functions, the Prediction Meta-Function
ImprovedPredictionFunction <- function(InputText) {
        
        # Start Timer
        ptm <- proc.time()
        
        # Run Functions
        f.clean(InputText)
        f.count(CleanText)
        f.search(NGram.df)
        #f.handler_1(NGram.df)
        #f.handler_2(NGram.df)
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
}
if (nrow(SearchText) == 0) {
        M <<- M + 1
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