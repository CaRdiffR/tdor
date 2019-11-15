# Example of correcting data issues: correcting column names
# Changes here in the following PR (N.B. Mercurial repo)
# https://bitbucket.org/annajayne/tdor_data/pull-requests/4/correct-source-ref-column-names/diff
library("dplyr")
library("purrr")
library("readr")

# Get Data ----
# Data sourced from https://bitbucket.org/annajayne/tdor_data/downloads/, unzipped
files <- list.files("./Data",
                    "*.csv$",
                    recursive = TRUE,
                    full.names = TRUE)

# Read in raw data
tdor_raw <- files %>%
  map(~ suppressWarnings(read_csv(.)))

# Get all column names
nm <- tdor_raw %>%
  map(names)

# ID files with column name "Source Ref"
id <- numeric(0)
for (i in seq_along(nm))
  if (any(nm[[i]] %in% "Source Ref")) id <- c(id, i)

# Correct to "Source ref"
for (i in id){
  read_csv(files[i]) %>%
    rename(`Source ref` = `Source Ref`) %>%
    write_csv(files[i], na = "")
}

# Repeat (separate commit) for TGEU ref to Source ref
id <- numeric(0)
for (i in seq_along(nm))
  if (any(nm[[i]] %in% c("TGEU ref"))) id <- c(id, i)

## Here it was important to read and write all columns as character to avoid
## making unwanted changes
col_types <- cols_only(
  Name = col_character(),
  Age = col_character(),
  Photo = col_character(),
  `Photo source` = col_character(),
  Date = col_character(),
  `TGEU ref` = col_character(),
  Location = col_character(),
  `State/Province` = col_character(),
  Country = col_character(),
  Latitude = col_character(),
  Longitude = col_character(),
  `Cause of death` = col_character(),
  Description = col_character(),
  Tweet = col_character(),
  Permalink = col_character()
)

for (i in id){
  read_csv(files[i], col_types = col_types) %>%
    rename(`Source ref` = `TGEU ref`) %>%
    write_csv(files[i], na = "")
}
