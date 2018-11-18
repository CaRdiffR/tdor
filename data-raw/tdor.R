library("dplyr")
library("janitor")
library("lubridate")
library("purrr")
library("readr")
library("tidyr")
library("usethis")

# Get Data ----
# Data sourced from https://bitbucket.org/annajayne/tdor_data/downloads/, unzipped and the contents of the data folder placed in data-raw

tdor <-
  list.files("./data-raw/tdor_data",
             "*.csv",
             recursive = TRUE,
             full.names = TRUE)  %>%
  map(~ suppressWarnings(read_csv(.))) %>%
  # ensure variables same class across data sets
  map(mutate,
      Age = as.character(Age),
      Date = dmy(Date)) %>%
  # combine and remove redundant rows/columns
  bind_rows() %>%
  remove_empty(which = c("rows", "cols")) %>%
  filter(!is.na(Name)) %>%
  # sometimes age is a range; separate into min and max
  mutate(Age = ifelse(Age == "32-25", "32-35", Age)) %>%
  separate(Age, into = c("Age_min", "Age_max"), sep = "-", remove = FALSE) %>%
  mutate(Age_min = ifelse(!is.na(as.numeric(Age_min)), as.numeric(Age_min),
                          as.numeric(sub("(Approx. )", "", Age))),
         Age_max = ifelse(!is.na(Age_max), as.numeric(Age_max),
                          as.numeric(sub("(Approx. |Under )", "", Age)))) %>%
  # filter to last complete TDoR period
  mutate(Month = month(Date),
         Year = year(Date),
         TDoR = ifelse(Month %in% 1:9, Year, Year + 1)) %>%
  filter(Date < as.Date("2018-10-01"))

use_data(tdor, overwrite = TRUE)



