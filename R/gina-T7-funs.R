#' Thin shp file and gg-fy it
#'
#' @param mydf dataframe of long/lats
#' @return
#' @export
#'
#'

FunLongLat <- function(mydf){

  newdf <- data.frame(order = c(1:nrow(dframe)), long = dframe$x, lat = dframe$y)
  return(newdf)
}


## Here our depth is 3, but that could change depending on the file
ozplus <- oz$geometry %>%
  modify_depth(3,data.frame) %>%
  modify_depth(3,f) %>%
  flatten() %>%
  flatten() %>%
  bind_rows(.id = "group")
# ozplus %>%
#   ggplot(aes(x = long, y = lat, group = group)) +
#   geom_polygon(fill = "white", colour = "black", lwd = 1)+
#   theme_bw()+
#   coord_quickmap()



oz_st <- maptools::thinnedSpatialPoly(
  as(ozbig, "Spatial"), tolerance = 0.1,
  minarea = 0.001, topologyPreserve = TRUE)
oz <- st_as_sf(oz_st)
