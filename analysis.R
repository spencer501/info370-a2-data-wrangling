# Analysis file for measuring segregation
#

# Load libraries
library(dplyr)

# Get functions for segregation metrics
source('metric_functions.R')

# Get geographical data (to add to city data)
geo.data <- read.delim('data/Gaz_tracts_national.txt') %>%
    select(GEOID,
           ALAND,
           INTPTLAT,
           INTPTLONG) %>%
    rename(area = ALAND,
           lat = INTPTLAT,
           long = INTPTLONG)

# store all data as a list of dataframes
# help from: http://stackoverflow.com/questions/5319839/,
#            http://stackoverflow.com/questions/1105659/
folder.location <- file.path('data/prepped')

filenames <- list.files(path = folder.location,
                        pattern = '*.csv')

city.data <- lapply(file.path(folder.location,
                              filenames),
                    read.csv,
                    stringsAsFactors = FALSE) %>%

    # make list names nice
    setNames(gsub('_race.csv',
                  '',
                  filenames,
                  fixed = TRUE)) %>%

    # Remove "-exclude" suffix from some GEOIDs
    # and convert to double
    lapply(function(df) {
        df <- df %>%
            mutate(GEOID = as.double(gsub('-exclude',
                                          '',
                                          GEOID,
                                          fixed = TRUE)))
        return(df)
    }) %>%

    # add geographical data
    lapply(function(df) {
        df <- df %>%
            inner_join(geo.data,
                       by = "GEOID")
        return(df)
    })
