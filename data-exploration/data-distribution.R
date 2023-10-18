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

# Load packages -------------------------------------------
source(here::here("R/dependencies.R"))

# Load functions -------------------------------------------
source(here::here("R/box_dot_histplot1.R"))

# Forest cover % -------------------------------------------
# define max value of the metric
max_cover <- max(pland$value)
forest_cover_dist <- box_dot_histplot1(
  data = pland,
  var = value,
  bin_width = 5,
  x_lab = "Cobertura florestal (%)",
  y_lab = "Frequência",
  min_x = 0,
  max_x = max_cover
)

# save forest cover distribution on disk -------------------------------------------
# ggsave(
#   plot = forest_cover_dist,
#   filename = "output/forest-cover-dist.tiff",
#   height = 15,
#   width = 10,
#   units = "cm",
#   dpi = 100
# )

# Patch number -------------------------------------------
max_np <- max(np$value)
np_dist <- box_dot_histplot1(
  data = np,
  var = value,
  bin_width = 200,
  x_lab = "Número de fragmentos",
  y_lab = "Frequência",
  max_x = max_np
)

# save patch number distribution on disk -------------------------------------------
# ggsave(
#   plot = np_dist,
#   filename = "output/np-dist.tiff",
#   height = 15,
#   width = 10,
#   units = "cm",
#   dpi = 100
# )

# Edge density -------------------------------------------
min_ed <- min(ed$value)
max_ed <- max(ed$value)
ed_dist <- box_dot_histplot1(
  data = ed,
  var = value,
  bin_width = 0.5,
  x_lab = "Densidade de borda",
  y_lab = "Frequência",
  min_x = -2,
  max_x = max_ed,
  angle = 0
) 

# save patch number distribution on disk -------------------------------------------
# ggsave(
#   plot = ed_dist,
#   filename = "output/ed-dist.tiff",
#   height = 15,
#   width = 10,
#   units = "cm",
#   dpi = 100
# )

# rm(list = ls())