# setup
library(dplyr)
library(shiny)
library(ggplot2)
library(plotly)

# server
my_server <- function(input, output){
<<<<<<< HEAD
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
=======
  output$Piechart <- renderPlotly({
    p <- plot_ly(Region_2017, labels = ~Region_2017$Description[Region_2017$GeoName == input$region],
                 values = ~Region_2017$X2017[Region_2017$GeoName == input$region], type = "pie") %>%
      layout(title = paste0("United States Regional GDP - ", input$region," in 2017"),
             xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
             yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
    p
>>>>>>> ec5f464cee244bf5a73897e9f37a0205b843b0e1
  }
  else if(input$category == " Government and government enterprises"){
    g <- ggplot(public_sector, aes(x = GeoName, y = GDP_17_inbillion)) +
      geom_bar(aes(fill = Description), stat="identity") + coord_flip()
    g
  }
}
)
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