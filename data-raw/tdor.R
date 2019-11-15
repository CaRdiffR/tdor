library("dplyr")
library("janitor")
library("lubridate")
library("purrr")
library("readr")
library("tidyr")
library("usethis")

# Get Data ----
# Data sourced from https://bitbucket.org/annajayne/tdor_data/downloads/, unzipped and the contents of the data folder placed in data-raw

## data corrsponding to commit: 4ef244b
files <- list.files("./data-raw/tdor_data",
                    "*.csv$",
                    recursive = TRUE,
                    full.names = TRUE)

# Read in raw data
tdor_raw <- files %>%
  map(~ suppressWarnings(read_csv(.)))

# Get all column names
nm <- tdor_raw %>%
  map(names)

# Check for unexpected names (errors or changes over time) against current variables and definitions: https://bitbucket.org/annajayne/tdor_data/src/default/
unique_nm <- nm %>% unlist() %>% unique()
empty <- grep("^[X][0-9]+$", unique_nm)
actual_nm <- unique_nm[-empty]

# Consider fixing and submitting PR to Bitbucket repo, otherwise allow for variants below

# Check current variables and definitions: https://bitbucket.org/annajayne/tdor_data/src/default/
col_types <- cols_only(
  Name = col_character(),
  Age = col_character(),
  Photo = col_character(),
  `Photo source` = col_character(),
  Date = col_character(),
  `Source ref` = col_character(),
  Location = col_character(),
  `State/Province` = col_character(),
  Country = col_character(),
  Latitude = col_double(),
  Longitude = col_double(),
  `Cause of death` = col_character(),
  Description = col_character(),
  Tweet = col_character(),
  Permalink = col_character()
)

tdor <- files %>%
  map(~ suppressWarnings(read_csv(., col_types = col_types))) %>%
  # combine and remove redundant rows
  bind_rows() %>%
  remove_empty(which = "rows") %>%
  select(!!names(col_types$cols)) %>%
  # fix known data issues
  filter(!is.na(Name)) %>% # empty row with one "`" in cause of death column
  # sometimes age is a range; separate into min and max
  separate(Age, into = c("Age_min", "Age_max"), sep = "-", remove = FALSE) %>%
  mutate(Age_min = suppressWarnings(ifelse(!is.na(as.numeric(Age_min)),
                                           as.numeric(Age_min),
                                           as.numeric(sub("(Approx. )",
                                                          "", Age)))),
         Age_max = suppressWarnings(ifelse(!is.na(Age_max), as.numeric(Age_max),
                                           as.numeric(sub("(Approx. |Under )",
                                                          "", Age))))) %>%
  # simple conversion to TDOR period no longer works
  mutate(Date = dmy(Date),
         Month = month(Date),
         Year = year(Date)) %>%
  select(Name:Date, Month, Year, everything())

use_data(tdor, overwrite = TRUE)



