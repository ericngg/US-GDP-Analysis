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
          # Panel 1 -Andrew
          tabPanel(
            titlePanel("Trends"),
            sidebarLayout(
              sidebarPanel(
                sliderTextInput("range", "Please select a time range",
                            choices = years, selected = c("2002", "2012")),
                "Please click the labels to choose the industry of interest"
              ),
              mainPanel(plotlyOutput("trendchart"))
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
                      mainPanel(plotlyOutput("Bar", height = 500), width = "12"
                                
                      
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