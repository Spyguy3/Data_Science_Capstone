#######################################################################################
# This R script will Find the accuracy of predictWord algorithym
#######################################################################################




Packages <- c("qdap", "tm" ,"wordcloud", "ggplot2", "ggthemes", "RWeka", "data.table", "dplyr", "tidyr")
lapply(Packages, library, character.only = TRUE)
rm(Packages)

load("Accuracy_ngrams.Rdata")
load("predictWord.Rdata")

matched <- vector()
finalWord <- vector()
predictedword <- vector()
combinedword <- vector()




for (i in 1:1000)
  {
  ngram_model <- sample(3,1)

  
  if (ngram_model == 1){
    Sample_Sentence <- Accuracy_ngram2_df[sample(length(Accuracy_ngram2_df$combinedWord),1),]
    AccuracyCombinedWord <- Sample_Sentence$combinedWord
    AccuracyFinalWord <- Sample_Sentence$SecondWord  
    AccuracyPredictedWord <- predictWord(AccuracyCombinedWord)
  }
  
  
  if (ngram_model == 2){
    Sample_Sentence <- Accuracy_ngram3_df[sample(length(Accuracy_ngram3_df$combinedWord),1),]
    AccuracyCombinedWord <- Sample_Sentence$combinedWord
    AccuracyFinalWord <- Sample_Sentence$ThirdWord  
    AccuracyPredictedWord <- predictWord(AccuracyCombinedWord)
  }
  
  if (ngram_model == 3){
    Sample_Sentence <- Accuracy_ngram4_df[sample(length(Accuracy_ngram4_df$combinedWord),1),]
    AccuracyCombinedWord <- Sample_Sentence$combinedWord
    AccuracyFinalWord <- Sample_Sentence$FourthWord  
    AccuracyPredictedWord <- predictWord(AccuracyCombinedWord)

  }
  
  matched[i] <- AccuracyPredictedWord == AccuracyFinalWord
  finalWord[i] <- AccuracyFinalWord
  predictedword[i] <- AccuracyPredictedWord
  combinedword[i] <- AccuracyCombinedWord
  i = i+1
  

}

accuracy_results <- data_frame(Matched =  matched, OriginalWord = finalWord, PredictedWord =  predictedword, CombinedInputWord = combinedword)

sum(accuracy_results$Matched)

matched_accuracy_results <- accuracy_results %>%
  filter(Matched == TRUE)


rm(matched_accuracy_results, accuracy_results, AccuracyCombinedWord, AccuracyFinalWord, AccuracyPredictedWord,
   combinedword, finalWord, i, matched, ngram_model, predictedword,
   Sample_Sentence)