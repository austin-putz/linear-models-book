# Week 13 Datasets

This directory contains datasets for Week 13 exercises on unbalanced data, generalized inverses, and constraint systems.

All datasets are simulated but reflect realistic livestock performance and study designs.

---

## Dataset 1: beef_feedlot.csv

**Description**: Average daily gain (ADG) for beef steers in a multi-breed, multi-farm feedlot trial.

**Sample size**: n = 162 steers

**Design**: 4 breeds × 5 farms, **unbalanced with missing cells**
- Missing: No Angus on Farm 5
- Missing: No Charolais on Farm 1

**Variables**:
- `animal_id`: Unique animal identifier (integer)
- `farm`: Feedlot location (Farm1, Farm2, Farm3, Farm4, Farm5)
- `breed`: Breed of animal (Angus, Hereford, Charolais, Simmental)
- `adg`: Average daily gain in kg/day (numeric)
- `initial_weight`: Initial body weight at feedlot entry in kg (numeric)
- `days_on_feed`: Number of days in feedlot (integer)

**Cell counts**:
```
             Farm1  Farm2  Farm3  Farm4  Farm5
Angus           10      8     12      6      0
Hereford        12     10     10      8     10
Charolais        0      6     10      8      8
Simmental       10      8     12      6      8
```

**Use in exercises**:
- Exercise 4: Missing cell analysis
- Demonstrates Type III SS necessity
- Estimable vs. non-estimable contrasts

**True population parameters** (for verification):
- Overall mean ADG: 1.45 kg/day
- Breed effects: Angus +0.08, Hereford 0 (ref), Charolais +0.15, Simmental +0.12
- Farm effects: Range from -0.05 to +0.05
- Residual SD: 0.18 kg/day

---

## Dataset 2: dairy_sire.csv

**Description**: 305-day milk yield for daughters of 8 dairy sires with **unequal progeny numbers**.

**Sample size**: n = 95 daughters

**Design**: One-way ANOVA with unequal replication (5 to 20 daughters per sire)

**Variables**:
- `daughter_id`: Unique cow identifier (integer)
- `sire`: Sire identification (Sire1, Sire2, ..., Sire8)
- `milk_yield`: 305-day milk production in kg (numeric)
- `age_first_calving`: Age at first calving in months (integer)
- `days_in_milk`: Days since calving at measurement (integer)

**Progeny distribution**:
```
Sire1  Sire2  Sire3  Sire4  Sire5  Sire6  Sire7  Sire8
    5     12      8     15     20      7     18     10
```

**Use in exercises**:
- Exercise 5: Sire evaluation with unequal information
- Compare cell means vs. effects models
- Illustrate SE ~ 1/√n relationship
- Discuss selection decisions with uncertain estimates

**True population parameters**:
- Overall mean yield: 9000 kg
- True sire transmitting abilities: Range from -200 to +300 kg
- Residual SD: 900 kg

---

## Dataset 3: layer_egg_production.csv

**Description**: Annual egg production for laying hens across 4 commercial strains.

**Sample size**: n = 45 hens

**Design**: One-way ANOVA, **unbalanced** (8-15 hens per strain)

**Variables**:
- `hen_id`: Unique hen identifier (integer)
- `strain`: Genetic strain (Leghorn_White, Rhode_Island_Red, Plymouth_Rock, Australorp)
- `egg_production`: Number of eggs laid in one year (integer)
- `body_weight`: Hen body weight in kg (numeric)

**Sample sizes by strain**:
```
Australorp: 10
Leghorn_White: 12
Plymouth_Rock: 15
Rhode_Island_Red: 8
```

**Use in exercises**:
- Exercise 3: Constraint comparison (set-to-zero, sum-to-zero, weighted)
- ANCOVA with body weight as covariate
- Adjusted means interpretation

**True population parameters**:
- Overall mean production: 280 eggs/year
- Strain effects: Leghorn +25, RIR -10, Plymouth -5, Australorp 0 (ref)
- Body weight effect: +8 eggs per kg body weight
- Residual SD: 35 eggs

---

## Dataset 4: swine_litter.csv

**Description**: Litter size (number of pigs born alive) by breed and parity.

**Sample size**: n = 31 litters

**Design**: Two-way ANOVA, **unbalanced**
- 4 breeds: Yorkshire, Landrace, Duroc, Hampshire
- 4 parity levels: 1, 2, 3, 4

**Variables**:
- `sow_id`: Unique sow identifier (integer)
- `breed`: Breed of sow (Yorkshire, Landrace, Duroc, Hampshire)
- `parity`: Parity number (1, 2, 3, 4)
- `litter_size`: Number of pigs born alive (integer)

**Sample sizes**:
- By breed: Duroc (10), Hampshire (7), Landrace (6), Yorkshire (8)
- By parity: 1 (4), 2 (15), 3 (7), 4 (5)

**Use in exercises**:
- Exercise 3 (variant): Apply different constraints
- Exercise 6 (variant): Two-way ANOVA with unbalanced design
- Type I vs Type III SS comparison

**True population parameters**:
- Overall mean litter size: 10.5 pigs
- Breed effects: Yorkshire +1.5, Landrace +1.0, Duroc -1.0, Hampshire +0.5
- Residual SD: 2.0 pigs

---

## Dataset 5: broiler_bodyweight.csv

**Description**: Body weight at 42 days for broiler chickens in a strain × sex experiment.

**Sample size**: n = 89 birds

**Design**: 3 strains × 2 sexes, **unbalanced** (10-20 birds per cell, all cells present)

**Variables**:
- `bird_id`: Unique bird identifier (integer)
- `strain`: Commercial strain (Cobb, Ross, Hubbard)
- `sex`: Sex of bird (Male, Female)
- `body_weight`: Body weight at 42 days in kg (numeric)
- `age`: Actual age at weighing in days (integer)

**Cell counts**:
```
          Female  Male
Cobb          12    15
Ross          18    20
Hubbard       14    10
```

**Use in exercises**:
- Two-way ANOVA with unbalanced design
- Main effects and interaction
- Type I vs Type III SS comparison
- Interaction plots

**True population parameters**:
- Overall mean body weight: 2.5 kg
- Strain effects: Cobb +0.1, Ross +0.15, Hubbard +0.05
- Sex effects: Male +0.3, Female 0 (ref)
- Residual SD: 0.25 kg

---

## Data Generation

All datasets were generated using `generate_datasets.R` with seed 2025 for reproducibility.

To regenerate datasets:
```r
source("generate_datasets.R")
```

---

## Notes

- **Missing values**: beef_feedlot.csv has structural missing cells (2 breed × farm combinations)
- **Unequal sample sizes**: All datasets except broiler have varying cell sizes
- **Realistic values**: Parameters based on actual livestock performance data
- **Covariates**: Included where appropriate for ANCOVA exercises
- **True effects**: Documented above for teaching purposes (unknown in real analysis)

---

## Usage in Exercises

| Exercise | Dataset(s) | Focus |
|----------|-----------|-------|
| Exercise 1 | swine_litter.csv | Type I vs III SS, unbalanced ANOVA |
| Exercise 2 | (Hand calculation) | Generalized inverse theory |
| Exercise 3 | layer_egg_production.csv | Constraint systems comparison |
| Exercise 4 | beef_feedlot.csv | Missing cells, estimability |
| Exercise 5 | dairy_sire.csv | Sire evaluation, unequal information |

See `Week13_Exercises.qmd` for detailed exercise descriptions.

---

**Contact**: For questions about datasets, see course instructor or Week 13 lecture notes.
