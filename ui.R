library(shiny)
library(dplyr)
library(ggplot2)
library(plotly)
library(shinyWidgets)
library(shinythemes)

#Source file
source("regional_2017.R")
source("trend_data.R")


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
                         tags$p("Please click the labels to choose the industry of interest"))
              ),
              mainPanel(plotlyOutput("trendchart"))
            )
          ),
          
          #Panel 2 - Ryan
                  tabPanel(
                    titlePanel("Latest Regional Analysis"),
                    sidebarLayout(
                      sidebarPanel(tags$div(class = "title", checked = NA,
                                            tags$p("Regional GDP")),
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
                    )),
          #Panel 3 - Eric
                 tabPanel(
                   titlePanel("Interactive Map"),
                    sidebarLayout(
                      sidebarPanel(),
                      mainPanel()
                     )
                   )
)
shinyUI(my_ui)