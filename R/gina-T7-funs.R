#' Thin shp file and gg-ify it
#'
#' @param myfile dataframe of long/lats
#' @param mytoler numeric, desired tolerance to thin, default is 0.1
#' @return A tibble for ggplot2
#' @examples
#' # Take in sf data, use FunTeam7, plot output using ggplot2
#' data(ausex)
#' datatib <- FunTeam7(myfile = ausex)
#' datatib %>%
#'   ggplot(aes(x = long, y = lat, group = group)) +
#'   geom_polygon(fill = "white", colour = "black", lwd = 1)+
#'   theme_bw()+
#'   coord_quickmap()
#'


FunTeam7 <- function(myfile, mytoler = 0.1) {
  # If file is sf, continue w/analysis. Otherwise throw a message

  if (is.numeric(mytoler) == TRUE) {

    if (is(myfile, "sf") == TRUE) {
      # If it passes, proceed to thin it

      print(paste("Thinning to tolerance =", mytoler, "...be patient..."))

      oz <-
        maptools::thinnedSpatialPoly(
          as(myfile, "Spatial"),
          tolerance = mytoler,
          minarea = 0.001,
          topologyPreserve = TRUE
        ) %>%
        st_as_sf


      FunLongLat <- function(dframe) {
        newdf <-
          data.frame(order = c(1:nrow(dframe)),
                     long = dframe$x,
                     lat = dframe$y)
        return(newdf)
      }

      ozplus <-
        oz$geometry %>%
        modify_depth(3, data.frame) %>%
        modify_depth(3, FunLongLat) %>%
        flatten() %>%
        flatten() %>%
        bind_rows(.id = "group")

      oztib <- as_tibble(ozplus)

      print("Success! Use my output in ggplot2")
      return(oztib)


    } else {
      print("Your file is not class sf. You broke me.")

    }
  } else {
    print("Your tolerance is not numeric. You broke me.")
  }
}
