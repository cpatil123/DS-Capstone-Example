### ProbabilityDataFrame.R
################################################################################
# Set working directory
setwd("C://Users//Yanal Kashou//Data Science//Projects//R//DataScienceCapstone//cache")

# Load .RData file(s)
load("TwoGram.RData")
load("ThreeGram.RData")
load("FourGram.RData")
load("FiveGram.RData")
load("SixGram.RData")
load("NGram.RData")

# Load libraries
library(RWeka)
library(tm)
################################################################################
# Convert each Term-Document Matrix to a Data Frame
TwoGram.df <- as.data.frame(as.matrix(TwoGram.stdm))
ThreeGram.df <- as.data.frame(as.matrix(ThreeGram.stdm))
FourGram.df <- as.data.frame(as.matrix(FourGram.stdm))
FiveGram.df <- as.data.frame(as.matrix(FiveGram.stdm))
SixGram.df <- as.data.frame(as.matrix(SixGram.stdm))
NGram.df <- as.data.frame(as.matrix(NGram.tdm))

# Create a summation Column in each Data Frame
TwoGram.df$Count <- rowSums(TwoGram.df[1:3])
ThreeGram.df$Count <- rowSums(ThreeGram.df[1:3])
FourGram.df$Count <- rowSums(FourGram.df[1:3])
FiveGram.df$Count <- rowSums(FiveGram.df[1:3])
SixGram.df$Count <- rowSums(SixGram.df[1:3])
NGram.df$Count <- rowSums(NGram.df[1:3])

# Name the first unnamed column
# Remove unwanted columns
TwoGram.df <- setNames(cbind(rownames(TwoGram.df), TwoGram.df, row.names = NULL),
                      c("Terms", "x", "x1", "x2", "Count"))
TwoGram.df <- TwoGram.df[, !(colnames(TwoGram.df) %in% c("x","x1","x2"))]
ThreeGram.df <- setNames(cbind(rownames(ThreeGram.df), ThreeGram.df, row.names = NULL),
                      c("Terms", "x", "x1", "x2", "Count"))
ThreeGram.df <- ThreeGram.df[, !(colnames(ThreeGram.df) %in% c("x","x1","x2"))]
FourGram.df <- setNames(cbind(rownames(FourGram.df), FourGram.df, row.names = NULL),
                      c("Terms", "x", "x1", "x2", "Count"))
FourGram.df <- FourGram.df[, !(colnames(FourGram.df) %in% c("x","x1","x2"))]
FiveGram.df <- setNames(cbind(rownames(FiveGram.df), FiveGram.df, row.names = NULL),
                      c("Terms", "x", "x1", "x2", "Count"))
FiveGram.df <- FiveGram.df[, !(colnames(FiveGram.df) %in% c("x","x1","x2"))]
SixGram.df <- setNames(cbind(rownames(SixGram.df), SixGram.df, row.names = NULL),
                      c("Terms", "x", "x1", "x2", "Count"))
SixGram.df <- SixGram.df[, !(colnames(SixGram.df) %in% c("x","x1","x2"))]
NGram.df <- setNames(cbind(rownames(NGram.df), NGram.df, row.names = NULL),
                       c("Terms", "x", "x1", "x2", "Count"))
NGram.df <- NGram.df[, !(colnames(NGram.df) %in% c("x","x1","x2"))]

# Assign and calculate Probability Column for each Data Frame
TwoGram.df$Probability <- TwoGram.df$Count/sum(TwoGram.df$Count)
ThreeGram.df$Probability <- ThreeGram.df$Count/sum(ThreeGram.df$Count)
FourGram.df$Probability <- FourGram.df$Count/sum(FourGram.df$Count)
FiveGram.df$Probability <- FiveGram.df$Count/sum(FiveGram.df$Count)
SixGram.df$Probability <- SixGram.df$Count/sum(SixGram.df$Count)
NGram.df$Probability <- NGram.df$Count/sum(NGram.df$Count)

# Add a `Split` column where the string entries in the `Term` column are split into there consituent parts
TwoGram.df$Split <- strsplit(as.character(TwoGram.df$Terms), " ")
ThreeGram.df$Split <- strsplit(as.character(ThreeGram.df$Terms), " ")
FourGram.df$Split <- strsplit(as.character(FourGram.df$Terms), " ")
FiveGram.df$Split <- strsplit(as.character(FiveGram.df$Terms), " ")
SixGram.df$Split <- strsplit(as.character(SixGram.df$Terms), " ")
NGram.df$Split <- strsplit(as.character(NGram.df$Terms), " ")

# Save .RData file(s)
################################################################################
save(NGram.df, file = "NGram.df.RData")
