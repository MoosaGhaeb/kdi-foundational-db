# --------------------------------------------------------------------------
# SCRIPT: 02_transform_and_merge.R
# PROJECT: KDI Foundational Database
#
# PURPOSE: 1. Cleans and standardizes each of the three datasets.
#          2. Filters each dataset to the relevant time period (1990+).
#          3. Merges the clean datasets into a single master data frame.
#
# --------------------------------------------------------------------------


# world bank
wb_clean <- wb_raw_data %>%
  filter(date >= 1990) %>%
  select(iso3c, country, date, NY.GDP.PCAP.KD) %>%
  rename(
    country_iso3 = iso3c,
    country_name = country,
    year = date,
    wb_gdp_pc = NY.GDP.PCAP.KD
  )


# vdem
vdem_clean <- vdem_raw_data %>%
  filter(year >= 1990) %>%
  select(country_text_id, country_name, year, v2x_polyarchy) %>%
  rename(
    country_iso3 = country_text_id,
    vdem_polyarchy = v2x_polyarchy
  )


# qog
qog_clean <- qog_raw_data %>%
  filter(year >= 1990) %>%
  select(ccodealp, cname, year, bci_bci) %>%
  rename(
    country_iso3 = ccodealp,
    country_name = cname,
    qog_bci = bci_bci
  )



# join
merged_data_temp <- vdem_clean %>%
  full_join(qog_clean, by = c("country_iso3", "year")) %>%
  full_join(wb_clean, by = c("country_iso3", "year"))


merged_data <- merged_data_temp %>%
  mutate(country_name = coalesce(country_name.x, country_name.y, country_name)) %>%
  select(country_iso3, country_name, year, vdem_polyarchy, qog_bci, wb_gdp_pc)
