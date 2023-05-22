#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
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



