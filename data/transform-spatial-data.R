##%#########################################%##
#                                             #
####              Tidy data                ####
####       Transform spatial data          ####
####        Vitor Borges-Júnior            ####
####       Created on 04 Oct 2023          ####
#                                             #
##%#########################################%##

# Load data -------------------------------------------
source(here::here("data-raw/load-spatial-data.R"))

# Load packages -------------------------------------------
source(here::here("R/dependencies.R"))

# Transform spatial data -------------------------------------------

# Define coordinate reference system -------------------------------------------
novo_crs <- CRS("+proj=longlat +datum=WGS84 +no_defs")

# convert shapefile objects to the same crs -------------------------------------------
# epizooties events
point_ep <- st_transform(
  point_ep,
  novo_crs
)

# cities polygon
polygon_cities <- st_transform(
  polygon_cities,
  novo_crs
)

# Polygon and point data with epizooties and cities limits -------------------------------------------

# create a filter for cities of interest
cities_filter <- c(sort(unique(point_ep$MUN)),
                   "FRANCISCO MORATO", "HORTOLÂNDIA",
                   "JOANÓPOLIS", "LOUVEIRA",
                   "SUMARÉ", "VARGEM")

# filter cities polygons
filtered_polygon_cities <- polygon_cities |> 
  dplyr::mutate(name_muni = toupper(name_muni)) |> 
  dplyr::filter(name_muni %in% cities_filter) |> 
  dplyr::select(
    name_muni, 
    geom
  )

# give equal names to city names column
point_ep <- point_ep |> 
  rename(name_muni = MUN) |>
  mutate(
    status = as.factor(STATUS),
    status = fct_recode(
      status,
      Positive = "positivo",
      Negative = "Negativo"
    )
  )

ep_cities <- filtered_polygon_cities |> 
  st_join(
    point_ep,
    left = TRUE
  )

# Epizootic event exploration data -------------------------------------------
exploration_point_ep <- point_ep |> 
  filter(name_muni %in% cities_names)

# Data for mapping buffers -------------------------------------------
# filter data for one city and one point
buffer_ep_atibaia <- point_ep_atibaia |> 
  dplyr::filter(
    status == "Positivo",
    ID == 351
  )

# define buffer sizes
buffer1 <- 40
buffer2 <- 100
buffer3 <- 200
buffer4 <- 400
buffer5 <- 1000
buffer6 <- 2000

# define buffers around point
# 40 meters
buffer_points1 <- st_buffer(
  buffer_ep_atibaia, 
  dist = buffer1
)

# 100 meters
buffer_points2 <- st_buffer(
  buffer_ep_atibaia, 
  dist = buffer2
)

# 200 meters
buffer_points3 <- st_buffer(
  buffer_ep_atibaia, 
  dist = buffer3
)

# 400 meters
buffer_points4 <- st_buffer(
  buffer_ep_atibaia, 
  dist = buffer4
)

# 1000 meters
buffer_points5 <- st_buffer(
  buffer_ep_atibaia, 
  dist = buffer5
)

# 2000 meters
buffer_points6 <- st_buffer(
  buffer_ep_atibaia, 
  dist = buffer6
)

# rm(list = ls())