# Probability Table Generation and Next-Word Prediction

__The idea is very simple. There are a few steps involved in the creation of the algorithm, we can begin by creating the following `.R` files:__  

- [x] `DataLoading.R` : A script to load the data  
- [x] `DataCleaning.R` : A script to clean the data  
- [x] `NGramGenerate.R` : A script to generate Term Document Matrices based on N-Grams  
- [x] `PredictionFunction.R` : A function that takes an input text and predicts an output  
- [x] `ProbabilityDataFrame.R` : A script to generate a Probability Data Frame  

__The general guidelines are as follows:__  
- [ ] Creating N-Gram Models using `RWeka`'s `NGramTokenizer` Function from `N = 2`  
to `N = 6`. Preferably a one-time operation using the entire cleaned dataset and not a `15%` sample. Then saved and loaded as a list of `.RData` files.
- [ ] Combine all into one Data Frame  
- [ ] We can now create a Frequency/Total Probability Column for each N-Gram  
  
__Then we can define the function:__  
  
- [ ] Takes a string of text.  
- [ ] Lowercases it.  
- [ ] Finds the number of words in the string  
- [ ] Based on the number of words, it assigns `N = Number of Words` for upto the last `N = 6` words in the string.  
- [ ] Recursively and negatively iterates N only if no match occurs from the N-Gram Data Frame. Example: "I am here" is the string we input, we want to predict the last word "dad". So it assigns `N = 3` and searches the dataframe for a match from the `N = N + 1`, i.e `N = 3 + 1 = 4` column.   
- [ ] If a possible partial match is available, it returns it and the probabilities assigned to the top 1-5 matches.  
- [ ] If there is no match. It iterates down to `N = 2` and searches `N = 3` column for matches. So instead of using "I am here" to find "I am here dad", you use "am here" to find "am here dad".   
- [ ] If there is no match. It iterates down even further to `N = 1` and searches `N = 2` column for matches. So instead of using "am here" to find "am here dad", you use "here" to find "here dad".   