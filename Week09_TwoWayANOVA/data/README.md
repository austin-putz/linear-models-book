# Week 9 Data Files: Two-Way ANOVA and Factorial Models

This directory contains datasets for Week 9, focusing on two-way ANOVA with interactions.

---

## 1. swine_growth_breed_diet.csv

**Description**: Small balanced 2×2 factorial design for hand calculations

**Context**: Swine growth trial comparing two breeds on two different diets

**Sample Size**: n = 8 pigs (2 per cell)

**Variables**:
- `breed`: Pig breed (Yorkshire, Duroc)
- `diet`: Feed ration (Diet1, Diet2)
- `adg`: Average daily gain in kg/day during grow-finish period

**Design**: Balanced 2×2 factorial (2 breeds × 2 diets × 2 replicates)

**Use**: Small numerical example for hand calculations, demonstrating interaction effects

**Notes**:
- Diet1 is a standard corn-soybean diet
- Diet2 is enhanced with additional lysine and energy
- Data shows breed × diet interaction (Duroc responds better to Diet2)

---

## 2. lamb_growth_breed_diet.csv

**Description**: Small balanced 2×3 factorial design

**Context**: Lamb weaning weight study comparing two breeds on three different creep feed diets

**Sample Size**: n = 12 lambs (2 per cell)

**Variables**:
- `breed`: Lamb breed (Suffolk, Dorset)
- `diet`: Creep feed type (Diet1, Diet2, Diet3)
- `weight_kg`: Weaning weight in kilograms at 60 days of age

**Design**: Balanced 2×3 factorial (2 breeds × 3 diets × 2 replicates)

**Use**: Demonstrating Type I vs Type III SS, showing how order matters

**Notes**:
- Diet1: High grain creep feed
- Diet2: Balanced creep feed
- Diet3: High forage creep feed
- Suffolk lambs generally heavier than Dorset at weaning
- Used to demonstrate SS type comparisons

---

## 3. dairy_milk_fat_breed_diet.csv

**Description**: Larger unbalanced 2×3 factorial design for realistic application

**Context**: Dairy cow milk composition study examining breed and diet effects on milk fat percentage

**Sample Size**: n = 54 cows (unbalanced: 8-11 cows per cell)

**Variables**:
- `cow_id`: Unique cow identifier (1-54)
- `breed`: Dairy breed (Holstein, Jersey)
- `diet`: Total mixed ration formulation (HighGrain, Balanced, HighForage)
- `fat_pct`: Milk fat percentage (%)
- `protein_pct`: Milk protein percentage (%)
- `days_in_milk`: Days since calving (all in mid-lactation, 44-52 days)

**Design**: Unbalanced 2×3 factorial
- Holstein × HighGrain: n = 8
- Holstein × Balanced: n = 9
- Holstein × HighForage: n = 10
- Jersey × HighGrain: n = 11
- Jersey × Balanced: n = 8
- Jersey × HighForage: n = 8

**Use**: Comprehensive realistic application demonstrating:
- Type I vs Type III SS differences with unbalanced data
- Effect size calculations
- Simple effects analysis
- Model diagnostics
- Biological interpretation

**Notes**:
- All cows in similar stage of lactation (45-50 DIM) to control for lactation curve effects
- Jersey cows have naturally higher fat and protein percentages than Holstein
- HighGrain diet: 60% concentrate, 40% forage (DM basis)
- Balanced diet: 50% concentrate, 50% forage
- HighForage diet: 40% concentrate, 60% forage
- Expected interaction: Jersey cows maintain fat % better on high forage diets
- Protein percentage included for potential multivariate discussions

**Biological Context**:
- Milk fat percentage is economically important (component pricing)
- Breed differences well-established (Jersey > Holstein)
- Diet affects milk composition through rumen fermentation patterns
- High grain diets can sometimes reduce milk fat (milk fat depression)
- High forage diets support fat synthesis but may reduce total milk volume
- Understanding breed × diet interactions helps producers optimize feeding strategies

---

## Data Generation Notes

All datasets contain realistic values based on:
- Published literature on livestock production
- Typical production parameters for each species
- Realistic biological variability
- Scientifically plausible interaction patterns

Values were generated to provide:
- Clear but not unrealistic effect sizes
- Biologically meaningful interactions
- Sufficient variation for statistical testing
- Educational examples that mirror real research scenarios

---

## References for Biological Context

**Swine Growth**:
- Typical ADG for grow-finish pigs: 0.8-1.0 kg/day
- Breed and diet interactions common in commercial production
- Lysine-enhanced diets improve growth in some genetic lines

**Lamb Weaning Weights**:
- Suffolk lambs: Heavy breed (28-35 kg at 60 days)
- Dorset lambs: Medium breed (26-32 kg at 60 days)
- Creep feeding can increase weaning weights by 10-20%

**Dairy Milk Composition**:
- Holstein fat %: typically 3.4-4.0%
- Jersey fat %: typically 4.5-5.5%
- Diet forage:concentrate ratio significantly affects milk composition
- Breed × diet interactions important for herd nutrition management
