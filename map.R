library("leaflet")
library("dplyr")
library("maps")
library("geojsonio")
library("RColorBrewer")
library("htmltools")
library("lazyeval")

states <- geojson_read("USA.json", what = "sp")
states <- merge(states, all_industry, by.x = "NAME", by.y = "GeoName")



bins <- c(10000, 60000, 110000, 160000, 210000, 260000, 310000, 360000, Inf)
pal <- colorBin("YlOrRd", domain = as.numeric(states$X1997), bins = bins)

labels <- sprintf(
  "<strong>%s</strong><br/>%g Millions",
  states$NAME, states$X1997
) %>% lapply(htmltools::HTML)

m <- leaflet(states) %>%
  setView(-96, 37.8, 5) %>%
  addTiles() %>%
  addPolygons(
  fillColor = ~pal(X1997),
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
    )

addLegend(m, pal = pal, values = ~X1997, opacity = 0.7, title = NULL,
            position = "bottomright")

