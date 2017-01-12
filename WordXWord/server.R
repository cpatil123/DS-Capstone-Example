### AUTHOR : YANAL KASHOU ###

################
### server.R ### 
################

# Load Shiny Packages
library(shiny)
library(shinydashboard)

# Load Necessary Packages
library(NLP)
library(dplyr)
library(stringr)
library(stringi)
library(tm)
library(ggplot2)
library(RWeka)

time1.df <- data.frame()
time2.df <- data.frame()

########################################################################
# Define server logic required to take a text input and then provide predictions 
# and visualizaitons in the form of histograms and word clouds.
shinyServer(function(input, output) {
        
        # Load .RData files
        Raw <<- readRDS("SRaw.Rds")
        NGram.df <<- readRDS("NGram.Rds")
        
        ########################################################################
        InputText1 <<- eventReactive(input$do1, ({
                input$text1
        }))
        ########################################################################
        Prediction1 <- reactive({
                source("ImprovedPredictionFunction.R")
                ImprovedPredictionFunction(InputText1())
                Prediction.1
        })
        ########################################################################
        output$table1 <- renderTable({
                time1.df <<- rbind(t1, time1.df)
                names(time1.df)[1:3] <<- c("user", "system", "elapsed")
                time1.df <<- time1.df[1:3]
                time1.df
        })
        ########################################################################
        output$plot.prob1 <- renderPlot({
                p1.init.1 <- Prediction1()
                plot.pred1 <- ggplot(p1.init.1, aes(Prediction, Probability)) +
                        geom_bar(stat="identity", fill="darkblue") +
                        ggtitle("Predictions") +
                        ylab("Probability") + 
                        theme(axis.text.x=element_text(angle=45, hjust=1),
                              axis.title.x=element_blank(),
                              panel.background = element_blank())
                plot.pred1
        })
        ########################################################################
        output$pred.table1 <- renderTable({
                p1 <- Prediction1()
                p1
        })
        ########################################################################                
        ########################################################################
        InputText2 <<- eventReactive(input$do2, ({
                input$text2
        }))
        ########################################################################
        Prediction2 <- reactive({
                source("SDPredictionFunction.R")
                SDPredictionFunction(InputText2())
                Prediction.2
        })
        #Prediction.2
        ########################################################################        
        output$table2 <- renderTable({
                time2.df <<- rbind(t2, time2.df)
                names(time2.df)[1:3] <<- c("user", "system", "elapsed")
                time2.df <<- time2.df[1:3]
                time2.df
        })
        ########################################################################
        output$pred.table2 <- renderTable({
                p2 <- Prediction2()
                p2
        })
        ########################################################################
        output$plot.prob2 <- renderPlot({
                p2.init.1 <- Prediction2()
                plot.pred2 <- ggplot(p2.init.1, aes(Prediction, Probability)) +
                        geom_bar(stat="identity", fill="darkred") +
                        ggtitle("Predictions") +
                        ylab("Probability") + 
                        theme(axis.text.x=element_text(angle=45, hjust=1),
                              axis.title.x=element_blank(),
                              panel.background = element_blank())
                plot.pred2
        })
        ########################################################################
})
        
        

################################################################################