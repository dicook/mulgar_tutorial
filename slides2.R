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
set.seed(645)
detour(c1,
       tour_aes(projection = x1:x6)) |>
  tour_path(grand_tour(2), fps = 60,
            max_bases=40) |>
  show_scatter(alpha = 0.7,
               axes = FALSE)

# Your turn 2
set.seed(1042)
p_rf <- randomForest(species~., data=p_tidy_std, ntrees=10)
p_cl <- p_tidy_std |>
  mutate(pspecies = p_rf$predicted) |>
  dplyr::select(bl:bm, species, pspecies) |>
  mutate(sp_jit = jitter(as.numeric(species)),
         psp_jit = jitter(as.numeric(pspecies)))
p_cl_shared <- SharedData$new(p_cl)

detour_plot <- detour(p_cl_shared, tour_aes(
  projection = bl:bm,
  colour = species)) |>
  tour_path(grand_tour(2),
            max_bases=50, fps = 60) |>
  show_scatter(alpha = 0.9, axes = FALSE,
               width = "100%", height = "450px")

conf_mat <- plot_ly(p_cl_shared,
                    x = ~psp_jit,
                    y = ~sp_jit,
                    color = ~species,
                    colors = viridis_pal(option = "D")(3),
                    height = 450) |>
  highlight(on = "plotly_selected",
            off = "plotly_doubleclick") %>%
  add_trace(type = "scatter",
            mode = "markers")

bscols(
  detour_plot, conf_mat,
  widths = c(5, 6)
)
