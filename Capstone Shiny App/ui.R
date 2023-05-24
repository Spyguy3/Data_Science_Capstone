# Coursera Data Science Capstone Project
# Bill Lisse
# 20 May 2023
#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)



# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Coursera Data Science Capstone - Start Typing To Predict Next Word"),
  
  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(


      textInput("input_text",
                   "Enter 1, 2 or 3 Words Here:",
                   value = "")
      

    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      tabsetPanel(type = "tabs",
                  tabPanel("Word Prediction", br(), textOutput("outputText")),
                  tabPanel("Documentation", br(), textOutput("documentation"))
                  
      )
      
      
    )
  )
))