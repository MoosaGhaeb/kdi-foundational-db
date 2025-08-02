# Harmonizing Macro-Level Democratic Indicators

## Core Objective

This project demonstrates a complete data engineering pipeline to address a common challenge in computational social science: data fragmentation. Its goal is to ingest data from three separate, high-profile sources (The World Bank, V-Dem, and The QoG Institute), perform a deterministic linkage, and load the resulting harmonized dataset into a structured PostgreSQL database.

The result is a single, analysis-ready resource that serves as a case study in building a robust, reproducible, and documented process for data integration.

## Key Features & Skills Demonstrated

This project showcases a range of data engineering and analysis skills:

* **Data Pipeline Development:** An end-to-end, scripted pipeline using R to perform ETL (Extract, Transform, Load) operations.
* **Database Management (PostgreSQL):**
    * Designing a logical database schema with a composite primary key to ensure data integrity.
    * Writing and executing SQL scripts (`schema.sql`) to create the database structure.
    * Loading cleaned data from R into the PostgreSQL database using the `DBI` and `RPostgres` packages.
* **R Programming:**
    * Using `dplyr` for efficient data cleaning, transformation, and manipulation.
    * Ingesting data from multiple sources, including a web API (`wbstats`) and static files (`.csv`, `.dta`).
    * Implementing methodological extensions, such as time-series imputation using `imputeTS` to handle missing data.
* **Deterministic Linking:** Merging disparate datasets using a robust, key-based approach (`country_iso3`, `year`). A `full_join` strategy was deliberately chosen to create a complete data matrix, preserving all observations from all sources and explicitly marking missing data as `NA` for potential future imputation.
* **Technical Documentation:**
    * This `README.md` file (Markdown).
* **Version Control:** The entire project is managed using **Git**.

## Data Sources

* **Varieties of Democracy (V-Dem):** The V-Dem Country-Year Core Dataset.
* **The Quality of Government (QoG) Institute:** The QoG Standard Time-Series Dataset.
* **The World Bank:** World Development Indicators, specifically GDP per capita (Constant 2015 US$), accessed via the World Bank API.

## Project Structure

```text
KDI_Foundational_DB/
└── R/
    ├── 01_ingest_and_assess_data.R
    ├── 02_transform_and_merge.R
    ├── 03_load_to_db.R
    └── 04_imputation_example.R
└── sql/
    └── schema.sql
└── data/
    ├── qog/
    │   └── qog_std_ts_jan25.csv
    └── vdem/
        └── V-Dem-CY-Core-v15.dta
└── .gitignore
└── KDI_Foundational_DB.Rproj
└── README.md
```

* **/data**: Contains the raw data downloaded by the ingestion script, organized by source. This folder is included in `.gitignore`.
* **/R**: Contains all R scripts, numbered in the order they should be run.
* **/sql**: Contains the SQL script to define the database schema.
* **.gitignore**: Specifies files and folders for Git to ignore (e.g., the `/data` folder and environment files).
* **README**: This file.

## How to Replicate This Project

**1. Prerequisites:**

* R and RStudio installed.
* PostgreSQL installed and running.
* Git installed.

**2. Setup:**

* Clone this repository to your local machine.
* Create a PostgreSQL database named `kdi_db`.
* Execute the `sql/schema.sql` script to create the `harmonized_data` table.
* Create a `.Renviron` file in the project root and add your database password: `DB_PASSWORD="your_password"`.
* Open the `KDI_Foundational_DB.Rproj` file in RStudio to set the correct working directory.

**3. Run the R Scripts:**

* Execute the R scripts in the `/R` folder in numerical order:
    1.  `01_ingest_and_assess_data.R` (Downloads all raw data)
    2.  `02_transform_and_merge.R` (Cleans and merges the data)
    3.  `03_load_to_db.R` (Loads the final data into PostgreSQL)
    4.  `04_imputation_example.R` (Runs the bonus imputation and visualization)

## Final Database Schema (`harmonized_data`)

| Column Name      | Data Type          | Description                                         |
| :--------------- | :----------------- | :-------------------------------------------------- |
| `country_iso3`   | `VARCHAR(3)`       | **Primary Key.** 3-letter ISO country code.         |
| `year`           | `INTEGER`          | **Primary Key.** The year of observation.           |
| `country_name`   | `TEXT`             | Common English name of the country.                 |
| `vdem_polyarchy` | `DOUBLE PRECISION` | V-Dem's Electoral Democracy Index.                  |
| `qog_bci`        | `DOUBLE PRECISION` | QoG's Basic Corruption Index.                       |
| `wb_gdp_pc`      | `DOUBLE PRECISION` | World Bank's GDP per capita (Constant 2015 US$).    |

