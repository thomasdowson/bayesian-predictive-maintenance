# ============================================================
# Bayesian Predictive Maintenance
#
# Script: 05_model_checks.R
#
# Purpose:
# Assess convergence and model fit using posterior predictive
# checks and MCMC diagnostics.
# ============================================================

# Load packages -----------------------------------------------------------

library(tidyverse)
library(here)
library(brms)
library(bayesplot)

theme_set(
  theme_minimal(base_size = 13)
)

# Load fitted model -------------------------------------------------------

failure_model <- readRDS(
  here(
    "outputs",
    "models",
    "failure_model.rds"
  )
)

# Posterior predictive check ----------------------------------------------

png(
  filename = here(
    "outputs",
    "figures",
    "05_posterior_predictive_check.png"
  ),
  width = 900,
  height = 600,
  res = 150
)

pp_check(failure_model)

dev.off()

# Trace plots and posterior distributions ---------------------------------

png(
  filename = here(
    "outputs",
    "figures",
    "06_traceplots_and_posteriors.png"
  ),
  width = 1800,
  height = 2200,
  res = 200
)

plot(failure_model)

dev.off()

# Print model summary -----------------------------------------------------

summary(failure_model)