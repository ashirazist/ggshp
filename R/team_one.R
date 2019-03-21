#' Converting sf format into a data frame
#'
#' @name team_one
#' @title Converting sf file into a dataframe/ tibble
#' @description This is a helper fucntion to turn one of these matrices into a single data frame/ tibble with variables long, lat, group and order.
#' @usage team_1(.file, tolerance=0.1)
#' @param file read "sf" file
#' @param tolerance tolerance value used for thinning the polygon
#' @return A dataframe or a tibble of the geographic information of the polygons.
#' @examples  team_one(system.file("shape/nc.shp", package="sf"),0.1)
#' @import sf
#' @import ggplot2
#' @export

team_one <- function(.file= file.choose(), tolerance = 0.1) {

  if (tools::file_ext(.file) == "shp")
  {
      if (is.numeric(tolerance) == TRUE) {
        print("Reading shape file")
        ozbig <- read_sf(.file)
      print(paste("Tolerance Level =", tolerance, "...processing..."))

      oz_st <- maptools::thinnedSpatialPoly(as(ozbig, "Spatial"),
                                            tolerance = 0.1,
                                            minarea = 0.001,
                                            topologyPreserve = TRUE)
      oz <- st_as_sf(oz_st)
      print("Converting the data to a data frame ...")
      df.oz.purr <- oz$geometry %>%
        purrr::map_depth(3, data.frame) %>%
        purrr::flatten() %>%
        purrr::flatten() %>%
        dplyr::bind_rows(.id = "group") %>%
        dplyr::rename("lat" = y, "long" = x)


      print("The data frame is ready to be mapped to ")
      print("Loading ggplot ...")
      out<- df.oz.purr %>%
        ggplot()+
        geom_polygon(aes(x = long, y = lat, group = group))
      print("Plotting the polygon ...")
      return(out)


   } else {
     print("The chosen tolerance is not numeric.")
   }


  } else {
    print("The chosen file is not supported. Please use .shp fromat")
  }
  }

