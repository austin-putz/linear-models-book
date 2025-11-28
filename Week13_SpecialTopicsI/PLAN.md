# Week 13: Special Topics I - Detailed Plan

## Overview
This week integrates concepts from Weeks 2, 7, 8, and 12 to provide students with practical strategies for handling unbalanced data, understanding generalized inverses deeply, and correctly interpreting non-estimable parameters. The capstone example on sire evaluation provides a bridge to mixed models (Week 14).

---

## 1. Learning Objectives (5 objectives)

After completing this week, students will be able to:

1. Diagnose when unbalanced data causes problems and select appropriate analytical strategies
2. Distinguish between different types of generalized inverses and understand when each is appropriate
3. Apply different constraint systems (set-to-zero, sum-to-zero, custom) and interpret their effects on parameter estimates
4. Identify estimable vs. non-estimable functions and correctly interpret results from rank-deficient models
5. Analyze real genetic evaluation data with unequal information and understand the limitations of fixed-effects least squares

---

## 2. Document Structure

### 2.1 Introduction Section
**Title**: "Making Sense of Messy Data: Practical Strategies for Real-World Linear Models"

**Content**:
- Motivational opening: Real livestock data is rarely balanced
  - Unequal sire progeny numbers in dairy evaluation
  - Missing breed × farm combinations due to management practices
  - Dropped animals due to health issues or data quality
- Preview of four main topics (A, B, C, D)
- Connection to previous weeks:
  - Week 2: Generalized inverses (mathematical foundation)
  - Week 7: Balanced ANOVA (ideal case)
  - Week 8: Estimable functions (theoretical framework)
  - Week 12: Non-full rank models (immediate prerequisite)
- Preview to Week 14: Why we need mixed models (random effects)

**Callout Box 1**:
- Type: Note
- Content: "This week synthesizes concepts from multiple previous weeks. If you need to review rank deficiency, generalized inverses, or estimability, revisit Weeks 2, 8, and 12."

---

### 2.2 Topic A: Strategic Approaches to Unbalanced Data

#### A.1 When is Unbalanced Data a Problem?

**Mathematical Content**:
- Balanced design properties:
  - Orthogonality: X'X is (nearly) diagonal after centering
  - Type I = Type II = Type III SS (all equivalent)
  - Main effects independent of interactions
  - Simple interpretation

- Unbalanced design consequences:
  - Loss of orthogonality: X'X off-diagonal elements non-zero
  - Type I/II/III SS differ (show mathematical reason)
  - Confounding between effects
  - Estimability issues if cells missing

**Numerical Demonstration**:
Small 2×2 factorial example:
- **Balanced case**:
  ```
  Factor A: A1, A2
  Factor B: B1, B2
  Cell counts: n₁₁=5, n₁₂=5, n₂₁=5, n₂₂=5
  ```
  Show X'X structure (orthogonal)

- **Unbalanced case**:
  ```
  Cell counts: n₁₁=10, n₁₂=3, n₂₁=2, n₂₂=8
  ```
  Show X'X structure (non-orthogonal)

- Compute Type I, Type II, Type III SS for both
- Show numerical differences

**Callout Box 2**:
- Type: Important
- Content: "Unbalanced data itself is not always problematic. The issue arises when unbalance creates confounding or rank deficiency. Cell means models are always full rank, regardless of balance."

#### A.2 Strategic Solutions

**Strategy 1: Use Estimable Functions**
- Focus on contrasts rather than individual parameters
- Example: For sire evaluation, estimate sire differences, not absolute sire values
- Show mathematically why contrasts remain estimable

**Strategy 2: Cell Means Model**
- Always full rank: r(X) = number of non-empty cells
- Direct estimation of cell means: μᵢⱼ
- Comparison via contrasts post-hoc
- Trade-off: More parameters, but all estimable

**Strategy 3: Appropriate SS Type**
- Type I (Sequential): Order-dependent, use when order matters theoretically
- Type II: Main effects adjusted for other main effects, not interactions
- Type III (Marginal): Each effect adjusted for all others, most common for unbalanced data
- Show calculation formulas for each type

**Strategy 4: Weighted Analysis**
- When to weight: Heterogeneous variances across groups
- Example: Pen means with different pen sizes
- Show weighted least squares formulation: X'WX b = X'Wy

**Callout Box 3**:
- Type: Warning
- Content: "Type III SS tests can be difficult to interpret with severe unbalance and missing cells. Always examine cell counts before choosing SS type."

#### A.3 Small Numerical Example

**Scenario**: Broiler body weight by strain and sex (unbalanced)

**Data**:
```
          Male              Female
Strain A: 2.1, 2.3, 2.2    1.8, 1.9
Strain B: 2.4, 2.5         1.9, 2.0, 2.1
```

Cell sizes: A-Male (3), A-Female (2), B-Male (2), B-Female (3)

**Analysis Steps**:
1. Construct design matrix for effects model (μ + strain + sex + strain×sex)
2. Show X'X is not diagonal (non-orthogonal)
3. Compute Type I SS (two orders: strain first vs. sex first)
4. Compute Type III SS
5. Show differences between SS types
6. Interpret results using estimable contrasts:
   - Strain A vs B in males: μ_AM - μ_BM
   - Strain A vs B in females: μ_AF - μ_BF
   - Test for interaction: (μ_AM - μ_BM) - (μ_AF - μ_BF)

**R Code**:
- Fit model both ways for Type I SS
- Use `car::Anova(type=3)` for Type III
- Extract and compare SS
- Compute contrasts manually using emmeans

---

### 2.3 Topic B: Types of Generalized Inverses

#### B.1 Review: Why Generalized Inverses?

**Quick Review**:
- Regular inverse A⁻¹: exists only if A is square and full rank
- For rank-deficient X'X (common with categorical predictors), need generalized inverse
- Normal equations X'Xb = X'y have infinitely many solutions
- Any solution b satisfies: Xb is unique (fitted values same), but individual bⱼ differ

#### B.2 Reflexive Generalized Inverse (g-inverse)

**Definition**:
A⁻ is a generalized inverse of A if: **AA⁻A = A**

**Properties**:
- Not unique (infinitely many g-inverses exist)
- Minimum requirement for solving normal equations
- One solution: b = (X'X)⁻X'y

**Mathematical derivation**:
Show that if AA⁻A = A, then b = A⁻X'y is a solution to X'Xb = X'y:
```
X'Xb = X'X(A⁻X'y) = [X'X A⁻ X'X]X'y = X'X X'y  [using AA⁻A = A]
```

**Computing g-inverse by row reduction**:
- Augment [A | I] and row reduce
- When rank deficiency encountered, make arbitrary choices for free variables
- Different choices → different g-inverses

**Small Example**:
```
A = [1  1]
    [1  1]

r(A) = 1 (rank deficient)
```

Find two different g-inverses:
- A⁻₁ = [1  0]
        [0  0]

- A⁻₂ = [0.5  0.5]
        [0.5  0.5]

Verify both satisfy AA⁻A = A

**Callout Box 4**:
- Type: Important
- Content: "For solving normal equations, ANY g-inverse works. The choice matters only for interpretability of individual parameter estimates, not for estimable functions."

#### B.3 Moore-Penrose Inverse (Pseudoinverse)

**Definition**:
A⁺ is the Moore-Penrose inverse if it satisfies all four conditions:
1. **AA⁺A = A** (g-inverse property)
2. **A⁺AA⁺ = A⁺** (reflexive for A⁺)
3. **(AA⁺)' = AA⁺** (AA⁺ is symmetric)
4. **(A⁺A)' = A⁺A** (A⁺A is symmetric)

**Key Property**: **A⁺ is UNIQUE** (only one Moore-Penrose inverse exists for any matrix A)

**Computing via SVD**:
For A = UDV', where:
- U, V are orthogonal matrices
- D is diagonal with singular values σ₁, σ₂, ..., σᵣ > 0, rest zeros

Then: **A⁺ = VD⁺U'**

Where D⁺ has 1/σᵢ on diagonal for non-zero σᵢ, zeros elsewhere

**Properties**:
- Symmetric if A is symmetric
- Gives minimum norm solution: ||b|| is smallest among all solutions
- In R: `MASS::ginv(A)` computes Moore-Penrose inverse

**Small Example**:
Same A as before:
```
A = [1  1]
    [1  1]
```

Compute A⁺ using SVD in R:
- Show singular values
- Construct D⁺
- Show A⁺ = [0.25  0.25]
           [0.25  0.25]
- Verify all 4 properties

**Callout Box 5**:
- Type: Note
- Content: "The Moore-Penrose inverse gives the 'minimum norm' solution - the solution with smallest sum of squares of parameter estimates. This is R's default in `ginv()` and is most commonly used."

#### B.4 Conditional Inverse (with Constraints)

**Concept**: Impose constraints to make system full rank, then use regular inverse

**Example**: Effects model with sum-to-zero constraint
```
Original system (rank deficient):
X'Xb = X'y

Augmented system (full rank):
[X'X  C'] [b]   [X'y]
[C    0 ] [λ] = [c  ]

Where C'b = c represents constraints (e.g., Σαᵢ = 0)
```

**Properties**:
- Solution is unique
- Choice of constraint affects individual bⱼ values
- Estimable functions c'b unchanged by constraint choice

**Comparison Table**:

| Type | Uniqueness | Computation | Use Case |
|------|------------|-------------|----------|
| Reflexive g-inverse | Many exist | Row reduction | Quick solution, don't care about individual parameters |
| Moore-Penrose | Unique | SVD | Prefer unique solution, `ginv()` default |
| Conditional | Unique (for given constraints) | Augmented system | Want specific interpretation (e.g., sum-to-zero) |

#### B.5 Numerical Comparison Example

**Data**: One-way ANOVA, 3 groups, unequal n
```
Group 1: 10, 12, 11       (n=3, mean=11)
Group 2: 14, 15           (n=2, mean=14.5)
Group 3: 16, 17, 18, 19   (n=4, mean=17.5)
```

**Effects model**: yᵢⱼ = μ + αᵢ + eᵢⱼ

**Compare solutions using**:
1. Moore-Penrose inverse (R's `ginv()`)
2. Sum-to-zero constraint: Σαᵢ = 0
3. Set-to-zero constraint: α₁ = 0 (lm() default)

**Show**:
- Three different sets of (μ, α₁, α₂, α₃) estimates
- All give same fitted values: ŷᵢⱼ = ȳᵢ.
- Contrast α₂ - α₁ is identical in all three
- Interpretation differs for each parameterization

**R Code**:
```r
# Moore-Penrose
library(MASS)
b_mp <- ginv(XtX) %*% Xty

# Sum-to-zero
options(contrasts = c("contr.sum", "contr.poly"))
fit_sum <- lm(y ~ group)

# Set-to-zero (default)
options(contrasts = c("contr.treatment", "contr.poly"))
fit_set <- lm(y ~ group)

# Compare estimates
# Compare fitted values (should be identical)
# Compare contrast estimates (should be identical)
```

---

### 2.4 Topic C: Constraint Systems

#### C.1 Set-to-Zero Constraints (Reference Cell Coding)

**Formulation**: Set α₁ = 0 (first level is reference)

**Model becomes**:
- Group 1: E(y₁ⱼ) = μ
- Group 2: E(y₂ⱼ) = μ + α₂
- Group 3: E(y₃ⱼ) = μ + α₃

**Interpretation**:
- μ = mean of reference group
- αᵢ = difference between group i and reference group
- This is R's `lm()` default with `contr.treatment`

**Design Matrix**:
```
     μ   α₂  α₃
    [1   0   0]  <- observation from group 1
    [1   1   0]  <- observation from group 2
    [1   0   1]  <- observation from group 3
```

**Estimable Functions**:
- μ (mean of group 1): estimable
- α₂ (group 2 vs group 1): estimable
- α₃ (group 3 vs group 1): estimable
- All pairwise comparisons: estimable via linear combinations

**When to Use**:
- Clear reference/control group exists
- Want to express all effects relative to control
- Common in experimental designs with placebo/control

**Callout Box 6**:
- Type: Note
- Content: "Set-to-zero is natural when you have a clear control or reference group. In animal breeding, this might be a base breed or standard management practice."

#### C.2 Sum-to-Zero Constraints

**Formulation**: Σαᵢ = 0 or Σᵢnᵢαᵢ = 0 (weighted)

**Model remains**: E(yᵢⱼ) = μ + αᵢ, but with constraint

**Interpretation**:
- μ = overall mean (grand mean)
- αᵢ = deviation of group i from grand mean
- More symmetric: no group is "special"

**Design Matrix** (using effect coding):
```
     μ   α₁  α₂
    [1   1   0]  <- group 1
    [1   0   1]  <- group 2
    [1  -1  -1]  <- group 3 (coded as -(others) so sum = 0)
```

**Implementation in R**:
```r
options(contrasts = c("contr.sum", "contr.poly"))
```

**When to Use**:
- No natural reference group
- Want symmetric interpretation
- Balanced designs (classical ANOVA approach)
- Comparing to overall average makes sense

**Weighted Sum-to-Zero**:
For unbalanced data, sometimes use: **Σᵢnᵢαᵢ = 0**

Then μ is weighted mean, αᵢ weighted deviations

#### C.3 Custom Constraints

**Example 1: Baseline Constraint**
Force first and last group to average zero:
```
α₁ + αg = 0
```

**Example 2: Anchoring to External Standard**
If external reference value known (e.g., breed standard):
```
μ + α₁ = known_value
```

**Example 3: Structural Constraint**
Enforce biological relationships (e.g., heterosis constraint):
```
α₃ = (α₁ + α₂)/2 + h  (crossbred = midparent + heterosis)
```

**Implementation**:
Augment normal equations:
```
[X'X  C'] [b]   [X'y]
[C    0 ] [λ] = [c  ]
```

#### C.4 Effect of Constraints on Estimates

**Key Principle**:
- **Estimable functions remain unchanged**
- **Non-estimable functions change** with constraint choice

**Demonstration with 3-group example**:

| Parameter | Set-to-Zero | Sum-to-Zero | Cell Means |
|-----------|-------------|-------------|------------|
| μ | 11.0 | 14.33 | Not in model |
| α₁ | 0 (fixed) | -3.33 | μ₁ = 11.0 |
| α₂ | 3.5 | 0.17 | μ₂ = 14.5 |
| α₃ | 6.5 | 3.17 | μ₃ = 17.5 |
| **α₂ - α₁** | **3.5** | **3.5** | **3.5** |
| **α₃ - α₂** | **3.0** | **3.0** | **3.0** |

Note: Contrasts (bold) are identical across parameterizations!

**Callout Box 7**:
- Type: Warning
- Content: "Never interpret individual parameter estimates (μ, αᵢ) from rank-deficient models! Only interpret estimable functions (contrasts). The constraint choice is arbitrary and doesn't change biological conclusions."

#### C.5 Small Numerical Example: Sow Litter Size by Parity

**Data**:
```
Parity 1: 10, 11, 10, 12    (n=4, mean=10.75)
Parity 2: 11, 12, 13        (n=3, mean=12.00)
Parity 3: 12, 13            (n=2, mean=12.50)
```

**Tasks**:
1. Fit effects model: yᵢⱼ = μ + parityᵢ + eᵢⱼ
2. Apply three constraint systems:
   - Set-to-zero: parity₁ = 0
   - Sum-to-zero: Σαᵢ = 0
   - Weighted sum-to-zero: Σnᵢαᵢ = 0
3. Compare parameter estimates
4. Show contrasts are identical:
   - Parity 2 vs 1
   - Parity 3 vs 1
   - Parity 3 vs 2
5. Test H₀: no parity effect (F-test) - same for all constraints

**R Code**: Show all three fits with detailed output

---

### 2.5 Topic D: Interpreting Non-Estimable Parameters

#### D.1 What Makes a Function Estimable?

**Mathematical Definition** (review from Week 8):

c'β is estimable if and only if:
- c' = a'X for some vector a
- Equivalently: c is in the row space of X
- Equivalently: c = (X'X)g X'X for some g-inverse and this holds for ALL g-inverses

**Practical Test**:
If c'b is the same for ALL possible g-inverse choices, then c'β is estimable

**Why It Matters**:
- Estimable functions have biological meaning (observable from data)
- Non-estimable functions are artifacts of parameterization

#### D.2 Common Estimable Functions

**For One-Way ANOVA** (μ + αᵢ model):

| Function | Estimable? | Biological Meaning |
|----------|------------|-------------------|
| μ | ❌ No | Confounded with αᵢ |
| αᵢ | ❌ No | Confounded with μ |
| μ + αᵢ | ✅ Yes | Group i mean |
| αᵢ - αⱼ | ✅ Yes | Difference between groups |
| Σwᵢαᵢ where Σwᵢ=0 | ✅ Yes | Contrast |

**For Two-Way ANOVA** (μ + αᵢ + βⱼ + (αβ)ᵢⱼ):

| Function | Estimable? | Comment |
|----------|------------|---------|
| μ + αᵢ + βⱼ + (αβ)ᵢⱼ | ✅ Yes | Cell mean (if cell exists) |
| αᵢ - αᵢ' | ✅ Yes (if balanced or other conditions) | Main effect contrast |
| (αβ)ᵢⱼ - (αβ)ᵢ'ⱼ - (αβ)ᵢⱼ' + (αβ)ᵢ'ⱼ' | ✅ Yes | Interaction contrast |

#### D.3 Testing Estimability in R

**Method 1: Compare across g-inverses**
```r
# Compute two different g-inverses
ginv1 <- ginv(XtX)  # Moore-Penrose
ginv2 <- custom_ginv(XtX)  # Custom g-inverse

b1 <- ginv1 %*% Xty
b2 <- ginv2 %*% Xty

# Test contrast
contrast <- c(0, 1, -1, 0)  # α₂ - α₃
est1 <- t(contrast) %*% b1
est2 <- t(contrast) %*% b2

if (abs(est1 - est2) < 1e-10) {
  print("Estimable!")
} else {
  print("Not estimable")
}
```

**Method 2: Use estimability package**
```r
library(estimability)
is.estble(contrast, X)
```

**Method 3: Algebraic check**
Verify c is in row space of X'X

#### D.4 Reporting Results from Rank-Deficient Models

**DO**:
✅ Report estimable contrasts with SEs and p-values
✅ Report adjusted means (μ + αᵢ are estimable)
✅ Report fitted values and residuals
✅ Report model fit statistics (R², F-test, SSE)
✅ State clearly which constraint was used (for reproducibility)

**DON'T**:
❌ Interpret individual α parameters as if meaningful
❌ Report α SE without noting non-estimability
❌ Compare α values across studies using different constraints
❌ Make biological conclusions based on α magnitudes

**Example Report Statement**:
"Using a sum-to-zero constraint, breed effects were significant (F₂,₄₇=12.3, p<0.001). Breed A differed from Breed B by 3.5 kg (SE=0.8, p<0.001), corresponding to a 25% increase in weaning weight. Individual breed parameters (α₁, α₂, α₃) are not uniquely defined and depend on constraint choice; only contrasts are biologically interpretable."

**Callout Box 8**:
- Type: Important
- Content: "In your thesis, dissertation, or publication: ALWAYS report which constraint system you used, but ONLY interpret estimable functions. Reviewers will check this!"

---

### 2.6 Large Realistic Example: Sire Evaluation with Unequal Progeny

This is the capstone example bringing together all concepts A-D.

#### Background

**Scenario**: Dairy sire comparison study
- 10 Holstein sires (randomly sampled from AI stud)
- Varying daughter numbers: range 3 to 25 per sire
- Response: 305-day milk yield (kg)
- Total: n = 135 daughters

**Biological Context**:
- Genetic evaluation goal: identify superior sires
- Unequal progeny common in dairy: popular sires have more daughters
- Fixed effects model (LS) vs. mixed model (BLUP) comparison
- Motivates need for Week 14 (mixed models)

**Data Structure**:
```
Sire | n daughters | Mean yield | SD
-----|-------------|------------|----
1    | 3           | 8500       | 850
2    | 8           | 9200       | 920
3    | 15          | 8950       | 780
4    | 5           | 7800       | 940
5    | 25          | 9100       | 890
6    | 12          | 8700       | 810
7    | 18          | 9300       | 750
8    | 7           | 8400       | 960
9    | 20          | 9000       | 800
10   | 22          | 8850       | 820
```

#### Model

**Fixed effects model**: yᵢⱼ = μ + sireᵢ + eᵢⱼ

Where:
- yᵢⱼ = 305-day milk yield for daughter j of sire i
- μ = overall mean (not estimable)
- sireᵢ = effect of sire i (not estimable individually)
- eᵢⱼ ~ N(0, σ²) i.i.d.

**Rank Deficiency**:
- 11 parameters (μ + 10 sires)
- r(X) = 10 (rank deficient by 1)
- Infinite solutions exist

#### Analysis Steps

**Step 1: Exploratory Analysis**
- Summary statistics by sire (means, SD, n)
- Box plots of yield by sire
- Check for outliers
- Assess: Is variation between-sire > within-sire?

**Step 2: Three Modeling Approaches**

**Approach 1: Cell Means Model** (always full rank)
```
yᵢⱼ = μᵢ + eᵢⱼ
```
- 10 parameters, r(X) = 10 (full rank)
- μᵢ = mean of sire i (all estimable)
- Solution: μ̂ᵢ = ȳᵢ. (simple daughter average)
- Variance: Var(μ̂ᵢ) = σ²/nᵢ (depends on nᵢ!)
- Problem: Unequal information → unequal precision

**Approach 2: Effects Model with Sum-to-Zero**
```
yᵢⱼ = μ + sireᵢ + eᵢⱼ with Σᵢnᵢsireᵢ = 0
```
- μ̂ = weighted overall mean
- sireᵢ̂ = deviation from weighted mean
- Still LS estimates, same fitted values as Approach 1

**Approach 3: Effects Model with Set-to-Zero**
```
yᵢⱼ = μ + sireᵢ + eᵢⱼ with sire₁ = 0
```
- μ̂ = mean of sire 1 (reference)
- sireᵢ̂ = difference from sire 1
- R's `lm()` default

**Step 3: Compute Estimates for All Three Approaches**

Show full calculations:
- Design matrix X for each
- Normal equations X'X b = X'y
- Solutions using appropriate g-inverse or constraint
- Compare: Are estimable contrasts identical? (Yes!)

**Step 4: Hypothesis Testing**

**Test 1: Overall sire effect**
H₀: sire₁ = sire₂ = ... = sire₁₀ (all equal)

F = MS(Sire) / MSE ~ F(9, 125)

This test is the same regardless of constraint!

**Test 2: Specific contrasts**
- Sire 7 vs Sire 4 (highest vs lowest mean)
- Top 3 sires vs Bottom 3 sires
- Sire 5 (most progeny) vs others

Show SE calculations: SE(sireᵢ - sireⱼ) = σ̂√(1/nᵢ + 1/nⱼ)

Note: SE depends on progeny numbers!

**Step 5: Adjusted Sire Means (LSMEANS)**

Compute μ + sireᵢ for each sire (estimable!)

Show ranking:
1. Sire 7: 9300 kg
2. Sire 2: 9200 kg
3. Sire 5: 9100 kg
...
10. Sire 4: 7800 kg

**Step 6: Confidence Intervals**

For each sire mean:
CI = (μ + sireᵢ) ± t_{0.025, 125} × SE

Where SE = σ̂/√nᵢ

Note: Sire 5 (n=25) has narrower CI than Sire 1 (n=3)

**Step 7: Limitations of Fixed Effects Approach**

Discuss problems:
1. **Unequal precision**: Small progeny groups have large SE
   - Sire 1 (n=3): SE = 570 kg
   - Sire 5 (n=25): SE = 198 kg

2. **No shrinkage**: Extreme estimates for small groups not pulled toward mean
   - If Sire 1 (n=3) happens to have 3 high daughters → estimate too high
   - No borrowing of information across sires

3. **Selection bias**: Popular sires (more progeny) may not be random
   - Confounds genetic merit with mating decisions

4. **No heritability consideration**: Treats all variation as genetic
   - Ignores that only ~30% of variation is genetic in dairy

**Step 8: Preview to Mixed Models (BLUP)**

Briefly show:
- Mixed model treats sire effects as random: sireᵢ ~ N(0, σ²ₛ)
- BLUP shrinks estimates toward mean
- Shrinkage inversely proportional to information
- Sire 1 (n=3): shrunk heavily toward mean
- Sire 5 (n=25): shrunk lightly (reliable estimate)

**Comparison Table**:

| Sire | n | LS Estimate | SE | BLUP Estimate | Reliability |
|------|---|-------------|-----|---------------|-------------|
| 1 | 3 | 8500 | 570 | 8750 | 0.23 |
| 2 | 8 | 9200 | 350 | 9150 | 0.52 |
| 5 | 25 | 9100 | 198 | 9080 | 0.82 |

Show: BLUP for Sire 1 is pulled toward mean (more shrinkage)

**Callout Box 9**:
- Type: Important
- Content: "This example shows WHY we need mixed models! With unequal information and random sampling of sires, fixed effects LS is suboptimal. Week 14 will introduce random effects and BLUP, which handle unequal information elegantly."

#### R Implementation

**Complete R script**:
```r
# Simulate realistic data
set.seed(2025)
n_sires <- 10
sire_n <- c(3, 8, 15, 5, 25, 12, 18, 7, 20, 22)
true_sire_effects <- c(-150, 400, 150, -900, 300, -100, 500, -400, 200, 50)
sigma <- 850

# Generate data
sire <- rep(1:n_sires, sire_n)
y <- 8800 + true_sire_effects[sire] + rnorm(sum(sire_n), 0, sigma)

# Approach 1: Cell means
fit1 <- lm(y ~ factor(sire) - 1)
summary(fit1)

# Approach 2: Effects with sum-to-zero
options(contrasts = c("contr.sum", "contr.poly"))
fit2 <- lm(y ~ factor(sire))
summary(fit2)

# Approach 3: Effects with set-to-zero
options(contrasts = c("contr.treatment", "contr.poly"))
fit3 <- lm(y ~ factor(sire))
summary(fit3)

# Show fitted values are identical
max(abs(fitted(fit1) - fitted(fit2)))  # Should be ~0
max(abs(fitted(fit1) - fitted(fit3)))  # Should be ~0

# Test overall sire effect
anova(fit3)

# Specific contrasts
library(emmeans)
emm <- emmeans(fit3, "sire")
contrast(emm, method = "pairwise")

# Confidence intervals for sire means
confint(emm)

# Plot with uncertainty
plot(emm) + coord_flip()

# Compare with BLUP (preview)
library(lme4)
fit_mm <- lmer(y ~ 1 + (1|sire))
ranef(fit_mm)  # BLUP estimates (shrunken)

# Shrinkage plot
ls_est <- coef(emm)$emmean
blup_est <- ranef(fit_mm)$sire[,1] + fixef(fit_mm)
plot(ls_est, blup_est,
     xlab = "LS Estimate", ylab = "BLUP Estimate",
     main = "Shrinkage: BLUP pulls toward mean")
abline(0, 1, col = "red")  # Identity line
```

---

### 2.7 Exercises (7 problems)

#### Exercise 1: Computational (Unbalanced ANOVA)
**Given**: Swine litter size by breed
```
Yorkshire: 11, 12, 10
Landrace: 12, 13
Duroc: 9
```

**Tasks**:
a) Fit effects model manually (μ + breed)
b) Compute Type I SS (breed first)
c) Compute Type III SS using R
d) Explain why they differ
e) Test H₀: no breed effect (both methods)

#### Exercise 2: Computational (Generalized Inverses)
**Given**:
```
A = [2  1]
    [1  2]
    [3  3]

A'A = [14  14]
      [14  14]
```

**Tasks**:
a) Show A'A is singular (rank 1)
b) Find Moore-Penrose inverse (A'A)⁺ using SVD by hand
c) Find a different g-inverse using row reduction
d) Verify both satisfy (A'A)(A'A)⁻(A'A) = A'A
e) Show the two give different solutions to A'Ab = A'y where y = [1, 2, 3]'
f) Show Xb is the same for both solutions

#### Exercise 3: Computational (Constraints)
**Given**: Layer hen egg production by strain (unbalanced)
```
Strain A: 285, 290, 280         (n=3, mean=285)
Strain B: 300, 305, 310, 295    (n=4, mean=302.5)
Strain C: 275, 280              (n=2, mean=277.5)
```

**Tasks**:
a) Apply set-to-zero constraint (strain A = 0) and solve
b) Apply sum-to-zero constraint and solve
c) Apply weighted sum-to-zero (Σnᵢαᵢ = 0) and solve
d) Verify: strain B - strain A is identical in all three
e) Interpret μ in each parameterization
f) Which constraint makes most sense here? Why?

#### Exercise 4: Applied (Beef Cattle Data)
**Given**: Feedlot ADG dataset (provided CSV, n=80)
- 4 breeds, 5 farms
- Missing: no Angus on Farm 5, no Charolais on Farm 1
- Model: ADG ~ breed + farm

**Tasks**:
a) Create table of cell counts (breed × farm)
b) Identify which parameters are estimable
c) Fit model and test H₀: no breed effect (Type III)
d) Compute estimable contrasts:
   - Angus vs Hereford within farms where both exist
   - British vs Continental breeds
e) Explain why we cannot estimate "Angus effect on Farm 5"

#### Exercise 5: Applied (Dairy Sire Analysis)
**Given**: Sire dataset (provided CSV, n=100)
- 8 sires, progeny range 5-20 per sire
- Response: milk yield (kg)

**Tasks**:
a) Fit cell means model and report sire means with 95% CI
b) Fit effects model (sum-to-zero) and report sire effects
c) Verify: sire means from (a) = μ + sireᵢ from (b)
d) Plot sire means with error bars (proportional to 1/√nᵢ)
e) Test: do sires differ significantly? (F-test)
f) Rank sires and identify top 3 for selection
g) Discuss: What problem do you see with selecting Sire 3 (n=5) who ranks #1?

#### Exercise 6: Theoretical (Estimability Proof)
**Prove**: For one-way ANOVA model yᵢⱼ = μ + αᵢ + eᵢⱼ:
a) Show μ is not estimable (provide counterexample with two g-inverses giving different μ̂)
b) Prove αᵢ - αⱼ is estimable (show c'b is invariant to g-inverse choice)
c) Prove Σwᵢαᵢ is estimable if and only if Σwᵢ = 0
d) For two-way ANOVA yᵢⱼₖ = μ + αᵢ + βⱼ + (αβ)ᵢⱼ + eᵢⱼₖ, prove that μ + αᵢ + βⱼ + (αβ)ᵢⱼ (cell mean) is estimable

#### Exercise 7: Theoretical (Constraint Systems)
**Given**: General linear model y = Xβ + e with r(X) = r < p (rank deficient)

**Tasks**:
a) Show that if C is (p-r) × p with r(C) = p-r and C is orthogonal to row space of X, then the constrained system:
```
[X'X  C'] [b]   [X'y]
[C    0 ] [λ] = [0  ]
```
has a unique solution

b) Prove that estimable functions c'β give the same c'b regardless of which constraint matrix C is chosen

c) Show that the sum-to-zero constraint Σαᵢ = 0 for one-way ANOVA can be written as C'b = 0 where C' = [0, 1, 1, ..., 1]

d) Verify that this C is orthogonal to the row space of X for one-way ANOVA design

---

### 2.8 Solutions (provided in separate document)

Full worked solutions for all 7 exercises, including:
- Step-by-step calculations
- R code with output
- Detailed explanations
- Common mistakes to avoid

---

## 3. Quarto Features to Include

### 3.1 Callout Boxes (9 total, see above)
- Types: Note, Important, Warning
- Strategic placement after key concepts

### 3.2 Code Chunks
- All R examples executable
- Heavily commented
- Include output in rendered HTML
- Use `#| echo: true, eval: true` options

### 3.3 Figures
- Comparison plots (Type I vs III SS)
- Residual plots
- Shrinkage plot (LS vs BLUP)
- Error bar plots (sire means with SE)
- Generated dynamically from R code

### 3.4 Tables
- Comparison tables (constraints, g-inverses)
- ANOVA tables
- Summary statistics
- Use `knitr::kable()` or `gt` package for formatting

### 3.5 Cross-References
- Reference equations by number
- Reference previous weeks
- Reference specific topics within chapter

### 3.6 Collapsible Solutions
- Exercise solutions in expandable sections
- Use Quarto divs: `:::{.callout-note collapse="true"}`

### 3.7 Tabs
- Compare different approaches side-by-side
- Example: Three constraint systems in tabbed panels

---

## 4. Pedagogical Approach

### 4.1 Progression
1. Review concepts (A-D topics)
2. Build intuition with small examples
3. Apply to realistic scenario (sire evaluation)
4. Synthesize understanding through exercises

### 4.2 Connections
- Backward: Weeks 2, 7, 8, 12 (review and build upon)
- Forward: Week 14 (motivation for mixed models)
- Horizontal: Connect theory to practice throughout

### 4.3 Emphasis
- **Key message**: Estimable functions are what matter
- **Practical skill**: Choosing appropriate constraint and SS type
- **Biological context**: Real breeding program challenges
- **Software skill**: Implementing in R correctly

---

## 5. Expected Student Outcomes

After this week, students should be able to:

✅ Diagnose when rank deficiency is problematic
✅ Choose appropriate SS type for unbalanced data
✅ Understand that constraint choice is arbitrary for estimable functions
✅ Never misinterpret non-estimable parameters in publications
✅ Implement multiple constraint systems in R
✅ Analyze real genetic evaluation data with confidence
✅ Understand limitations of fixed effects models (motivation for Week 14)

---

## 6. Datasets Needed

### Dataset 1: Small examples (create in document)
- Broiler weight (strain × sex, unbalanced)
- Sow litter size (parity, unbalanced)
- Layer egg production (strain, unbalanced)

### Dataset 2: Moderate examples (CSV files)
- Beef feedlot ADG (breed × farm, n=80, missing cells)
- Sire evaluation (10 sires, n=135 total)

### Dataset 3: Exercise datasets (CSV files)
- Swine litter size (breed, n=6)
- Layer egg production (strain, n=9)
- Beef cattle ADG (breed × farm, n=80)
- Dairy sire milk yield (8 sires, n=100)

All datasets should be realistic, include variable descriptions, and be documented in Datasets/README.md

---

## 7. Estimated Time

**Content Development**:
- Topic A: 4 hours (strategic approaches)
- Topic B: 5 hours (g-inverse types, detailed)
- Topic C: 4 hours (constraint systems)
- Topic D: 3 hours (estimability interpretation)
- Large Example: 6 hours (sire evaluation, comprehensive)
- Exercises: 4 hours (7 problems + solutions)
- Datasets: 2 hours (creation and documentation)
- Quarto formatting: 3 hours (callouts, tabs, polish)

**Total**: ~31 hours

**Student Time**:
- Reading/study: 3 hours
- Working examples: 2 hours
- Exercises: 4 hours
**Total**: ~9 hours (3 weeks × 3 hours/week)

---

## 8. Quality Checks

Before finalizing:
- [ ] All notation consistent with CLAUDE.md standards
- [ ] All symbols defined at first use
- [ ] All equations numbered and labeled
- [ ] All R code tested and runs without errors
- [ ] All datasets created and documented
- [ ] Exercise solutions verified
- [ ] Callout boxes placed strategically
- [ ] Cross-references working
- [ ] HTML compiles without warnings
- [ ] Livestock examples biologically realistic
- [ ] Progression logical from Week 12 to Week 14

---

## 9. Key Themes to Emphasize Throughout

1. **Estimability is King**: Only estimable functions have meaning
2. **Constraints are Arbitrary**: Choice doesn't affect biology, only interpretation
3. **Unbalanced ≠ Bad**: It's about confounding and rank deficiency
4. **Fixed Effects Limitations**: Motivates need for mixed models
5. **Real Data is Messy**: These tools let you handle it correctly

---

## 10. Week 13 Learning Journey

```
Start: "I'm confused about non-full rank models"
  ↓
Topic A: "I can diagnose unbalance problems and choose solutions"
  ↓
Topic B: "I understand different g-inverses and when to use each"
  ↓
Topic C: "I can apply any constraint system and interpret results"
  ↓
Topic D: "I know what's estimable and report only meaningful results"
  ↓
Large Example: "I can analyze real genetic data confidently"
  ↓
End: "I'm ready for mixed models and understand why we need them!"
```

---

This plan provides a comprehensive, integrated treatment of unbalanced data, generalized inverses, constraints, and estimability - synthesizing Weeks 2, 7, 8, 12 and preparing for Week 14.
