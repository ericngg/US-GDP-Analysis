# setup
library(dplyr)
library(shiny)
library(ggplot2)
library(plotly)
library(leaflet)
library(maps)
library(geojsonio)
library(RColorBrewer)
library(htmltools)
library(lazyeval)
library(sp)

# server
shinyServer(function(input, output) {
  ##### Bars ###############################################################################
  
  output$Bar <- renderPlotly({
   if(input$category == "All industry total"){
     a
   }

  else if(input$category == " Private industries"){
    p
  }

  else if(input$category == " Government and government enterprises"){
    gov
  }
}
)


  

  
  
  
  
  
##### Plots ##############################################################################  
  
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
  
  ##### Maps ###############################################################################
  
  output$catOutput <- renderUI({
    sliderInput("year", "Year:",
                min = 1997, max = 2017,
                value = 1997, sep = "", animate = TRUE)
  })
  
  mdata <- reactive({
    req(input$catOutput)
    year_chosen <- paste0("X", input$catOutput)
    select(map_all_industry, "GeoName", year_chosen)
  })
  
  
  states_frame <- geojson_read("USA.json", what = "sp")
  states_frame <- sp::merge(states_frame, map_all_industry, by.x = "NAME", by.y = "GeoName")
  
  output$all_industry_map <- renderLeaflet({
    leaflet() %>%
    addTiles() %>%
    setView(-96, 37.8, 4)
  })
    
  observe({
    bins <- c(10000, 20000, 30000, 40000, 50000, 60000, 70000, 80000, Inf)
    pal <- colorBin("YlOrRd", domain = mdata()[2], bins = bins)
    labels <- sprintf(
      "<strong>%s</strong><br/>%g Millions",
      mdata[1], mdata[2]
    ) %>% lapply(htmltools::HTML)
    
    leafletProxy("all_industry_map", data = state_frame) %>%
      addTiles() %>%
      clearShapes() %>%
      clearControls() %>%
      addPolygons(
        fillColor = ~pal(mdata[2]),
        weight = 2,
        opacity = 1,
        color = "white",
        dashArray = "3",
        fillOpacity = 0.7,
        highlight = highlightOptions(
          weight = 5,
          color = "#666",
          dashArray = "",
          fillOpacity = 0.7,
          bringToFront = TRUE),
        label = labels,
        labelOptions = labelOptions(
          style = list("font-weight" = "normal", padding = "3px 8px"),
          textsize = "15px",
          direction = "auto")
      ) %>%
      addLegend(pal = color, values = ~year_chosen, opacity = 0.7,
                position = "bottomright",
                title = paste0(input$year, "<br>"))
  })
  
  
})