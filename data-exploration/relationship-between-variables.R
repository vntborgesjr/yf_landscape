##%#########################################%##
#                                             #
####           Data exploration            ####
####    Relationship between variables     ####
####        Vitor Borges-Júnior            ####
####       Created on 12 Oct 2023          ####
#                                             #
##%#########################################%##

# Load data -------------------------------------------
source(here::here("data/transform-landscape-data.R"))

# Load packages -------------------------------------------
source(here::here("R/dependencies.R"))

# Load functions -------------------------------------------
source(here::here("R/xy_categoric_relation.R"))

# Relation between epizooties and forest cover -------------------------------------------
ep_forest_cover <- ep_pland |> 
  xy_categoric_relation(
  x = cover_category,
  y = n,
  fill = status,
  xlab = "Cobertura de floresta (%)",
  ylab = "Número de epizootias"
)


# save epizooties distribution on forest cover gradient on disk -------------------------------------------
# ggplot2::ggsave(
#   plot = ep_forest_cover,
#   filename = "output/ep-forest-cover.tiff",
#   height = 15,
#   width = 30,
#   units = "cm",
#   dpi = 100
# )

# Relation between epizooties and number of patches -------------------------------------------
ep_number_patches <- ep_np |> 
  xy_categoric_relation(
    x = np_category,
    y = n,
    fill = status,
    xlab = "Número de manchas",
    ylab = "Número de epizootias",
    angle = 45,
    hjust = 1,
    vjust = 1
  )

# save epizooties distribution on number of patches gradient on disk -------------------------------------------
# ggplot2::ggsave(
#   plot = ep_number_patches,
#   filename = "output/ep-np.tiff",
#   height = 15,
#   width = 30,
#   units = "cm",
#   dpi = 100
# )

# Relation between epizooties and edge density -------------------------------------------
ep_edge_density <- ep_ed |> 
  xy_categoric_relation(
    x = ed_category,
    y = n,
    fill = status,
    xlab = "Densidade de borda",
    ylab = "Número de epizootias",
    angle = 45,
    hjust = 1,
    vjust = 1
  )

# save epizooties distribution on edge density gradient on disk -------------------------------------------
# ggplot2::ggsave(
#   plot = ep_edge_density,
#   filename = "output/ep-ed.tiff",
#   height = 15,
#   width = 30,
#   units = "cm",
#   dpi = 100
# )

# number of PNH of each genus -------------------------------------------
ep_genus |>
  dplyr::filter(metric == "pland") |>
  ggplot2::ggplot() +
  ggplot2::aes(
    x = genero,
    y = n,
    fill = status
  ) +
  ggplot2::geom_col(
    position = "dodge",
    width = 0.5
  )  +
  ggplot2::facet_wrap(
    ggplot2::vars(buffer),
    scales = "free_y"
  ) +
  ggplot2::scale_discrete_manual(
    "Status",
    aesthetics = "fill",
    values = c("blue", "red")
  ) +
  ggplot2::theme_classic(
    base_size = 14,
    base_family = "serif"
  ) +
  ggplot2::labs(
    x = "Gênero",
    y = "Número de epizootias"
  ) +
  ggplot2::theme(
    axis.text.x = ggplot2::element_text(
      angle = 45,
      size = 12,
      vjust = 0.5
    ),
    axis.text.y = ggplot2::element_text(size = 12)
  )

# rm(list= ls())