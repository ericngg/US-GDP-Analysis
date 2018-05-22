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
  theme = shinytheme("sandstone"),
  "U.S. Overall Gross Domestic Product Report",
          # Panel 1 - Andrew
                    tabPanel(
                      titlePanel("Trends (National)"),
                      sidebarLayout(
                        sidebarPanel(
                          sliderTextInput("range", "Please select a time range",
                                          choices = years, selected = years[c(5,15)])
                        ),
                        mainPanel(plotlyOutput("ustrendchart"))
                      )
                    ),
          # Panel 1.1 -Andrew
          tabPanel(
            titlePanel("Trends (Industries)"),
            sidebarLayout(
              sidebarPanel(
              ),
              mainPanel(plotlyOutput("industrytrendchart"))
            )
          ),
          
          #Panel 2 - Ryan
                  tabPanel(
                    titlePanel("Latest Regional Analysis"),
                    sidebarLayout(
                      sidebarPanel(
                        selectInput("region", "Please select a region of choice",
                                    Region_choice, selected = "New England")
                      ),
                      mainPanel(plotlyOutput("Piechart"))
                     )
                    ),
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