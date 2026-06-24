# Honey Bee Smart Feeding Calculator
# Decision-Support Tool for Pre-Overwintering Feeding Management

## Overview

The **Honey Bee Smart Feeding Calculator Shiny App** is a free interactive R Shiny application designed to support estimation of overwintering food reserve requirements and associated feeding costs in honey bee colonies.

The application supports both:

- *Apis mellifera*
- *Apis cerana*

The calculator allows users to estimate:
- target overwintering food reserves,
- reserve-based sugar feeding requirements,
- estimated supplemental sugar costs,
- estimated market value of equivalent honey reserves,
- economic comparisons between feeding costs and honey reserve value.

The app is intended for:
- practical beekeeping,
- educational purposes,
- overwintering planning,
- economic estimation,
- research and extension activities.

---

## Scientific Background

Successful overwintering of honey bee colonies depends on maintaining sufficient food reserves and appropriate colony strength before winter. Feeding strategies vary according to climate, bee species, and local beekeeping practices.

This application was developed to provide a simple and transparent tool for estimating:
- colony food requirements,
- sugar feeding needs,
- economic effectiveness of overwintering strategies.

The Honey Bee Smart Feeding Calculator was developed to provide a transparent and user-friendly framework for estimating:
- overwintering food reserve requirements,
- reserve-based sugar feeding requirements,
- associated feeding costs,
- management considerations related to winter food reserves and feeding requirements.
  
The calculator uses species-specific reserve estimates derived from published beekeeping recommendations and practical management guidelines. It is intended as a decision-support tool and does not replace direct colony inspection or professional beekeeping judgment.
Importantly, the calculator is not designed to encourage replacement of natural honey stores with sugar syrup. Rather, it aims to assist decision-making when supplemental feeding is required because winter food reserves are insufficient.

---

## Installation

### 1. Install R

Download and install R:

https://cran.r-project.org/

### 2. Install RStudio (Optional)

Download RStudio Desktop:

https://posit.co/download/rstudio-desktop/

### 3. Install Required Packages

Run “RUN1_pre.R” to install packages. 

### 4. Run the Application

Run "RUN2_app.R" in RStudio and click:
Run App

or execute:

shiny::runApp()

## How to Use

### Step 1 — Select Bee Species
Choose:
- A = *Apis cerana*
- B = *Apis mellifera* (Langstroth or Dadant)
### Step 2 — Enter Colony Information
Input:
- number of frames per colony,
- number of colonies,
- sugar price per kg,
- honey price per kg.
### Step 3 — Run Calculation
Click:
- Run calculation
#### The application calculates:
- total overwintering food,
- total sugar required,
- estimated sugar costs,
- estimated honey costs.
### Step 4 — View Results
Results are displayed as:
- data tables,
- graphical outputs.

## Calculation framework

The calculator uses species-specific estimates of overwintering food reserves:
- Apis cerana	2 kg per frame
- Apis mellifera (Langstroth)	3 kg per frame
- Apis mellifera (Dadant)	4 kg per frame
* These values represent generalized reference estimates derived from practical beekeeping recommendations and management guidelines.
* The application estimates target overwintering food reserves and corresponding reserve-based feeding requirements using these species-specific reference values.
### Economic outputs are calculated using user-defined honey and sugar prices.
The economic efficiency ratio is calculated as:
- Supplemental Sugar Cost ÷ Honey Reserve Value
* This comparison is intended to illustrate management options and economic considerations and should not be interpreted as a recommendation to replace natural honey stores with sugar syrup.
 
## Limitations

- The calculator provides approximate estimates only.
- The current version of the calculator estimates target food reserve requirements based on colony size and species-specific reference values. Measured honey reserves already present in colonies are not directly incorporated into calculations and should be considered separately by the user.
- 
The application does not directly account for:

- regional climate variation,
- nectar availability,
- colony genetics,
- disease status,
- parasite pressure,
- colony-specific overwintering success,
- market fluctuations,
- additional management costs.

Results should be interpreted together with field observations, colony inspections, and local beekeeping experience.

## Troubleshooting
### Missing Packages

Install missing packages manually:
- install.packages("package_name")
- Older R Version

Recommended:

- R version ≥ 4.0
- Test Shiny Installation
library(shiny)
runExample("01_hello")

If the example works, Shiny is correctly installed.

## Citation

If you use this software in scientific work, please cite:
Frunze, O., Park, J., Lee, J.-H., Kim, H., Woo, S.O., Han, S.M., & Kwon, H.-W. (2026). Honey Bee Smart Feeding Calculator (Version 1.0). Zenodo. DOI: 10.5281/zenodo.20101912

## License

This project is distributed under the GNU General Public License v3.0 (GPL-3.0).

## Disclaimer

This software is intended for educational, research, and planning purposes only.
All calculations represent generalized estimates and should not replace professional beekeeping assessment, direct colony inspection, or locally adapted management recommendations.
The authors assume no responsibility for management decisions made solely on the basis of calculator outputs.

## Contact
#### Prof. Hyung-Wook Kwon
- E-mail: hwkwon@inu.ac.kr
- Department of Life Sciences
- Incheon National University
- Republic of Korea
  
#### PhD. Olga Frunze
- E-mail: frunzeon@gmail.com
- Division of Life Science
- Incheon National University
- Republic of Korea

## Screenshots

### Main Interface

![Main Interface](screenshots/main_interface.PNG)

### Example Calculation

![Calculation](screenshots/calculations.PNG)

### Results for *Apis cerana*

![Apis cerana Results](screenshots/results_Apis_cerana.PNG)

### Results for *Apis mellifera*

![Apis mellifera Results](screenshots/results_Apis_mellifera.PNG)
