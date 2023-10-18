##%#########################################%##
#                                             #
####           Data analysis               ####
####           Mapping data                ####
####        Vitor Borges-Júnior            ####
####       Created on 04 Oct 2023          ####
#                                             #
##%#########################################%##

# Load data -------------------------------------------
source(here::here("data/transform-spatial-data.R"))
cities_cover <- raster::raster(here::here("data/cities-cover.tif"))

# Load packages -------------------------------------------
source(here::here("R/dependencies.R"))

# New limits -------------------------------------------
new_limits <- st_bbox(filtered_polygon_cities) + 
  c(-0.05, -0.1, 0.05, 0.15)

# Thematic map with tmap -------------------------------------------
# city limits layer
city_limits_layer1 <- tm_shape(
  polygon_cities, 
  bbox = new_limits
) +
  tm_borders(
    col = "grey",
    lwd = 0.2
  )

city_limits_layer2 <- tm_shape(
  filtered_polygon_cities, 
  bbox = new_limits
) +
  tm_borders(
    col = "grey",
    lwd = 1
  )

# epizooties events layer
ep_events_layer <- tm_shape(
  point_ep, 
  bbox = new_limits
) +
  tm_symbols(
    size = 0.2,
    col = "status",
    col.scale = tm_scale_categorical(
      values = c("blue", "red")
    ),
    col.legend = tm_legend(
      title = "",
      width = 7.5,
      height = 5,
      position = tm_pos_in(
        pos.h = "right",
        pos.v = "top"
      )
    )
  )

# land cover layer
land_cover_layer <- tm_shape(
  cities_cover, 
  bbox = new_limits
) +
  tm_raster(
    col.scale = tm_scale_ordinal(
      n.max = 2,
      values = c("white", "green"),
      levels = c(0, 1),
      labels = c("Não floresta", "Floresta")
    ),
    col.legend = tm_legend(
      title = "Legenda",
      width = 7.5,
      height = 5,
      position = tm_pos_in(
        pos.h = "right",
        pos.v = "top"
      ),
      title.fontfamily = "serif",
      title.fontface = "bold",
      title.size = 1
    )
  )

# Grid layer -------------------------------------------
grid_layer <- tm_grid(
  crs = projection(cities_cover),
  lines = FALSE, 
  labels.rot = c(0, 90),
  labels.cardinal = TRUE
)

# Scale bar layer -------------------------------------------
scale_layer <- tm_scalebar(
  width = 1,
  breaks = c(0, 11, 23, 46, 69, 92), 
  text.size = 0.5
)

# Compass layer -------------------------------------------
compass_layer <- tm_compass(
  type = "4star", 
  size = 2, 
  position = c("left", "top")
)

# Map of the study area -------------------------------------------

study_area_map <- land_cover_layer +
  ep_events_layer +
  city_limits_layer1 +
  city_limits_layer2 +
  grid_layer +
  scale_layer +
  compass_layer 

study_area_map  

# Save study area map on disk -------------------------------------------

# tmap_save(
#   tm = study_area_map,
#   filename = "output/mapa-area-de-estudo.tiff",
#   width = 5.5,
#   height = 5.5,
#   dpi = 200
# )

# tmap_leaflet(
#   study_area_map
# )

# Buffers map -------------------------------------------
# adjust map limits
new_limits <- st_bbox(buffer_points6) + 
  c(-0.001, -0.004, 0.001, 0.002) 

# cover layer -------------------------------------------
cover_layer_bufffer <- tm_shape(
  crop_atibaia,
  bbox = new_limits, 
  crs = projection(cover_reclass2$ATIBAIA)
) +
  tm_raster(
    col.scale = tm_scale_ordinal(
      n.max = 2,
      values = c("white", "green"),
      levels = c(0, 1),
      labels = c("Não floresta", "Floresta")
    ),
    col.legend = tm_legend(
      title = "Legenda",
      width = 7.5,
      height = 5,
      position = tm_pos_auto_out(
        pos.h = "left",
        pos.v = "top"
      ),
      title.fontfamily = "serif",
      title.fontface = "bold",
      title.size = 1
    )
  ) 

# 2000 meters buffer layer -------------------------------------------
buffer_layer2000 <- tm_shape(buffer_points6) +
  tm_polygons(fill_alpha = 0)

# 1000 meters buffer layer -------------------------------------------
buffer_layer1000 <- tm_shape(buffer_points5) +
  tm_polygons(fill_alpha = 0) 

# 400 meters buffer layer -------------------------------------------
buffer_layer400 <- tm_shape(buffer_points4) +
  tm_polygons(fill_alpha = 0) 

# 200 meters buffer layer -------------------------------------------
buffer_layer200 <- tm_shape(buffer_points3) +
  tm_polygons(fill_alpha = 0) 

# 100 meters buffer layer   -------------------------------------------
buffer_layer100 <- tm_shape(buffer_points2) +
  tm_polygons(fill_alpha = 0) 

# 40 meters buffer layer -------------------------------------------
buffer_layer40 <- tm_shape(buffer_points1) +
  tm_polygons(fill_alpha = 0) 

# Grid layer -------------------------------------------
grid_layer_buffer <- tm_grid(
  crs = projection(cover_reclass2$ATIBAIA),
  n.y = 4,
  lines = FALSE, 
  labels.rot = c(0, 90),
  labels.cardinal = TRUE
)

# Scale bar layer -------------------------------------------
scale_layer_buffer <- tm_scalebar(
  width = 1,
  breaks = c(0, 0.5, 1, 1.5, 2), 
  text.size = 0.5
)

# Compass layer -------------------------------------------
compass_layer_buffer <- tm_compass(
  type = "4star", 
  size = 2, 
  position = c("left", "top")
)

# Final buffer map -------------------------------------------
buffer_map <- cover_layer_bufffer +
  grid_layer_buffer + 
  buffer_layer2000 +
  buffer_layer1000 +
  buffer_layer400 +
  buffer_layer200 +
  buffer_layer100 +
  buffer_layer40 +
  scale_layer_buffer +
  compass_layer_buffer

buffer_map

# Save buffer map on disk -------------------------------------------
tmap_save(
  tm = buffer_map,
  filename = "output/mapa-buffers.tiff",
  width = 6.5,
  height = 5.5,
  dpi = 200
)

# Test maps municipalities cover -------------------------------------------
# fliter
atibaia <- ep_cities_data$ATIBAIA |> 
  dplyr::filter(name_muni == "ATIBAIA") |> 
  count(status)


# epizooties events layer
ep_events_layer <- tm_shape(
  buffer_ep_atibaia, 
  bbox = new_limits
) +
  tm_symbols(
    size = 0.2,
    col = "status",
    col.scale = tm_scale_categorical(
      values = c("blue", "red")
    ),
    col.legend = tm_legend(
      title = "",
      width = 7.5,
      height = 5,
      position = tm_pos_in(
        pos.h = "right",
        pos.v = "top"
      )
    )
  )

# land cover layer
land_cover_layer <- tm_shape(cover_reclass2$ATIBAIA) +
  tm_raster(col.scale = tm_scale_ordinal(
    n.max = 2,
    values = c("white", "green"),
    levels = c(0, 1),
    labels = c("Não floresta", "Floresta")
  ),
  col.legend = tm_legend(
    title = "Legenda",
    width = 7.5,
    height = 5,
    position = tm_pos_in(
      pos.h = "right",
      pos.v = "top"
    ),
    title.fontfamily = "serif",
    title.fontface = "bold",
    title.size = 1
  ))

land_cover_layer +
  ep_events_layer








  