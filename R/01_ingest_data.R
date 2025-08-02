# --------------------------------------------------------------------------
# SCRIPT: 01_ingest_and_assess_data.R
# PROJECT: KDI Foundational Database
#
# PURPOSE: 1. Load necessary libraries.
#          2. Ingest raw data from three sources.
#
# --------------------------------------------------------------------------


if (!require("wbstats")) install.packages("wbstats")
if (!require("dplyr")) install.packages("dplyr")
if (!require("haven")) install.packages("haven")

library(wbstats)
library(dplyr)
library(haven)



dir.create("data/vdem", showWarnings = FALSE, recursive = TRUE)
dir.create("data/qog", showWarnings = FALSE, recursive = TRUE)


# World Bank Data (via API)
wb_raw_data <- wb_data(
  indicator = "NY.GDP.PCAP.KD",
  start_date = 1990,
  end_date = 2023
)


# V-Dem Data
vdem_url <- "https://www.v-dem.net/media/datasets/V-Dem-CY-Core-v15_dta.zip"
vdem_zip_path <- "data/vdem/V-Dem-CY-Core-v15.zip"
vdem_dta_path <- "data/vdem/V-Dem-CY-Core-v15.dta"

if (!file.exists(vdem_zip_path)) {
  download.file(vdem_url, destfile = vdem_zip_path, mode = "wb")
}
if (!file.exists(vdem_dta_path)) {
  unzip(vdem_zip_path, exdir = "data/vdem")
}
vdem_raw_data <- read_dta(vdem_dta_path)


# QoG Data
qog_url <- "https://www.qogdata.pol.gu.se/data/qog_std_ts_jan25.csv"
qog_csv_path <- "data/qog/qog_std_ts_jan25.csv"

if (!file.exists(qog_csv_path)) {
  download.file(qog_url, destfile = qog_csv_path, mode = "wb")
}
qog_raw_data <- read.csv(qog_csv_path)
