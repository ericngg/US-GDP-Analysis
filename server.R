# setup
library(dplyr)
library(shiny)
library(ggplot2)
library(plotly)

# server
my_server <- function(input, output){
  output$Bar <- renderPlotly({
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
})
  output$ustrendchart <- renderPlotly({
    a <- plot_ly(ustrend_data, x= ~input$range,
                              name = "U.S. GDP",
                              type = "scatter", mode = "lines+markers") %>%
      layout(title = "U.S. GDP Trend",
             xaxis = list(title = "Year"),
             yaxis = list(title = "GDP (in millions)"))
    a  
  }
  )
  output$industrytrendchart <- renderPlotly({
    b <- plot_ly(trend_data, x= ~year, y = ~manufacturing,
                                    name = "Manufacturing",
                                    type = "scatter", mode = "lines+markers") %>%
      layout(title = "U.S. GDP Trend by industry",
             xaxis = list(title = "Year"),
             yaxis = list(title = "GDP (in millions)")) %>%
      add_trace(x= ~year, y = ~information,
                name = "Information", mode = "lines+markers") %>%
      add_trace(x= ~year, y = ~retail_trade,
                name = "Retail", mode = "lines+markers") %>%
      add_trace(x= ~year, y = ~finance_insurance_real_estate_rental_and_leasing,
              name = "Finance", mode = "lines+markers") %>%
      add_trace(x= ~year, y = ~educational_services_health_care_and_social_assistance,
                name = "Education", mode = "lines+markers") %>%
      add_trace(x= ~year, y = ~government_and_government_enterprises,
                name = "Government", mode = "lines+markers")
    b
  })
}

shinyServer(my_server)