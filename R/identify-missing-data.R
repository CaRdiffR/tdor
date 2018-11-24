library("tidyverse")
library("ggmap")
load("~/R/tdor/data/tdor.rda")

missings <- c(
  sum(is.na(tdor$Name) | tdor$Name == "Name Unknown"),
  sum(is.na(tdor$Age)),
  sum(is.na(tdor$Age_min)),
  sum(is.na(tdor$Age_max)),
  sum(is.na(tdor$Photo)),
  sum(is.na(tdor$`Photo source`)),
  sum(is.na(tdor$Date)),
  sum(is.na(tdor$`Source ref`)),
  sum(is.na(tdor$Location)),
  sum(is.na(tdor$Country)),
  sum(is.na(tdor$Latitude)),
  sum(is.na(tdor$Longitude)),
  sum(is.na(tdor$`Cause of death`)),
  sum(is.na(tdor$Description)),
  sum(is.na(tdor$Permalink)),
  sum(is.na(tdor$`TGEU ref`)),
  sum(is.na(tdor$Source)),
  sum(is.na(tdor$Month)),
  sum(is.na(tdor$Year)),
  sum(is.na(tdor$TDoR)),
  sum(is.na(tdor$Date_1))
)
missings <- data.frame(colnames(tdor), missings)

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

# To improve our data, if you knew any of the circunstances around the following victims' deaths, please report this information here:
# User can maybe drill down by geography to check who is missing this data
Help_Find_Info <- tdor %>%
  filter(is.na(Description) & is.na(Source)) %>%
  select(Name, Age, Photo, Date, Location, Country, Permalink, `Cause of death`)

