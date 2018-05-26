library(shiny)
library(dplyr)
library(ggplot2)
library(plotly)
library(shinyWidgets)
library(shinythemes)
library(leaflet)
library(maps)
library(geojsonio)
library(RColorBrewer)
library(htmltools)
library(lazyeval)

#Source file
source("regional_2017.R")
source("trend_data.R")
source("map_data.R")

my_ui <- navbarPage(
  theme = shinytheme("cosmo"),
  tags$div(class = "header", checked = NA,
           tags$p("U.S. Overall GDP Analysis")),
          # Panel 1 -Andrew
          tabPanel(
            titlePanel(tags$div(class = "title", checked = NA,
                                tags$p("Trends"))),
            sidebarLayout(
              sidebarPanel(
                sliderTextInput("range", "Please select a time range",
                            choices = years, selected = c("2002", "2012")),
                tags$link(rel = "stylesheet",
                          type = "text/css", href = "style.css"),
                tags$div(class = "tab", checked = NA,
                         tags$p("Please click the labels to choose the industry of interest")),
                helpText("Double clicking an industry could isolate its trend"),
                width = 3
              ),
              mainPanel(plotlyOutput("trendchart", width = 1000),
                        tags$div(class = "analysis", checked = NA,
                                 tags$p("This line chart demonstrates how the U.S. GDP developed
                                        over time in the recent 20 years. By changing the year 
                                        range and the industry of interest, you can observe the changes
                                        and relate to recent ecnomic development. For example, the GDP
                                        of the big industries, especially finance, dropped significantly
                                        after the financial crisis in 2008.")))
            )
          ),
          
          #Panel 2 - Ryan
                  tabPanel(
                    titlePanel("Latest Regional Analysis"),
                    sidebarLayout(
                      sidebarPanel(tags$div(class = "title", checked = NA,
                                            tags$p("Regional GDP in 2017")),
                        radioButtons("category", "Category of interest",
                                     c("Top 10 Industries" = "top10",
                                       "All Industry" = "All industry total"),
                                       selected = "top10"),
                        checkboxGroupInput("Region", "Region of choice", choice_region,
                                           selected = c("New England", "Mideast")),
                                           width = 3
                      ),
                      mainPanel(plotlyOutput("Bar", height = 500), width = "9"
                     )
                    ),
                    sidebarLayout(
                      wellPanel(tags$div(class = "ryans", checked = NA,
                                         tags$p("Double click on the tab - information- on the right side. Why would possibly be the reason that Far West
                                                has the highest GDP in 2017 in the industry of information?")),
                        actionButton("AnswerCA", "Click me and see Possible Reason")
                      ),
                      mainPanel(textOutput("answersCA"))
                    ),
                    sidebarLayout(
                      wellPanel(tags$div(class = "ryans", checked = NA,
                                         tags$p("Next, select the industry - Finance and Insurance. How is it that Mideast region dominates this particular industry?")),
                                actionButton("AnswerNY", "Click me and see Possible Reason")
                      ),
                      mainPanel(textOutput("answersNY"))
                    ),
                    sidebarLayout(
                      wellPanel(tags$div(class = "ryans", checked = NA,
                                         tags$p("Lastly, take a look at the industry - Natural Resources. Why might Southwest have the greatest GDP in the natural resource industry?")),
                                actionButton("AnswerTX", "Click me and see Possible Reason")
                      ),
                      mainPanel(textOutput("answersTX"))
                    )),
          #Panel 3 - Eric
                 tabPanel(
                   titlePanel("Interactive Map"),
                    sidebarLayout(
                      sidebarPanel(
                        textOutput("title"),
                        selectInput("year", "Year:",
                                    choices = years_choice_map,
                                    selected = "1997"),
                        uiOutput("year"),
                        width = 3
                      ),
                      mainPanel(leafletOutput("industry_map", height = "800"))
                     )
                   )
)
shinyUI(my_ui)