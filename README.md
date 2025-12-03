# Linear Models for Animal Breeding and Genetics

**📚 [View Online Book](https://austin-putz.github.io/linear-models-book)**

[![Deploy to GitHub Pages](https://github.com/austin-putz/linear-models-book/actions/workflows/publish.yml/badge.svg)](https://github.com/austin-putz/linear-models-book/actions/workflows/publish.yml)

A comprehensive graduate-level textbook teaching linear models from first principles with applications in animal breeding and genetics.

## About This Book

This 15-week course builds linear models from the ground up, emphasizing manual matrix operations before using statistical software. Students learn to construct their own least squares solvers and deeply understand the mathematics underlying genetic evaluation.

**Target Audience**: Graduate students in Animal Breeding and Genetics

**Key Features**:
- Builds understanding through hands-on implementation
- Real livestock examples (dairy, beef, swine, poultry, sheep)
- Complete R code with step-by-step matrix operations
- Prepares students for mixed models and BLUP
- All content written in Quarto and published online

## Course Structure

### Part I: Foundations (Weeks 1-3)
- Course Overview & Computational Foundations
- Linear Algebra Essentials
- Building the Design Matrix Framework

### Part II: Core Regression Theory (Weeks 4-6)
- Simple Linear Regression
- Least Squares Theory
- Multiple Regression

### Part III: Analysis of Variance (Weeks 7-10)
- One-Way ANOVA
- Contrasts and Estimable Functions
- Two-Way ANOVA and Factorial Models
- Analysis of Covariance (ANCOVA)

### Part IV: Diagnostics and Advanced Topics (Weeks 11-14)
- Model Diagnostics
- Non-Full Rank Models and Unbalanced Data
- Special Topics I: Unbalanced Data & Constraints
- Special Topics II: Polynomial Regression, WLS, Mixed Models Preview

### Part V: Integration (Week 15)
- Capstone Project: Multi-breed Beef Cattle Analysis

### Appendices
- Notation Reference
- Matrix Algebra Review
- R Functions Guide
- Dataset Descriptions
- Exercise Solutions

## Prerequisites

- Basic statistics (inference, hypothesis testing)
- Elementary linear algebra (reviewed in Week 2)
- Basic R programming (taught as needed)

## Development Status

**Complete**: Weeks 1-2 with full content, examples, and exercises
**In Progress**: Weeks 3-15 framework and structure established

## Technical Details

- **Format**: Quarto book compiled to HTML
- **Programming Language**: R (all examples and code)
- **Publishing**: Automated deployment via GitHub Actions
- **Themes**: Light/dark mode with responsive design

## Usage

### View Online
The book is published at: **https://austin-putz.github.io/linear-models-book**

### Build Locally
```bash
# Clone repository
git clone https://github.com/austin-putz/linear-models-book.git
cd linear-models-book

# Render book (requires Quarto and R)
quarto render

# Preview book
quarto preview
```

### Required R Packages
```r
install.packages(c("MASS", "car", "emmeans", "multcomp", "lme4"))
```

## Contributing

This is an educational resource under active development. Feedback and suggestions are welcome via GitHub issues.

## Author

**Austin Putz**
Graduate-level instruction in Animal Breeding and Genetics

## License

This educational material is shared for academic and teaching purposes.

---

**Last Updated**: December 2025
