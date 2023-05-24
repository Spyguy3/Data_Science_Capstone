#######################################################################################
# This R script create an ngram model to predcit next word.
#######################################################################################


Packages <- c("dplyr")
lapply(Packages, library, character.only = TRUE)
rm(Packages)
# Set The Seed
set.seed(1111)


load("ngrams.Rdata")

############################################################################
#Caclulate and add term frequcncies column for each ngram
ngram1_df <- ngram1_df %>%
  mutate(term_freq = count/sum(count))

ngram2_df <- ngram2_df %>%
  mutate(term_freq = count/sum(count))

ngram3_df <- ngram3_df %>%
  mutate(term_freq = count/sum(count))

ngram4_df <- ngram4_df %>%
  mutate(term_freq = count/sum(count))

#############################################################################


inputSentence <- "last work"

predictWord <- function(sentence, n = 10){
  match_ngram <- data.table()
  inputSentence <- removeNumbers(inputSentence)
  inputSentence <- removePunctuation(inputSentence)
  inputSentence <- tolower(inputSentence)
  sentenceWords <- unlist(strsplit(inputSentence, split = " " ))
  #get last 3 words from the sentence
  sentenceWords <- tail(sentenceWords, 3)
  SentenceFirstWord <- sentenceWords[1]
  SentenceScondWord <- sentenceWords[2]
  SentenceThirdword <- sentenceWords[3]
  
  if (is.na(scondWord)) 
    MacthedRows <- ngram2_df %>%
                      filter(FirstWord == SentenceFirstWord)
  
  
  
}




