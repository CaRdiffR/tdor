library("tidyverse")
library("ggmap")
load("~/R/tdor/data/tdor.rda")

# Found some Names that need to be corrected
tdor <- tdor %>% mutate(Name = if_else(
  str_detect(Name, "Name Unknown") & Name != "Name Unknown",
  str_replace(Name, "Name Unknown", "nn"),
  Name
))
# Summary of how many missings there are per variable
missings <- mutate(tdor, Name = if_else(Name != "Name Unknown", Name, NULL))
missings <- data.frame(colSums(is.na(missings)))

# To improve our data, if you knew any of the following victims' ages, please report this information here:
# User can maybe drill down by geography to check who is missing age data
Help_Find_Ages <- tdor %>%
  filter(is.na(Age) & Name != "Name Unknown") %>%
  select(Name, Country, Location, Date_of_Death = Date)

# To improve our data, if you have a photo of any of the following victims, please send this information here:
# User can maybe drill down by geography to check who is missing a photo
Help_Find_Images <- tdor %>%
  filter(is.na(Photo) & Name != "Name Unknown") %>%
  select(Name, Country, Location, Date_of_Death = Date)

# To improve our data, if you know the names of any of the following victims, please report this information here:
# User can maybe drill down by geography to check who is missing a name
Help_Find_Names <- tdor %>%
  filter(Name == "Name Unknown") %>%
  select(Country, Location, Date_of_Death = Date, Age, Photo, Description)

# To improve our data, if you knew any of the circumstances around the following victims' deaths, please report this information here:
# User can maybe drill down by geography to check who is missing this data
Help_Find_Info <- tdor %>%
  filter(is.na(Description) & is.na(Source)) %>%
  select(Name, Age, Photo, Date, Location, Country, Permalink, `Cause of death`)

