# Honey Bee Smart Feeding Calculator Shiny App

## Overview

The **Honey Bee Smart Feeding Calculator Shiny App** is a free interactive R Shiny application designed to help beekeepers estimate sugar feeding requirements and economic costs associated with overwintering honey bee colonies.

The application supports both:

- *Apis mellifera*
- *Apis cerana*

The tool allows users to estimate:
- total overwintering food requirements,
- total sugar needed for 50% sugar syrup preparation,
- estimated sugar costs,
- estimated honey replacement costs.

The app is intended for:
- practical beekeeping,
- educational purposes,
- overwintering planning,
- economic estimation.

---

## Scientific Background

Successful overwintering of honey bee colonies depends strongly on sufficient food reserves and colony strength. Feeding management strategies vary according to climate, bee species, local beekeeping traditions, and environmental conditions.

This application was developed to provide a simple and transparent tool for estimating:
- colony food requirements,
- sugar feeding needs,
- economic effectiveness of overwintering strategies.

The calculator uses approximate practical conversion factors commonly applied in beekeeping practice.

---

## Installation

### 1. Install R

Download and install R:

https://cran.r-project.org/

### 2. Install RStudio (Optional)

Download RStudio Desktop:

https://posit.co/download/rstudio-desktop/

### 3. Install Required Packages

Run “RUN1 pre.R” to install packages. 

### 4. Run the Application

Run "RUN2.R" in RStudio and click:
Run App

or execute:

shiny::runApp()

---

# How to Use
## Step 1 — Select Bee Species
Choose:
A = Apis cerana
B = Apis mellifera
## Step 2 — Enter Colony Information
Input:
	number of frames per colony,
	number of colonies,
	sugar price per kg,
	honey price per kg.
## Step 3 — Run Calculation

Click:
	Predict
# The application calculates:

	total overwintering food,
	total sugar required,
	estimated sugar costs,
	estimated honey costs.
### Step 4 — View Results
Results are displayed as:
	data tables,
	graphical outputs.
### Step 5 — Get Outputs

## Sugar-to-Honey Conversion

The application uses an approximate practical conversion factor: 1.5

This factor may vary depending on:

	colony strength,
	colony health,
	feeding method,
	environmental temperature,
	seasonal conditions.
## Applications

The application can be used for:

	planning overwintering feeding strategies,
	estimating sugar requirements,
	economic comparison of feeding approaches,
	educational demonstrations,
	extension and outreach activities.
## Limitations

The tool provides approximate estimates only.

The application does not account for:

	regional climate variation,
	nectar availability,
	colony genetics,
	disease status,
	parasite pressure,
	colony-specific overwintering success,
	market fluctuations,
	additional management costs.

Results should be interpreted together with field observations and local beekeeping experience.

# Troubleshooting
## Missing Packages

Install missing packages manually:

install.packages("package_name")
Older R Version

Recommended:

R version ≥ 4.0
Test Shiny Installation
library(shiny)
runExample("01_hello")

If the example works, Shiny is correctly installed.

## Repository Structure
HoneyBee_Overwintering_Calculator/
│
├── app.R
├── README.md
├── LICENSE
├── CITATION.cff
├── requirements.R
└── screenshots/
##Citation

If you use this software in scientific work, please cite:

Frunze O. (2026).
Honey Bee Overwintering and Economic Effectiveness Shiny App.
GitHub repository.
License

This project is distributed under the GNU General Public License v3.0 (GPL-3.0).

## Disclaimer

This software is intended for educational and planning purposes only.

The calculated values are approximate and should not replace professional beekeeping assessment or direct colony inspection.

## Contact
Prof. Hyung-Wook Kwon
E-mail: hwkwon@inu.ac.kr
PhD. Olga Frunze
Division of Life Science
Incheon National University
Republic of Korea
