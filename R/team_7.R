#' Thin shp file and gg-ify it
#'
#' @param myfile dataframe of long/lats
#' @param mytoler numeric, desired tolerance to thin, default is 0.1
#' @return A tibble for ggplot2
#' @import tools dplyr purrr maptools testthat checkmate sf
#' @export
#' @examples
#' # Take in sf data, use team_7 function, plot output using ggplot2
#' exdat <- sf::read_sf(system.file("shape/nc.shp", package = "sf"))
#' datatib <- team_7(myfile = exdat, mytoler = 0.2)
#' datatib %>%
#'   ggplot(aes(x = long, y = lat, group = group)) +
#'   geom_polygon(fill = "white", colour = "black", lwd = 1)+
#'   theme_bw()+
#'   coord_quickmap()
#'


team_7 <- function(myfile, mytoler = 0.1) {

  checkmate::assertNumber(mytoler, lower = 0)

  if (is(myfile, "sf") == TRUE) {

        # If it passes everything, proceed to thin it
        print(paste("Thinning to tolerance =", mytoler, "...be patient..."))

    oz0 <-
      maptools::thinnedSpatialPoly(
        as(myfile, "Spatial"),
        tolerance = mytoler,
        minarea = 0.001,
        topologyPreserve = TRUE
      )

      oz <- sf::st_as_sf(oz)

        # Function________________
        FunLongLat <- function(dframe) {
          newdf <-
            data.frame(
              order = c(1:nrow(dframe)),
              long = dframe$x,
              lat = dframe$y
            )
          return(newdf)
        }
        #________________

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
      }
      else {
        print("Your file is not class sf. You broke me.")
      }
}

# exdat <- sf::read_sf(system.file("shape/nc.shp", package = "sf"))
# team_7(exdat)
