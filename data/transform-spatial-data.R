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
  # CRS("EPSG:31983")

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
cities_filter_polygons <- c(sort(unique(point_ep$MUN))[-c(1, 19)],
                   "FRANCISCO MORATO", "HORTOLÂNDIA",
                   "JOANÓPOLIS", "LOUVEIRA",
                   "SUMARÉ")

# filter points by cities names
point_ep <- point_ep |> 
  dplyr::select(1, 8, 9, 10, 11, 12, 14) |> 
  dplyr::filter(MUN %in% cities_filter) |> 
  rename(
    id = ID,
    name_muni = MUN,
    animais = Animais,
    status = STATUS,
    genero = GENERO,
    data = Data,
    ano = ANO
  ) |>
  mutate(
    status = fct_recode(
      status,
      Positive = "positivo",
      Negative = "Negativo"
    )
  )

# filter cities polygons
filtered_polygon_cities <- polygon_cities |> 
  dplyr::mutate(name_muni = toupper(name_muni)) |> 
  dplyr::filter(name_muni %in% cities_filter) |> 
  dplyr::select(
    name_muni, 
    geom
  )

# join ep events and cities polygons
ep_cities <- filtered_polygon_cities |> 
  st_join(
    point_ep,
    left = TRUE
  )

# Epizootic event exploration data -------------------------------------------
exploration_point_ep <- point_ep |> 
  filter(name_muni %in% cities_filter)

# rm(list = ls())