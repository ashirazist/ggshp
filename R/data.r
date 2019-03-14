#' Australia example
#'
#' A dataset of class sf that produces a map of Australia
#'
#' @format An sf object
#' @source \url{https://gadm.org/download_country_v3.html}
#' @docType data
#' @keywords datasets
#' @name ausex

"ausex"

#' Australia example out
#'
#' A tibble that is produced by the function FunTeam7 when applied to ausex
#'
#'#' @format A data frame with 53940 rows and 10 variables:
#' \describe{
#'   \item{group}{identifies a single polygon}
#'   \item{order}{tells what order to connect points}
#'   \item{long}{longitude, 'y' coordinate}
#'   \item{lat}{latitude, 'x' coordinate}
#' }
#' @docType data
#' @keywords datasets
#' @name ausexout
#' @format A tibble
"ausexout"
