# Generate datasets for Week 13 Exercises
# Linear Models for Animal Breeding and Genetics
#
# This script creates realistic datasets for exercises
set.seed(2025)

# =============================================================================
# Dataset 1: Beef Feedlot ADG (Breed × Farm, Unbalanced with Missing Cells)
# =============================================================================

# 4 breeds, 5 farms, not all breeds on all farms
# Missing: No Angus on Farm 5, No Charolais on Farm 1

breeds <- c("Angus", "Hereford", "Charolais", "Simmental")
farms <- paste0("Farm", 1:5)

# Define cell sizes (0 = missing)
cell_design <- matrix(c(
  10, 12, 8, 10,   # Farm 1: no Charolais (0)
  8, 10, 6, 8,     # Farm 2
  12, 10, 10, 12,  # Farm 3
  6, 8, 8, 6,      # Farm 4
  0, 10, 8, 8      # Farm 5: no Angus (0)
), nrow = 5, byrow = TRUE)

cell_design[1, 3] <- 0  # No Charolais on Farm 1
cell_design[5, 1] <- 0  # No Angus on Farm 5

# True effects (population means)
overall_adg <- 1.45  # kg/day
breed_effects <- c(Angus = 0.08, Hereford = 0, Charolais = 0.15, Simmental = 0.12)
farm_effects <- c(Farm1 = -0.05, Farm2 = 0, Farm3 = 0.05, Farm4 = -0.02, Farm5 = 0.02)
sigma <- 0.18

# Generate data
beef_data <- data.frame()
animal_id <- 1

for(i in 1:5) {  # farms
  for(j in 1:4) {  # breeds
    n <- cell_design[i, j]
    if(n > 0) {
      adg <- overall_adg + farm_effects[i] + breed_effects[j] + rnorm(n, 0, sigma)
      temp_df <- data.frame(
        animal_id = animal_id:(animal_id + n - 1),
        farm = farms[i],
        breed = breeds[j],
        adg = adg
      )
      beef_data <- rbind(beef_data, temp_df)
      animal_id <- animal_id + n
    }
  }
}

# Add some covariates
beef_data$initial_weight <- rnorm(nrow(beef_data), 320, 35)
beef_data$days_on_feed <- round(rnorm(nrow(beef_data), 140, 15))

write.csv(beef_data, "beef_feedlot.csv", row.names = FALSE)
cat("Created beef_feedlot.csv: n =", nrow(beef_data), "\n")
print(table(beef_data$breed, beef_data$farm))

# =============================================================================
# Dataset 2: Dairy Sire Evaluation (Unequal Progeny)
# =============================================================================

n_sires <- 8
sire_names <- paste0("Sire", 1:8)

# Progeny numbers (realistic variation: 5 to 20 per sire)
n_progeny <- c(5, 12, 8, 15, 20, 7, 18, 10)

# True sire transmitting abilities (breeding values / 2)
true_sta <- c(-150, 200, -50, 300, 100, -200, 250, 50)

# Parameters
overall_milk <- 9000  # kg
sigma_e <- 900        # within-sire SD

# Generate data
sire_vec <- rep(sire_names, n_progeny)
daughter_id <- 1:sum(n_progeny)
milk_yield <- overall_milk + rep(true_sta, n_progeny) + rnorm(sum(n_progeny), 0, sigma_e)

# Add covariates
age_first_calving <- round(rnorm(sum(n_progeny), 25, 2.5))  # months
days_in_milk <- round(rnorm(sum(n_progeny), 180, 40))  # days

dairy_data <- data.frame(
  daughter_id = daughter_id,
  sire = factor(sire_vec),
  milk_yield = milk_yield,
  age_first_calving = age_first_calving,
  days_in_milk = days_in_milk
)

write.csv(dairy_data, "dairy_sire.csv", row.names = FALSE)
cat("\nCreated dairy_sire.csv: n =", nrow(dairy_data), "\n")
print(table(dairy_data$sire))

# =============================================================================
# Dataset 3: Layer Hen Egg Production (Strain, Unbalanced)
# =============================================================================

strains <- c("Leghorn_White", "Rhode_Island_Red", "Plymouth_Rock", "Australorp")
n_strain <- c(12, 8, 15, 10)

# True strain effects
overall_eggs <- 280  # eggs/year
strain_effects <- c(Leghorn_White = 25, Rhode_Island_Red = -10,
                    Plymouth_Rock = -5, Australorp = 0)
sigma_eggs <- 35

# Generate data
strain_vec <- rep(strains, n_strain)
hen_id <- 1:sum(n_strain)
egg_production <- overall_eggs + rep(strain_effects, n_strain) +
                  rnorm(sum(n_strain), 0, sigma_eggs)

# Add body weight covariate
body_weight <- rnorm(sum(n_strain), 1.8, 0.25)
# Adjust egg production for body weight relationship
egg_production <- egg_production + 8 * (body_weight - 1.8)

layer_data <- data.frame(
  hen_id = hen_id,
  strain = factor(strain_vec),
  egg_production = round(egg_production),
  body_weight = round(body_weight, 2)
)

write.csv(layer_data, "layer_egg_production.csv", row.names = FALSE)
cat("\nCreated layer_egg_production.csv: n =", nrow(layer_data), "\n")
print(table(layer_data$strain))

# =============================================================================
# Dataset 4: Swine Litter Size (Breed, Unbalanced)
# =============================================================================

breeds_swine <- c("Yorkshire", "Landrace", "Duroc", "Hampshire")
n_breed_swine <- c(8, 6, 10, 7)

# True breed effects
overall_litter <- 10.5  # pigs born alive
breed_effects_swine <- c(Yorkshire = 1.5, Landrace = 1.0,
                         Duroc = -1.0, Hampshire = 0.5)
sigma_litter <- 2.0

# Generate data
breed_vec_swine <- rep(breeds_swine, n_breed_swine)
sow_id <- 1:sum(n_breed_swine)
litter_size <- overall_litter + rep(breed_effects_swine, n_breed_swine) +
               rnorm(sum(n_breed_swine), 0, sigma_litter)
litter_size <- pmax(round(litter_size), 6)  # Minimum 6 pigs

# Add parity covariate
parity <- sample(1:4, sum(n_breed_swine), replace = TRUE, prob = c(0.3, 0.3, 0.25, 0.15))

swine_data <- data.frame(
  sow_id = sow_id,
  breed = factor(breed_vec_swine),
  parity = factor(parity),
  litter_size = litter_size
)

write.csv(swine_data, "swine_litter.csv", row.names = FALSE)
cat("\nCreated swine_litter.csv: n =", nrow(swine_data), "\n")
print(table(swine_data$breed))
print(table(swine_data$parity))

# =============================================================================
# Dataset 5: Broiler Body Weight (Strain × Sex, Unbalanced)
# =============================================================================

strains_broiler <- c("Cobb", "Ross", "Hubbard")
sex <- c("Male", "Female")

# Cell design (unequal but all cells present)
cell_n_broiler <- matrix(c(
  15, 12,  # Cobb
  20, 18,  # Ross
  10, 14   # Hubbard
), nrow = 3, byrow = TRUE)

overall_bw <- 2.5  # kg at 42 days
strain_effects_broiler <- c(Cobb = 0.1, Ross = 0.15, Hubbard = 0.05)
sex_effects_broiler <- c(Male = 0.3, Female = 0)
sigma_bw <- 0.25

# Generate data
broiler_data <- data.frame()
bird_id <- 1

for(i in 1:3) {  # strains
  for(j in 1:2) {  # sex
    n <- cell_n_broiler[i, j]
    bw <- overall_bw + strain_effects_broiler[i] + sex_effects_broiler[j] +
          rnorm(n, 0, sigma_bw)
    temp_df <- data.frame(
      bird_id = bird_id:(bird_id + n - 1),
      strain = strains_broiler[i],
      sex = sex[j],
      body_weight = bw
    )
    broiler_data <- rbind(broiler_data, temp_df)
    bird_id <- bird_id + n
  }
}

# Add age covariate (days)
broiler_data$age <- round(rnorm(nrow(broiler_data), 42, 1.5))

write.csv(broiler_data, "broiler_bodyweight.csv", row.names = FALSE)
cat("\nCreated broiler_bodyweight.csv: n =", nrow(broiler_data), "\n")
print(table(broiler_data$strain, broiler_data$sex))

cat("\n===== All datasets created successfully! =====\n")
cat("Files saved in current directory:\n")
cat("1. beef_feedlot.csv\n")
cat("2. dairy_sire.csv\n")
cat("3. layer_egg_production.csv\n")
cat("4. swine_litter.csv\n")
cat("5. broiler_bodyweight.csv\n")
