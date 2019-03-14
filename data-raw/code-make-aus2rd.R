library(sf)
library(tidyverse)

aus2 <- read_sf("data-raw/gadm36_AUS_shp/gadm36_AUS_2.shp")

saveRDS(aus2, "data-raw/ausexin.rds")

aus2rd <- readRDS("data-raw/ausexin.rds")

usethis::use_data(aus2rd, overwrite = T)
