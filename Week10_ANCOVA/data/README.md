# Week 10 ANCOVA Datasets

This directory contains datasets for Week 10: Analysis of Covariance (ANCOVA).

## Dataset Overview

All datasets are designed to illustrate ANCOVA concepts where:
- A categorical treatment variable (breed, herd, ration, strain) is of primary interest
- A continuous covariate (parity, days in milk, initial weight, body weight) needs to be adjusted for
- Treatment groups differ on the covariate, creating confounding that ANCOVA can remove

---

## 1. swine_litter_parity.csv

**Purpose**: Small numerical example for hand calculations

**Description**: Litter size data from 9 sows across 3 breeds, adjusting for sow parity (experience)

**Variables**:
- `sow_id`: Unique sow identifier (1-9)
- `breed`: Sow breed (Yorkshire, Landrace, Duroc)
- `parity`: Parity number (1-5), where 1 = first litter, 2 = second litter, etc.
- `litter_size`: Number of piglets born alive (range: 9.8-12.8)

**Sample Size**: n = 9 (3 sows per breed)

**Design Features**:
- Landrace sows have higher average parity (mean = 3.0) compared to Yorkshire (3.0) and Duroc (3.67)
- Creates confounding: higher parity inflates unadjusted Landrace means
- Used to demonstrate how adjusted means differ from unadjusted means

**Biological Context**:
Sow parity strongly affects litter size - older, more experienced sows typically have larger litters. When comparing breeds, we must adjust for parity differences to get fair comparisons.

---

## 2. dairy_milk_herds.csv

**Purpose**: Large realistic example showing herd comparisons with lactation stage adjustment

**Description**: Daily milk yield from 40 Holstein cows across 4 commercial dairy herds, adjusting for days in milk (lactation stage)

**Variables**:
- `cow_id`: Unique cow identifier (1-40)
- `herd`: Dairy herd identifier (HerdA, HerdB, HerdC, HerdD)
- `days_in_milk`: Days since calving/freshening (range: 45-158 days)
- `milk_yield_kg`: Daily milk production in kilograms (range: 28.9-38.2 kg)

**Sample Size**: n = 40 (10 cows per herd)

**Design Features**:
- **HerdA**: Early lactation (mean DIM = 51), high unadjusted yield
- **HerdB**: Mid-late lactation (mean DIM = 121), lower yield due to stage
- **HerdC**: Mid lactation (mean DIM = 80)
- **HerdD**: Late lactation (mean DIM = 151), lowest unadjusted yield
- Strong negative relationship: milk yield declines as DIM increases (lactation curve)

**Biological Context**:
Milk production peaks around 60-80 days post-calving, then gradually declines. Comparing herds tested at different lactation stages is unfair without adjustment. ANCOVA removes the DIM effect to reveal true herd management differences.

**Key Insight**:
HerdD may actually have excellent management, but appears worst due to late-lactation testing. Adjustment reveals true performance.

---

## 3. beef_feedlot_adg.csv

**Purpose**: Large realistic example demonstrating precision increase and confounding control

**Description**: Average daily gain during finishing for 40 beef steers across 5 feedlot rations, adjusting for initial weight at feedlot entry

**Variables**:
- `steer_id`: Unique steer identifier (1-40)
- `ration`: Feedlot ration (Ration1, Ration2, Ration3, Ration4, Ration5)
- `initial_weight_kg`: Live weight at feedlot entry in kilograms (range: 300-380 kg)
- `adg_kg_day`: Average daily gain in kg/day during finishing period (range: 1.35-1.70 kg/day)

**Sample Size**: n = 40 (8 steers per ration)

**Design Features**:
- **Ration1**: Moderate initial weights (mean = 332 kg), moderate ADG
- **Ration2**: Heavy initial weights (mean = 359 kg), highest ADG
- **Ration3**: Light initial weights (mean = 326 kg), moderate ADG
- **Ration4**: Heavy initial weights (mean = 364 kg), moderate ADG
- **Ration5**: Lightest initial weights (mean = 313 kg), lowest ADG
- Positive relationship: heavier steers at entry tend to have higher ADG

**Biological Context**:
Initial weight correlates with ADG due to:
1. Compensatory growth (lighter animals may have reduced gain)
2. Maturity differences (heavier animals closer to mature weight)
3. Prior management/health history

Adjusting for initial weight allows fair comparison of rations for steers of SIMILAR entry weight.

**Key Insight**:
Demonstrates all 3 purposes of ANCOVA:
1. **Precision**: Accounting for initial weight reduces error variance
2. **Adjustment**: Some rations assigned heavier steers (confounding)
3. **Fair comparison**: Which ration is best for 330 kg steers?

---

## 4. layer_egg_bodyweight.csv

**Purpose**: Exercise dataset for students to analyze independently

**Description**: Monthly egg production from 30 laying hens across 3 strains, adjusting for hen body weight

**Variables**:
- `hen_id`: Unique hen identifier (1-30)
- `strain`: Layer strain (Leghorn, RhodeIsland, Sussex)
- `body_weight_kg`: Hen body weight in kilograms (range: 1.65-2.28 kg)
- `eggs_month`: Number of eggs laid in 30-day period (range: 24.5-27.8 eggs)

**Sample Size**: n = 30 (10 hens per strain)

**Design Features**:
- **Leghorn**: Light birds (mean = 1.71 kg), high egg production
- **RhodeIsland**: Medium birds (mean = 2.01 kg), medium production
- **Sussex**: Heavy birds (mean = 2.21 kg), lower production
- Negative relationship: heavier hens lay fewer eggs (energy partitioning)

**Biological Context**:
Lighter-bodied strains (Leghorn) evolved for egg production efficiency, heavier dual-purpose breeds (Sussex) partition energy to both eggs and body maintenance. Body weight confounds strain comparisons.

**Exercise Goal**:
Students fit ANCOVA, compute adjusted strain means, and interpret which strain has superior egg production for hens of the SAME body weight.

---

## Data Simulation Details

All datasets were simulated using realistic parameters from animal breeding and production literature:

- **Swine litter size**: Mean ~11 piglets, parity effect +0.8 piglets per parity, breed effects ±0.5-1.0 piglets
- **Dairy milk yield**: Lactation curve following Wood's model, peak ~38 kg/day, decline ~0.05 kg/day per DIM
- **Beef ADG**: Mean ~1.50 kg/day, initial weight effect +0.003 kg/day per kg entry weight
- **Layer egg production**: Mean ~26 eggs/month, body weight effect -2.5 eggs per kg body weight

Random error was added to all responses to create realistic variation (CV ~ 3-8%).

---

## Usage

Load datasets in R using:

```r
# Small example
swine <- read.csv("data/swine_litter_parity.csv")

# Large examples
dairy <- read.csv("data/dairy_milk_herds.csv")
beef <- read.csv("data/beef_feedlot_adg.csv")

# Exercise data
layers <- read.csv("data/layer_egg_bodyweight.csv")
```

## Notes

- All datasets have complete cases (no missing values)
- Factor variables are character strings (convert to factor as needed)
- Continuous variables are numeric
- Data suitable for hand calculations (small example) and computer analysis (large examples)
- All values are biologically plausible based on commercial livestock production

## References

- Litter size and parity: Rothschild, M. F., & Bidanel, J. P. (1998). Biology and genetics of reproduction. *The Genetics of the Pig*, 313-343.
- Lactation curves: Wood, P. D. P. (1967). Algebraic model of the lactation curve in cattle. *Nature*, 216(5111), 164-165.
- Beef growth: Owens, F. N., Dubeski, P., & Hanson, C. F. (1993). Factors that alter the growth and development of ruminants. *Journal of Animal Science*, 71(11), 3138-3150.
- Egg production: Leeson, S., & Summers, J. D. (2005). *Commercial Poultry Nutrition*. 3rd edition. Nottingham University Press.
