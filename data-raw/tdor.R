library("tidyverse")
library("janitor")

# Get Data ----
# Data sourced from https://bitbucket.org/annajayne/tdor_data/downloads/, unzipped and the contents of the data folder placed in data-raw
list.files("./data-raw/tdor_data",
           "*.csv",
           recursive = TRUE,
           full.names = TRUE)  %>%
  map( ~ read_csv(.)) %>%
  map(., mutate,
      Age = as.character(Age),
      Date = dmy(Date, tz = "GMT")
      ) %>%
  bind_rows() %>%
  remove_empty(dat = ., which = c("rows", "cols")) %>%
  filter(!is.na(Name)) -> tdor_files

# tdor_files %>%
#   mutate(Year = year(Date),
#          Month = month(Date))%>%
#   group_by(Year, Month) %>%
#   summarise(n()) %>%
#   View(.)


