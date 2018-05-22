library(dplyr)
library(shiny)
library(ggplot2)
library(plotly)


my_server <- function(input, output){
  output$Bar <- renderPlotly({
 
#    category_selected <- data_regional %>%
 #     filter(Description == input$category)
   if(input$category == "All industry total"){
     g <- ggplot(all_industry, aes(x = GeoName, y = GDP_17_inbillion)) +
       geom_bar(aes(fill = Description), stat="identity") + coord_flip()
     g
   }
  else if(input$category == " Private industries"){
    g <- ggplot(private_sector, aes(x = GeoName, y = GDP_17_inbillion)) +
      geom_bar(aes(fill = Description), stat="identity") + coord_flip()
    g
  }
  else if(input$category == " Government and government enterprises"){
    g <- ggplot(public_sector, aes(x = GeoName, y = GDP_17_inbillion)) +
      geom_bar(aes(fill = Description), stat="identity") + coord_flip()
    g
  }
}
)
}
shinyServer(my_server)