# ==============================================================================
# Week 2: Linear Algebra Essentials
# R Code Examples
# ==============================================================================

library(MASS)  # For ginv()

# ==============================================================================
# Example 1: Computing Matrix Rank
# ==============================================================================

# Full rank matrix
A_full <- matrix(c(1, 2, 3, 4), nrow = 2, ncol = 2)
print("Full rank 2x2 matrix:")
print(A_full)
print(paste("Rank:", qr(A_full)$rank))

# Rank deficient matrix
A_deficient <- matrix(c(1, 2, 2, 4), nrow = 2, ncol = 2)
print("\nRank deficient matrix (col2 = 2*col1):")
print(A_deficient)
print(paste("Rank:", qr(A_deficient)$rank))

# ==============================================================================
# Example 2: Linear Independence
# ==============================================================================

# Independent vectors
v1 <- c(1, 0, 0)
v2 <- c(0, 1, 0)
v3 <- c(0, 0, 1)
V_indep <- cbind(v1, v2, v3)
print("\nLinearly independent vectors:")
print(paste("Rank:", qr(V_indep)$rank))

# Dependent vectors
w1 <- c(1, 2)
w2 <- c(2, 4)  # w2 = 2*w1
W_dep <- cbind(w1, w2)
print("\nLinearly dependent vectors:")
print(paste("Rank:", qr(W_dep)$rank))

# ==============================================================================
# Example 3: Regular Matrix Inverse
# ==============================================================================

A <- matrix(c(4, 3, 3, 2), nrow = 2, ncol = 2)
print("\nMatrix A:")
print(A)

A_inv <- solve(A)
print("A inverse:")
print(A_inv)

# Verify: A * A^-1 = I
I_check <- A %*% A_inv
print("A * A^-1 (identity):")
print(round(I_check, 10))

# ==============================================================================
# Example 4: Generalized Inverse
# ==============================================================================

# Singular matrix
B <- matrix(c(1, 2, 2, 4), nrow = 2, ncol = 2)
print("\nSingular matrix B:")
print(B)
print(paste("Rank:", qr(B)$rank))
print(paste("Determinant:", det(B)))

# Generalized inverse using ginv()
B_ginv <- ginv(B)
print("Generalized inverse B^-:")
print(B_ginv)

# Verify property: B * B^- * B = B
check <- B %*% B_ginv %*% B
print("B * B^- * B (should equal B):")
print(round(check, 10))

# Note: B * B^- is NOT identity
BB_ginv <- B %*% B_ginv
print("B * B^- (NOT identity):")
print(round(BB_ginv, 10))

# ==============================================================================
# Example 5: Design Matrix Rank
# ==============================================================================

# Beef feedlot example: 4 steers, 2 pens
pen <- factor(c(1, 1, 2, 2))
y <- c(120, 125, 135, 140)

# Effects model design matrix
X <- model.matrix(~ pen)
print("\nEffects model design matrix:")
print(X)
print(paste("Columns:", ncol(X)))
print(paste("Rank:", qr(X)$rank))

# X'X is singular
XtX <- t(X) %*% X
print("X'X:")
print(XtX)
print(paste("Det(X'X):", det(XtX)))

# ==============================================================================
# Example 6: Solving with Generalized Inverse
# ==============================================================================

# Solve normal equations using ginv
XtX_ginv <- ginv(XtX)
Xty <- t(X) %*% y
b <- XtX_ginv %*% Xty

print("\nSolution using g-inverse:")
print(b)

# Estimable function: pen difference
pen_means <- tapply(y, pen, mean)
print("Pen means (from data):")
print(pen_means)
print(paste("Pen 2 - Pen 1:", pen_means[2] - pen_means[1]))

# ==============================================================================
# Example 7: Systems of Linear Equations
# ==============================================================================

# Case 1: Unique solution
A1 <- matrix(c(2, 1, 1, 3), nrow = 2, ncol = 2)
b1 <- c(8, 7)
x1 <- solve(A1) %*% b1
print("\nUnique solution:")
print(x1)

# Case 2: Infinite solutions
A2 <- matrix(c(1, 2, 2, 4), nrow = 2, ncol = 2)
b2 <- c(5, 10)
x2 <- ginv(A2) %*% b2  # One particular solution
print("\nOne solution (infinitely many exist):")
print(x2)

# Case 3: No solution (inconsistent)
A3 <- matrix(c(1, 2, 2, 4), nrow = 2, ncol = 2)
b3 <- c(5, 12)  # Inconsistent
x3 <- ginv(A3) %*% b3  # Least squares approximation
print("\nLeast squares solution (system inconsistent):")
print(x3)
print("Ax (doesn't equal b):")
print(A3 %*% x3)

# ==============================================================================
# Example 8: Cell Means vs Effects Model
# ==============================================================================

# Pig litter size data
litter_size <- c(11, 12, 10, 10, 11, 9)
breed <- factor(c(rep("Yorkshire", 3), rep("Landrace", 2), "Duroc"))

# Cell means model (full rank)
X_cell <- model.matrix(~ breed - 1)
print("\nCell means design matrix:")
print(X_cell)
print(paste("Rank:", qr(X_cell)$rank))

XtX_cell <- t(X_cell) %*% X_cell
b_cell <- solve(XtX_cell) %*% (t(X_cell) %*% litter_size)
print("Breed means:")
print(b_cell)

# Effects model (rank deficient)
X_effects <- model.matrix(~ breed)
print("\nEffects model design matrix:")
print(X_effects)
print(paste("Rank:", qr(X_effects)$rank))

XtX_effects <- t(X_effects) %*% X_effects
b_effects <- ginv(XtX_effects) %*% (t(X_effects) %*% litter_size)
print("Effects model solution:")
print(b_effects)

# Estimable contrast is the same
contrast_cell <- b_cell[1] - b_cell[3]
contrast_effects <- b_effects[2] - b_effects[3]
print(paste("\nYorkshire - Duroc (cell means):", round(contrast_cell, 4)))
print(paste("Yorkshire - Duroc (effects):", round(contrast_effects, 4)))

# ==============================================================================
# Example 9: Realistic Sheep Example
# ==============================================================================

set.seed(456)

# Sheep fleece weight: 3 breeds, 2 farms, missing cells
farm <- factor(c(rep("A", 5), rep("B", 4)))
breed <- factor(c(rep("Merino", 3), rep("Suffolk", 2),
                  rep("Suffolk", 2), rep("Romney", 2)))
fleece_weight <- c(4.8, 5.1, 4.9, 5.5, 5.8, 5.2, 5.4, 5.9, 6.1)

print("\nSheep data structure:")
print(table(farm, breed))

# Full model with interaction
X_full <- model.matrix(~ farm * breed)
print(paste("Columns:", ncol(X_full)))
print(paste("Rank:", qr(X_full)$rank))

# Solve with ginv
XtX <- t(X_full) %*% X_full
b_sheep <- ginv(XtX) %*% (t(X_full) %*% fleece_weight)
print("\nParameter estimates:")
print(b_sheep)

# Compare with lm()
model_sheep <- lm(fleece_weight ~ farm * breed)
print("\nlm() coefficients:")
print(coef(model_sheep))

# ==============================================================================
# Example 10: Verification Functions
# ==============================================================================

check_ginv_property <- function(A) {
  # Check if A^- satisfies AA^-A = A
  A_ginv <- ginv(A)
  check <- A %*% A_ginv %*% A
  max_diff <- max(abs(check - A))
  return(list(
    satisfies = max_diff < 1e-10,
    max_difference = max_diff
  ))
}

# Test
test_matrix <- matrix(c(1, 2, 2, 4), nrow = 2, ncol = 2)
result <- check_ginv_property(test_matrix)
print("\nG-inverse verification:")
print(result)

# ==============================================================================
# End of Week 2 Code Examples
# ==============================================================================

cat("\n=== All Week 2 examples completed ===\n")
