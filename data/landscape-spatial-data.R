##%#########################################%##
#                                             #
####              Tidy data                ####
####       Landscape spatial data          ####
####        Vitor Borges-Júnior            ####
####       Created on 11 Oct 2023          ####
#                                             #
##%#########################################%##

# Load data -------------------------------------------
source(here::here("data/transform-spatial-data.R"))
source(here::here("data/transform-raster-data.R"))

# Load packages -------------------------------------------
source(here::here("R/dependencies.R"))

# Break data into a list of different cities -------------------------------------------
cities_names <- sort(unique(point_ep$name_muni))
ep_cities_data <- purrr::map(
  cities_names,
  \(.x) point_ep |> 
    dplyr::filter(name_muni == .x)
)
names(ep_cities_data) <- sort(unique(point_ep$name_muni))
ep_cities_data <- ep_cities_data[-c(1, 19)]

# Select raster from the same city -------------------------------------------
cover_reclass3 <- cover_reclass2[cities_names[-c(1, 19)]]
