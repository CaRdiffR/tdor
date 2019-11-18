library("countrycode")
library("dplyr")
library("janitor")
library("lubridate")
library("purrr")
library("readr")
library("tidyr")
library("usethis")
library("WDI")

# Get Data ----
# Data sourced from https://bitbucket.org/annajayne/tdor_data/downloads/, unzipped and the contents of the data folder placed in data-raw
dir <- "./data-raw/tdor_data"
# OR fork/clone https://bitbucket.org/annajayne/tdor_data
dir <- "../tdor_data/Data"

## data corresponding to commit: 9174f76
files <- list.files(dir,
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
actual_nm

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
  Country = col_character(),
  Latitude = col_double(),
  Longitude = col_double(),
  `Cause of death` = col_character(),
  Description = col_character(),
  Permalink = col_character(),
  `State/Province` = col_character(),
  Tweet = col_character()
)

# combine all data files

tdor <- files %>%
  map(~ suppressWarnings(read_csv(., col_types = col_types))) %>%
  # combine and remove redundant rows
  bind_rows() %>%
  remove_empty(which = "rows") %>%
  select(!!names(col_types$cols))

# fix known data issues ... currently all fixed at source

# add R only variables/fix up data types

tdor <- tdor %>%
  # sometimes age is a range; separate into min and max
  separate(Age, into = c("Age min", "Age max"), sep = "-", remove = FALSE) %>%
  mutate(`Age min` = suppressWarnings(ifelse(!is.na(as.numeric(`Age min`)),
                                           as.numeric(`Age min`),
                                           as.numeric(sub("(Approx. )",
                                                          "", Age)))),
         `Age max` = suppressWarnings(ifelse(!is.na(`Age max`), as.numeric(`Age max`),
                                           as.numeric(sub("(Approx. |Under )",
                                                          "", Age))))) %>%
  # simple conversion to TDOR period no longer works
  mutate(Date = dmy(Date),
         Month = month(Date),
         Year = year(Date),
         TDoR =
           case_when(
             # TDoR started in 1999
             Date < as.Date("1998-11-19") ~ NA_real_,
             # up to 2010, covered year in between TDoR days
             between(Date, as.Date("1998-11-20"), as.Date("2010-11-19")) ~
               case_when(Month %in% 1:10 ~ Year,
                         Month == 12 ~ Year  + 1,
                         day(Date) < 20 ~ Year,
                         TRUE ~ Year + 1),
             # for a few years cutoff date kept shifting earlier
             Date < as.Date("2011-11-14") ~ 2011,
             Date < as.Date("2012-11-19") ~ 2012,
             Date < as.Date("2013-09-30") ~ 2013,
             # 1st October to 30th September from now on
             TRUE ~ ifelse(Month %in% 1:9, Year, Year + 1)
           )) %>%
  # country code
  mutate(`Country code` = countrycode(Country, "country.name", "iso3c")) %>%
  # logical order
  select(Name, Age, `Age min`, `Age max`,
         Date, Month, Year, TDoR,
         Location, `State/Province`, Country, `Country code`, Latitude, Longitude,
         `Cause of death`, Description,
         `Photo source`, `Source ref`, Tweet, Permalink)

use_data(tdor, overwrite = TRUE)



