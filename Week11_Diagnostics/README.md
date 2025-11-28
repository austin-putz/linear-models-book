# Week 11: Model Diagnostics - COMPLETE ✓

## Summary

This week covers comprehensive model diagnostics for linear models with emphasis on livestock applications. Students learn to check assumptions, identify outliers and influential observations, interpret diagnostic plots, and apply transformations when needed.

## Files Created

### Main Content
- **Week11_ModelDiagnostics.qmd** (~4,500 lines) - Main lecture with theory, examples, and R implementation
- **Week11_ModelDiagnostics.html** (681 KB) - Compiled HTML output ✓
- **Week11_Exercises.qmd** (7 exercises, 195 points) - Comprehensive problem set
- **Week11_Exercises.html** (60 KB) - Compiled HTML output ✓

### Data Files (8 total)
1. **beef_marbling.csv** (n=9) - Small example for hand calculations
2. **poultry_fcr.csv** (n=50) - Application 1: Sick bird outlier
3. **dairy_lactation_variance.csv** (n=40) - Application 2: Heteroscedasticity
4. **swine_birth_weight_outliers.csv** (n=40) - Exercise 3: Two outlier types
5. **lamb_weaning_weight.csv** (n=60) - Exercise 4: Clean data
6. **broiler_bodyweight_growth.csv** (n=50) - Exercise 5: Heteroscedasticity
7. **beef_feedlot_gain.csv** (n=45) - Exercise 6: Box-Cox transformation
8. **dairy_scc_mastitis.csv** (n=100) - Exercise 7: Multiple violations

## Learning Objectives (6)
1. **Compute** different types of residuals and understand their uses
2. **Identify** outliers and high-leverage observations
3. **Create and interpret** diagnostic plots
4. **Distinguish** between high-leverage and high-influence observations
5. **Apply** transformations appropriately
6. **Build** a systematic diagnostic workflow

## Key Features

### Mathematical Coverage
- Residuals (raw, standardized, studentized, deleted)
- Hat matrix properties with complete proofs
- Leverage vs. influence concepts
- Cook's Distance full derivation
- Box-Cox transformations (moderate depth)
- 10 strategic callout boxes throughout

### Three Comprehensive Examples
1. **Beef Carcass Marbling (n=9)**: Hand calculations demonstrating leverage ≠ influence
2. **Poultry FCR (n=50)**: High-influence outlier requiring exclusion
3. **Dairy Lactation (n=40)**: Heteroscedasticity with log transformation

### R Implementation
- 5 custom diagnostic functions
- Complete verification against base R
- Heavily commented educational code

### Exercises (195 total points)
- Exercise 1: Hand calculations (25 pts)
- Exercise 2: Theoretical concepts (20 pts)
- Exercise 3: Swine analysis with outliers (30 pts)
- Exercise 4: Systematic assumption checking (20 pts)
- Exercise 5: Heteroscedasticity transformation (35 pts)
- Exercise 6: Box-Cox selection (25 pts)
- Exercise 7: Complete diagnostic report (40 pts)

## Citations Added (9)

Added to `../references.bib`:
1. Cook 1977 (Detection of influential observation)
2. Box & Cox 1964 (Transformations)
3. Belsley et al. 1980 (Regression diagnostics)
4. Anscombe 1973 (Graphs in statistical analysis)
5. Shapiro-Wilk 1965 (Normality test)
6. Breusch-Pagan 1979 (Heteroscedasticity test)
7. White 1980 (Heteroscedasticity)
8. Weisberg 2005 (Applied linear regression)
9. Fox & Weisberg 2019 (R companion)

## Compilation Status

✅ Main lecture compiles to HTML successfully
✅ Exercises compile to HTML successfully
✅ All code chunks execute without errors
✅ All 8 datasets generated with correct properties
✅ Citations properly formatted with DOIs

---

**Status**: COMPLETE and ready for students ✓
**Date**: November 27, 2025
