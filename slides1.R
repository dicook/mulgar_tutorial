# Load libraries
library(readr)
library(tidyr)
library(dplyr)
library(ggplot2)
library(tourr)
library(mulgar)
library(geozoo)
library(detourr)
library(palmerpenguins)
library(GGally)
library(mclust)
library(MASS)
library(randomForest)
library(crosstalk)
library(plotly)
library(viridis)
library(conflicted)

# General R options
options(width = 60, digits=2)

# resolve potential function conflicts
conflicts_prefer(dplyr::filter)
conflicts_prefer(dplyr::select)
conflicts_prefer(dplyr::slice)
conflicts_prefer(palmerpenguins::penguins)
conflicts_prefer(tourr::flea)

# Example data
p_tidy <- penguins |>
  select(species, bill_length_mm:body_mass_g) |>
  rename(bl=bill_length_mm,
         bd=bill_depth_mm,
         fl=flipper_length_mm,
         bm=body_mass_g) |>
  na.omit()
p_tidy_std <- p_tidy |>
  mutate_if(is.numeric, function(x) (x-mean(x))/sd(x))

# Your turn 1
animate_xy(c1)

# Your turn 2
pbmc <- readRDS("data/pbmc_pca_50.rds")
animate_xy(pbmc[,1:9])

