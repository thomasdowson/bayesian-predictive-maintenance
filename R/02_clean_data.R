# ============================================================
# Bayesian Predictive Maintenance
#
# Script: 02_clean_data.R
#
# Purpose:
# Clean the raw AI4I 2020 Predictive Maintenance dataset,
# remove identifier and target-leakage variables, assign
# appropriate data types, and save a modelling-ready dataset.
#
# Inputs:
#   data/raw/ai4i2020.rds
#
# Outputs:
#   data/processed/maintenance_clean.rds
#
# Author:
#   Thomas Dowson
# ============================================================

# Load packages -----------------------------------------------------------

library(tidyverse)
library(here)
library(janitor)

# Read raw data -----------------------------------------------------------

raw_data <- readRDS(
  here("data", "raw", "ai4i2020.rds")
)

# Clean data --------------------------------------------------------------

maintenance_clean <- raw_data |>
  clean_names() |>
  select(
    type,
    air_temperature_k,
    process_temperature_k,
    rotational_speed_rpm,
    torque_nm,
    tool_wear_min,
    machine_failure
  ) |>
  rename(
    air_temperature = air_temperature_k,
    process_temperature = process_temperature_k,
    rotational_speed = rotational_speed_rpm,
    torque = torque_nm,
    tool_wear = tool_wear_min
  ) |>
  mutate(
    type = factor(
      type,
      levels = c("L", "M", "H")
    ),
    machine_failure = as.integer(machine_failure)
  )

# Validation checks -------------------------------------------------------

stopifnot(
  nrow(maintenance_clean) == nrow(raw_data),
  ncol(maintenance_clean) == 7,
  !anyNA(maintenance_clean),
  all(maintenance_clean$machine_failure %in% c(0L, 1L)),
  identical(levels(maintenance_clean$type), c("L", "M", "H"))
)

# Inspect cleaned data ----------------------------------------------------

glimpse(maintenance_clean)

summary(maintenance_clean)

cat("\n")
cat("Rows:", nrow(maintenance_clean), "\n")
cat("Columns:", ncol(maintenance_clean), "\n")
cat(
  "Failure rate:",
  round(mean(maintenance_clean$machine_failure) * 100, 2),
  "%\n"
)

# Save cleaned data -------------------------------------------------------

saveRDS(
  maintenance_clean,
  here(
    "data",
    "processed",
    "maintenance_clean.rds"
  )
)

cat("Clean dataset successfully saved.\n")