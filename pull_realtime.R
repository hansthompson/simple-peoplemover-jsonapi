load("/home/hans/simple-peoplemover-jsonapi/stops.rda")
write_files_to <- "/home/hans/"

library(dplyr)
library(XML)
library(lubridate)
library(tidyr)
library(leaflet)


time_stamp <- Sys.time()

locations <- xmlToDataFrame(xmlParse("http://bustracker.muni.org/InfoPoint/XML/vehiclelocation.xml")) %>% 
  filter(latitude != "0.0")

stop_departures <- xmlToList(xmlParse("http://bustracker.muni.org/InfoPoint/XML/stopdepartures.xml")) 

removenulls <- function(x) {ifelse(is.null(x), NA, x)}

delays <- data.frame(
  id = as.numeric(unlist(lapply(stop_departures[-1], function(x) x[[1]]))),
  routeID = unlist(lapply(stop_departures[-1], function(x) x[[3]][[5]][[1]])), 
  direction = unlist(lapply(stop_departures[-1], function(x) x[[3]][[6]])),
  dev = unlist(lapply(lapply(stop_departures[-1], function(x) x[[3]][[3]]), removenulls)),
  edt = ymd_hms(paste0(format(Sys.time(), "%Y-%m-%d"), " ", unlist(lapply(stop_departures[-1], function(x) x[[3]][[1]])), ":00")),
  sdt = unlist(lapply(stop_departures[-1], function(x) x[[3]][[2]]))
)

delays <- delays %>% filter(dev != 0)
delays$id <- as.numeric(as.character(delays$id))

delays <- delays %>% 
  group_by(routeID, direction) %>% 
  mutate(ord = order(edt - Sys.time())) %>%
  filter(ord < 2)

delays <- inner_join(delays, stops, by = "id") 

save(locations, delays, time_stamp, file = paste0(write_files_to, "people_mover_realtime.rda"))
