# ==============================================================================
# Week 3: Building the Design Matrix Framework - R Code Examples
# ==============================================================================
#
# This script contains all the R code examples from Week 3 lecture notes.
# It demonstrates how to construct design matrices for different types of
# predictors and coding schemes.
#
# Topics covered:
# 1. Continuous predictors (regression)
# 2. Categorical predictors (ANOVA) - cell means and effects models
# 3. Mixed predictors (ANCOVA)
# 4. Manual construction vs. model.matrix()
# 5. Checking design matrix properties
#
# Author: Linear Models Course
# Date: 2025
# ==============================================================================

# ==============================================================================
# Setup
# ==============================================================================

# Clear workspace
rm(list = ls())

# Set working directory to Week03 folder
# setwd("path/to/Week03_DesignMatrix")  # Uncomment and modify as needed

# Load required packages
if (!require("MASS")) install.packages("MASS")
library(MASS)  # For generalized inverse (ginv)

# ==============================================================================
# Example 1: Continuous Predictors (Simple Linear Regression)
# ==============================================================================

cat("\n=== Example 1: Simple Linear Regression ===\n")

# Data: broiler weight (kg) vs. age (days)
age <- c(21, 28, 35, 42)
weight <- c(0.5, 0.9, 1.4, 1.9)

# Design matrix: intercept + age
X <- cbind(1, age)
colnames(X) <- c("Intercept", "Age")

cat("\nDesign Matrix X:\n")
print(X)

cat("\nDimensions:", nrow(X), "observations ×", ncol(X), "parameters\n")

# ==============================================================================
# Example 2: Multiple Continuous Predictors
# ==============================================================================

cat("\n=== Example 2: Multiple Regression ===\n")

# Predict lamb weaning weight from birth weight and dam age
birth_wt <- c(4.5, 4.0, 4.8, 4.2, 4.6)
dam_age <- c(3, 5, 4, 6, 4)
wean_wt <- c(28, 24, 30, 26, 29)

# Design matrix
X_mult <- cbind(1, birth_wt, dam_age)
colnames(X_mult) <- c("Intercept", "BirthWt", "DamAge")

cat("\nDesign Matrix X:\n")
print(X_mult)

cat("\nRank:", qr(X_mult)$rank, "\n")

# ==============================================================================
# Example 3: Cell Means Model (Categorical Predictor)
# ==============================================================================

cat("\n=== Example 3: Cell Means Model ===\n")

# Pig litter size by breed
pig_data <- data.frame(
  breed = c("Yorkshire", "Yorkshire", "Landrace", "Landrace", "Duroc", "Duroc"),
  litter_size = c(11, 12, 10, 11, 9, 10)
)

cat("\nData:\n")
print(pig_data)

# Cell means design matrix using model.matrix()
X_cell <- model.matrix(~ breed - 1, data = pig_data)

cat("\nCell Means Design Matrix:\n")
print(X_cell)

cat("\nRank:", qr(X_cell)$rank, "\n")
cat("Full rank?", qr(X_cell)$rank == ncol(X_cell), "\n")

# Manual construction (alternative method)
n <- nrow(pig_data)
X_cell_manual <- matrix(0, nrow = n, ncol = 3)
X_cell_manual[pig_data$breed == "Duroc", 1] <- 1
X_cell_manual[pig_data$breed == "Landrace", 2] <- 1
X_cell_manual[pig_data$breed == "Yorkshire", 3] <- 1
colnames(X_cell_manual) <- c("Duroc", "Landrace", "Yorkshire")

cat("\nManually Constructed Cell Means Matrix:\n")
print(X_cell_manual)

# Solve normal equations
y <- pig_data$litter_size
XtX <- t(X_cell_manual) %*% X_cell_manual
Xty <- t(X_cell_manual) %*% y

cat("\nX'X:\n")
print(XtX)

cat("\nX'y:\n")
print(Xty)

# Estimates
b_cell <- solve(XtX) %*% Xty
cat("\nParameter estimates (breed means):\n")
print(b_cell)

# Verify: these should equal group means
cat("\nVerify with tapply():\n")
print(tapply(y, pig_data$breed, mean))

# ==============================================================================
# Example 4: Effects Model (Reference Cell Coding)
# ==============================================================================

cat("\n=== Example 4: Effects Model (Reference Cell Coding) ===\n")

# Effects model design matrix
X_effects <- model.matrix(~ breed, data = pig_data)

cat("\nEffects Model Design Matrix:\n")
print(X_effects)

cat("\nReference breed:", levels(factor(pig_data$breed))[1], "\n")

# Fit with lm()
fit_effects <- lm(litter_size ~ breed, data = pig_data)

cat("\nParameter estimates:\n")
print(coef(fit_effects))

# Interpretation
group_means <- tapply(y, pig_data$breed, mean)
cat("\nInterpretation:\n")
cat("Intercept (Duroc mean):", coef(fit_effects)[1], "\n")
cat("Landrace effect (Landrace - Duroc):", coef(fit_effects)[2], "\n")
cat("Yorkshire effect (Yorkshire - Duroc):", coef(fit_effects)[3], "\n")

# ==============================================================================
# Example 5: Comparing Cell Means and Effects Models
# ==============================================================================

cat("\n=== Example 5: Comparing Coding Schemes ===\n")

# Fitted values from both models
fitted_cell <- X_cell_manual %*% b_cell
fitted_effects <- X_effects %*% coef(fit_effects)

cat("Fitted values from cell means model:\n")
print(fitted_cell)

cat("\nFitted values from effects model:\n")
print(fitted_effects)

cat("\nAre fitted values identical?", all.equal(fitted_cell[,1], fitted_effects[,1]), "\n")

# ==============================================================================
# Example 6: ANCOVA (Mixed Predictors)
# ==============================================================================

cat("\n=== Example 6: ANCOVA ===\n")

# Egg production by strain with body weight covariate
egg_data <- data.frame(
  strain = rep(c("Strain1", "Strain2", "Strain3"), each = 3),
  body_weight = c(1.8, 2.0, 1.9, 1.7, 1.8, 1.9, 2.1, 2.3, 2.2),
  eggs = c(24, 26, 25, 22, 23, 24, 26, 28, 27)
)

# Center body weight
egg_data$bw_centered <- egg_data$body_weight - mean(egg_data$body_weight)

# ANCOVA design matrix
X_ancova <- model.matrix(~ strain + bw_centered, data = egg_data)

cat("\nANCOVA Design Matrix:\n")
print(X_ancova)

cat("\nDimensions:", nrow(X_ancova), "×", ncol(X_ancova), "\n")
cat("Rank:", qr(X_ancova)$rank, "\n")

# Fit ANCOVA model
fit_ancova <- lm(eggs ~ strain + bw_centered, data = egg_data)

cat("\nANCOVA Model Coefficients:\n")
print(coef(fit_ancova))

# ==============================================================================
# Example 7: Broiler Body Weight Application
# ==============================================================================

cat("\n=== Example 7: Broiler Body Weight by Sex ===\n")

# Load broiler data
broiler_data <- read.csv("data/broiler_bodyweight_sex.csv")

cat("Data summary:\n")
str(broiler_data)

# Summary statistics
cat("\nSummary by sex:\n")
aggregate(body_weight_kg ~ sex, data = broiler_data, FUN = function(x) {
  c(n = length(x), mean = mean(x), sd = sd(x))
})

# Cell means model
X_cell_broiler <- model.matrix(~ sex - 1, data = broiler_data)
y_broiler <- broiler_data$body_weight_kg

# Solve normal equations
XtX_broiler <- t(X_cell_broiler) %*% X_cell_broiler
Xty_broiler <- t(X_cell_broiler) %*% y_broiler

cat("\nX'X:\n")
print(XtX_broiler)

cat("\nX'y:\n")
print(Xty_broiler)

b_cell_broiler <- solve(XtX_broiler) %*% Xty_broiler
cat("\nEstimated means (kg):\n")
print(b_cell_broiler)

# Compute model fit statistics
fitted_broiler <- X_cell_broiler %*% b_cell_broiler
residuals_broiler <- y_broiler - fitted_broiler
SSE_broiler <- sum(residuals_broiler^2)
SST_broiler <- sum((y_broiler - mean(y_broiler))^2)
R2_broiler <- 1 - SSE_broiler / SST_broiler

cat("\nModel fit:\n")
cat("SSE =", round(SSE_broiler, 4), "\n")
cat("SST =", round(SST_broiler, 4), "\n")
cat("R² =", round(R2_broiler, 4), "\n")

# Effects model using lm()
fit_broiler <- lm(body_weight_kg ~ sex, data = broiler_data)

cat("\nEffects model summary:\n")
print(summary(fit_broiler))

# ==============================================================================
# Example 8: Manual Construction Function
# ==============================================================================

cat("\n=== Example 8: Manual Design Matrix Construction ===\n")

# Simple example
group <- c("A", "A", "B", "B")
y_vals <- c(5, 7, 3, 4)

# Build cell means matrix manually
n <- length(y_vals)
X_manual <- matrix(0, nrow = n, ncol = 2)
X_manual[group == "A", 1] <- 1
X_manual[group == "B", 2] <- 1
colnames(X_manual) <- c("GroupA", "GroupB")

cat("Manually constructed design matrix:\n")
print(X_manual)

# Compare with model.matrix()
example_data <- data.frame(group = group, y = y_vals)
X_auto <- model.matrix(~ group - 1, data = example_data)

cat("\nUsing model.matrix():\n")
print(X_auto)

cat("\nAre they equal?", all.equal(X_manual, X_auto, check.attributes = FALSE), "\n")

# ==============================================================================
# Example 9: Checking Design Matrix Properties
# ==============================================================================

cat("\n=== Example 9: Checking Design Matrix Properties ===\n")

# Function to check design matrix
check_design <- function(X, name = "X") {
  cat("\n=== Design Matrix Check:", name, "===\n")
  cat("Dimensions:", nrow(X), "×", ncol(X), "\n")
  cat("Rank:", qr(X)$rank, "\n")
  cat("Full rank?", qr(X)$rank == ncol(X), "\n")

  if (qr(X)$rank < ncol(X)) {
    cat("WARNING: Matrix is rank deficient!\n")
    cat("Number of parameters:", ncol(X), "\n")
    cat("Effective rank:", qr(X)$rank, "\n")
  }

  # Check condition number (multicollinearity indicator)
  if (qr(X)$rank == ncol(X)) {
    XtX <- t(X) %*% X
    eigenvalues <- eigen(XtX)$values
    condition_number <- sqrt(max(eigenvalues) / min(eigenvalues))
    cat("Condition number:", round(condition_number, 2), "\n")

    if (condition_number > 30) {
      cat("WARNING: High condition number suggests multicollinearity!\n")
    }
  }
}

# Check various matrices
check_design(X_cell_broiler, "Cell Means (Broiler)")
check_design(model.matrix(fit_broiler), "Effects Model (Broiler)")
check_design(X_ancova, "ANCOVA (Egg Production)")

# ==============================================================================
# Example 10: Demonstration of Rank Deficiency
# ==============================================================================

cat("\n=== Example 10: Rank Deficiency Demonstration ===\n")

# Create overparameterized effects model (all breed indicators + intercept)
X_overparameterized <- cbind(
  Intercept = 1,
  Duroc = c(1, 1, 0, 0, 0, 0),
  Landrace = c(0, 0, 1, 1, 0, 0),
  Yorkshire = c(0, 0, 0, 0, 1, 1)
)

cat("Overparameterized design matrix:\n")
print(X_overparameterized)

cat("\nNumber of columns:", ncol(X_overparameterized), "\n")
cat("Rank:", qr(X_overparameterized)$rank, "\n")
cat("Rank deficient:", qr(X_overparameterized)$rank < ncol(X_overparameterized), "\n")

# Show linear dependence: Intercept = Duroc + Landrace + Yorkshire
cat("\nLinear dependence check:\n")
cat("Intercept column:\n")
print(X_overparameterized[, 1])
cat("\nSum of breed columns:\n")
print(X_overparameterized[, 2] + X_overparameterized[, 3] + X_overparameterized[, 4])
cat("\nAre they equal?",
    all.equal(X_overparameterized[, 1],
              X_overparameterized[, 2] + X_overparameterized[, 3] + X_overparameterized[, 4]), "\n")

# Use generalized inverse
XtX_over <- t(X_overparameterized) %*% X_overparameterized
XtX_ginv <- ginv(XtX_over)

cat("\nX'X (singular):\n")
print(XtX_over)

cat("\nGeneralized inverse:\n")
print(XtX_ginv)

# Verify property: X'X * (X'X)^- * X'X = X'X
verification <- XtX_over %*% XtX_ginv %*% XtX_over
cat("\nVerify X'X (X'X)^- X'X = X'X:\n")
cat("Max absolute difference:", max(abs(verification - XtX_over)), "\n")

# ==============================================================================
# End of Code Examples
# ==============================================================================

cat("\n=== All Examples Complete ===\n")
cat("\nKey takeaways:\n")
cat("1. Design matrices connect raw data to linear model equations\n")
cat("2. Cell means models are always full rank\n")
cat("3. Effects models need constraints to be full rank\n")
cat("4. Different coding schemes give same fitted values\n")
cat("5. Always check matrix rank and condition number\n")
