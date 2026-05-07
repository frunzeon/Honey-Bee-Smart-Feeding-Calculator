# ===============================
# Honey Bee Shiny App - One-Click Launch
# ===============================

# --- Step 1: Install required packages if missing ---
required_pkgs <- c('shiny','readr','DT','writexl','ggplot2','dplyr')
for (p in required_pkgs) {
  if (!requireNamespace(p, quietly = TRUE)) {
    install.packages(p, dependencies = TRUE)
  }
}

# --- Step 2: Load packages ---
library(shiny)
library(readr)
library(DT)
library(writexl)
library(ggplot2)
library(dplyr)

# --- Step 3: Launch the Shiny app ---
# Make sure app.R is in the same folder as this script
app_path <- file.path(dirname(normalizePath(sys.frame(1)$ofile)), "app.R")

if (!file.exists(app_path)) {
  stop("app.R not found in the same folder as this script. Please place app.R here.")
}

shiny::runApp(app_path)
