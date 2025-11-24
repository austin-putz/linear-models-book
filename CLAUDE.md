# Linear Models for Animal Breeding and Genetics

## Graduate Course Plan

This will be a Quarto textbook written for graduate students to learn linear models (fixed effects models) through careful explaination and plenty of examples. 

---

## COURSE OVERVIEW

**Target Audience**: Graduate students in Animal Breeding and Genetics
**Prerequisites**: Basic statistics (inference, hypothesis testing, distributions)
**Programming Language**: R (all code examples, solver implementations, and exercises will use R)
**Course Focus**: Building and solving linear model equations from first principles (fixed effects only in this course)
**Duration**: 15 weeks, 2-3 hours per week
**Primary Goal**: Enable students to construct their own least squares solvers and deeply understand the mathematics underlying genetic evaluation and statistical analysis in animal breeding without getting to mixed models
**Format**: All course materials will be written in Quarto (.qmd files) and compiled to HTML for distribution to students

---

## CITATIONS

Citations shall be provided when necessary and use a .bib file with links to the HTML page/link and the DOI clearly noted and double checked. 

Example, provide a citation on the original AIC paper when introduced. 

---

## NOTATION STANDARDS

**Critical**: This notation will be established in Week 1 and maintained consistently throughout all 15 weeks. Any deviations or extensions will be explicitly noted with prominent callout boxes.

### Vector and Matrix Notation
- **y** (or **y**): response/observation vector (lowercase bold)
- **X**: design/incidence matrix (uppercase bold)
- **β**: vector of fixed effects parameters (Greek lowercase bold)
- **b**: vector of estimates (lowercase bold)
- **e**: vector of residuals/errors (lowercase bold)
- **I**: identity matrix (uppercase bold)
- **A**: general matrix (uppercase bold)
- **H**: hat matrix/projection matrix (uppercase bold)
- **C**: contrast matrix (uppercase bold)

### Scalars and Operators
- **σ²**: variance (Greek lowercase with superscript)
- **n**: sample size (scalar, lowercase italic)
- **p**: number of parameters (scalar, lowercase italic)
- **r()**: rank of a matrix
- **tr()**: trace of a matrix
- **()′** or **()ᵀ**: matrix transpose
- **()⁻¹**: matrix inverse
- **()⁻**: generalized inverse (Moore-Penrose or other)

### Statistical Quantities
- **SSE**: sum of squares for error
- **SST**: total sum of squares
- **SSM**: model sum of squares (or SSR for regression)
- **MSE**: mean square error
- **MSM**: mean square model
- **R²**: coefficient of determination
- **df**: degrees of freedom

### Special Notation Extensions
When introducing random effects (Week 14), the following will be added:
- **u**: vector of random effects
- **Z**: incidence matrix for random effects
- **G**: variance-covariance matrix for random effects
- **R**: variance-covariance matrix for residuals

**→ Every time notation changes or extends, include a clearly marked box stating "NOTATION UPDATE" or "NOTATION EXTENSION"**

### Other Standards
- No equation shall be presented without each part of the model or equation described below and the order of such vector or matrix provided, or noted it's a scaler
- Provide information on what needs to be solved for and make that abundantly clear when needed
- use call out boxes as needed throughout for warning, notes, extra information, etc

---

## EXAMPLES

It will be critical to provide plenty of real examples for students and highlight in call out boxes. Each lesson within a chapter is not complete without a real example for students. Both small examples that can be followed and larger (real world) examples as well to cover real topics outside the solving itself. This is the most critical part of the book as just the theory, math, and models will not do! Think carefully and only grab examples from the livestock industry such as swine, broilers, layers, dairy, beef, sheep, and maybe horses and aquaculture. Mainly focus on animal breeding students but livestock examples are all okay even if we have to use nutrition or other disciplines. 

---

## CHAPTER/WEEK STRUCTURE

Each chapter follows this consistent structure:

### 1. Learning Objectives (3-5 bullet points)
Clear statements of what students will be able to do after completing the week

### 2. Conceptual Introduction
Motivation and biological/breeding context for the week's topic

### 3. Mathematical Theory
- Full derivations with all steps shown
- Every symbol defined immediately when introduced
- Assumptions stated explicitly
- Theorems presented with proofs (or proof sketches)

### 4. Small Numerical Example
- Hand-calculable dataset (n = 5-10 observations typically)
- Complete step-by-step arithmetic
- Shows matrix operations explicitly
- Livestock data (realistic but simple)

### 5. Realistic Livestock Application
- Larger dataset (n = 50-100 observations)
- Reflects real breeding/genetics scenarios
- Shows practical interpretation of results
- Connects results to breeding decisions

### 6. Solver Implementation in R
- Code builds X matrix from raw data
- Shows all matrix operations: X′X, X′y, (X′X)⁻¹
- Computes estimates manually: b = (X′X)⁻¹X′y
- Calculates residuals, SSE, variance estimates
- Compares with lm() output to verify correctness
- Heavily commented to explain each step

### 7. Exercises (5-7 problems)
- 2-3 computational problems (small hand calculations)
- 2-3 applied problems (analyze provided datasets)
- 1-2 theoretical problems (prove properties, derive results)
- Full solutions provided in appendix at end of chapter

---

## WEEKLY COURSE OUTLINE

### **Week 1: Course Overview & Computational Foundations**

**Learning Objectives**:
- Understand the philosophy of building equations before using software
- Set up computational environment for matrix operations
- Connect linear models to animal breeding applications (EPDs, breeding values, BLUP preview)
- Perform basic matrix operations in R

**Topics**:
- Why build our own solvers? Understanding vs. black boxes
- Overview of linear models in animal breeding: Best Linear Unbiased Prediction (BLUP), Estimated Progeny Differences (EPDs), yield deviations, genetic evaluation systems
- Computing environment: R/RStudio setup, packages (MASS for ginv)
- Review of matrix operations: addition, multiplication, transpose
- Basic model: sample mean as a linear model

**Small Example**: Calculate the mean milk yield for 5 Holstein cows using matrix notation
- Data: y = [25, 28, 26, 30, 27] kg/day
- Model: yᵢ = μ + eᵢ
- X = [1, 1, 1, 1, 1]′ (5×1 vector of ones)
- β = [μ] (scalar, treated as 1×1)
- Show: X′X = 5, X′y = 136, b = (X′X)⁻¹X′y = 136/5 = 27.2

**R Implementation**: Create vectors and matrices, perform operations, verify results

**Exercises**: Basic matrix operations, computing means via matrix formulation, simple data entry

---

### **Week 2: Linear Algebra Essentials**

**Learning Objectives**:
- Define and compute matrix rank
- Understand linear independence and its implications
- Compute matrix inverses and generalized inverses
- Solve systems of linear equations using matrix methods

**Topics**:
- Vector spaces and linear independence
- Rank of a matrix: r(A) = number of linearly independent rows/columns
- Matrix operations: multiplication, transpose, trace
- Determinants and invertibility
- Regular inverse: A⁻¹ exists iff A is square and full rank
- Generalized inverse: A⁻ satisfies AA⁻A = A (multiple solutions exist)
- Solving Ax = b: unique solutions, infinite solutions, no solution
- Moore-Penrose inverse (brief introduction)
- Eigenvalues and eigenvectors (conceptual introduction for later use)

**Small Example**: Consider a design matrix from beef feedlot study
```
X = [ 1  1  0 ]
    [ 1  1  0 ]
    [ 1  0  1 ]
    [ 1  0  1 ]
```
- Show X′X is singular (not full rank)
- Compute rank: r(X′X) = 2 (less than 3)
- Find a generalized inverse
- Discuss implications for solving normal equations

**Livestock Application**: Analyze structure of design matrix for pig litter size study with 3 breeds but unequal replication

**R Implementation**:
- Matrix rank: qr(X)$rank
- Regular inverse: solve(A)
- Generalized inverse: ginv(A) from MASS package
- Check properties: A %*% ginv(A) %*% A should equal A

**Exercises**: Computing rank, finding inverses, solving systems, determining if systems are consistent

---

### **Week 3: Building the Design Matrix Framework**

**Learning Objectives**:
- Construct design matrices from raw data
- Understand different coding schemes (cell means, reference cell)
- Write the general linear model in matrix form
- State and interpret model assumptions

**Topics**:
- From raw data to matrix representation
- The general linear model: **y = Xβ + e**
- Building X for different effect types:
  - Continuous predictors (regression)
  - Categorical predictors (ANOVA)
  - Mixed models (regression + ANOVA)
- Coding schemes:
  - Cell means model: E(yᵢⱼ) = μᵢ
  - Effects model: E(yᵢⱼ) = μ + αᵢ
  - Reference cell coding
  - Dummy variable coding
- Model assumptions (Gauss-Markov conditions):
  - E(e) = 0 (expected value of errors is zero)
  - Var(e) = σ²I (homoscedasticity and independence)
  - Often add: e ~ N(0, σ²I) for inference

**Small Example**: Litter size for 6 sows across 3 breeds
- Raw data: Yorkshire (11, 12), Landrace (10, 11), Duroc (9, 10)
- Cell means model: X₁ (3 columns, one per breed)
- Effects model: X₂ (3 columns: intercept, Yorkshire effect, Landrace effect)
- Show both X matrices explicitly
- Discuss rank and estimability issues

**Livestock Application**: Construct design matrix for broiler body weight by sex (male/female) with n=20 observations

**R Implementation**:
- Manual construction: cbind(), matrix()
- Using model.matrix() and comparing
- Converting factors to design matrices
- Verifying matrix dimensions

**Exercises**: Build X matrices for various scenarios, identify rank, convert between coding schemes

---

### **Week 4: Simple Linear Regression**

**Learning Objectives**:
- Derive least squares estimates for simple linear regression
- Interpret slope and intercept parameters
- Make predictions and compute residuals
- Understand the geometry of least squares

**Topics**:
- Model: yᵢ = β₀ + β₁xᵢ + eᵢ (i = 1, ..., n)
- Matrix form: y = Xβ + e where X = [1, x] (n×2), β = [β₀, β₁]′
- Normal equations: X′Xb = X′y
- Expanding:
  ```
  [ n      Σxᵢ    ] [ b₀ ]   [ Σyᵢ   ]
  [ Σxᵢ    Σxᵢ²   ] [ b₁ ] = [ Σxᵢyᵢ ]
  ```
- Solution: b = (X′X)⁻¹X′y
- Closed form: b₁ = Σ(xᵢ - x̄)(yᵢ - ȳ) / Σ(xᵢ - x̄)², b₀ = ȳ - b₁x̄
- Fitted values: ŷ = Xb
- Residuals: e = y - ŷ = y - Xb
- Residual sum of squares: SSE = e′e = Σ(yᵢ - ŷᵢ)²

**Small Example**: Broiler weight (y, in kg) vs. age (x, in days)
```
Age (days):    21    28    35    42
Weight (kg):  0.5   0.9   1.4   1.9
```
- Compute X′X, X′y by hand
- Solve for b₀ and b₁
- Calculate fitted values and residuals
- Interpret: growth rate = b₁ kg/day

**Livestock Application**: Regression of dairy cow milk yield on days in milk (lactation curve, linear approximation for first 100 days) using n=30 observations

**R Implementation**:
```r
# Manual calculation
X <- cbind(1, age)
XtX <- t(X) %*% X
Xty <- t(X) %*% weight
b <- solve(XtX) %*% Xty

# Compare with lm()
fit <- lm(weight ~ age)
coef(fit)
```

**Exercises**: Hand calculations for simple regression, interpretation of parameters, prediction, residual analysis

---

### **Week 5: Least Squares Theory**

**Learning Objectives**:
- Understand why least squares estimates are "best"
- Prove properties of LS estimators (unbiasedness, minimum variance)
- Derive distributions of estimates and test statistics
- Compute and interpret variance estimates

**Topics**:
- Least squares criterion: minimize S(β) = (y - Xβ)′(y - Xβ)
- Derivation: ∂S/∂β = -2X′y + 2X′Xβ = 0
- Normal equations: X′Xb = X′y
- Solution (when X full rank): b = (X′X)⁻¹X′y
- **Gauss-Markov Theorem**: Under assumptions E(e) = 0 and Var(e) = σ²I, the LS estimator b is BLUE (Best Linear Unbiased Estimator)
  - Proof of unbiasedness: E(b) = E[(X′X)⁻¹X′y] = β
  - Proof of minimum variance among linear unbiased estimators
  - Var(b) = (X′X)⁻¹σ²
- Projection matrices and geometry:
  - Hat matrix: H = X(X′X)⁻¹X′
  - Properties: H is symmetric, idempotent (H² = H)
  - ŷ = Hy (projection of y onto column space of X)
  - e = (I - H)y (projection onto orthogonal complement)
- Sum of squares decomposition:
  - SST = y′y - nȳ² (total SS)
  - SSM = b′X′y - nȳ² (model SS)
  - SSE = y′y - b′X′y (error SS)
  - SST = SSM + SSE
- Variance estimation: σ̂² = SSE/(n - p) where p = r(X)
- Distribution theory (under normality):
  - y ~ N(Xβ, σ²I)
  - b ~ N(β, (X′X)⁻¹σ²)
  - SSE/σ² ~ χ²(n-p)
  - b and SSE are independent

**Small Example**: Dairy milk fat percentage (y) vs. milk protein percentage (x)
```
Protein %:  3.0   3.2   3.4   3.6   3.8
Fat %:      3.5   3.8   4.0   4.2   4.5
```
- Derive LS estimates showing all matrix operations
- Compute SST, SSM, SSE
- Calculate σ̂²
- Find Var(b) = (X′X)⁻¹σ̂²
- Construct confidence intervals for β₁

**Livestock Application**: Predict lamb weaning weight from birth weight (n=40 lambs), compute full ANOVA table, test significance of regression

**R Implementation**:
```r
# Projection matrices
H <- X %*% solve(t(X) %*% X) %*% t(X)
I_minus_H <- diag(n) - H

# Verify properties
max(abs(H %*% H - H))  # Should be ≈ 0

# Sum of squares
SST <- sum((y - mean(y))^2)
SSE <- t(e) %*% e
SSM <- SST - SSE

# Variance
sigma2_hat <- SSE / (n - p)
var_b <- solve(t(X) %*% X) * c(sigma2_hat)
```

**Exercises**: Prove properties of H, derive Gauss-Markov theorem for simple case, compute confidence intervals, partitioning sums of squares

---

### **Week 6: Multiple Regression**

**Learning Objectives**:
- Extend simple regression to multiple predictors
- Interpret partial regression coefficients
- Understand collinearity and its consequences
- Compare sequential vs. partial sums of squares

**Topics**:
- Model: yᵢ = β₀ + β₁x₁ᵢ + β₂x₂ᵢ + ... + βₚ₋₁xₚ₋₁,ᵢ + eᵢ
- Matrix form: y = Xβ + e where X is n×p
- Normal equations: X′Xb = X′y (now p×p system)
- Interpretation of βⱼ: effect of xⱼ holding all other predictors constant
- Partial vs. marginal effects
- R² and adjusted R²:
  - R² = SSM/SST = 1 - SSE/SST
  - R̄² = 1 - (SSE/(n-p))/(SST/(n-1))
- Sequential (Type I) SS: SS due to x₁ | intercept, then SS due to x₂ | intercept, x₁, etc.
- Partial (Type III) SS: SS due to xⱼ | all other predictors
- F-test for overall regression: F = MSM/MSE ~ F(p-1, n-p)
- t-tests for individual coefficients: t = bⱼ/se(bⱼ) ~ t(n-p)
- Collinearity:
  - Perfect collinearity → X not full rank
  - Near collinearity → large Var(bⱼ), unstable estimates
  - Variance Inflation Factor (VIF): VIFⱼ = 1/(1 - R²ⱼ)

**Small Example**: Predict lamb weaning weight (y, kg) from birth weight (x₁, kg), dam age (x₂, years), and sex (x₃, coded 0=ewe, 1=ram)
```
Observation:   1     2     3     4     5
Birth wt:    4.5   4.0   4.8   4.2   4.6
Dam age:       3     5     4     6     4
Sex:           1     0     1     0     1
Wean wt:      28    24    30    26    29
```
- Construct X matrix (5×4)
- Solve normal equations
- Interpret each coefficient
- Compute R²

**Livestock Application**: Predict beef cattle carcass marbling score from live weight, ribeye area, and backfat thickness (n=50)
- Show correlation matrix to assess collinearity
- Compute VIF for each predictor
- Test significance of full model and individual predictors

**R Implementation**:
```r
# Multiple predictors
X <- cbind(1, birth_wt, dam_age, sex)
b <- solve(t(X) %*% X) %*% t(X) %*% y

# R-squared
y_hat <- X %*% b
SSE <- sum((y - y_hat)^2)
SST <- sum((y - mean(y))^2)
R2 <- 1 - SSE/SST

# VIF calculation
library(car)
vif(lm(y ~ x1 + x2 + x3))
```

**Exercises**: Multiple regression hand calculations, interpreting partial coefficients, computing R², detecting collinearity

---

### **Week 7: Analysis of Variance (One-Way)**

**Learning Objectives**:
- Express ANOVA as a linear model
- Construct design matrices for categorical predictors
- Partition total variation into model and error components
- Conduct F-tests for treatment effects

**Topics**:
- One-way ANOVA setting: compare g groups (e.g., breeds, diets, environments)
- Data: yᵢⱼ = observation j in group i (i = 1, ..., g; j = 1, ..., nᵢ)
- Cell means model: yᵢⱼ = μᵢ + eᵢⱼ
  - X is n×g with indicator variables
  - β = [μ₁, μ₂, ..., μg]′
- Effects model: yᵢⱼ = μ + αᵢ + eᵢⱼ with Σαᵢ = 0
  - X is n×g (overparameterized, not full rank)
  - β = [μ, α₁, ..., αg]′
- Normal equations: X′Xb = X′y
- Sum of squares:
  - SST = ΣΣ(yᵢⱼ - ȳ..)² with df = n-1
  - SS(Treatments) = Σnᵢ(ȳᵢ. - ȳ..)² with df = g-1
  - SSE = ΣΣ(yᵢⱼ - ȳᵢ.)² with df = n-g
  - SST = SS(Treatments) + SSE
- ANOVA table:
  | Source     | df  | SS   | MS  | F        |
  |------------|-----|------|-----|----------|
  | Treatments | g-1 | SSM  | MSM | MSM/MSE  |
  | Error      | n-g | SSE  | MSE |          |
  | Total      | n-1 | SST  |     |          |
- F-test: F = MSM/MSE ~ F(g-1, n-g) under H₀: μ₁ = ... = μg
- Connection to regression: ANOVA is regression with dummy variables

**Small Example**: Compare milk yield (kg/day) across 4 dairy breeds
```
Holstein:    30, 32, 31       (n₁=3)
Jersey:      24, 25, 24       (n₂=3)
Brown Swiss: 28, 29, 27       (n₃=3)
Ayrshire:    26, 27, 26       (n₄=3)
```
- Cell means model: construct X (12×4)
- Compute group means: ȳᵢ.
- Calculate SST, SS(Breeds), SSE
- Form ANOVA table
- Test H₀: all breeds have equal yield

**Livestock Application**: Compare average daily gain (ADG) in beef steers across 5 different feedlot rations (n=10 per ration, total n=50)

**R Implementation**:
```r
# Cell means model
X <- model.matrix(~ breed - 1)  # -1 removes intercept
b <- solve(t(X) %*% X) %*% t(X) %*% y

# ANOVA table
anova(lm(yield ~ breed))

# Manual computation
group_means <- tapply(y, breed, mean)
grand_mean <- mean(y)
SS_between <- sum(table(breed) * (group_means - grand_mean)^2)
SS_within <- sum((y - group_means[breed])^2)
```

**Exercises**: One-way ANOVA hand calculations, construct ANOVA tables, interpret F-tests, compare with t-test (2 groups)

---

### **Week 8: Contrasts and Estimable Functions**

**Learning Objectives**:
- Define and compute linear contrasts
- Determine which functions are estimable
- Test hypotheses involving contrasts
- Construct orthogonal contrasts

**Topics**:
- Linear combinations: ψ = c′β where c is a p×1 vector
- Examples: μ₁ - μ₂, (μ₁ + μ₂)/2 - μ₃, β₁ - 2β₂ + β₃
- Estimable functions: c′β is estimable if c′ = a′X for some vector a
  - Equivalent: c is in the row space of X
  - If X is full rank, all c′β are estimable
  - If X is not full rank, only certain c′β are estimable
- For overparameterized models (not full rank):
  - Individual μ or α parameters may not be estimable
  - But differences (contrasts) are often estimable
- Estimation: If c′β is estimable, c′b is unique (independent of generalized inverse used)
- Variance: Var(c′b) = c′(X′X)⁻c σ² (note: uses generalized inverse)
- Testing: t = (c′b - c′β₀)/se(c′b) ~ t(n-p*)
  where p* = r(X) and se(c′b) = √[c′(X′X)⁻c σ̂²]
- Multiple contrasts: F-test for H₀: Cβ = 0 where C is q×p
  - F = (b′C′[C(X′X)⁻C′]⁻¹Cb/q) / MSE ~ F(q, n-p*)
- Orthogonal contrasts:
  - c₁′β and c₂′β are orthogonal if c₁′(X′X)⁻c₂ = 0
  - For balanced designs: Σcᵢⱼc₂ⱼ = 0
  - Set of g-1 orthogonal contrasts partitions SS(Treatments)

**Small Example**: Four beef breeds, test specific hypotheses
```
Angus (A):      250, 255, 252  (n=3, mean=252.3)
Hereford (H):   248, 251, 250  (n=3, mean=249.7)
Charolais (C):  268, 270, 272  (n=3, mean=270.0)
Simmental (S):  265, 267, 266  (n=3, mean=266.0)
```
- H₁: Angus vs. Hereford (c₁ = [1, -1, 0, 0]′)
- H₂: British breeds vs. Continental breeds (c₂ = [1, 1, -1, -1]′)
- H₃: Charolais vs. Simmental (c₃ = [0, 0, 1, -1]′)
- Verify orthogonality (for balanced case)
- Compute each contrast estimate and standard error
- Test each hypothesis

**Livestock Application**: Egg production across 5 layer strains
- Test: Rhode Island Red vs. Leghorn
- Test: Single Comb vs. Rose Comb (grouping strains)
- Construct set of 4 orthogonal contrasts

**R Implementation**:
```r
# Single contrast
c <- c(1, -1, 0, 0)
estimate <- t(c) %*% b
var_estimate <- t(c) %*% solve(t(X) %*% X) %*% c * sigma2_hat
se_estimate <- sqrt(var_estimate)
t_stat <- estimate / se_estimate

# Multiple contrasts
library(multcomp)
C <- rbind(c1, c2, c3)
# General linear hypothesis test
```

**Exercises**: Identify estimable functions, construct and test contrasts, verify orthogonality, partition SS

---

### **Week 9: Two-Way ANOVA and Factorial Models**

**Learning Objectives**:
- Build models with multiple factors
- Interpret main effects and interactions
- Understand different types of sums of squares (Type I, II, III)
- Test for interactions and interpret interaction plots

**Topics**:
- Two-way ANOVA: two factors (e.g., breed and sex, diet and environment)
- Data: yᵢⱼₖ = observation k in cell (i,j)
- Model: yᵢⱼₖ = μ + αᵢ + βⱼ + (αβ)ᵢⱼ + eᵢⱼₖ
  - αᵢ: main effect of factor A (i = 1, ..., a)
  - βⱼ: main effect of factor B (j = 1, ..., b)
  - (αβ)ᵢⱼ: interaction effect
  - eᵢⱼₖ: random error (k = 1, ..., nᵢⱼ)
- Constraints for identifiability:
  - Σαᵢ = 0, Σβⱼ = 0
  - Σᵢ(αβ)ᵢⱼ = 0 for all j, Σⱼ(αβ)ᵢⱼ = 0 for all i
- Cell means model: yᵢⱼₖ = μᵢⱼ + eᵢⱼₖ (always full rank)
- Interpretation:
  - Main effect: average effect of one factor across levels of other factor
  - Interaction: effect of one factor depends on level of other factor
- Balanced design (nᵢⱼ = n for all cells):
  - SS(A) = bn Σ(ȳᵢ.. - ȳ...)²
  - SS(B) = an Σ(ȳ.ⱼ. - ȳ...)²
  - SS(AB) = n ΣΣ(ȳᵢⱼ. - ȳᵢ.. - ȳ.ⱼ. + ȳ...)²
  - SSE = ΣΣΣ(yᵢⱼₖ - ȳᵢⱼ.)²
- ANOVA table for balanced design:
  | Source       | df        | SS      | MS      | F         |
  |--------------|-----------|---------|---------|-----------|
  | Factor A     | a-1       | SS(A)   | MS(A)   | MS(A)/MSE |
  | Factor B     | b-1       | SS(B)   | MS(B)   | MS(B)/MSE |
  | Interaction  | (a-1)(b-1)| SS(AB)  | MS(AB)  | MS(AB)/MSE|
  | Error        | ab(n-1)   | SSE     | MSE     |           |
  | Total        | abn-1     | SST     |         |           |
- Unbalanced designs:
  - Type I SS: sequential (order matters)
  - Type II SS: each effect after all others except interactions
  - Type III SS: each effect adjusted for all others (most common in unbalanced data)
- Interaction plots: plot cell means, separate lines for levels of one factor

**Small Example**: Swine growth rate (ADG, kg/day) by breed and diet
```
          Diet 1         Diet 2
Yorkshire:  0.85, 0.87    0.92, 0.90
Duroc:      0.82, 0.84    0.95, 0.93
```
- Balanced 2×2 factorial, n=2 per cell
- Cell means: Yorkshire-Diet1=0.86, Yorkshire-Diet2=0.91, Duroc-Diet1=0.83, Duroc-Diet2=0.94
- Compute SS(Breed), SS(Diet), SS(Breed×Diet), SSE
- Test for interaction
- Create interaction plot (lines cross → interaction present)

**Livestock Application**: Broiler breast yield (% of live weight) across 3 strains and 2 sexes (n=8 per cell, total n=48)
- Test main effects and interaction
- If interaction significant, perform simple effects analysis
- Interpret biological meaning of interaction

**R Implementation**:
```r
# Two-way ANOVA
fit <- lm(ADG ~ breed * diet)
anova(fit)  # Type I SS

# Type III SS
library(car)
Anova(fit, type=3)

# Interaction plot
interaction.plot(diet, breed, ADG)

# Cell means
tapply(ADG, list(breed, diet), mean)
```

**Exercises**: Two-way ANOVA hand calculations (balanced), interpret interactions, compare Type I/II/III SS, construct interaction plots

---

### **Week 10: Analysis of Covariance (ANCOVA)**

**Learning Objectives**:
- Combine categorical and continuous predictors in one model
- Adjust treatment means for covariate effects
- Test homogeneity of slopes assumption
- Interpret adjusted means

**Topics**:
- ANCOVA model: yᵢⱼ = μ + αᵢ + β(xᵢⱼ - x̄) + eᵢⱼ
  - αᵢ: treatment effect (i = 1, ..., g)
  - β: regression coefficient (slope)
  - xᵢⱼ: covariate value
  - Centering covariate (xᵢⱼ - x̄) makes αᵢ interpretable as adjusted mean at x̄
- Parallel slopes model: assumes β is same for all groups
- Design matrix: X includes both indicator variables (treatments) and continuous variable (covariate)
- Purposes of ANCOVA:
  1. Increase precision by accounting for covariate variation
  2. Adjust treatment means for differences in covariate
  3. Control for confounding variables
- Adjusted means: ȳᵢ* = ȳᵢ. - b(x̄ᵢ. - x̄..)
  - Removes effect of differences in covariate across groups
- Testing:
  - H₀: all αᵢ equal (no treatment effect) → F-test
  - H₀: β = 0 (covariate not needed) → t-test
- Homogeneity of slopes assumption:
  - H₀: slopes equal for all groups
  - Test by including interaction (treatment × covariate)
  - If rejected, cannot use simple ANCOVA (need separate slopes)
- Sum of squares:
  - SSE(covariate model) < SSE(no covariate) → covariate is useful
  - SS(Treatments | covariate) may differ from SS(Treatments) alone

**Small Example**: Egg production (eggs/month) across 3 layer strains, adjusting for hen body weight
```
Strain 1: y=[24, 26, 25], x=[1.8, 2.0, 1.9] kg
Strain 2: y=[22, 23, 24], x=[1.7, 1.8, 1.9] kg
Strain 3: y=[26, 28, 27], x=[2.1, 2.3, 2.2] kg
```
- Fit ANCOVA model
- Compute adjusted strain means
- Test H₀: no strain effect (after adjusting for weight)
- Test H₀: no weight effect

**Livestock Application**: Compare milk yield across 4 dairy herds, adjusting for days in milk (covariate)
- n=40 cows (10 per herd)
- Show how adjustment changes ranking of herds
- Test homogeneity of slopes (is lactation curve slope same across herds?)

**R Implementation**:
```r
# ANCOVA model (parallel slopes)
fit1 <- lm(egg_production ~ strain + body_weight)
anova(fit1)

# Test homogeneity of slopes
fit2 <- lm(egg_production ~ strain * body_weight)
anova(fit1, fit2)  # Compare models

# Adjusted means
library(emmeans)
emmeans(fit1, "strain")
```

**Exercises**: ANCOVA hand calculations, compute adjusted means, test homogeneity of slopes, interpret results

---

### **Week 11: Model Diagnostics**

**Learning Objectives**:
- Examine residuals to check model assumptions
- Identify outliers and influential observations
- Use diagnostic plots effectively
- Apply transformations when needed

**Topics**:
- Why diagnostics matter: model validity, prediction accuracy, inference
- Residual analysis:
  - Raw residuals: eᵢ = yᵢ - ŷᵢ
  - Standardized residuals: eᵢ* = eᵢ/σ̂
  - Studentized residuals: rᵢ = eᵢ/(σ̂√(1-hᵢᵢ))
  - Studentized deleted residuals: tᵢ (leave-one-out)
- Diagnostic plots:
  1. Residuals vs. fitted values (check linearity, homoscedasticity)
  2. Normal Q-Q plot (check normality)
  3. Scale-location plot (check homoscedasticity)
  4. Residuals vs. leverage (identify influential points)
- Checking assumptions:
  - **Linearity**: residuals vs. fitted should show no pattern
  - **Homoscedasticity**: constant variance (no funnel shape)
  - **Normality**: Q-Q plot should be linear
  - **Independence**: check for patterns (time series, spatial)
- Leverage and influence:
  - Hat values: hᵢᵢ = [H]ᵢᵢ where H = X(X′X)⁻¹X′
  - High leverage: hᵢᵢ > 2p/n or 3p/n
  - Cook's distance: Dᵢ = (eᵢ²/(p·MSE)) · (hᵢᵢ/(1-hᵢᵢ)²)
  - Rule of thumb: Dᵢ > 1 or Dᵢ > 4/n indicates influential point
  - DFFITS: measures change in fitted value when point removed
- Outliers:
  - Observation with large |rᵢ| (typically |rᵢ| > 3)
  - May indicate data error, unusual biology, or model inadequacy
- Transformations:
  - Box-Cox family: y(λ) where λ=1 (none), λ=0.5 (sqrt), λ=0 (log), λ=-1 (inverse)
  - Log transformation: often helps with right-skewed data, stabilizes variance
  - When to transform: systematic patterns in residuals

**Small Example**: Beef carcass marbling score vs. live weight
```
Weight: 500, 520, 540, 560, 580, 600, 620, 640, 850 kg
Marbling: 5, 5.5, 5.8, 6, 6.2, 6.5, 6.7, 7, 6.5
```
- Note last observation: very heavy animal with lower marbling than expected
- Fit linear regression
- Compute residuals and studentized residuals
- Calculate leverage (hᵢᵢ) and Cook's distance
- Identify: last point has high leverage and moderate influence
- Create diagnostic plots

**Livestock Application**: Poultry feed conversion ratio (FCR) vs. age
- n=50 broilers
- Plant outlier (sick bird with very poor FCR)
- Show how outlier affects regression line
- Demonstrate leverage vs. influence distinction

**R Implementation**:
```r
# Fit model
fit <- lm(marbling ~ weight)

# Diagnostic plots
par(mfrow=c(2,2))
plot(fit)  # Produces 4 standard plots

# Individual diagnostics
h <- hatvalues(fit)
r <- rstandard(fit)
D <- cooks.distance(fit)

# Identify influential points
which(D > 4/length(y))
which(abs(r) > 3)

# Leave-one-out
influence.measures(fit)
```

**Exercises**: Compute diagnostic statistics by hand, interpret diagnostic plots, identify problematic observations, apply transformations

---

### **Week 12: Unequal Subclass Numbers & Non-Full Rank Models**

**Learning Objectives**:
- Understand consequences of unbalanced data
- Work with non-full rank design matrices
- Compute and use generalized inverses
- Apply constraints to obtain unique solutions

**Topics**:
- Unbalanced data: unequal nᵢⱼ or missing cells
  - Consequences:
    - X′X may not be full rank
    - Type I, II, III SS differ
    - Loss of orthogonality
    - Individual parameters may not be estimable
- Rank deficiency: r(X′X) < p
  - Normal equations: X′Xb = X′y has infinitely many solutions
  - Any solution satisfies: (X′X)(X′X)⁻(X′y) = (X′y)
  - But individual elements of b are not unique
- Generalized inverse: (X′X)⁻ satisfies (X′X)(X′X)⁻(X′X) = (X′X)
  - Not unique (many possible generalized inverses)
  - One solution: b = (X′X)⁻X′y
  - Different (X′X)⁻ give different b, but Xb is always the same
- Properties of solutions:
  - Estimable functions c′β: estimate c′b is unique regardless of (X′X)⁻ used
  - Non-estimable functions: estimate depends on (X′X)⁻ chosen
- Computing generalized inverses:
  - Moore-Penrose inverse (unique)
  - Set pivot columns, use row reduction
  - In R: ginv() from MASS package
- Constraints to achieve uniqueness:
  - Set-to-zero constraints: set some βⱼ = 0
  - Sum-to-zero constraints: Σβⱼ = 0
  - Choice affects interpretation but not estimable functions
- Estimability criteria:
  - c′β is estimable iff c′ = a′X for some a
  - Equivalent: c is in row space of X
  - For contrasts (Σcⱼ = 0), often estimable even when individual parameters are not

**Small Example**: Sheep fleece weight by breed (unbalanced)
```
Breed 1: 5.2, 5.4, 5.3          (n₁=3)
Breed 2: 4.8, 5.0               (n₂=2)
Breed 3: 5.6                    (n₃=1)
```
- Cell means model: X is 6×3, full rank (always full rank)
- Effects model: X is 6×4, r(X)=3 < 4 (not full rank)
- Normal equations: 4×4 system but r(X′X)=3
- Show that μ, α₁, α₂, α₃ are not uniquely estimable
- Show that α₁ - α₂ IS uniquely estimable
- Apply sum-to-zero constraint: Σαᵢ = 0
- Compute constrained solution

**Livestock Application**: Multi-farm beef cattle dataset with missing breed × farm combinations
- 4 breeds, 5 farms, but not all breeds on all farms
- Some cells have 0 observations
- Show rank deficiency
- Use generalized inverse to solve
- Interpret estimable contrasts (breed differences within farms that have both breeds)

**R Implementation**:
```r
# Non-full rank X'X
XtX <- t(X) %*% X
qr(XtX)$rank  # Less than ncol(X)

# Generalized inverse
library(MASS)
XtX_inv <- ginv(XtX)

# Verify property
max(abs(XtX %*% XtX_inv %*% XtX - XtX))  # Should be ≈ 0

# Solution
b <- XtX_inv %*% t(X) %*% y

# Check estimable function
contrast <- c(0, 1, -1, 0)  # α₁ - α₂
estimate <- t(contrast) %*% b  # Unique regardless of ginv
```

**Exercises**: Identify rank deficiency, compute generalized inverses by hand, apply constraints, determine estimability

---

### **Week 13: Special Topics I**

**Learning Objectives**:
- Develop strategies for handling unbalanced data
- Understand types of generalized inverses
- Apply different constraint systems
- Interpret parameters under various parameterizations

**Topics**:

**A. Strategic approaches to unbalanced data**:
- When is unbalanced data a problem?
  - Confounding of effects
  - Loss of orthogonality
  - Interpretation challenges
- Solutions:
  - Use estimable functions (contrasts)
  - Cell means model (always full rank)
  - Apply appropriate SS type (usually Type III)
  - Consider weighted analysis if heterogeneous variances

**B. Types of generalized inverses**:
- **Reflexive g-inverse**: A⁻ satisfies AA⁻A = A (minimum requirement)
- **Moore-Penrose inverse**: A⁺ satisfies:
  1. AA⁺A = A
  2. A⁺AA⁺ = A⁺
  3. (AA⁺)′ = AA⁺
  4. (A⁺A)′ = A⁺A
  - Unique and symmetric
  - Computed by SVD: A = UDV′ → A⁺ = VD⁺U′
- **Other g-inverses**: many exist for rank-deficient matrices
- For normal equations: any g-inverse gives valid solution for estimable functions

**C. Constraint systems**:
- **Set-to-zero constraints** (reference cell coding):
  - Set α₁ = 0, interpret other αᵢ as deviations from breed 1
  - Common in regression software (lm() default)
- **Sum-to-zero constraints**:
  - Σαᵢ = 0, interpret αᵢ as deviation from overall mean
  - More symmetric, useful for balanced designs
- **Other constraints**:
  - Weighted sum-to-zero: Σnᵢαᵢ = 0
  - Custom constraints based on problem structure
- **Effect on estimates**:
  - Constraints change individual b values
  - Estimable functions c′b remain unchanged
  - Choice is computational/interpretational, not statistical

**D. Interpreting non-estimable parameters**:
- Non-estimable parameters have no unique value
- Solutions depend on constraint/g-inverse chosen
- **Rule**: Only interpret estimable functions
- Example: in μ + αᵢ model:
  - μ is not estimable (confounded with αᵢ)
  - αᵢ - αⱼ is estimable
  - Σwᵢαᵢ with Σwᵢ=0 is estimable

**Large Applied Example**: Genetic evaluation with unequal progeny per sire
- Dairy sire comparison: 10 sires, varying daughters per sire (3 to 25)
- Daughter milk yields
- Model: yᵢⱼ = μ + sireᵢ + eᵢⱼ
- Rank deficiency: r(X′X) = 10 < 11 parameters
- Solutions:
  1. Cell means model: estimate each sire's daughter average directly
  2. Effects model with sum-to-zero constraint
  3. Interpret sire differences (all estimable)
- Compare with simple daughter averages (unadjusted)
- Discuss: preview to BLUP (accounts for unequal information)

**R Implementation**:
```r
# Compare different constraints
# Set-to-zero (lm default)
fit1 <- lm(yield ~ sire)
coef(fit1)  # sire1 is reference (not shown)

# Sum-to-zero (using contrasts)
options(contrasts = c("contr.sum", "contr.poly"))
fit2 <- lm(yield ~ sire)
coef(fit2)  # last sire computed as -sum(others)

# Manual constraint
# Add constraint row to normal equations
# [X'X   C'] [b]   [X'y]
# [C     0 ] [λ] = [c  ]

# Cell means (always unique)
fit3 <- lm(yield ~ sire - 1)
coef(fit3)  # One parameter per sire, all estimable
```

**Exercises**: Apply different constraints and compare, verify estimability, interpret parameters correctly, work with unbalanced genetic evaluation data

---

### **Week 14: Special Topics II**

**Learning Objectives**:
- Model nonlinear trends with polynomial regression
- Apply weighted least squares for heterogeneous variance
- Understand regression through the origin
- Preview mixed model concepts and random effects

**Topics**:

**A. Polynomial regression** (growth curves):
- Model: yᵢ = β₀ + β₁xᵢ + β₂xᵢ² + ... + βₖxᵢᵏ + eᵢ
- Matrix form: X includes 1, x, x², ..., xᵏ
- Choosing polynomial degree:
  - Sequential F-tests
  - Adjusted R²
  - Biological plausibility
- Interpretation: βⱼ is coefficient of xʲ term
- Predictions and fitted curves
- **Application**: Animal growth curves (sigmoid, Gompertz)
  - Weight vs. age
  - Lactation curves (Wood's curve as polynomial approximation)
- Orthogonal polynomials: reduce collinearity

**B. Weighted least squares** (WLS):
- Heteroscedastic errors: Var(eᵢ) = σᵢ² (not constant)
- Weighted model: minimize Σwᵢ(yᵢ - ŷᵢ)²
- Weights: wᵢ = 1/σᵢ² (inversely proportional to variance)
- Normal equations: X′WXb = X′Wy where W = diag(w₁, ..., wₙ)
- Solution: b = (X′WX)⁻¹X′Wy
- Var(b) = (X′WX)⁻¹
- When to use WLS:
  - Known heteroscedasticity
  - Grouped data with different group sizes (weight by nᵢ)
  - Reliability varies across observations
- **Application**: Feed efficiency data
  - Pen averages: variance ∝ 1/n
  - Weight by pen size

**C. Regression through the origin** (no-intercept):
- Model: yᵢ = β₁xᵢ + eᵢ (no β₀)
- Matrix form: X is n×1 (just x column, no intercept)
- Normal equations: (x′x)b₁ = x′y
- Solution: b₁ = Σxᵢyᵢ / Σxᵢ²
- **Warning**: R² not directly comparable to models with intercept
- When to use:
  - Theory dictates y=0 when x=0
  - Example: milk production = 0 when feed = 0 (biological constraint)
- Be cautious: forcing through origin can distort fit

**D. Preview of mixed models**:
- **Fixed effects**: parameters with fixed unknown values (what we've been doing)
- **Random effects**: parameters that are random variables
  - E.g., animal effects in genetic evaluation: aᵢ ~ N(0, σₐ²)
- **Mixed model**: y = Xβ + Zu + e
  - X: design matrix for fixed effects
  - Z: incidence matrix for random effects
  - u: vector of random effects, u ~ N(0, G)
  - e: errors, e ~ N(0, R)
- Why random effects?
  - Large number of levels (e.g., thousands of animals)
  - Levels are sample from population
  - Interested in variance components
  - "Shrinkage" toward population mean (borrowing strength)
- **Henderson's mixed model equations** (MME):
  ```
  [X′R⁻¹X    X′R⁻¹Z  ] [β̂]   [X′R⁻¹y]
  [Z′R⁻¹X  Z′R⁻¹Z+G⁻¹] [û] = [Z′R⁻¹y]
  ```
- Solution gives:
  - β̂: BLUE of fixed effects
  - û: BLUP of random effects (Best Linear Unbiased Prediction)
- **Connection to this course**:
  - MME are like normal equations, but augmented
  - Same matrix algebra tools apply
  - This course provides foundation for mixed models

**Small Example (Polynomial)**: Broiler weight vs. age
```
Age (days):   7    14    21    28    35    42
Weight (g):  150   350   650  1050  1500  1950
```
- Fit linear, quadratic, cubic models
- Compare fits
- Predict weight at day 49

**Small Example (WLS)**: Pen-average ADG, varying pen sizes
```
Pen:     1      2      3      4      5
ADG:    0.85   0.90   0.88   0.87   0.92
n:       8     12      6     10      9
```
- Weight wᵢ = nᵢ
- Compare weighted vs. unweighted regression

**Livestock Application**:
1. **Polynomial**: Dairy cow lactation curve (milk yield vs. days in milk), fit 2nd and 3rd degree polynomials
2. **WLS**: Swine feed efficiency by diet, pen-level data with heterogeneous pen sizes
3. **Mixed model preview**: Simple sire model with 5 sires, show MME structure

**R Implementation**:
```r
# Polynomial regression
fit1 <- lm(weight ~ age)
fit2 <- lm(weight ~ age + I(age^2))
fit3 <- lm(weight ~ age + I(age^2) + I(age^3))
anova(fit1, fit2, fit3)

# Orthogonal polynomials
fit4 <- lm(weight ~ poly(age, degree=3))

# WLS
weights <- pen_size
fit_wls <- lm(ADG ~ diet, weights=weights)

# No-intercept
fit_no_int <- lm(y ~ x - 1)

# Mixed model preview (using lme4)
library(lme4)
fit_mixed <- lmer(yield ~ 1 + (1|sire))
# Show MME structure conceptually
```

**Exercises**: Fit polynomial models and choose degree, apply WLS to heteroscedastic data, understand when to use no-intercept, interpret mixed model output

---

### **Week 15: Capstone Project**

**Learning Objectives**:
- Integrate all course concepts in comprehensive analysis
- Build complete least squares solver from scratch
- Analyze realistic multi-factor livestock dataset
- Communicate statistical results with biological interpretation

**Project Description**: Multi-breed, multi-farm beef cattle performance evaluation

**Dataset**:
- **n = 120 steers**
- **Response**: Average daily gain (ADG, kg/day) during feedlot period
- **Factors**:
  - Breed: Angus, Hereford, Charolais (3 levels)
  - Farm: 5 different feedlots (5 levels)
  - Not all breed × farm combinations present (unbalanced)
- **Covariates**:
  - Initial weight (kg) at feedlot entry
  - Days on feed
- **Structure**: Breed nested within farm (some farms don't have all breeds)

**Tasks**:

**1. Exploratory Data Analysis**
- Summary statistics by breed and farm
- Check for outliers (box plots, scatter plots)
- Examine distributions
- Assess balance (table of n by breed × farm)

**2. Build Design Matrix**
- Construct X matrix for breed + farm + breed×farm model
- Include covariates (centered)
- Determine rank of X′X
- Identify rank deficiency

**3. Fit Multiple Models**
- Model 1: ADG ~ Breed + Farm + Initial Weight
- Model 2: ADG ~ Breed + Farm + Breed×Farm + Initial Weight
- Model 3: Add Days on Feed
- For each model:
  - Solve normal equations manually (show X′X and X′y)
  - Use generalized inverse if needed
  - Compute estimates, fitted values, residuals

**4. Hypothesis Testing**
- Test H₀: no breed effect (after adjusting for farm and covariates)
- Test H₀: no breed × farm interaction
- Specific contrasts:
  - Angus vs. Hereford
  - British breeds (Angus, Hereford) vs. Continental (Charolais)
  - Farm 1 vs. Farm 2 within Angus
- Report F-statistics, p-values

**5. Model Diagnostics**
- Residual plots (vs. fitted, vs. initial weight)
- Normal Q-Q plot
- Identify potential outliers (studentized residuals)
- Compute leverage and Cook's distance
- Check for influential observations

**6. Interpret Results**
- Adjusted breed means (LSMEANS)
- Effect of initial weight on ADG
- Which breed × farm combinations perform best?
- Practical recommendations for feedlot managers

**7. Build Least Squares Solver Package**
Students create R functions:
```r
# Core solver
my_lm <- function(X, y) {
  # Returns: b, se(b), fitted, residuals, SSE, R^2
}

# Contrast testing
my_contrast_test <- function(fit, contrast) {
  # Returns: estimate, se, t-stat, p-value
}

# Diagnostics
my_diagnostics <- function(fit) {
  # Returns: leverage, Cook's D, studentized residuals
}
```

**8. Validation**
- Compare all results with lm() output
- Verify estimates match to high precision
- Confirm F-tests, t-tests, R² values

**9. Written Report**
Students prepare report with:
- Introduction (biological context)
- Methods (models fit, equations)
- Results (tables, figures)
- Discussion (interpretation, limitations)
- Appendix (R code for solver)

**Deliverables**:
1. Commented R script with complete analysis
2. Working least squares solver functions
3. Written report (8-10 pages)
4. Presentation (optional, 15 minutes)

**Evaluation Criteria**:
- Correctness of matrix operations
- Proper handling of rank deficiency
- Accurate hypothesis testing
- Appropriate diagnostics
- Clear interpretation
- Functional solver code
- Professional communication

**Extension (Optional)**:
- Incorporate family structure (sire information) and preview BLUP approach
- Compare LS estimates with BLUP estimates
- Discuss advantages of mixed model for this data structure

---

## APPENDICES

### Appendix A: Notation Quick Reference
Comprehensive table of all symbols used, consistent across all chapters

### Appendix B: Matrix Algebra Review
Summary of key matrix operations and properties

### Appendix C: R Functions Reference
List of R functions used throughout course with examples

### Appendix D: Datasets
Description and access information for all livestock datasets used

### Appendix E: Solutions to Selected Exercises
Detailed solutions to all exercises from all chapters

---

## IMPLEMENTATION NOTES

### Document Format: Quarto
All course materials MUST be written in Quarto (.qmd format) and compiled to HTML:

**Quarto Requirements**:
- Each week's lecture notes: `WeekXX_TopicName.qmd` → compile to HTML
- Each exercise set: `WeekXX_Exercises.qmd` → compile to HTML
- Solutions: `WeekXX_Solutions.qmd` → compile to HTML
- Capstone project description: `Week15_Capstone_Project.qmd` → compile to HTML

**Quarto Features to Use**:
- Code chunks for all R examples (with syntax highlighting)
- LaTeX math rendering for all equations (inline with `$...$` and display with `$$...$$`)
- Callout boxes for important concepts, warnings, and notation updates
- Cross-references for equations, figures, and tables
- Numbered equations with labels for reference
- Tabbed content for comparing different approaches
- Collapsible sections for solutions (using `<details>` tags or Quarto divs)

**HTML Compilation**:
- Generate self-contained HTML files (embed images, CSS)
- Include table of contents with floating sidebar
- Use a clean, readable theme (e.g., `cosmo`, `flatly`, or custom)
- Ensure all mathematical notation renders properly with MathJax/KaTeX
- Code chunks should be formatted with copy button enabled
- Include section numbering for easy reference

### File Structure for Course Materials:
```
/LinearModels/
  /Week01_Overview/
    Week01_CourseOverview.qmd
    Week01_CourseOverview.html (compiled)
    Week01_Exercises.qmd
    Week01_Exercises.html (compiled)
    Week01_Solutions.qmd
    Week01_Solutions.html (compiled)
    code_examples.R (standalone R scripts)
    data/
  /Week02_LinearAlgebra/
    Week02_LinearAlgebra.qmd
    Week02_LinearAlgebra.html (compiled)
    ...
  /Week15_Capstone/
    Week15_Capstone_Project.qmd
    Week15_Capstone_Project.html (compiled)
    data/
  /Appendices/
    AppendixA_Notation.qmd
    AppendixB_MatrixAlgebra.qmd
    (all compiled to HTML)
  /Datasets/
    README.md (data dictionary)
  _quarto.yml (project configuration)
```

### Data Format:
- CSV files for all datasets
- Well-documented (readme with variable descriptions)
- Realistic values based on actual livestock performance
- Some datasets intentionally include outliers or missing values

### Code Style:
- Clear variable names
- Extensive comments
- Step-by-step matrix operations shown explicitly
- Verification against lm() at each stage

### Consistency Checks:
- Symbol glossary reviewed in each chapter
- Cross-references maintained
- Progressive complexity (earlier concepts built upon)
- All livestock examples vetted for biological realism

---

## ESTIMATED TIMELINE

- **Weeks 1-3**: Foundations (overview, linear algebra, design matrices)
- **Weeks 4-6**: Core regression theory (simple, LS theory, multiple)
- **Weeks 7-10**: ANOVA and extensions (one-way, contrasts, two-way, ANCOVA)
- **Week 11**: Diagnostics (mid-course application of all prior concepts)
- **Weeks 12-14**: Advanced topics (rank deficiency, special topics)
- **Week 15**: Integration (capstone project)

Total: **15 weeks × 2 hours = 30 contact hours**
Expected student time: 30 hours lecture + 60 hours homework/project = **90 hours total**

---

This plan provides a comprehensive, rigorous, hands-on course that will enable graduate students to deeply understand linear models from first principles and apply them confidently to animal breeding and genetics problems.
