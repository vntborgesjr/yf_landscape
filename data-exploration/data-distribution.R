##%#########################################%##
#                                             #
####           Data exploration            ####
####          Data distribution            ####
####        Vitor Borges-Júnior            ####
####       Created on 12 Oct 2023          ####
#                                             #
##%#########################################%##

# Load data -------------------------------------------
source(here::here("data/transform-landscape-data.R"))

# Load functions -------------------------------------------
source(here::here("R/box_dot_histplot1.R"))
source(here::here("R/my_hist.R"))
source(here::here("R/my_hist_facet.R"))

# Forest cover % -------------------------------------------
forest_cover_dist <- my_hist_facet(
  data = pland,
  x = value,
  binwidth = 25,
  xlab = "Cobertura floresta (%)",
  ylab = "Frequência"
)

# save forest cover distribution on disk -------------------------------------------
# ggplot2::ggsave(
#   plot = forest_cover_dist,
#   filename = "output/forest-cover-dist.jpeg",
#   height = 15,
#   width = 30,
#   units = "cm",
#   dpi = 50
# )

# Patch number -------------------------------------------
np_dist <- my_hist_facet(
  data = np,
  x = value,
  binwidth = 10,
  xlab = "Número de fragmentos",
  ylab = "Frequência"
)

# save patch number distribution on disk -------------------------------------------
# ggplot2::ggsave(
#   plot = np_dist,
#   filename = "output/np-dist.jpeg",
#   height = 15,
#   width = 30,
#   units = "cm",
#   dpi = 50
# )

# Edge density -------------------------------------------
ed_dist <- my_hist_facet(
  data = ed,
  x = value,
  binwidth = 1,
  xlab = "Densidade de borda",
  ylab = "Frequência"
) 

# save patch number distribution on disk -------------------------------------------
# ggplot2::ggsave(
#   plot = ed_dist,
#   filename = "output/ed-dist.jpeg",
#   height = 15,
#   width = 30,
#   units = "cm",
#   dpi = 50
# )

# Mean distance between epizootic events -------------------------------------------
# uses point_ep as soon as loaded
data_dist <- data.frame(
  x = point_ep$LONGITUDE,
  y = point_ep$LATITUDE
)
point_ep <- sf::st_transform(
  point_ep, 
  crs = raster::crs("EPSG:31983")
  )

data_dist <- data.frame(sf::st_distance(point_ep))
mean_data_dist <- data_dist |>
  dplyr::summarise(
    dplyr::across(1:449), 
    list(mean = mean),
    .names = "x"
    )

library(units)
mean_dist_ep_points <- mean_data_dist["X449"] |> 
  my_hist(
    x = X449,
    binwidth = 5,
    xlab = "Distance between sampling points",
    ylab = "Frequency",
    fill = "white",
    xfrom = 0,
    xto = 95, 
    xby = 5,
    yfrom = 0,
    yto = 60, 
    yby = 10
  ) +
  units::scale_x_units(unit = "km", breaks = seq(0, 95, 5))
  
# save patch number distribution on disk -------------------------------------------
# ggplot2::ggsave(
#   plot = mean_dist_ep_points,
#   filename = "output/figs2-mean-dist-ep-points.jpeg",
#   height = 15,
#   width = 30,
#   units = "cm",
#   dpi = 100
# )               

# number of PNH of each genus -------------------------------------------
point_ep |> 
  dplyr::count(
    genero
  ) |> 
  ggplot2::ggplot() +
  ggplot2::aes(
    x = genero,
    y = n
  ) +
  ggplot2::geom_col()

# rm(list = ls())