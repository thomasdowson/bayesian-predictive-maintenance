# ============================================================
# Bayesian Predictive Maintenance
#
# Script: 01_download_data.R
#
# Purpose:
# Download the AI4I Predictive Maintenance dataset and save
# the original file into data/raw/.
#
# Author: Thomas Dowson
# ============================================================
install.packages("here")
library(tidyverse)
library(here)

# Import raw data ---------------------------------------------------------

raw_data <- read_csv(
  here("data", "raw", "ai4i2020.csv"),
  show_col_types = FALSE
)

# Basic information -------------------------------------------------------

glimpse(raw_data)

summary(raw_data)

# Save an RDS copy --------------------------------------------------------

saveRDS(
  raw_data,
  here("data", "raw", "ai4i2020.rds")
)

cat("\n")
cat("Rows:", nrow(raw_data), "\n")
cat("Columns:", ncol(raw_data), "\n")
cat("Raw dataset successfully imported.\n")

# Inspect the imported data -----------------------------------------------

head(raw_data)

glimpse(raw_data)

summary(raw_data)

names(raw_data)

cat("\nRows:", nrow(raw_data), "\n")
cat("Columns:", ncol(raw_data), "\n")