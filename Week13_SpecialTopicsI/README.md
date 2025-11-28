# Week 13: Special Topics I

## Unbalanced Data, Generalized Inverses, and Constraint Systems

This week synthesizes concepts from Weeks 2, 7, 8, and 12 to provide practical strategies for analyzing real-world, unbalanced livestock data. Students learn to diagnose when unbalance causes problems, choose appropriate analytical strategies, and correctly interpret results from rank-deficient models.

---

## Contents

### Main Lecture
- **Week13_SpecialTopicsI.qmd** - Main lecture notes with all theory, examples, and R code
  - Topic A: Strategic Approaches to Unbalanced Data
  - Topic B: Types of Generalized Inverses
  - Topic C: Constraint Systems (Set-to-Zero, Sum-to-Zero, Custom)
  - Topic D: Interpreting Non-Estimable Parameters
  - Large Example: Dairy Sire Evaluation with Unequal Progeny
  - Summary and Key Takeaways

### Exercises
- **Week13_Exercises.qmd** - 7 exercises (mostly applied) + 1 bonus challenge
  - Exercise 1: Unbalanced Two-Way ANOVA (swine litter size)
  - Exercise 2: Constraint Systems Comparison (layer egg production)
  - Exercise 3: Missing Cells and Estimability (beef feedlot)
  - Exercise 4: Dairy Sire Evaluation with Unequal Progeny
  - Exercise 5: Broiler Strain × Sex Interaction
  - Exercise 6: Generalized Inverse (computational)
  - Exercise 7: Reporting Estimable Functions (conceptual/applied)
  - Bonus: Fixed Effects vs. Mixed Model Comparison

### Solutions
- **Week13_Solutions.qmd** - Complete worked solutions for all exercises

### Datasets
All datasets are located in the `data/` subfolder:

1. **beef_feedlot.csv** - Multi-breed, multi-farm feedlot trial (n=162, missing cells)
2. **dairy_sire.csv** - Sire evaluation with unequal progeny (n=95, 8 sires)
3. **layer_egg_production.csv** - Egg production by strain (n=45, 4 strains)
4. **swine_litter.csv** - Litter size by breed and parity (n=31, unbalanced)
5. **broiler_bodyweight.csv** - Body weight by strain × sex (n=89, unbalanced)

See **data/README.md** for detailed dataset documentation.

### Planning Documents
- **PLAN.md** - Detailed planning document with structure, learning objectives, and content outline

---

## Compiling the Documents

### Main Lecture

```bash
cd Week13_SpecialTopicsI
quarto render Week13_SpecialTopicsI.qmd
```

Output: `Week13_SpecialTopicsI.html`

### Exercises

```bash
quarto render Week13_Exercises.qmd
```

Output: `Week13_Exercises.html`

### Solutions

```bash
quarto render Week13_Solutions.qmd
```

Output: `Week13_Solutions.html`

### Render All at Once

```bash
quarto render Week13_SpecialTopicsI.qmd Week13_Exercises.qmd Week13_Solutions.qmd
```

---

## Learning Objectives

After completing this week, students will be able to:

1. **Diagnose** when unbalanced data causes problems and select appropriate analytical strategies
2. **Distinguish** between different types of generalized inverses and understand when each is appropriate
3. **Apply** different constraint systems (set-to-zero, sum-to-zero, custom) and interpret their effects on parameter estimates
4. **Identify** estimable vs. non-estimable functions and correctly interpret results from rank-deficient models
5. **Analyze** real genetic evaluation data with unequal information and understand the limitations of fixed-effects least squares

---

## Key Concepts

### Strategic Approaches (Topic A)
- When does unbalance cause problems? Confounding, rank deficiency, interpretation issues
- Solutions: Estimable functions, cell means model, Type III SS, weighted LS
- Type I vs. Type II vs. Type III sums of squares

### Generalized Inverses (Topic B)
- Reflexive g-inverse: Minimum requirement (AA⁻A = A)
- Moore-Penrose inverse: Unique, SVD-based, R's `ginv()` default
- Conditional inverse: Constraint-based for interpretability

### Constraint Systems (Topic C)
- Set-to-zero: Reference group, express effects relative to control
- Sum-to-zero: Symmetric, effects as deviations from overall mean
- Custom: Specialized situations (anchoring, structural constraints)
- **Key principle**: Constraint is arbitrary; estimable functions unchanged

### Estimability (Topic D)
- **Estimable** = "observable from data" (unique across g-inverses)
- **Non-estimable** = parameterization artifact (changes with constraints)
- **Golden rule**: Report only estimable functions (contrasts, LS means)
- Never interpret individual α parameters from rank-deficient models!

---

## Software Requirements

### R Packages
Install required packages before starting:

```r
install.packages(c("MASS", "emmeans", "car", "lme4", "knitr"))
```

### Package Usage
- `MASS::ginv()` - Moore-Penrose generalized inverse
- `emmeans` - Estimated marginal means and contrasts
- `car::Anova()` - Type II and Type III sums of squares
- `lme4::lmer()` - Mixed models (bonus exercise)
- `knitr::kable()` - Formatted tables

---

## Dataset Usage

| Exercise | Dataset(s) | Focus |
|----------|-----------|-------|
| 1 | swine_litter.csv | Type I vs III SS, unbalanced ANOVA |
| 2 | layer_egg_production.csv | Constraint systems comparison |
| 3 | beef_feedlot.csv | Missing cells, estimability |
| 4 | dairy_sire.csv | Sire evaluation, unequal information |
| 5 | broiler_bodyweight.csv | Interaction, Type III SS |
| 6 | (Hand calculation) | Generalized inverse theory |
| 7 | (Conceptual) | Reporting best practices |

All datasets are **simulated** but reflect realistic livestock performance and study designs.

---

## Pedagogical Approach

### Progression
1. **Review & Synthesize**: Bring together concepts from Weeks 2, 7, 8, 12
2. **Build Intuition**: Small examples with clear interpretation
3. **Apply to Practice**: Realistic livestock scenarios
4. **Connect Forward**: Preview Week 14 (mixed models)

### Emphasis
- **Estimable functions are what matter** (biological meaning)
- **Constraints are arbitrary** (computational choice, not biological)
- **Unbalanced ≠ bad** (but requires careful analysis)
- **Fixed effects have limitations** (motivates mixed models)

### Active Learning
- 9 callout boxes throughout lecture
- Extensive R code examples (all executable)
- Multiple visualization types (plots, tables, interaction plots)
- Hands-on exercises with real data

---

## Connection to Other Weeks

### Builds On
- **Week 2**: Linear algebra, rank, generalized inverses (mathematical foundation)
- **Week 7**: One-way ANOVA (balanced case as reference)
- **Week 8**: Estimable functions and contrasts (theoretical framework)
- **Week 12**: Unequal subclass numbers, non-full rank models (immediate prerequisite)

### Prepares For
- **Week 14**: Mixed models and random effects
  - Sire evaluation example motivates BLUP
  - Unequal information problem solved by random effects
  - Fixed vs. random effects framework
  - Henderson's mixed model equations (MME)

---

## Expected Time Commitment

### Instructor
- Lecture preparation: 31 hours (if creating from scratch)
- Dataset generation: 2 hours
- Exercise grading: ~30 minutes per student

### Student
- Reading lecture notes: 3 hours
- Working through examples: 2 hours
- Completing exercises: 4 hours
- **Total**: ~9 hours (3 weeks × 3 hours/week)

---

## Quality Checks

Before distributing materials:

- [ ] All R code chunks execute without errors
- [ ] All datasets load correctly
- [ ] Quarto documents compile to HTML
- [ ] Cross-references and equation numbers work
- [ ] Citations render correctly (if using bibliography)
- [ ] Figures display properly
- [ ] Tables are formatted nicely
- [ ] Solution outputs match exercise questions
- [ ] Notation consistent with CLAUDE.md standards

---

## Notes for Instructors

### Customization
- Datasets can be regenerated with different seed: Edit `data/generate_datasets.R` and change `set.seed(2025)` to any value
- True effects are documented in `data/README.md` for teaching purposes
- Exercise difficulty can be adjusted by changing dataset complexity

### Grading
- Emphasize **interpretation** over computation
- Give partial credit for correct reasoning even if code has minor errors
- Look for: proper use of emmeans, correct SS type, focus on estimable functions
- Common mistakes: reporting non-estimable parameters, misinterpreting Type I SS

### Additional Resources
- Henderson, C.R. (1984). Applications of Linear Models in Animal Breeding. (Classic reference for Week 14 transition)
- Searle, S.R. (1987). Linear Models for Unbalanced Data. (Comprehensive theoretical treatment)
- R Documentation: `?emmeans`, `?contrast`, `?car::Anova`

---

## Troubleshooting

### Common Issues

**Q: Code gives "cannot find function" errors**
A: Install missing packages: `install.packages(c("MASS", "emmeans", "car"))`

**Q: Quarto won't render**
A: Ensure Quarto is installed: `quarto check`

**Q: Datasets not loading**
A: Check that you're in the correct working directory or use full file paths

**Q: emmeans results differ from lecture**
A: Check that you've set contrasts correctly: `options(contrasts = c("contr.treatment", "contr.poly"))`

**Q: Mixed model won't fit (bonus exercise)**
A: Install lme4: `install.packages("lme4")`

---

## Contact

For questions about Week 13 materials:
- See course instructor
- Consult CLAUDE.md for notation standards
- Check data/README.md for dataset documentation

---

## Version History

- **2025-11-28**: Initial creation
  - All topics, examples, exercises, and solutions completed
  - 5 datasets generated with documentation
  - ~50,000 words of content

---

**This week provides essential skills for analyzing real livestock data with confidence!**
