# --------------------------------------------------------------------------
# SCRIPT: 04_imputation_example.R
#
# PURPOSE: linear interpolation.
# --------------------------------------------------------------------------


if (!require("dplyr")) install.packages("dplyr")
if (!require("imputeTS")) install.packages("imputeTS")
if (!require("ggplot2")) install.packages("ggplot2")

library(dplyr)
library(imputeTS)
library(ggplot2)



imputed_data <- merged_data %>%
  group_by(country_iso3) %>%
  arrange(year) %>%
  mutate(
    imputed_gdp = if (sum(!is.na(wb_gdp_pc)) >= 2) {
      na_interpolation(wb_gdp_pc)
    } else {
      wb_gdp_pc
    }
  ) %>%
  ungroup()



imputed_data %>%
  filter(country_iso3 == "POL") %>%
  ggplot(aes(x = year)) +
  geom_line(aes(y = imputed_gdp), color = "dodgerblue", linewidth = 1) +
  geom_point(aes(y = wb_gdp_pc), color = "red", size = 2.5) +
  labs(
    title = "GDP per Capita for Poland (Imputed vs. Original)",
    subtitle = "Red points are original data. The blue line shows the imputed time-series.",
    x = "Year",
    y = "GDP per Capita (Constant 2015 US$)",
    caption = "Source: World Bank data with linear interpolation for missing values."
  ) +
  theme_minimal()