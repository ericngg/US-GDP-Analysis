# setup
library(dplyr)
library(shiny)
library(ggplot2)
library(plotly)

# server
my_server <- function(input, output){
  region_input <- reactive({
    all_data <- all_industry_data %>%
      filter(region %in% input$Region)
    return(all_data)
    })
  
  output$Bar <- renderPlotly({
    
    
   if(input$category == "All industry total"){
#     all_industry_data <- all_industry_data[all_industry_data$region %in% input$Region, ]
     a <- plot_ly(region_input(), x = ~region, y = ~X...Real.estate.and.rental.and.leasing,
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
  #  all_industry_data <- all_industry_data[all_industry_data$region %in% input$Region, ]
    top10_data <- plot_ly(region_input(), x = ~region, y = ~X...Real.estate.and.rental.and.leasing,
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

  filtered <- reactive({
    t <- filter(trend_data, year >= input$range[1], year <= input$range[2])
    return(t)
  })
  
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
}
shinyServer(my_server)