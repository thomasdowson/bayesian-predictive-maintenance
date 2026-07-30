install.packages("brms")

# ============================================================
# Bayesian Predictive Maintenance
#
# Script: 04_fit_model.R
#
# Purpose:
# Fit a Bayesian logistic regression model to estimate the
# probability of machine failure from sensor measurements.
#
# Inputs:
#   data/processed/maintenance_clean.rds
#
# Outputs:
#   outputs/models/brms_model.rds
#
# Author:
#   Thomas Dowson
# ============================================================

# Load packages -----------------------------------------------------------

library(tidyverse)
library(here)
library(brms)
#read in cleaned data
maintenance <- readRDS(
  here(
    "data",
    "processed",
    "maintenance_clean.rds"
  )
)

#scaling units (normalising)

maintenance_model <-
  
  maintenance |>
  
  mutate(
    
    across(
      
      c(
        air_temperature,
        process_temperature,
        rotational_speed,
        torque,
        tool_wear
      ),
      
      scale
      
    )
    
  )
#model

failure_formula <-
  
  bf(
    
    machine_failure ~
      
      air_temperature +
      process_temperature +
      rotational_speed +
      torque +
      tool_wear +
      type
    
  )

#priors
priors <-
  
  c(
    
    prior(
      normal(0, 1),
      class = "b"
    ),
    
    prior(
      normal(0, 2),
      class = "Intercept"
    )
    
  )


# Fit Bayesian logistic regression ----------------------------------------

failure_model <-
  
  brm(
    
    formula = failure_formula,
    
    data = maintenance_model,
    
    family = bernoulli(link = "logit"),
    
    prior = priors,
    
    chains = 4,
    
    iter = 2000,
    
    warmup = 1000,
    
    seed = 123,
    
    cores = parallel::detectCores()
    
  )