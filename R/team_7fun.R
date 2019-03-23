#' Thin shp file and gg-ify it
#'
#' @param mypath path to file you want to read
#' @param mytoler numeric, desired tolerance to thin, default is 0.1
#' @return A tibble for ggplot2
#' @import tools dplyr purrr maptools testthat checkmate sf ggplot2
#' @export
#' @examples
#' # Take in sf data, use team_7 function, plot output using ggplot2
#' datatib <- team_7fun(mypath = system.file("shape/nc.shp", package = "sf"), mytoler = 0.2)



team_7fun <- function(mypath, mytoler = 0.1) {

  checkmate::assertNumber(mytoler, lower = 0)

  myfile <- sf::read_sf(mypath)

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

      oz <- sf::st_as_sf(oz0)

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
