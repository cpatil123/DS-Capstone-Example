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