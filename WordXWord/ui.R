### AUTHOR : YANAL KASHOU ###

################
### ui.R ###
################

# Load Shiny Packages
library(shiny)
library(shinydashboard)

dashboardPage(skin = "purple",
        dashboardHeader(title = "WordXWord",
                        titleWidth = 250),
################################################################################
        ## Sidebar content ##
        dashboardSidebar(width = 250,
                         sidebarMenu(
                menuItem("Overview", tabName = "overview", icon = icon("dashboard")),
                menuItem("Algorithms", tabName = "algos", icon = icon("th"),
                        menuSubItem("Destroy and Search (Fast)", tabName = "algorithm1", icon = icon("cogs")),
                        menuSubItem("Search and Destroy (Slow)", tabName = "algorithm2", icon = icon("gear"))
                         ),
                menuItem("Developer's Notes", tabName = "devnotes", icon = icon("user")),
                menuItem("Source Code", tabName = "source", icon = icon("code"))
        )),
################################################################################        
        ## Body content
        dashboardBody(
                tabItems(
                        # First tab content
                        ########################################################
                        tabItem(tabName = "overview",
                                h2("Welcome to WordXWord", align = "center"),
                                h4("I am Yanal Kashou, and this is my text prediction app!", align = "center"),
                                br(),
                                br(),
                                h4(strong("Overview")),
                                p("This data product demonstrates two similar algorithms:"),
                                p("The first one is called", strong("Destroy and Search"), "and is optimized for computational speed/efficiency."), 
                                p("The second one is called", strong("Search and Destroy"), "and is optimized for accuracy."),
                                p("This app is very intuitive to use, you can use the sidebar to navigate, it has 4 main tabs, the first is this one, titled", strong("Overview"), "the second is", strong("Algorithms"), "and contains 2 nested tabs, one for the fast algorithm and the other for the slow algorithm, the third tab is titled", strong("Developer's Notes"), "and contains my own notes on the app, the good, the bad and the ugly. Finally the fourth and last tab is titled", strong("Source Code"), "and contains the link to my GitHub Repository associated with this project. Feel free to click the URL, it will open in another tab and will not redirect you."),
                                br(),
                                h4(strong("Note")),
                                p("Please allow the app a few seconds to load before running any of the algorithms.")
                                
                        ),
                        # Sub Tab 1
                        ########################################################
                        tabItem(tabName = "algorithm1",
                                h2("Destroy and Search (Fast)", align = "center"),
                                br(),
                                fluidRow(
                                        column(width = 6,
                                               h3("Instructions"),
                                               h5(strong("STEP 1")),
                                               p("Below you can enter a phrase and press the button to predict"),
                                               h5(strong("STEP 2")),
                                               p("After you are done with", em("STEP 1"), "on the right you will find a tab box, feel free to navigate through it to preview the prediction table, the word probability histogram or the time elapsed."),
                                               br(),
                                               box(width = "1000px",
                                                   status = "primary",
                                                   title = "Destroy and Search (Fast)",
                                                   textInput("text1", "Please enter a phrase in the box below:", value = "I think that"),
                                                   actionButton("do1", "Predict My Next Word!")
                                               ),
                                               p(strong("NOTE:"), "This is the", strong("fast"), "algorithm, it should display results almost immediately when you click", strong(em("Predict My Next Word!")), "if it takes long, it means the app is still loading the data files for your first prediction. And this should resolve automatically within 15 Seconds, the next predictions will be much faster. Also be aware that this algorithm uses a pre-built N-Gram Model, so even though the entire data have been used to generate the models, there is a limitation in accuracy.")
                                        ),
                                        tabBox(
                                                side = "left", height = "250px",
                                                selected = "Predictions",
                                                tabPanel("Predictions",
                                                         tableOutput("pred.table1")
                                                ),
                                                tabPanel("Probability Histogram",
                                                         plotOutput("plot.prob1")),
                                                tabPanel("Time Elapsed",
                                                         tableOutput("table1"))
                                        )
                                )
                        ),
                        # Sub Tab 2
                        ########################################################
                        tabItem(tabName = "algorithm2",
                                h2("Search and Destroy (Slow)", align = "center"),
                                br(),
                                fluidRow(
                                        column(width = 6,
                                                h3("Instructions"),
                                               h5(strong("STEP 1")),
                                               p("Below you can enter a phrase and press the button to predict"),
                                               h5(strong("STEP 2")),
                                               p("After you are done with", em("STEP 1"), "on the right you will find a tab box, feel free to navigate through it to preview the prediction table, the word probability histogram or the time elapsed."),
                                               br(),
                                                box(width = "1000px",
                                                    status = "primary",
                                                        title = "Search and Destroy (Slow)",
                                                        textInput("text2", "Please enter a phrase in the box below:", value = "a bouquet and a case of"),
                                                        actionButton("do2", "Predict My Next Word!")
                                                ),
                                               p(strong("NOTE:"), "This is the", strong("slow"), "algorithm, after clicking", strong(em("Predict My Next Word!")), "please allow roughly ~30 seconds until results are returned. It was designed with accuracy as the top priority, hence N-Gram models are generated on-demand.")
                                        ),
                                        tabBox(
                                                height = "250px",
                                                selected = "Predictions",
                                                tabPanel("Predictions",
                                                         tableOutput("pred.table2")),
                                                tabPanel("Probability Histogram",
                                                         plotOutput("plot.prob2")),
                                                tabPanel("Time Elapsed",
                                                         tableOutput("table2"))
                                        )
                                )
                        ),
                        # Third tab content
                        ########################################################
                        tabItem(tabName = "devnotes",
                                h2("Developer's Notes", align = "center"),
                                br(),
                                h3("Positives"),
                                p("The algorithms have decent accuracy and this is because the text data was never stemmed and the sentence structure was maintained as the model was built. There is a disparity in the running time of the two algorithms that showcases their design differences. Both in my opinion run in a decent timeframe once the app is fully loaded."),
                                p("The app in general is very easy to use."),
                                h3("Negatives"),
                                p("It could be faster, if more time was spent learning about memory handling."),
                                p("It could be neater, if more time was spent designing the UI, especially if it was designed with the user in mind, it could contain some simple tools that can elevate it such as progress counter, predictions report downloader, etc..."),
                                h3("Possible Improvements"),
                                p("Experiment more with removing sparse serms from the NGram models, maybe this could improve accuracy while at the same time reducing size of model."),
                                p("Use a larger dataset, implement Markov Chains, rebuild app with memory management at the center.."),
                                p("Utilize non-global environments"),
                                h3("Browser Compatibility"),
                                h5("This app has been tested with the following web browsers:"),
                                p(em("Firefox Developer Edition 52.0a2 (2016-12-27) (32-bit)")),
                                p(em("irefox Developer Edition 52.0a2 (2016-12-19) (32-bit)")),
                                p(em("Chrome 54.0.2840.59 (Official Build) m (64-bit)"))
                                ),
                        # Fourth tab content
                        ########################################################
                        tabItem(tabName = "source",
                                h2("Source Code", align = "center"),
                                br(),
                                p("Please feel free to access my GitHub Repository associated with this project..."),
                                p("You can find all the code written during this Capstone Project."),
                                p("There is also the generated .RData files and the code of the app itself in the  GitHub Repository"),
                                p(icon("github", "fa-2x"), a("Data Science Capstone Project Repository", 
                                                             target="_blank", 
                                                             href="https://github.com/ykashou92/DataScienceCapstone")),
                                br(),
                                br(),
                                h3("You can find me at:"),
                                h3(icon("github", "fa-2x"), a("My GitHub Account", 
                                                              target="_blank", 
                                                              href="https://github.com/ykashou92/")
                                ),
                                h3(icon("linkedin", "fa-2x"), a("My LinkedIn Account", 
                                                                target="_blank", 
                                                                href="https://linkedin.com/in/yanalkashou/"))
                                
                        )
                )
        )
)
