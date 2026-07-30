# Bayesian Predictive Maintenance

A Bayesian machine learning project that predicts industrial machine failures using sensor data and Bayesian logistic regression in R.

The project demonstrates a complete statistical workflow, including data cleaning, exploratory data analysis, Bayesian model fitting with Stan via `brms`, posterior predictive checking, and model diagnostics.

---

## Project Overview

Unexpected machine failures can lead to costly downtime in manufacturing. This project develops a probabilistic predictive maintenance model using operational sensor measurements to estimate the probability of machine failure.

Unlike traditional logistic regression, the Bayesian approach provides full posterior distributions for model parameters, allowing uncertainty to be quantified alongside predictions.

---

## Features

- Reproducible R workflow
- Bayesian logistic regression using `brms`
- Weakly informative priors
- Posterior predictive checks
- MCMC convergence diagnostics
- Exploratory data analysis
- Publication-quality visualisations

---

## Repository Structure

```
bayesian-predictive-maintenance/
│
├── README.md
├── bayesian-predictive-maintenance.Rproj
├── renv.lock
│
├── R/
│   ├── 01_download_data.R
│   ├── 02_clean_data.R
│   ├── 03_exploration.R
│   ├── 04_fit_model.R
│   └── 05_model_checks.R
│
├── data/
│   ├── raw/
│   └── processed/
│
├── outputs/
│   ├── figures/
│   ├── models/
│   └── tables/
│
└── report/
    ├── analysis.qmd
    └── analysis.html
```

---

## Data

This project uses the **AI4I 2020 Predictive Maintenance Dataset**, containing 10,000 simulated observations of industrial machine operation.

Variables include:

- Air temperature
- Process temperature
- Rotational speed
- Torque
- Tool wear
- Machine failure indicator

Failure mechanism variables were intentionally excluded from modelling to avoid target leakage.

---

## Methodology

The analysis follows a fully reproducible workflow:

1. Import raw data
2. Clean and prepare variables
3. Explore relationships between predictors
4. Standardise continuous variables
5. Fit a Bayesian logistic regression model
6. Assess convergence using MCMC diagnostics
7. Evaluate model fit using posterior predictive checks

---

## Results

The fitted model converged successfully.

Model diagnostics showed:

- All R̂ values equal to 1.00
- Well-mixed MCMC chains
- Good effective sample sizes
- Posterior predictive checks indicating an adequate fit

Among the predictors, torque and rotational speed showed the strongest positive association with machine failure.

---

## Technologies

- R
- tidyverse
- brms
- Stan
- bayesplot
- here

---

## Running the Project

Clone the repository and open the R project.

Install the required packages:

```r
install.packages(c(
  "tidyverse",
  "here",
  "brms",
  "bayesplot"
))
```

Run the scripts in numerical order:

```
01_download_data.R
02_clean_data.R
03_exploration.R
04_fit_model.R
05_model_checks.R
```

---

## Example Outputs

The project produces:

- Failure distribution
- Failure rate by machine type
- Correlation matrix
- Posterior predictive check
- Trace plots and posterior distributions

---

## Author

Tom Maby

Statistician with interests in Bayesian statistics, statistical modelling, R programming and data visualisation.