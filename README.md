# Linear Models for Animal Breeding and Genetics

A comprehensive, 15-week graduate-level Quarto textbook teaching linear models from first principles with applications in animal breeding and genetics.

## 📚 Project Status

**Current Status**: Complete book structure with 2 fully developed weeks

### ✅ Completed
- **Week 1**: Course Overview & Computational Foundations *(Full content)*
- **Week 2**: Linear Algebra Essentials *(Full content)*
- **Weeks 3-15**: Skeleton structure ready for content development
- **Appendices A-E**: Framework established
- **Book infrastructure**: Quarto configuration, references, styling

### 🚧 In Development
- **Weeks 3-15**: Core content to be developed
- **Appendices**: Detailed content to be added
- **Datasets**: Additional CSV files to be created

## 🎯 Course Overview

**Target Audience**: Graduate students in Animal Breeding and Genetics

**Key Features**:
- Builds linear models from first principles
- Emphasizes manual matrix operations before using software
- Real livestock examples (dairy, beef, swine, poultry, sheep)
- Hands-on R implementation with verification
- Prepares students for mixed models and BLUP

**Prerequisites**:
- Basic statistics (inference, hypothesis testing)
- Elementary linear algebra (reviewed in Week 2)
- Basic R programming (taught as needed)

## 📖 Book Structure

### Part I: Foundations (Weeks 1-3)
1. **Week 1**: Course Overview & Computational Foundations ✅
2. **Week 2**: Linear Algebra Essentials ✅
3. **Week 3**: Building the Design Matrix Framework 🚧

### Part II: Core Regression Theory (Weeks 4-6)
4. **Week 4**: Simple Linear Regression 🚧
5. **Week 5**: Least Squares Theory 🚧
6. **Week 6**: Multiple Regression 🚧

### Part III: Analysis of Variance (Weeks 7-10)
7. **Week 7**: Analysis of Variance (One-Way) 🚧
8. **Week 8**: Contrasts and Estimable Functions 🚧
9. **Week 9**: Two-Way ANOVA and Factorial Models 🚧
10. **Week 10**: Analysis of Covariance (ANCOVA) 🚧

### Part IV: Diagnostics and Advanced Topics (Weeks 11-14)
11. **Week 11**: Model Diagnostics 🚧
12. **Week 12**: Unequal Subclass Numbers & Non-Full Rank Models 🚧
13. **Week 13**: Special Topics I 🚧
14. **Week 14**: Special Topics II 🚧

### Part V: Integration (Week 15)
15. **Week 15**: Capstone Project 🚧

### Appendices
- **A**: Notation Quick Reference
- **B**: Matrix Algebra Review
- **C**: R Functions Reference
- **D**: Datasets Description
- **E**: Solutions to Selected Exercises

## 🗂️ Directory Structure

```
LinearModels/
├── _quarto.yml                    # Book configuration
├── index.qmd                      # Homepage
├── references.bib                 # Citations with DOIs
├── styles.css                     # Custom styling
├── .gitignore                     # Git ignore rules
│
├── Week01_Overview/               ✅ COMPLETE
│   ├── Week01_CourseOverview.qmd
│   ├── Week01_Exercises.qmd
│   ├── Week01_Solutions.qmd
│   ├── code_examples.R
│   └── data/
│       └── dairy_milk_practice.csv
│
├── Week02_LinearAlgebra/          ✅ COMPLETE
│   ├── Week02_LinearAlgebra.qmd
│   ├── Week02_Exercises.qmd
│   ├── Week02_Solutions.qmd
│   └── code_examples.R
│
├── Week03_DesignMatrix/           🚧 SKELETON
│   └── Week03_DesignMatrix.qmd
│
├── [Weeks 4-15]/                  🚧 SKELETON
│   └── WeekXX_*.qmd
│
├── Appendices/                    🚧 SKELETON
│   ├── AppendixA_Notation.qmd
│   ├── AppendixB_MatrixAlgebra.qmd
│   ├── AppendixC_RFunctions.qmd
│   ├── AppendixD_Datasets.qmd
│   └── AppendixE_Solutions.qmd
│
└── Datasets/                      📁 FRAMEWORK
    └── README.md
```

## 🚀 Quick Start

### Building the Book

```bash
# Render the entire book
quarto render

# Render a single chapter
quarto render Week01_Overview/Week01_CourseOverview.qmd

# Preview the book (live reload)
quarto preview
```

### Viewing the Book

After rendering, open `_book/index.html` in your browser.

### Running Code Examples

```bash
# Run standalone R code for any week
cd Week01_Overview
Rscript code_examples.R
```

## 📝 Development Workflow

### To Complete a Week's Content

Each week should include:

1. **Main Lecture** (`WeekXX_TopicName.qmd`):
   - Learning objectives (3-5 points)
   - Conceptual introduction
   - Mathematical theory with full derivations
   - Small numerical example (n=5-10)
   - Realistic livestock application (n=50-100)
   - R solver implementation
   - Summary and connections

2. **Exercises** (`WeekXX_Exercises.qmd`):
   - 5-7 problems total
   - 2-3 computational (hand calculations)
   - 2-3 applied (datasets)
   - 1-2 theoretical (proofs)

3. **Solutions** (`WeekXX_Solutions.qmd`):
   - Fully worked solutions
   - R code verification
   - Biological interpretation

4. **Code Examples** (`code_examples.R`):
   - Standalone R script
   - Heavily commented
   - All examples from lecture

5. **Data** (if needed):
   - CSV files in `data/` subdirectory
   - Documented in `Datasets/README.md`

## 🎓 Pedagogical Approach

### Philosophy
- **Build before use**: Construct solvers manually before using `lm()`
- **Understand deeply**: Derive estimators from first principles
- **Verify always**: Compare custom code against R functions
- **Apply realistically**: Every concept illustrated with livestock data

### Notation Consistency
Established in Week 1, maintained throughout:
- **Vectors**: lowercase bold ($\mathbf{y}$, $\mathbf{e}$)
- **Matrices**: uppercase bold ($\mathbf{X}$, $\mathbf{H}$)
- **Scalars**: italic ($n$, $\sigma^2$)
- See Appendix A for complete notation reference

## 🔧 Requirements

### Software
- **R** (≥ 4.0)
- **RStudio** (recommended)
- **Quarto** (≥ 1.3)

### R Packages
```r
install.packages(c("MASS", "car", "emmeans", "lme4", "multcomp"))
```

## 📚 Key References

Core textbooks cited throughout:
- Searle (1971, 2006) - Linear Models
- Henderson (1984) - Applications in Animal Breeding
- Mrode (2005) - Prediction of Animal Breeding Values
- Lynch & Walsh (1998) - Genetics and Analysis of Quantitative Traits

See `references.bib` for complete bibliography with DOIs.

## 🤝 Contributing

To develop content for a specific week:

1. Read the specification in `CLAUDE.md`
2. Follow the structure from Weeks 1-2
3. Maintain notation consistency
4. Include realistic livestock examples
5. Test all R code
6. Verify renders correctly

## 📄 License

Educational use for teaching linear models in animal breeding and genetics.

## 👤 Author

Austin Putz

## 🔗 Links

- **Repository**: [github.com/austinputz/LinearModels](https://github.com/austinputz/LinearModels)
- **Course Spec**: See `CLAUDE.md` for detailed specifications

## 📊 Progress Tracking

| Week | Topic | Status | Files |
|------|-------|--------|-------|
| 1 | Course Overview | ✅ Complete | 4/4 |
| 2 | Linear Algebra | ✅ Complete | 4/4 |
| 3 | Design Matrix | 🚧 Skeleton | 1/4 |
| 4 | Simple Regression | 🚧 Skeleton | 1/4 |
| 5 | Least Squares Theory | 🚧 Skeleton | 1/4 |
| 6 | Multiple Regression | 🚧 Skeleton | 1/4 |
| 7 | One-Way ANOVA | 🚧 Skeleton | 1/4 |
| 8 | Contrasts | 🚧 Skeleton | 1/4 |
| 9 | Two-Way ANOVA | 🚧 Skeleton | 1/4 |
| 10 | ANCOVA | 🚧 Skeleton | 1/4 |
| 11 | Diagnostics | 🚧 Skeleton | 1/4 |
| 12 | Non-Full Rank | 🚧 Skeleton | 1/4 |
| 13 | Special Topics I | 🚧 Skeleton | 1/4 |
| 14 | Special Topics II | 🚧 Skeleton | 1/4 |
| 15 | Capstone | 🚧 Skeleton | 1/4 |

**Overall Progress**: 2/15 weeks complete (13%)

## 🎯 Next Steps

Priority order for development:

1. **Week 3**: Design Matrix Framework
2. **Week 4**: Simple Linear Regression
3. **Week 5**: Least Squares Theory
4. **Week 6**: Multiple Regression
5. **Week 7**: One-Way ANOVA
6. Continue through Week 15
7. Flesh out all appendices
8. Create all datasets
9. Final review and quality check

---

**Last Updated**: November 23, 2025

**Book renders successfully**: ✅ Yes

**Git commits**: 3 (initial structure, Week 1, Week 2)
