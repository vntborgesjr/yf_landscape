##%#####################################################################%##
#                                                                         #
####                    Relation between YF, habitat                   ####
####                  amount and habitat configuration                 ####
####                            Dependencies                           ####
####                         Vitor Borges-Júnior                       ####
####                        Created on 11 Oct 2023                     ####
#                                                                         #
##%#####################################################################%##

# Objective -------------------------------------------
# The objective of the script is to load all packages needed to conduct the
# analysis
    
# Load packages -------------------------------------------
library(DiagrammeR)
library(dplyr)
library(forcats)
library(geobr)
library(ggplot2)
library(glmmTMB)
library(here)
library(landscapemetrics)
library(MuMIn)
library(piecewiseSEM)
library(purrr)
library(raster)
library(readxl)
library(sf)
library(sp)
library(terra)
library(tibble)
library(tidyr)
library(tmap) # for static and interactive maps
library(writexl)

# Citation of MapBiomas

# Projeto MapBiomas – Coleção [versão] da Série Anual
# de Mapas de Cobertura e Uso da Terra do Brasil, 
# acessado em [data] através do link: [LINK]

