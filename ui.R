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
                    titlePanel("latest Regional Analysis"),
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