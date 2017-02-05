## City Segregation Maps
#

# Load libraries
library(geojsonio)
library(dplyr)

# Get map files
map.location <- file.path('data/shapefiles')
map.names <- list.files(path = map.location,
                        pattern = '*.json')

map.files <- lapply(file.path(map.location,
                              map.names),
                    file_to_geojson,
                    method='web',
                    output = ":memory:") %>%

    setNames(gsub('_tracts.json',
                  '',
                  map.names,
                  fixed = TRUE))

#

