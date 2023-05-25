#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
# Coursera Data Science Capstone Project
# Bill Lisse
# 20 May 2023
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#



library(shiny)
library(tm)
library(dplyr)


#Load Rdata file that has predictWord fucntion and the ngrams dataframes
load("predictWord.Rdata", envir=.GlobalEnv)


# Define server logic required to draw a histogram
shinyServer( function(input, output) {
  

#This will populate the "About" tab of UI  
  my_documentation <- "This Next Word Preciction Application was created by Bill Lisse, 24 May 2023, and is a shiny application that
                            will let the user predict the next word as you are typing.
                        The application uses n-Grams tokens to predict the next word based on a sample of Twitter, Blogs and News.
                        We used 1, 2 and 3 n-grams tokens for the prediction model. The data was obtained from Swiftkey at
                        https://d396qusza40orc.cloudfront.net/dsscapstone/dataset/Coursera-SwiftKey.zip The Next Word Predict 
                        Presentation is located at: https://rpubs.com/wclisse/Capstone_Final_Presentation 
                        The Code is available at: https://github.com/Spyguy3/Data_Science_Capstone.git"
  

  output_text <- reactive({
    
    word <- as.character(input$input_text)
    predictWord(word)
    #ngram2_df$FirstWord[1]

    })
  
#  output_text <- predictWord("looking")
  
  output$documentation <- renderText(my_documentation)
  #output$outputText <- renderText({ predictedWord() })
  output$outputText <- renderText({ output_text() })
  
})



