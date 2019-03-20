##' @name team_11
##' @title Convert Shape File to Data Frame
##' @description This function extracts data from a shapefile. Reads in the shapefile and extracts data from nested lists, finally recording them into one data frame with columns: long, lat, group, area, sub and additional information containded by the original shape file.
##' @author Qing He
##' @usage team_11(path=getwd(), tol=0.1)
##' @param path file path to a shape file
##' @param tol tolerance value used for thinning the polygon
##' @return A data frame of the geographic information of the polygons.
##' @examples  nc<- team_11(system.file("shape/nc.shp", package="sf"),0.1)
##' @import to
##' @export


#documentation
team_11 <- function(path=getwd(), tol= 0.1) {
  #read shp file from path, thin, convert to st file.
  #errors will be reported if the file is format is wrong, or the path is wrong by "read_sf" function.
  if (file_ext(path) == "shp")
  {
    if (length(tol) == 1)
    {
      if (is.numeric(tol) == TRUE) {
        print("Reading shape file")
        geobig <- read_sf(path)
        #error will be reported if the tolerance is not numeric
        geothin <- maptools::thinnedSpatialPoly(
          as(geobig, "Spatial"),
          tolerance = tol,
          minarea = 0.0001,
          topologyPreserve = TRUE
        )
        geost <- st_as_sf(geothin)

        print("Converting to data frame")
        #transfer geometry into data frame, with groups of stat/territery, order within each group.
        nlevel <- vec_depth(geost$geometry)
        df <-
          map_depth(.x = geost$geometry, (nlevel - 1), .f = as.data.frame) %>% #change buttom layer into data frame
          modify_depth(-(nlevel), flatten) %>% #flatten from bottom to top
          modify_depth(-(nlevel - 1), bind_rows, .id = "order2") %>% #bind list into df within each areas
          bind_rows(.id = "order1") %>% #bind list into df for all areas
          group_by(order1, order2) %>%
          mutate(group = paste(order1, order2, sep = "_")) %>%
          data.frame()

        colnames(df) <- c("area", "sub", "long", "lat", "group")
        print("Attaching additional information")
        #attach additional information as cols to the geo coord
        nrep <- df %>%
          group_by(area) %>%
          summarise(n = n()) %>%
          select("n") %>%
          unlist(use.names = F)

        geo <- geost[1:(length(geost) - 1)]
        geo$geometry <- NULL
        geodf <- cbind(geo[rep(seq_len(nrow(geo)), nrep), ], df)
        print("Mission complete!")
        return(geodf)
      }
      else
        stop("tol is not numeric")
    }
    else
      stop("tol is not one number")
  }
  else
    stop("input file is not a shape file")
}



