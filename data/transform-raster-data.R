##%#########################################%##
#                                             #
####              Tidy data                ####
####       Transform raster data           ####
####        Vitor Borges-Júnior            ####
####       Created on 04 Oct 2023          ####
#                                             #
##%#########################################%##

# Load data -------------------------------------------
source(here::here("data-raw/load-spatial-data.R"))
source(here::here("data/transform-spatial-data.R"))
cities_cover1 <- raster::raster(here::here("data/cities-cover.tif"))

# Transform raster data -------------------------------------------

# select valid raster layers ----------------------------------------------
# geotiff_cover <- geotiff_cover[-c(1, 8, 11, 14, 16, 25, 28)]

# create a filter for cities of interest
# cities_filter2 <- sort(c(unique(point_ep$MUN),
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

# select valid objects in the list
cover_reclass2 <- cover_reclass[-c(1, 23, 28)]

# Create a single raster with all cities -------------------------------------------
# create an empty raster object
cities_cover2 <- raster::raster()

# add a new extent
raster::extent(cities_cover2) <- raster::extent(cover_reclass2$ATIBAIA)

# add a new resolution
raster::res(cities_cover2) <- raster::res(cover_reclass2$ATIBAIA)

# crerate new raster
for (i in 1:length(cover_reclass2)) {
  cities_cover2 <- merge(
    cities_cover2,
    cover_reclass2[[i]], 
    overlay = TRUE
  )
}

# Write raster as geotiff file -------------------------------------------
# writeRaster(
#   cities_cover, 
#   filename = "data/cities-cover.tif", 
#   format = "GTiff"
# )

# geotiff_cover_croped <- crop(
#   x = geotiff_cover,
#   y = point_ep
# )

# Transform raster to polygon -------------------------------------------
# cover_polygon <- rasterToPolygons(
#   x = cities_cover,
#   fun = \(.x) .x > 0
# )
# memória insuficiente
# # Attribute a new extent -------------------------------------------
# new_limits <- st_bbox(filtered_polygon_cities) + 
#   c(0, 0, 1.5, 1.5)
# extent(cover_polygon) <- new_limits

# Arquivos geotiff com problema
# AMPARO
# PEDREIRA
# PIRACAIA
# VARGEM
# # # convert raster object to the same crs -------------------------------------------
# crs(geotiff_cover) <- crs
# 
# # land cover
# geotiff_cover <- projectRaster(
#   geotiff_cover,
#   crs = projection(crs),
#   res = yres(geotiff_cover),
#   method = "ngb"
# )

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
# 
# rm(list = ls())