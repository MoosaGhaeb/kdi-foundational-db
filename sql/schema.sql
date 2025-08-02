-- SQL Schema for the KDI Foundational Database Project

DROP TABLE IF EXISTS harmonized_data;


CREATE TABLE harmonized_data (
    country_iso3   VARCHAR(3) NOT NULL,
    year           INTEGER NOT NULL,
    country_name   TEXT,
    vdem_polyarchy DOUBLE PRECISION,
    qog_bci        DOUBLE PRECISION,
    wb_gdp_pc      DOUBLE PRECISION,

    PRIMARY KEY (country_iso3, year)
);
