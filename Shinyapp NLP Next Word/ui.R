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
  titlePanel("Coursera Capstone - Start Typing To Predict the Next Word"),
  
  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(


      textInput("input_text",
                   "Enter Your Text Here:",
                   value = "")
      

    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      tabsetPanel(type = "tabs",
                  tabPanel("Word Prediction", br(), textOutput("outputText")),
                  
      )
      
      
    )
  )
))