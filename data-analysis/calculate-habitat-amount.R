##%#########################################%##
#                                             #
####           Data analysis               ####
####      Calculate habitat amount         ####
####        Vitor Borges-Júnior            ####
####       Created on 05 Oct 2023          ####
#                                             #
##%#########################################%##

# Load packages -------------------------------------------
library(landscapemetrics)

# Load data -------------------------------------------
source(here::here("data/transform-spatial-data.R"))

# Define buffer sizes -------------------------------------------
buffer_size <- c(100)

# Calculate habitat amount -------------------------------------------
habitat_amount <- sample_lsm(
  landscape = geotiff_cover_croped,
  y = point_ep[2:3], 
  shape = "circle",
  return_raster = TRUE,
  size = buffer_size
)
