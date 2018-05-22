library(dplyr)
library(shiny)
library(ggplot2)
library(plotly)


my_server <- function(input, output){
  output$Piechart <- renderPlotly({
    p <- plot_ly(Region_2017, labels = ~Region_2017$Description[Region_2017$GeoName == input$region],
                 values = ~Region_2017$X2017[Region_2017$GeoName == input$region], type = "pie") %>%
      layout(title = paste0("United States Regional GDP - ", input$region," in 2017"),
             xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
             yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
    
    p
  }
)
}
shinyServer(my_server)