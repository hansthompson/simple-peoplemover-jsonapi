#' @get /wheresthebus
routetracker <- function(routeID) {
library(XML)
#example routes 2, 7, 60
base <- "http://bustracker.muni.org/InfoPoint/map/GetVehicleXml.ashx?RouteId="
full_url <- paste0(base, routeID)
xml_obj <- xmlParse(full_url)
xml_df  <- (as.data.frame( xmlToList( xml_obj)))[-4,]
return(xml_df)
}

#' @get /whatsthedeparture
library(XML)
full_url <- "http://bustracker.muni.org/InfoPoint/XML/stopdepartures.xml"
xml_obj <- xmlParse(full_url)
departure_list <- xmlToList(xml_obj)
lapply(departure_list, function(x) x$stop$departure$edt)