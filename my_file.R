load("fullpath/people_mover_realtime.rda")

#' @get /delays
delays_endpoint_function <- function(all) {
    delays
}

#' @get /locations
locations_endpoint_function <- function(all) {
    locations
}
