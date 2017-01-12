### Search and Destroy Prediction Function

The meta function `SDPredictionFunction(InputText)` contains several sub-functions.

##### Sub-Functions

* `f.clean(InputText)` to clean the input text
* `f.grep(CleanText)` to grep data from final text (pre corpus stage)
* `f.corpus(GrepText)` to convert grepped data to corpus
* `f.N(M)` to tokenize according to length of input string
* `f.convert(CorpusText)` to make an easy-to-read data frame
* `f.select(ConvertText)` select the most probable words
* `f.predict(SelectText)`to predict the next word


##### N - 1  

A good approach is to remove all `N > 5` words and then create `N - 1` multiple inputs to ensure a higher accuracy and return of result.

Sample input:

**The guy in front of me just bought a pound of bacon, a bouquet, and a case of**
  
Since this sentence has words > 5, all terms before last 5 words will be removed.  
Also from that input sentence, failsafes are created.  
  
1.**bouquet, and a case of**  
2. **and a case of**  
3. **a case of**  
4. **case of**  
5. **of**  

Give result, else return, there is no match.
