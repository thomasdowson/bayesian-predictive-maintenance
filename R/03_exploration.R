# ============================================================
# Bayesian Predictive Maintenance
#
# Script: 03_exploration.R
#
# Purpose:
# Explore the cleaned predictive maintenance dataset,
# understand predictor distributions and relationships,
# and produce publication-quality figures for reporting.
#
# Inputs:
#   data/processed/maintenance_clean.rds
#
# Outputs:
#   outputs/figures/
#
# Author:
#   Thomas Dowson
# ============================================================

# Load packages -----------------------------------------------------------

library(tidyverse)
library(here)

theme_set(
  theme_minimal(base_size = 13)
)

# Load cleaned data -------------------------------------------------------

maintenance <- readRDS(
  here(
    "data",
    "processed",
    "maintenance_clean.rds"
  )
)

failure_summary <-
  maintenance |>
  count(machine_failure) |>
  mutate(
    percentage = 100 * n / sum(n)
  )

failure_summary

#FAILURE PLOT
failure_plot <-
  
  ggplot(
    maintenance,
    aes(
      x = factor(machine_failure)
    )
  ) +
  
  geom_bar() +
  
  labs(
    title = "Machine failures are relatively rare",
    subtitle = "Only 3.39% of observations resulted in machine failure",
    x = "Machine failure",
    y = "Number of observations"
  )

failure_plot

#SAVING

ggsave(
  filename = here(
    "outputs",
    "figures",
    "01_failure_distribution.png"
  ),
  plot = failure_plot,
  width = 7,
  height = 5,
  dpi = 300
)

#DO DIFFERENT MACHINE TYPES FAIL AT DIFFERENT RATES?
failure_by_type <-
  maintenance |>
  group_by(type) |>
  summarise(
    observations = n(),
    failures = sum(machine_failure),
    failure_rate = 100 * mean(machine_failure),
    .groups = "drop"
  )

failure_by_type

#PLOT FAILURE TYPE

failure_type_plot <-
  
  ggplot(
    failure_by_type,
    aes(
      x = type,
      y = failure_rate
    )
  ) +
  

geom_col(
  fill = "grey70",
  colour = "black"
) +
  
  geom_text(
    aes(
      label = sprintf("%.1f%%", failure_rate)
    ),
    vjust = -0.5,
    size = 4
  )
failure_type_plot

#SAVE PLOT
ggsave(
  filename = here(
    "outputs",
    "figures",
    "02_failure_rate_by_type.png"
  ),
  plot = failure_type_plot,
  width = 7,
  height = 5,
  dpi = 300
)

#RESHAPE DATA

sensor_data <-
  
  maintenance |>
  
  pivot_longer(
    
    cols = c(
      air_temperature,
      process_temperature,
      rotational_speed,
      torque,
      tool_wear
    ),
    
    names_to = "variable",
    values_to = "value"
  )

#PLOTS

sensor_plot <-
  
  ggplot(
    sensor_data,
    aes(
      x = factor(machine_failure),
      y = value
    )
  ) +
  
  geom_boxplot(
    fill = "grey70",
    colour = "black"
  ) +
  
  facet_wrap(
    ~ variable,
    scales = "free_y"
  ) +
  
  labs(
    title = "Sensor measurements differ between failed and non-failed machines",
    x = "Machine failure",
    y = NULL
  )
sensor_plot
#save

ggsave(
  filename = here(
    "outputs",
    "figures",
    "03_sensor_measurements.png"
  ),
  plot = sensor_plot,
  width = 9,
  height = 6,
  dpi = 300
)



# Correlation between sensor measurements --------------------------------

numeric_data <-
  
  maintenance |>
  
  select(
    air_temperature,
    process_temperature,
    rotational_speed,
    torque,
    tool_wear
  )

correlation_matrix <-
  
  cor(
    numeric_data
  )

correlation_matrix

#heatmap
correlation_plot <-
  
  as.data.frame(
    correlation_matrix
  ) |>
  
  rownames_to_column(
    "Variable_1"
  ) |>
  
  pivot_longer(
    -Variable_1,
    names_to = "Variable_2",
    values_to = "Correlation"
  ) |>
  
  ggplot(
    aes(
      Variable_1,
      Variable_2,
      fill = Correlation
    )
  ) +
  
  geom_tile(
    colour = "white"
  ) +
  
  geom_text(
    aes(
      label = sprintf("%.2f", Correlation)
    ),
    size = 4
  ) +
  
  scale_fill_gradient2(
    low = "steelblue",
    mid = "white",
    high = "firebrick",
    midpoint = 0,
    limits = c(-1, 1)
  ) +
  
  coord_equal() +
  
  labs(
    title = "Correlation between sensor measurements",
    x = NULL,
    y = NULL
  ) +
  
  theme(
    axis.text.x = element_text(
      angle = 45,
      hjust = 1
    )
  )

correlation_plot

#SAVE PLOT
ggsave(
  filename = here(
    "outputs",
    "figures",
    "04_correlation_matrix.png"
  ),
  plot = correlation_plot,
  width = 7,
  height = 6,
  dpi = 300
)
