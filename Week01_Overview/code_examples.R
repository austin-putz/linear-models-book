# ==============================================================================
# Week 1: Course Overview & Computational Foundations
# R Code Examples
# ==============================================================================

# Load required packages
library(MASS)  # For ginv() generalized inverse

# ==============================================================================
# Example 1: Basic Matrix Operations
# ==============================================================================

# Create vectors and matrices
y <- c(25, 28, 26, 30, 27)  # Observations
X <- matrix(1, nrow = 5, ncol = 1)  # Design matrix (column of ones)

# Display
print("Observation vector y:")
print(y)
print("Design matrix X:")
print(X)

# Matrix transpose
X_transpose <- t(X)
print("X transpose:")
print(X_transpose)

# Matrix multiplication
XtX <- t(X) %*% X  # X'X
Xty <- t(X) %*% y  # X'y

print("X'X (scalar):")
print(XtX)
print("X'y (scalar):")
print(Xty)

# Matrix inverse (for scalar, just 1/value)
XtX_inv <- solve(XtX)
print("(X'X)^-1:")
print(XtX_inv)

# Identity matrix
I5 <- diag(5)
print("5x5 Identity matrix:")
print(I5)

# ==============================================================================
# Example 2: Sample Mean as a Linear Model
# ==============================================================================

# Estimate mean using normal equations
# X'X * b = X'y
# Solve: b = (X'X)^-1 * X'y

b <- solve(XtX) %*% Xty
print("Estimated mean (b):")
print(b)

# Compare to built-in mean function
mean_y <- mean(y)
print("Built-in mean():")
print(mean_y)
print(paste("Match:", all.equal(c(b), mean_y)))

# ==============================================================================
# Example 3: Fitted Values and Residuals
# ==============================================================================

# Fitted values: y_hat = X * b
y_hat <- X %*% b
print("Fitted values:")
print(y_hat)

# Residuals: e = y - y_hat
residuals <- y - y_hat
print("Residuals:")
print(residuals)

# Property: sum of residuals = 0
print(paste("Sum of residuals:", sum(residuals)))

# ==============================================================================
# Example 4: Sum of Squares
# ==============================================================================

# Total sum of squares
y_bar <- mean(y)
SST <- sum((y - y_bar)^2)
print(paste("Total SS:", SST))

# Sum of squares for error
SSE <- sum(residuals^2)
print(paste("Error SS:", SSE))

# Alternative using matrix notation
SSE_matrix <- t(residuals) %*% residuals
print(paste("Error SS (matrix form):", SSE_matrix))

# ==============================================================================
# Example 5: Variance Estimation
# ==============================================================================

# Estimate variance: sigma^2 = SSE / (n - p)
n <- length(y)
p <- 1  # Number of parameters (just mu)
sigma2_hat <- SSE / (n - p)

print(paste("Estimated variance:", sigma2_hat))
print(paste("Estimated std deviation:", sqrt(sigma2_hat)))

# Variance of the mean estimator
var_b <- sigma2_hat / n
se_b <- sqrt(var_b)
print(paste("SE(mean):", se_b))

# ==============================================================================
# Example 6: Custom Function - Estimate Mean
# ==============================================================================

estimate_mean <- function(y) {
  # Estimate population mean using linear model framework
  #
  # Args:
  #   y: Vector of observations
  #
  # Returns:
  #   List containing:
  #     - estimate: Estimated mean
  #     - fitted_values: Vector of fitted values
  #     - residuals: Vector of residuals
  #     - SSE: Sum of squared errors
  #     - sigma2: Estimated variance
  #     - n: Sample size

  # Sample size
  n <- length(y)

  # Design matrix (column of ones)
  X <- matrix(1, nrow = n, ncol = 1)

  # Compute X'X
  XtX <- t(X) %*% X

  # Compute X'y
  Xty <- t(X) %*% y

  # Solve normal equations: b = (X'X)^-1 * X'y
  b <- solve(XtX) %*% Xty

  # Compute fitted values: y_hat = X * b
  y_hat <- X %*% b

  # Compute residuals: e = y - y_hat
  residuals <- y - y_hat

  # Compute SSE
  SSE <- sum(residuals^2)

  # Estimate variance: sigma^2 = SSE / (n - 1)
  sigma2_hat <- SSE / (n - 1)

  # Return results as list
  results <- list(
    estimate = c(b),
    fitted_values = c(y_hat),
    residuals = c(residuals),
    SSE = SSE,
    sigma2 = sigma2_hat,
    n = n
  )

  return(results)
}

# Test the function
test_data <- c(25, 28, 26, 30, 27)
results <- estimate_mean(test_data)

print("=== Results from custom function ===")
print(paste("Estimated mean:", results$estimate))
print(paste("SSE:", results$SSE))
print(paste("Estimated variance:", results$sigma2))

# ==============================================================================
# Example 7: Verify Against lm()
# ==============================================================================

# Fit using lm()
model <- lm(y ~ 1)  # Model with intercept only
print("=== Verification with lm() ===")
summary(model)

# Compare estimates
print("Our estimate:")
print(b)
print("lm() estimate:")
print(coef(model))

# Check if equal (within numerical precision)
print(paste("Estimates match:", all.equal(c(b), coef(model)[[1]])))

# ==============================================================================
# Example 8: Realistic Dairy Example (n=30)
# ==============================================================================

set.seed(123)  # For reproducibility

# Generate realistic milk yield data
n_large <- 30
mu_true <- 27  # True population mean
sigma_true <- 4  # True std deviation

milk_yield <- round(rnorm(n_large, mean = mu_true, sd = sigma_true), 1)

# Ensure no negative values
milk_yield[milk_yield < 0] <- abs(milk_yield[milk_yield < 0])

print("=== Dairy herd example ===")
print("Summary statistics:")
print(summary(milk_yield))

# Estimate using our function
results_large <- estimate_mean(milk_yield)

print(paste("Estimated mean milk yield:", round(results_large$estimate, 2), "kg/day"))
print(paste("Standard error:", round(sqrt(results_large$sigma2/results_large$n), 2)))

# 95% Confidence Interval
df <- n_large - 1
t_crit <- qt(0.975, df)
se_mean <- sqrt(results_large$sigma2 / results_large$n)
CI_lower <- results_large$estimate - t_crit * se_mean
CI_upper <- results_large$estimate + t_crit * se_mean

print(paste("95% CI: [", round(CI_lower, 2), ",", round(CI_upper, 2), "]"))

# ==============================================================================
# Example 9: Visualization
# ==============================================================================

# Histogram with mean marked
hist(milk_yield,
     breaks = 10,
     main = "Distribution of Milk Yield (30 Holstein Cows)",
     xlab = "Milk Yield (kg/day)",
     ylab = "Frequency",
     col = "lightblue",
     border = "white")
abline(v = results_large$estimate, col = "red", lwd = 2, lty = 2)
legend("topright",
       legend = paste("Mean =", round(results_large$estimate, 2)),
       col = "red", lty = 2, lwd = 2)

# Residual plot
plot(results_large$fitted_values, results_large$residuals,
     main = "Residuals vs Fitted Values",
     xlab = "Fitted Values",
     ylab = "Residuals",
     pch = 19,
     col = "blue")
abline(h = 0, col = "red", lty = 2, lwd = 2)

# ==============================================================================
# Example 10: Reading External Data
# ==============================================================================

# Read practice dataset (if available)
data_path <- "data/dairy_milk_practice.csv"

if (file.exists(data_path)) {
  dairy_data <- read.csv(data_path)
  print("=== Practice dataset loaded ===")
  print(head(dairy_data))

  # Analyze
  practice_results <- estimate_mean(dairy_data$milk_yield)
  print(paste("Mean from practice data:", round(practice_results$estimate, 2)))

  # Boxplot
  boxplot(dairy_data$milk_yield,
          main = "Milk Yield from Practice Dataset",
          ylab = "Milk Yield (kg/day)",
          col = "lightgreen")
} else {
  print("Practice dataset not found at: data/dairy_milk_practice.csv")
}

# ==============================================================================
# Example 11: Matrix Properties Demonstration
# ==============================================================================

# Create example matrix
A <- matrix(c(1, 2, 3, 4), nrow = 2, ncol = 2)
print("Matrix A:")
print(A)

# Transpose
A_t <- t(A)
print("A transpose:")
print(A_t)

# A'A (symmetric matrix)
AtA <- t(A) %*% A
print("A'A:")
print(AtA)

# Verify AtA is symmetric
print(paste("A'A is symmetric:", all.equal(AtA, t(AtA))))

# Identity matrix multiplication
I2 <- diag(2)
print("A * I = A:")
print(A %*% I2)
print(paste("Verified:", all.equal(A, A %*% I2)))

# ==============================================================================
# End of Week 1 Code Examples
# ==============================================================================

cat("\n=== All Week 1 examples completed ===\n")
