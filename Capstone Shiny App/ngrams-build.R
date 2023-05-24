
#######################################################################################
# This R script will create and Save 1,2,3,4 token grams. It reads the Data_Sample.txt 
# file and creates 1,2,3 and 4 ngrams in dataframe with terms and their frequencies
# The output file is saved in ngrams.Rdata file.
#######################################################################################


Packages <- c("qdap", "tm" ,"wordcloud", "ggplot2", "ggthemes", "RWeka")
lapply(Packages, library, character.only = TRUE)
rm(Packages)
# Set The Seed
set.seed(1111)


################################################################################
#create n-gram tokens
# Make tokenizer function for 2-gram

#Read The Sample Data File
con <- file("Data_Sample.txt")
txt_vector <- readLines(con)
close(con) ## It's important to close the connection when you are done
rm(con)

############################################################################
#Create and Cleanup volatile Corpse
text_source <- VectorSource(txt_vector)
text_corpus <- VCorpus(text_source)
rm(text_source)
print(text_corpus)
content(text_corpus[[2]])

#Clean Corpus
badwords <- c("damn", "shit")
clean_text_corpus <- tm_map(text_corpus, removePunctuation)
clean_text_corpus <- tm_map(clean_text_corpus, content_transformer(tolower))
clean_text_corpus <- tm_map(clean_text_corpus, removeWords, badwords)
clean_text_corpus <- tm_map(clean_text_corpus, removeWords, stopwords("en"))
clean_text_corpus <- tm_map(clean_text_corpus, stripWhitespace)
rm(badwords)
content(text_corpus[[2]])
content(clean_text_corpus[[2]])
print(text_corpus)
print(clean_text_corpus)
rm(text_corpus)


############################################################################
#Create n-grams tokens

tokenizer_ngram1 <- function(x) {
  NGramTokenizer(x, Weka_control(min = 1, max = 1))
}

tokenizer_ngram2 <- function(x) {
  NGramTokenizer(x, Weka_control(min = 2, max = 2))
}

tokenizer_ngram3 <- function(x) {
  NGramTokenizer(x, Weka_control(min = 3, max = 3))
}

tokenizer_ngram4 <- function(x) {
  NGramTokenizer(x, Weka_control(min = 4, max = 4))
}


# Create ngram_tdm
ngram1_tdm <- TermDocumentMatrix(clean_text_corpus,
                                      control = list(tokenize = tokenizer_ngram1))

ngram2_tdm <- TermDocumentMatrix(clean_text_corpus,
                                 control = list(tokenize = tokenizer_ngram2))

ngram3_tdm <- TermDocumentMatrix(clean_text_corpus,
                                 control = list(tokenize = tokenizer_ngram3))

ngram4_tdm <- TermDocumentMatrix(clean_text_corpus,
                                 control = list(tokenize = tokenizer_ngram4))


############################################################################
#Use slam package to calculate the frequencies of each term by using rowsum function) and #Convert into datatable
ngram1_freq <- slam::row_sums(ngram1_tdm, na.rm = T)
ngram1_freq <- sort(ngram1_freq, decreasing=TRUE)
ngram1_df <- data.table(token = names(ngram1_freq), count = unname(ngram1_freq))

#Use slam package to calculate the frequencies of each term by using rowsum function) and #Convert into datatable
ngram2_freq <- slam::row_sums(ngram2_tdm, na.rm = T)
ngram2_freq <- sort(ngram2_freq, decreasing=TRUE)
ngram2_df <- data.table(token = names(ngram2_freq), count = unname(ngram2_freq))


#Use slam package to calculate the frequencies of each term by using rowsum function) and #Convert into datatable
ngram3_freq <- slam::row_sums(ngram3_tdm, na.rm = T)
ngram3_freq <- sort(ngram3_freq, decreasing=TRUE)
ngram3_df <- data.table(token = names(ngram3_freq), count = unname(ngram3_freq))


#Use slam package to calculate the frequencies of each term by using rowsum function) and #Convert into datatable
ngram4_freq <- slam::row_sums(ngram4_tdm, na.rm = T)
ngram4_freq <- sort(ngram4_freq, decreasing=TRUE)
ngram4_df <- data.table(token = names(ngram4_freq), count = unname(ngram4_freq))

############################################################################
# Split tokens into individual words

ngram1_df <- ngram1_df %>%
  separate(token, c("FirstWord"), " ")

ngram2_df <- ngram2_df %>%
  separate(token, c("FirstWord", "SecondWord"), " ")

ngram3_df <- ngram3_df %>%
  separate(token, c("FirstWord", "SecondWord", "ThirdWord"), " ")

ngram4_df <- ngram4_df %>%
  separate(token, c("FirstWord", "SecondWord", "ThirdWord", "FourthWord"), " ")




rm(clean_text_corpus, txt_vector,
   ngram1_tdm, ngram2_tdm, ngram3_tdm, ngram4_tdm, 
   ngram1_freq, ngram2_freq,ngram3_freq, ngram4_freq,
   tokenizer_ngram1, tokenizer_ngram2, tokenizer_ngram3, tokenizer_ngram4)

save.image("ngrams.Rdata")