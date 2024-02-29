##%#####################################################################%##
#                                                                         #
####                              Tidy data                            ####
####                        Transform raster data                      ####
####                          Vitor Borges-Júnior                      ####
####                        Created on 04 Oct 2023                     ####
#                                                                         #
##%#####################################################################%##

# Objective -------------------------------------------
# The objective of the script is to generate all raster data nedeed to 
# conduct data analysis and mapping

# Load data -------------------------------------------
source(here::here("data/transform-spatial-data.R"))

# Transform raster data -------------------------------------------

# select valid raster layers ----------------------------------------------
geotiff_cover <- geotiff_cover[-c(1, 23, 28)]

# create a filter for cities of interest
# cities_filter2 <- sort(c(unique(point_ep$name_muni),
#                     "FRANCISCO MORATO", "HORTOLÂNDIA",
#                     "JOANÓPOLIS", "LOUVEIRA",
#                     "SUMARÉ", "VARGEM"))

# rename list itens
names(geotiff_cover) <- sort(cities_filter)

# reclassify
reclass <- c(
  0, 9, 1,
  10, 50, 0
)

# reclassification matrix
reclass_matrix <- matrix(
  data = reclass,
  ncol = 3,
  byrow = TRUE
)

# List of reclassified rasters -------------------------------------------
cover_reclass <- purrr::map(
  geotiff_cover,
  \(.x) reclassify(
    x = .x,
    rcl = reclass_matrix
  )
)

# Create a single raster with all cities -------------------------------------------

# convert to class SpatRaster
cover_reclass2 <- list()
cover_reclass2 <- cover_reclass |> 
  purrr::map2(
    seq_along(cover_reclass),
    \(.x, .y) cover_reclass2[[.y]] <- terra::rast(.x)
  )

# create a SpatRasterCollection
cover_reclass3 <- terra::sprc(cover_reclass2)

# merge the SpatRasterCollection to a SpatRaster object
cities_cover <- terra::merge(cover_reclass3)

# convert raster from geographic to projected  --------
cities_cover2 <- terra::project(
  x = cities_cover, 
  y = terra::crs("EPSG:31983"),
  method = "near"
)

# Write raster as geotiff file -------------------------------------------
# writeRaster(
#   cities_cover, 
#   filename = "data/cities-cover.tif", 
#   format = "GTiff"
# )

# terra::writeRaster(
#   cities_cover2,
#   filename = "data/cities-cover2.tif"
# )

# Arquivos geotiff com problema
# AMPARO
# PINHALZINHO
# VARGEM
# Change names of classification -------------------------------------------
# "Water" <- c(26, 31, 33)
# "Agricultural" <- c(
# 14:15, 
# 18:21, 
# 35:36, 
# 39:41, 
# 46:48, 
# 62
# )
# "Non vegetated" <- 22:25
# "Forest" <- c(1:6, 49)
# "Natural non forest" <- c(10:13, 29, 32, 50)
# "Forestry" <- 9
# teste <- rasterToPolygons(
#   geotiff_cover_croped,
#   dissolve = TRUE
# )
# plot(teste)

# rm(list = ls())