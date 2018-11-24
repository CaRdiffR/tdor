library("tidyverse")
library("ggmap")
load("~/R/tdor/data/tdor.rda")

# Found some Names that need to be corrected
Name_Data_Incorrect <- tdor %>% filter(str_detect(Name, "Name Unknown") & Name != "Name Unknown")

# All missing Locations had Longitude and Latitude, so I found what those Location fields should be.
Calculated_Locations <- read_csv("data/coords.csv")
Calculated_Locations <- Calculated_Locations %>%
  mutate(Location = if_else(!is.na(State), paste0(City, ", ", State), paste0(City))) %>%
  select(Latitude, Longitude, Location)
