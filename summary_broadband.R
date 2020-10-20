pacman::p_load(rgdal, dplyr, knitr, kableExtra)

states <- readOGR("c2hgis_state/c2hgis_statePoint.shp")
counties <- readOGR("c2hgis_county/c2hgis_countyPoint.shp")

summary_table <-t(apply(counties@data[, c("pctpopwbba", "pctpopwobb", 
                        "provcount_", "dsgteq25", "usgteq3")], 2, summary))
rownames(summary_table) <- c("Percent pop with broadband", 
                             "Percent pop without broadband",
                             "Provider Count",
                             "Percent pop with download speed 25mbps or greater",
                             "Percent pop with upload speed 3mbps or greater")

summary_table <- summary_table %>% kable()
View(summary_table)

