##%#####################################################################%##
#                                                                         #
####                              Tidy data                            ####
####                        Landscape spatial data                     ####
####                          Vitor Borges-Júnior                      ####
####                        Created on 11 Oct 2023                     ####
#                                                                         #
##%#####################################################################%##

# Objective -------------------------------------------
# The objective of the script is to generate all buffers (100, 200, 400, 
# 800, 1000, 2000, 5000 m) to further extraction of landscape metrics 

# Load data -------------------------------------------
# source(here::here("data/transform-spatial-data.R"))
source(here::here("data/transform-raster-data.R"))

# Data for mapping buffers and crop raster -------------------------------------------
# define buffer sizes
buffer1 <- 100
buffer2 <- 200
buffer3 <- 400
buffer4 <- 800
buffer5 <- 1000
buffer6 <- 2000
buffer7 <- 5000

# define buffers around point and each point an item of a list
# 100 meters
buffer_points1 <- sf::st_buffer(
  point_ep, 
  dist = buffer1
) |> 
  split(seq(nrow(point_ep)))

# name items using animals id
names(buffer_points1) <- point_ep$id

# 200 meters
buffer_points2 <- sf::st_buffer(
  point_ep, 
  dist = buffer2
) |> 
  split(seq(nrow(point_ep)))

# name items using animals id
names(buffer_points2) <- point_ep$id

# 400 meters
buffer_points3 <- sf::st_buffer(
  point_ep, 
  dist = buffer3
) |> 
  split(seq(nrow(point_ep)))

# name items using animals id
names(buffer_points3) <- point_ep$id

# 800 meters
buffer_points4 <- sf::st_buffer(
  point_ep, 
  dist = buffer4
) |> 
  split(seq(nrow(point_ep)))

# name items using animals id
names(buffer_points4) <- point_ep$id

# 1000 meters
buffer_points5 <- sf::st_buffer(
  point_ep, 
  dist = buffer5
) |> 
  split(seq(nrow(point_ep)))

# name items using animals id
names(buffer_points5) <- point_ep$id

# 2000 meters
buffer_points6 <- sf::st_buffer(
  point_ep, 
  dist = buffer6
) |> 
  split(seq(nrow(point_ep)))

# name items using animals id
names(buffer_points6) <- point_ep$id

# 5000 meters
buffer_points7 <- sf::st_buffer(
  point_ep, 
  dist = buffer7
) |> 
  split(seq(nrow(point_ep)))

# name items using animals id
names(buffer_points7) <- point_ep$id

# Crop ans mask land cover layer -------------------------------------------
# crop and mask raster to the same extent of 5000m buffer layer
buffer5000 <- buffer_points7 |> 
  purrr::map(
    \(.x) terra::crop(
      cities_cover2,
      .x
    )
  ) |> 
  purrr::map2(
    buffer_points7,
    \(.x, .y) terra::mask(
      x = .x,
      mask = .y
    )
  )

# crop and mask raster to the same extent of 2000m buffer layer
buffer2000 <- buffer5000 |> 
  purrr::map2(
    buffer_points6,
    \(.x, .y) terra::crop(
      .x,
      .y
    )
  ) |> 
  purrr::map2(
    buffer_points6,
    \(.x, .y) terra::mask(
      x = .x,
      mask = .y
    )
  )

# crop and mask raster to the same extent of 1000m buffer layer
buffer1000 <- buffer2000 |> 
  purrr::map2(
    buffer_points5,
    \(.x, .y) terra::crop(
      .x,
      .y
    )
  ) |> 
  purrr::map2(
    buffer_points5,
    \(.x, .y) terra::mask(
      x = .x,
      mask = .y
    )
  )

# crop and mask raster to the same extent of 800m buffer layer
buffer800 <- buffer1000 |> 
  purrr::map2(
    buffer_points4,
    \(.x, .y) terra::crop(
      .x,
      .y
    )
  ) |> 
  purrr::map2(
    buffer_points4,
    \(.x, .y) terra::mask(
      x = .x,
      mask = .y
    )
  )

# crop and mask raster to the same extent of 200m buffer layer
buffer400 <- buffer800 |> 
  purrr::map2(
    buffer_points3,
    \(.x, .y) terra::crop(
      .x,
      .y
    )
  ) |> 
  purrr::map2(
    buffer_points3,
    \(.x, .y) terra::mask(
      x = .x,
      mask = .y
    )
  )

# crop and mask raster to the same extent of 200m buffer layer
buffer200 <- buffer400 |> 
  purrr::map2(
    buffer_points2,
    \(.x, .y) terra::crop(
      .x,
      .y
    )
  ) |> 
  purrr::map2(
    buffer_points2,
    \(.x, .y) terra::mask(
      x = .x,
      mask = .y
    )
  )

# crop and mask raster to the same extent of 100m buffer layer
buffer100 <- buffer200 |> 
  purrr::map2(
    buffer_points1,
    \(.x, .y) terra::crop(
      .x,
      .y
    )
  ) |> 
  purrr::map2(
    buffer_points1,
    \(.x, .y) terra::mask(
      x = .x,
      mask = .y
    )
  )

# rm(list = ls())