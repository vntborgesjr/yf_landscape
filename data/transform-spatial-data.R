##%#####################################################################%##
#                                                                         #
####                              Tidy data                            ####
####                        Transform spatial data                     ####
####                          Vitor Borges-Júnior                      ####
####                        Created on 04 Oct 2023                     ####
#                                                                         #
##%#####################################################################%##

# Objective -------------------------------------------
# The objective of the script is to generate all point and polygon spatial 
# data to conduct data analysis and mapping

# Load data -------------------------------------------
source(here::here("data/load-spatial-data.R"))

# Transform spatial data -------------------------------------------

# Define coordinate reference system -------------------------------------------
novo_crs <- terra::crs("EPSG:31983")
  # sp::CRS("+proj=longlat +datum=WGS84 +no_defs")

# convert shapefile objects to the same crs -------------------------------------------
# epizooties events
point_ep <- sf::st_transform(
  epizootic,
  novo_crs
)

# cities polygon
polygon_cities <- sf::st_transform(
  polygon_cities,
  novo_crs
)

# Polygon and point data with epizooties and cities limits -------------------------------------------

# create a filter for cities of interest
cities_filter <- sort(c(unique(point_ep$MUN),
                        "FRANCISCO MORATO", "HORTOLÂNDIA",
                        "JOANÓPOLIS", "LOUVEIRA",
                        "SUMARÉ", "VARGEM"))

# exclude Amparo and Pinhalzinho
cities_filter <- cities_filter[-c(1, 23, 28)]

# filter points by cities names
point_ep <- point_ep |> 
  dplyr::select(1, 8, 9, 10, 11, 12, 14) |> 
  dplyr::filter(MUN %in% cities_filter) |> 
  dplyr::rename(
    id = ID,
    name_muni = MUN,
    animais = Animais,
    status = STATUS,
    genero = GENERO,
    data = Data,
    ano = ANO
  ) |>
  dplyr::mutate(
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
  sf::st_join(
    y = point_ep,
    left = TRUE
  )

# Epizootic event exploration data -------------------------------------------
exploration_point_ep <- point_ep |> 
  dplyr::filter(name_muni %in% cities_filter)

# rm(list = ls())