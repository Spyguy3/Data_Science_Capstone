# ui.R
# Author: Bill Lisse
# Date: May 20, 2023
# Description: Shiny UI, Coursera Data Science Capstone Final Project
# GitHub: https://github.com/Spyguy3/Data_Science_Capstone.git

library(shiny)
library(shinythemes)
library(markdown)
library(dplyr)
library(tm)

shinyUI(
    navbarPage("JHU Capstone Next Word Predict",
               theme = shinytheme("united"),
               tabPanel("Home",
                        fluidPage(
                            titlePanel("Home"),
                            sidebarLayout(
                                sidebarPanel(
                                    textInput("userInput",
                                              "Enter a word or phrase:",
                                              value =  "",
                                              placeholder = "Enter text here"),
                                    br(),
                                    sliderInput("numPredictions", "Number of Predictions:",
                                                value = 1.0, min = 1.0, max = 3.0, step = 1.0)
                                ),
                                mainPanel(
                                    h4("Input text"),
                                    verbatimTextOutput("userSentence"),
                                    br(),
                                    h4("Predicted words"),
                                    verbatimTextOutput("prediction1"),
                                    verbatimTextOutput("prediction2"),
                                    verbatimTextOutput("prediction3")
                                )
                            )
                        )
               ),
               tabPanel("About",
                        h3("About Next Word Predict"),
                        br(),
                        div("Next Word Predict Project is a Shiny app is the Project final for the JHU Data Science Specialization that uses a text
                            prediction algorithm to predict the next word(s)
                            based on text entered by a user. This project was craeted by Bill Lisse, May 20, 2023",
                            br(),
                            br(),
                            "The predicted next word will be shown when the application
                            detects that you have finished typing one or more
                            words. ",
                            br(),
                            br(),
                            "Use the slider bar to select the number of 
                            word predictions (based on n-grams), up to three. The most likey word prediction will be
                            shown first followed by the second and third likely
                            next words.",
                            br(),
                            br(),
                            "The source code for this application can be found
                            on GitHub:",
                            br(),
                            br(),
                          
                            a(target = "_blank", href = "https://github.com/Spyguy3/Data_Science_Capstone.git",
                            "https://github.com/Spyguy3/Data_Science_Capstone.git")),
             
               )
    )
)
