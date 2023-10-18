##%#########################################%##
#                                             #
####              Tidy data                ####
####          Load spatial data            ####
####        Vitor Borges-Júnior            ####
####       Created on 04 Oct 2023          ####
#                                             #
##%#########################################%##

# Load packages -------------------------------------------
source(here::here("R/dependencies.R"))

# Load spatial data -------------------------------------------

# Response data -------------------------------------------
point_ep <- sf::st_read("raw-data/Epizootic_Events_Circuit.shp")

# Landscape layers -------------------------------------------

# load layers of all cities limits of São Paulo in 2017 -------------------------------------------
polygon_cities <- geobr::read_municipality(
  code_muni = "SP",
  year = 2017
)

# load land cover layer -------------------------------------------
geotiff_files <- paste0(
  "raw-data/cobertura-municipios/",
  list.files("raw-data/cobertura-municipios/")
)

geotiff_cover <- purrr::map(
  geotiff_files,
  \(.x) raster::raster(.x)
)

# rm(list = ls())