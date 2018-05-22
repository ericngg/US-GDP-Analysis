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
                        mainPanel(plotlyOutput("ustrendchart"), width = "100%")
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
                        radioButtons("category", "Please select category of interest",
                                     c("All Industry" = "All industry total",
                                       "Private Sector" = " Private industries",
                                       "Public Sector" = " Government and government enterprises"),
                                       selected = "All industry total")
                      ),
                      mainPanel(plotOutput("Bar"))
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