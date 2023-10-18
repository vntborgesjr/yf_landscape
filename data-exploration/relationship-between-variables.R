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

# Relation between epizooties and forest cover -------------------------------------------
ep_forest_cover <- pland_summarize |> 
  ggplot() +
  aes(
    x = cover_category,
    y = n,
    fill = status
  ) +
  geom_boxplot(
    width = 0.5, 
    na.rm = TRUE
  )  +
  scale_discrete_manual(
    "Status",
    aesthetics = "fill",
    values = c("blue", "red")
  ) + 
  ggplot2::theme_classic(
    base_size = 12,
    base_family = "serif"
  ) +
  labs(
    x = "Cobertura de floresta (%)",
    y = "Número de epizootias"
  ) +
  ggplot2::theme(
    axis.text.x = ggplot2::element_text(size = 10), 
    axis.text.y = ggplot2::element_text(size = 10)
  )

# save epizooties distribution on forest cover gradient on disk -------------------------------------------
# ggsave(
#   plot = ep_forest_cover,
#   filename = "output/ep-forest-cover.tiff",
#   height = 10,
#   width = 15,
#   units = "cm",
#   dpi = 100
# )

# Relation between epizooties and number of patches -------------------------------------------
ep_np <- np_summarize |> 
  ggplot() +
  aes(
    x = np_category,
    y = n,
    fill = status
  ) +
  geom_boxplot(
    width = 0.5, 
    na.rm = TRUE
  )  +
  scale_discrete_manual(
    "Status",
    aesthetics = "fill",
    values = c("blue", "red")
  ) + 
  ggplot2::theme_classic(
    base_size = 12,
    base_family = "serif"
  ) +
  labs(
    x = "Número de manchas (%)",
    y = "Número de epizootias"
  ) +
  ggplot2::theme(
    axis.text.x = ggplot2::element_text(size = 10), 
    axis.text.y = ggplot2::element_text(size = 10)
  )

# save epizooties distribution on number of patches gradient on disk -------------------------------------------
# ggsave(
#   plot = ep_np,
#   filename = "output/ep-np.tiff",
#   height = 10,
#   width = 15,
#   units = "cm",
#   dpi = 100
# )

# Relation between epizooties and edge density -------------------------------------------
ep_ed <- ed_summarize |> 
  ggplot() +
  aes(
    x = ed_category,
    y = n,
    fill = status
  ) +
  geom_boxplot(
    width = 0.5, 
    na.rm = TRUE
  )  +
  scale_discrete_manual(
    "Status",
    aesthetics = "fill",
    values = c("blue", "red")
  ) + 
  ggplot2::theme_classic(
    base_size = 12,
    base_family = "serif"
  ) +
  labs(
    x = "Densidade de borda",
    y = "Número de epizootias"
  ) +
  ggplot2::theme(
    axis.text.x = ggplot2::element_text(size = 10), 
    axis.text.y = ggplot2::element_text(size = 10)
  )

# save epizooties distribution on edge density gradient on disk -------------------------------------------
# ggsave(
#   plot = ep_ed,
#   filename = "output/ep-ed.tiff",
#   height = 10,
#   width = 15,
#   units = "cm",
#   dpi = 100
# )

# rm(list= ls())