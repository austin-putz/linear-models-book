#!/bin/bash

# Week 3: Design Matrix
cat > Week03_DesignMatrix/Week03_DesignMatrix.qmd << 'QMDEOF'
# Week 3: Building the Design Matrix Framework {#sec-week03}

## Learning Objectives

By the end of this week, you will be able to:

1. Construct design matrices from raw data
2. Understand different coding schemes (cell means, reference cell)
3. Write the general linear model in matrix form
4. State and interpret model assumptions

## Coming Soon

This chapter is under development. The complete content will include:

- From raw data to matrix representation
- The general linear model: **y = Xβ + e**
- Building X for continuous and categorical predictors
- Coding schemes (cell means, effects, reference cell)
- Model assumptions (Gauss-Markov conditions)
- Small numerical example: Litter size across breeds
- Realistic application: Broiler body weight by sex
- R implementation and exercises

**Next**: [Week 4: Simple Linear Regression](../Week04_SimpleRegression/Week04_SimpleRegression.qmd)
QMDEOF

# Week 4: Simple Regression
cat > Week04_SimpleRegression/Week04_SimpleRegression.qmd << 'QMDEOF'
# Week 4: Simple Linear Regression {#sec-week04}

## Learning Objectives

By the end of this week, you will be able to:

1. Derive least squares estimates for simple linear regression
2. Interpret slope and intercept parameters
3. Make predictions and compute residuals
4. Understand the geometry of least squares

## Coming Soon

This chapter is under development. The complete content will include:

- Model: yᵢ = β₀ + β₁xᵢ + eᵢ
- Normal equations and solutions
- Fitted values and residuals
- Small example: Broiler weight vs age
- Realistic application: Dairy lactation curves
- R implementation and exercises

**Previous**: [Week 3: Design Matrix](../Week03_DesignMatrix/Week03_DesignMatrix.qmd)

**Next**: [Week 5: Least Squares Theory](../Week05_LeastSquares/Week05_LeastSquares.qmd)
QMDEOF

# Week 5: Least Squares Theory
cat > Week05_LeastSquares/Week05_LeastSquares.qmd << 'QMDEOF'
# Week 5: Least Squares Theory {#sec-week05}

## Learning Objectives

By the end of this week, you will be able to:

1. Understand why least squares estimates are "best"
2. Prove properties of LS estimators (unbiasedness, minimum variance)
3. Derive distributions of estimates and test statistics
4. Compute and interpret variance estimates

## Coming Soon

This chapter is under development. The complete content will include:

- Least squares criterion and derivation
- Gauss-Markov Theorem (BLUE properties)
- Projection matrices and geometry
- Sum of squares decomposition
- Variance estimation and distribution theory
- Small example: Dairy fat vs protein
- Realistic application: Lamb weaning weights
- R implementation and exercises

**Previous**: [Week 4: Simple Regression](../Week04_SimpleRegression/Week04_SimpleRegression.qmd)

**Next**: [Week 6: Multiple Regression](../Week06_MultipleRegression/Week06_MultipleRegression.qmd)
QMDEOF

# Week 6: Multiple Regression
cat > Week06_MultipleRegression/Week06_MultipleRegression.qmd << 'QMDEOF'
# Week 6: Multiple Regression {#sec-week06}

## Learning Objectives

By the end of this week, you will be able to:

1. Extend simple regression to multiple predictors
2. Interpret partial regression coefficients
3. Understand collinearity and its consequences
4. Compare sequential vs. partial sums of squares

## Coming Soon

This chapter is under development. The complete content will include:

- Multiple regression model
- Interpretation of partial coefficients
- R² and adjusted R²
- Sequential vs. partial SS
- F-tests and t-tests
- Collinearity and VIF
- Small example: Lamb weaning weight prediction
- Realistic application: Beef carcass marbling
- R implementation and exercises

**Previous**: [Week 5: Least Squares Theory](../Week05_LeastSquares/Week05_LeastSquares.qmd)

**Next**: [Week 7: One-Way ANOVA](../Week07_ANOVA_OneWay/Week07_ANOVA_OneWay.qmd)
QMDEOF

# Continue with remaining weeks...
echo "Created skeleton files for Weeks 3-6"
