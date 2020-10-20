pacman::p_load(leaflet, rgdal, dplyr, htmltools)

states <- readOGR("c2hgis_state/c2hgis_statePoint.shp")
states_bound <- readOGR("cb_2018_us_state_500k/cb_2018_us_state_500k.shp")
counties <- readOGR("c2hgis_county/c2hgis_countyPoint.shp")
counties_bound <- readOGR("cb_2018_us_county_500k/cb_2018_us_county_500k.shp")

# Remove unnecessary columns
states@data <- states@data %>% select(c(geography0, geography1, pctpopwbba, pctpopwobb))

counties@data <- counties@data %>% select(c(geography0, geography1, pctpopwbba, pctpopwobb))

# Remove US Territories
states_bound <- subset(states_bound, GEOID <= 56)
counties_bound <- subset(counties_bound, STATEFP <= 56)

# Merge broadband data with counties polygon data
states_merge <- sp::merge(states_bound, states@data, by.x = "GEOID", by.y = "geography0")
states_merge <- subset(states_merge, !is.na(pctpopwbba))

counties_merge <- sp::merge(counties_bound, counties@data, by.x = "GEOID", by.y = "geography0")
counties_merge <- subset(counties_merge, !is.na(pctpopwbba))

# Color palettes
pal_state <- colorNumeric(
  palette = "Purples",
  domain = states_merge$pctpopwbba
)

pal_county <- colorNumeric(
  palette = "Greens",
  domain = counties_merge$pctpopwbba
)

# Labels
labels_state <- sprintf(
  "<strong>%s</strong><br/>%s",
  states_merge$NAME, states_merge$pctpopwbba
) %>%
  lapply(HTML)

labels_county <- sprintf(
  "<strong>%s</strong><br/>%s",
  counties_merge$NAME, counties_merge$pctpopwbba
) %>%
  lapply(HTML)


# Map state boundaries
map_state_bound <- leaflet(data = states_merge) %>%
  addPolygons(weight = .5, smoothFactor = 0.2, fillOpacity = 1,
              color = ~pal_state(states_merge$pctpopwbba),
              highlight = highlightOptions(
                weight = 2, color= "White", fillOpacity = 1,
                bringToFront = TRUE),
              label = labels_state) %>% 
  setView(lng = -93,
          lat = 38,
          zoom = 3) %>%
  addLegend(pal = pal_state, values = states_merge$pctpopwbba, title = "Broadband Access %", opacity = 1)
map_state_bound

# Map county boundaries
map_county_bound <- leaflet(data = counties_merge) %>%
  addPolygons(weight = .5, smoothFactor = 0.2, fillOpacity = 1,
              color = ~pal_county(counties_merge$pctpopwbba),
              highlight = highlightOptions(
                weight = 2, color= "White", fillOpacity = 1,
                bringToFront = TRUE),
              label = labels_county) %>% 
  setView(lng = -93,
          lat = 38,
          zoom = 3) %>%
  addLegend(pal = pal_county, values = counties_merge$pctpopwbba, title = "Broadband Access %", opacity = 1)
map_county_bound
