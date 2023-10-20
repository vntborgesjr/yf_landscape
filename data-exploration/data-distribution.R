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
forest_cover_dist <- pland |> 
  ggplot2::ggplot() +
  ggplot2::aes(x = value) +
  ggplot2::geom_histogram(
    fill = "#bdd005",
    color = "black",
    binwidth = 25,
    center = 25/2
  ) +
  ggplot2::labs(
    x = "Cobertura floresta (%)",
    y = "Frequência"
  ) +
  ggplot2::facet_wrap(
    facets = ggplot2::vars(
      buffer
    ), 
    scales = "free_y", as.table = TRUE
  ) +
  ggplot2::theme_classic(
    base_size = 14,
    base_family = "serif"
  ) +
  ggplot2::theme(
    text = ggplot2::element_text(
      color = "black", 
      face = "bold"
    ),
    axis.text.x = ggplot2::element_text(
      size = 12
    ),
    axis.text.y = ggplot2::element_text(size = 12),
    # axis.ticks.x = ggplot2::element_blank(),
    strip.background = ggplot2::element_rect(
      color = "white"
    ), 
    strip.text = ggplot2::element_text(
      color = "black"
    )
  )

# save forest cover distribution on disk -------------------------------------------
ggplot2::ggsave(
  plot = forest_cover_dist,
  filename = "output/forest-cover-dist.tiff",
  height = 15,
  width = 30,
  units = "cm",
  dpi = 100
)

# Patch number -------------------------------------------
np_dist <- np |> 
  ggplot2::ggplot() +
  ggplot2::aes(x = value) +
  ggplot2::geom_histogram(
    fill = "#bdd005",
    color = "#bdd005",
    binwidth = 1,
    center = 1/2
  ) +
  ggplot2::labs(
    x = "Número de fragmentos",
    y = "Frequência"
  ) +
  ggplot2::facet_wrap(
    facets = ggplot2::vars(
      buffer
    ), 
    scales = "free_y"
  ) +
  ggplot2::theme_classic(
    base_size = 14,
    base_family = "serif"
  ) +
  ggplot2::theme(
    text = ggplot2::element_text(
      color = "black", 
      face = "bold"
    ),
    axis.text.x = ggplot2::element_text(
      size = 12
    ),
    axis.text.y = ggplot2::element_text(size = 12),
    # axis.ticks.x = ggplot2::element_blank(),
    strip.background = ggplot2::element_rect(
      color = "white"
    ), 
    strip.text = ggplot2::element_text(
      color = "black"
    )
  )

# save patch number distribution on disk -------------------------------------------
ggplot2::ggsave(
  plot = np_dist,
  filename = "output/np-dist.tiff",
  height = 15,
  width = 30,
  units = "cm",
  dpi = 100
)

# Edge density -------------------------------------------
ed_dist <- ed |> 
  ggplot2::ggplot() +
  ggplot2::aes(x = value) +
  ggplot2::geom_histogram(
    fill = "#bdd005",
    color = "black",
    binwidth = 1,
    center = 1/2
  ) +
  ggplot2::labs(
    x = "Densidade de borda",
    y = "Frequência"
  ) +
  ggplot2::facet_wrap(
    facets = ggplot2::vars(
      buffer
    ), 
    scales = "free_y", as.table = TRUE
  ) +
  ggplot2::theme_classic(
    base_size = 14,
    base_family = "serif"
  ) +
  ggplot2::theme(
    text = ggplot2::element_text(
      color = "black", 
      face = "bold"
    ),
    axis.text.x = ggplot2::element_text(
      size = 12
    ),
    axis.text.y = ggplot2::element_text(size = 12),
    # axis.ticks.x = ggplot2::element_blank(),
    strip.background = ggplot2::element_rect(
      color = "white"
    ), 
    strip.text = ggplot2::element_text(
      color = "black"
    )
  )

# save patch number distribution on disk -------------------------------------------
ggplot2::ggsave(
  plot = ed_dist,
  filename = "output/ed-dist.tiff",
  height = 15,
  width = 30,
  units = "cm",
  dpi = 100
)

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