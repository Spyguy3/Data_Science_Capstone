

Packages <- c("qdap", "tm" ,"wordcloud", "ggplot2", "ggthemes", "RWeka")
lapply(Packages, library, character.only = TRUE)
rm(Packages)
# Set The Seed
set.seed(1111)



# ###################################################################################
#Create Sample Files, We will use these sample files for our project instaed of all data
# fileSize("en_US.blogs.txt", units = "MB")
# con_tmp <- file("en_US.blogs.txt", "r")
# length(readLines(con_tmp))
# max(nchar(readLines(con_tmp)))
# 
# 
# 
# ##################################
# #Twitter Sample file creation
# con <- file("en_US.twitter.txt", "r")
# data_All <- readLines(con, skipNul = TRUE)
# data_sample <- sample(data_All, length(data_All) * 0.0001)
# fileConn<-file("Twitter_Sample.txt")
# writeLines(data_sample, fileConn)
# close(fileConn)
# close(con)
# rm(fileConn, con, data_sample,data_All )
# #
# # ################################
# # #News Sample file creation
# con <- file("en_US.news.txt", "r")
# data_All <- readLines(con, skipNul = TRUE)
# data_sample <- sample(data_All, length(data_All) * 0.0001)
# fileConn<-file("News_Sample.txt")
# writeLines(data_sample, fileConn)
# close(fileConn)
# close(con)
# rm(fileConn, con, data_sample,data_All )
# #
# # #################################
# # #Blogs Sample file creation
# con <- file("en_US.blogs.txt", "r")
# data_All <- readLines(con, skipNul = TRUE)
# data_sample <- sample(data_All, length(data_All) * 0.0001)
# fileConn<-file("Blogs_Sample.txt")
# writeLines(data_sample, fileConn)
# close(fileConn)
# close(con)
# rm(fileConn, con, data_sample,data_All )
# #
# # ###############################
# # #Create combined sample file
# con_twitter <- file("Twitter_Sample.txt", "r")
# con_news <- file("News_Sample.txt", "r")
# con_blogs <- file("Blogs_Sample.txt", "r")
# twitter_vector <- readLines(con_twitter)
# news_vector <- readLines(con_news)
# blogs_vector <- readLines(con_blogs)
# data_sample <- c(twitter_vector, news_vector, blogs_vector)
# fileConn<-file("Data_Sample.txt")
# writeLines(data_sample, fileConn)
# close(con_twitter)
# close(con_news)
# close(con_blogs)
# rm(twitter_vector, news_vector, blogs_vector, data_sample)
# rm(con_blogs, con_news, con_twitter, fileConn)
# 
# ###################################################################################





############################################################################
#Read Sample Files
con <- file("Data_Sample.txt")
#readLines(con, 1) ## Read the first line of text 
#readLines(con, 1) ## Read the next line of text 
#readLines(con, 5) ## Read 5 lines of text 
#Create Text vector of 
txt_vector <- readLines(con)
close(con) ## It's important to close the connection when you are done
rm(con)
###################################################################################


############################################################################
#Look at the top 10 Terms used in the text
term_count <- freq_terms(txt_vector, 5)
plot(term_count)
rm(term_count)
############################################################################



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

###########################################################################
# Create the dtm from the corpus: coffee_dtm
# text_dtm <- DocumentTermMatrix(clean_text_corpus)
# print(text_dtm)
# text_dtm_m <- as.matrix(text_dtm) # Convert dtm to a matrix
# dim(text_dtm_m)                   # Print the dimensions of matrix
# text_dtm_m[1:2, 1:10]             # Review a portion of the matrix
############################################################################


############################################################################
#Create Wordcloud Visulizations to explore data
# Create the tdm from the corpus: text_tdm
text_tdm <- TermDocumentMatrix(clean_text_corpus)
print(text_tdm)
text_tdm_m <- as.matrix(text_tdm) # Convert coffee_dtm to a matrix: coffee_m
dim(text_tdm_m) # Print the dimensions of text_tdm_m
rm(text_tdm)
# Calculate the rowSums: term_frequency
text_tdm_m_term_frequency <- rowSums(text_tdm_m) # Sort term_frequency in descending order
text_tdm_m_term_frequency <- sort(text_tdm_m_term_frequency, decreasing = TRUE) # View the top 10 most common words
text_tdm_m_term_frequency[1:10]    # Plot a barchart of the 10 most common words
barplot(text_tdm_m_term_frequency[1:10], col = "tan", las = 2)


###########################################################################
#Create Wordcloud
text_tdm_m_terms_vec <- names(text_tdm_m_term_frequency) # Create Vector of terms

# Create a wordcloud for the values in word_freqs
wordcloud(text_tdm_m_terms_vec, text_tdm_m_term_frequency, max.words = 100, colors = "red")

rm(text_tdm_m_term_frequency, text_tdm_m_terms_vec)
###########################################################################



###########################################################################
# Create Hirerechal Cluster of words in the TDM, HC helps you visulize which terms have
# similiar frequencies to each other.
dim(text_tdm)

# Create sparse TDM. If sparse is equal to .95, 
# then we are removing terms that only appear in at most 5% of the documents
text_tdm_hc <- removeSparseTerms(text_tdm, sparse = 0.95)

# Create matrix tdm_m for sparsed TDM
text_tdm_hc_m <- as.matrix(text_tdm_hc)

# Create data_dist, distance function calculates how close two terms are based on 
# their frequencies in the TDM. i.e how many times they appear in th TDM
data_dist <- dist(text_tdm_hc_m)

# Create hc
hc <- hclust(data_dist)

# Plot the dendrogram
plot(hc)
rm(data_dist, text_tdm_hc, text_tdm_hc_m, hc)


####################################################################################
# Find associations between two words to see For any given word, the function
# findAssocs() calculates its correlation with every other word in a TDM or DTM. 
# Scores range from 0 to 1. A score of 1 means that two words always appear together 
# in documents, 


# This function will find pair of assiciated words (for "time") which have atleast 0.27 value
# of correlation. Minimum correlation values are often relatively low because of word diversity. 
# Don't be surprised if 0.10 demonstrates a strong pairwise term association.

associations <- findAssocs(text_tdm, "time", 0.27)  # View the the word "time" associations
associations
associations_df <- list_vect2df(associations, col2 = "word", col3 = "score") # Create dataframe associations_df

# Plot the associations_df values
ggplot(associations_df, aes(score, word)) + 
  geom_point(size = 3) + 
  theme_gdocs()

rm(associations, associations_df)


################################################################################
#create n-gram tokens
# Make tokenizer function for 2-gram
bigramtokenizer <- function(x) {
  NGramTokenizer(x, Weka_control(min = 2, max = 2))
}

trigramtokenizer <- function(x) {
  NGramTokenizer(x, Weka_control(min = 3, max = 3))
}


# Create unigram_dtm
text_tdm_unigram <- TermDocumentMatrix(clean_text_corpus)

# Create bigram_dtm
text_tdm_bigram <- TermDocumentMatrix(clean_text_corpus,
                                 control = list(tokenize = bigramtokenizer))

# Create triigram_dtm
text_tdm_trigram <- TermDocumentMatrix(clean_text_corpus,
                                      control = list(tokenize = trigramtokenizer))

text_tdm_unigram             # Print unigram_dtm
text_tdm_bigram              # Print bigram_dtm
text_tdm_trigram            # Print bigram_dtm


text_tdm_unigram_m <- as.matrix(text_tdm_unigram)
text_tdm_bigram_m <- as.matrix(text_tdm_bigram)
text_tdm_trigram_m <- as.matrix(text_tdm_trigram)

rm(text_tdm_unigram, text_tdm_bigram, text_tdm_trigram)
rm(bigramtokenizer, trigramtokenizer)

##########################################################################################
#Look at top 10 term frequncies for Uni, Bi and Tri grams

# Calculate the rowSums: term_frequency for unigram tdm
text_tdm_unigram_m_frequency <- rowSums(text_tdm_unigram_m) # Sort term_frequency in descending order
text_tdm_unigram_m_frequency <- sort(text_tdm_unigram_m_frequency, decreasing = TRUE) # View the top 10 most common words
text_tdm_unigram_m_frequency[1:10]    # Plot a barchart of the 10 most common words
barplot(text_tdm_unigram_m_frequency[1:10], col = "tan", las = 2)

# Calculate the rowSums: term_frequency for bigram tdm
text_tdm_bigram_m_frequency <- rowSums(text_tdm_bigram_m) # Sort term_frequency in descending order
text_tdm_bigram_m_frequency <- sort(text_tdm_bigram_m_frequency, decreasing = TRUE) # View the top 10 most common words
text_tdm_bigram_m_frequency[1:10]    # Plot a barchart of the 10 most common words
barplot(text_tdm_bigram_m_frequency[1:10], col = "tan", las = 2)


# Calculate the rowSums: term_frequency for trigram tdm
text_tdm_trigram_m_frequency <- rowSums(text_tdm_trigram_m) # Sort term_frequency in descending order
text_tdm_trigram_m_frequency <- sort(text_tdm_trigram_m_frequency, decreasing = TRUE) # View the top 10 most common words
text_tdm_trigram_m_frequency[1:10]    # Plot a barchart of the 10 most common words
barplot(text_tdm_trigram_m_frequency[1:10], col = "tan", las = 2)

rm(text_tdm_unigram_m_frequency, text_tdm_bigram_m_frequency, text_tdm_trigram_m_frequency)
##########################################################################################