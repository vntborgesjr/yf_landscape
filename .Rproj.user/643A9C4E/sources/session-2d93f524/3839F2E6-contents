##%#########################################%##
#                                             #
####              Tidy data                ####
####       Landscape spatial data          ####
####        Vitor Borges-Júnior            ####
####       Created on 11 Oct 2023          ####
#                                             #
##%#########################################%##

# Load data -------------------------------------------
source(here::here("data/transform-spatial-data.R"))
source(here::here("data/transform-raster-data.R"))

# Load packages -------------------------------------------
source(here::here("R/dependencies.R"))

# Data for mapping buffers and crop raster -------------------------------------------
# define buffer sizes
buffer1 <- 40
buffer2 <- 100
buffer3 <- 200
buffer4 <- 400
buffer5 <- 1000
buffer6 <- 2000
buffer7 <- 5000

# define buffers around point and each point an item of a list
# 40 meters
buffer_points1 <- st_buffer(
  point_ep, 
  dist = buffer1
) |> 
  split(seq(nrow(point_ep)))

# name items using animals id
names(buffer_points1) <- point_ep$ID

# 100 meters
buffer_points2 <- st_buffer(
  point_ep, 
  dist = buffer2
) |> 
  split(seq(nrow(point_ep)))

# name items using animals id
names(buffer_points2) <- point_ep$ID

# 200 meters
buffer_points3 <- st_buffer(
  point_ep, 
  dist = buffer3
) |> 
  split(seq(nrow(point_ep)))

# name items using animals id
names(buffer_points3) <- point_ep$ID

# 400 meters
buffer_points4 <- st_buffer(
  point_ep, 
  dist = buffer4
) |> 
  split(seq(nrow(point_ep)))

# name items using animals id
names(buffer_points4) <- point_ep$ID

# 1000 meters
buffer_points5 <- st_buffer(
  point_ep, 
  dist = buffer5
) |> 
  split(seq(nrow(point_ep)))

# name items using animals id
names(buffer_points5) <- point_ep$ID

# 2000 meters
buffer_points6 <- st_buffer(
  point_ep, 
  dist = buffer6
) |> 
  split(seq(nrow(point_ep)))

# name items using animals id
names(buffer_points6) <- point_ep$ID

# 5000 meters
buffer_points7 <- st_buffer(
  point_ep, 
  dist = buffer7
) |> 
  split(seq(nrow(point_ep)))

# name items using animals id
names(buffer_points7) <- point_ep$ID

# Crop ans mask land cover layer -------------------------------------------
# crop and mask raster to the same extent of 5000m buffer layer
buffer5000 <- buffer_points7 |> 
  purrr::map(
    \(.x) terra::crop(
      cities_cover,
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

# crop and mask raster to the same extent of 400m buffer layer
buffer400 <- buffer1000 |> 
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
buffer200 <- buffer400 |> 
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

# crop and mask raster to the same extent of 100m buffer layer
buffer100 <- buffer200 |> 
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

# crop and mask raster to the same extent of 40m buffer layer
buffer40 <- buffer100 |> 
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