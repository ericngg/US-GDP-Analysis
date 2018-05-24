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
     data1 <- all_industry_data[all_industry_data$region %in% input$Region, ]
     a <- plot_ly(data1, x = ~region, y = ~X...Real.estate.and.rental.and.leasing,
                  type = "bar", name = "Real Estate, Renting, and Leasing") %>%
       add_trace(y = ~X.Government.and.government.enterprises, name = "State and local Government") %>%
       add_trace(y = ~X..Professional.and.business.services, name = "Professional and Business services") %>%
       add_trace(y = ~X...Finance.and.insurance, name = "Finance & Insurance") %>%
       add_trace(y = ~X...Health.care.and.social.assistance, name = "Health Care") %>%
       add_trace(y = ~X...Durable.goods.manufacturing, name = "Durable Manufacturing") %>%
       add_trace(y = ~X..Retail.trade, name = "Retail") %>%
       add_trace(y = ~X..Wholesale.trade, name = "Wholesale") %>%
       add_trace(y = ~X...Nondurable.goods.manufacturing, name = "Nondurable Manufacturing") %>%
       add_trace(y = ~X..Information, name = "Information") %>%
       add_trace(y = ~X...Arts..entertainment..and.recreation, name = "Arts & Recreation") %>%
       add_trace(y = ~X..Construction, name = "Construction") %>%
       add_trace(y = ~X..Transportation.and.warehousing, name = "Transportation") %>%
       add_trace(y = ~X...Educational.services, name = "Education") %>%
       add_trace(y = ~X...Accommodation.and.food.services, name = "Accommodation and food services") %>%
       add_trace(y = ~X..Other.services..except.government.and.government.enterprises., name = "Others") %>%
       add_trace(y = ~Natural.resources.and.mining, name = "Natural Resources") %>%
       add_trace(y = ~X..Utilities, name = "Utilities") %>%
       layout(xaxis = list(title = "Regions"),
              yaxis = list(title = "GDP (In billions USD)"), barmode = "stack")
      a
   }

  else if(input$category == "top10"){
    data1 <- all_industry_data[all_industry_data$region %in% input$Region, ]
    top10_data <- plot_ly(data1, x = ~region, y = ~X...Real.estate.and.rental.and.leasing,
                          type = "bar", name = "Real Estate, Renting, and Leasing") %>%
      add_trace(y = ~X.Government.and.government.enterprises, name = "State and local Government") %>%
      add_trace(y = ~X..Professional.and.business.services, name = "Professional and Business services") %>%
      add_trace(y = ~X...Finance.and.insurance, name = "Finance & Insurance") %>%
      add_trace(y = ~X...Health.care.and.social.assistance, name = "Health Care") %>%
      add_trace(y = ~X...Durable.goods.manufacturing, name = "Durable Manufacturing") %>%
      add_trace(y = ~X..Retail.trade, name = "Retail") %>%
      add_trace(y = ~X..Wholesale.trade, name = "Wholesale") %>%
      add_trace(y = ~X...Nondurable.goods.manufacturing, name = "Nondurable Manufacturing") %>%
      add_trace(y = ~X..Information, name = "Information") %>%
      layout(xaxis = list(title = "Regions"),
             yaxis = list(title = "GDP (In billions USD)"), barmode = "stack")
     top10_data
  }
}
)

<<<<<<< HEAD

  

  
  
  
  
  
##### Plots ##############################################################################  
=======
  filtered <- reactive({
    t <- filter(trend_data, year >= input$range[1], year <= input$range[2])
    return(t)
  })
>>>>>>> f5ab9676414ebe8564f05e6c8760cd36413cf4e5
  
  output$trendchart <- plotly::renderPlotly({
    a <- plot_ly(filtered(), x= ~year, y = ~all_industry_total,
                name = "National GDP", type = "scatter", mode = "lines+markers") %>%
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
<<<<<<< HEAD
  
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
=======
}
shinyServer(my_server)
>>>>>>> f5ab9676414ebe8564f05e6c8760cd36413cf4e5
