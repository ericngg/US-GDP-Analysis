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
  filtered <- reactive({
    t <- filter(trend_data, year >= input$range[1], year <= input$range[2])
    return(t)
  })
  
  output$trendchart <- plotly::renderPlotly({
    a <- plot_ly(filtered(), x= ~year, y = ~all_industry_total,
                name = "U.S. GDP", type = "scatter", mode = "lines+markers") %>%
      layout(title = "U.S. GDP Trend",
             xaxis = list(title = "Year", dtick = 1),
             yaxis = list(title = "GDP (in millions)")) %>%
      add_trace(x= ~year, y = ~information,
                name = "Information", mode = "lines+markers") %>%
      add_trace(x= ~year, y = ~manufacturing,
                name = "Manufacturing", mode = "lines+markers") %>%
      add_trace(x= ~year, y = ~finance_insurance_real_estate_rental_and_leasing,
                name = "Finance", mode = "lines+markers") %>%
      add_trace(x= ~year, y = ~educational_services_health_care_and_social_assistance,
                name = "Education", mode = "lines+markers") %>%
      add_trace(x= ~year, y = ~government_and_government_enterprises,
                name = "Government", mode = "lines+markers") %>%
      add_trace(x= ~year, y = ~retail_trade,
                name = "Retail", mode = "lines+markers")
      a
  })
}

shinyServer(my_server)