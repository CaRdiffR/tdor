library("tidyverse")
library("janitor")

# Get Data ----
# Data sourced from https://bitbucket.org/annajayne/tdor_data/downloads/, unzipped and the contents of the data folder placed in data-raw

list.files("./data-raw/tdor_data",
           "*.csv",
           recursive = TRUE,
           full.names = TRUE)  %>%
  map( ~ read_csv(.)) %>%
  map(., mutate, Age = as.character(Age)) %>%
  bind_rows() %>%
  remove_empty(dat = ., which = c("rows", "cols")) %>%
  filter(!is.na(Permalink))-> tdor_files



