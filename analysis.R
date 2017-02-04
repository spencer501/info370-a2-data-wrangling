# Analysis file for measuring segregation
#

# Load libraries
library(dplyr)

# Get functions for segregation metrics
source('metric_functions.R')

# store all data as a list of dataframes
# help from: http://stackoverflow.com/questions/5319839/,
#            http://stackoverflow.com/questions/1105659/
folder.location <- file.path('data/prepped')

filenames <- list.files(
    path = folder.location,
    pattern = '*.csv')

city.data <- lapply(
    file.path(
        folder.location,
        filenames),
    read.csv) %>%

    setNames(
        gsub('_race.csv',
             '',
             filenames,
             fixed = TRUE))

tmp.baltimore <- city.data$baltimore


# Get geographical data
geo.data <- read.delim('data/Gaz_tracts_national.txt') %>%
    select(GEOID,
           ALAND,
           INTPTLAT,
           INTPTLONG) %>%
    rename(area = ALAND,
           lat = INTPTLAT,
           long = INTPTLONG)






