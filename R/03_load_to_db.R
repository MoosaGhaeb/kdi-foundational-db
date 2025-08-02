# --------------------------------------------------------------------------
# SCRIPT: 03_load_to_db.R
# PROJECT: KDI Foundational Database
#
# PURPOSE: This script takes the final, merged dataframe from the R
#          environment and writes it to the 'harmonized_data' table
#          in the PostgreSQL database.
#
# --------------------------------------------------------------------------


if (!require("DBI")) install.packages("DBI")
if (!require("RPostgres")) install.packages("RPostgres")

library(DBI)
library(RPostgres)


# Establish the connection using credentials stored in .Renviron
con <- dbConnect(RPostgres::Postgres(),
                 dbname = "kdi_db",
                 host = "localhost",
                 port = 5432,
                 user = "postgres",
                 password = Sys.getenv("DB_PASSWORD")
)


dbWriteTable(con,
             "harmonized_data",
             merged_data,
             overwrite = TRUE,
             row.names = FALSE)

dbDisconnect(con)
