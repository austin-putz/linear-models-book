# Datasets for Linear Models Course

This directory contains datasets used throughout the 15-week course on Linear Models for Animal Breeding and Genetics.

## Dataset Inventory

### Week 1: Course Overview
- **dairy_milk_practice.csv** - Daily milk yield for 30 Holstein cows
  - Variables: `cow_id`, `milk_yield`
  - Located in: `Week01_Overview/data/`

### Planned Datasets (To Be Added)

#### Dairy Cattle
- **lactation_curves.csv** - Milk yield vs. days in milk
- **dairy_sire_eval.csv** - Bull daughters' milk production
- **dairy_fat_protein.csv** - Milk fat and protein percentages

#### Beef Cattle
- **beef_feedlot.csv** - Weight gain by diet and pen
- **beef_carcass.csv** - Carcass marbling, ribeye, backfat
- **beef_breeds.csv** - Multi-breed growth comparison

#### Swine
- **pig_litter_size.csv** - Litter size by breed
- **pig_growth.csv** - ADG by diet
- **pig_feed_efficiency.csv** - Feed conversion ratio

#### Poultry
- **layer_production.csv** - Egg production by strain
- **broiler_weight.csv** - Weight by age
- **broiler_yield.csv** - Breast yield by strain and sex

#### Sheep
- **sheep_fleece.csv** - Fleece weight by breed and farm
- **lamb_weaning.csv** - Weaning weight, birth weight, dam age

#### Capstone Project (Week 15)
- **beef_capstone.csv** - Multi-breed, multi-farm with covariates
  - 120 steers
  - Breeds: Angus, Hereford, Charolais
  - 5 farms
  - Unbalanced design

## Data Dictionary

### Common Variables

- **id** - Animal identification
- **breed** / **strain** / **line** - Genetic group
- **farm** / **herd** / **pen** - Management unit
- **sex** - Male/Female or Castrate/Intact
- **age** - Age in days or months
- **weight** - Body weight (kg)
- **gain** or **adg** - Average daily gain (kg/day)
- **yield** - Milk yield (kg/day) or egg production (eggs/day)

### Data Formats

- All datasets are in **CSV format** (comma-separated values)
- Missing values coded as `NA`
- Factors stored as character strings (not numeric codes)
- Dates in ISO format (YYYY-MM-DD) where applicable

## Usage

To load a dataset in R:

```r
# From main course directory
data <- read.csv("Datasets/dataset_name.csv")

# Or use relative path from week folder
data <- read.csv("../Datasets/dataset_name.csv")
```

## Data Sources

All datasets are:
- **Simulated** for educational purposes (not real animals)
- **Realistic** based on typical livestock performance
- **Vetted** for biological plausibility
- Designed to illustrate specific statistical concepts

## Notes for Instructors

- Small datasets (n=5-10) are provided within lecture notes for hand calculations
- Larger datasets (n=30-100) are stored here for realistic applications
- Capstone dataset intentionally includes:
  - Missing cells (unbalanced design)
  - Some outliers for diagnostics practice
  - Rank deficiency for constraint/estimability lessons

## Contributing

If you develop additional datasets for this course, please:
1. Follow naming conventions: `species_trait.csv`
2. Include variable descriptions in this README
3. Ensure data is biologically realistic
4. Test with example analyses

## Citation

When using these datasets, cite:

> Linear Models for Animal Breeding and Genetics: A Graduate-Level Textbook.
> Created for educational use in linear models instruction.

---

**Last Updated**: November 2025
