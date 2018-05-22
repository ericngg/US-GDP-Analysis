library(shiny)
library(dplyr)
library(ggplot2)
library(plotly)

#Source file
source("regional_2017.R")


my_ui <- navbarPage("U.S. Overall Gross Domestic Product Report",
          # Panel 1 - Andrew
                    tabPanel(
                      titlePanel("Trending"),
                      sidebarLayout(
                        sidebarPanel(),
                        mainPanel()
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
                      mainPanel(plotlyOutput("Bar"))
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