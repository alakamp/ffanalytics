#' @import dplyr tibble tidyr purrr stringr httr rvest
#' @importFrom glue glue
#' @importFrom lubridate year
#' @importFrom data.table fread
#' @importFrom readxl read_xlsx
#' @importFrom janitor clean_names

.onLoad <- function(libname, pkgname){
  player_table <- fread("https://s3.us-east-2.amazonaws.com/ffanalytics/packagedata/player_table.csv",
                      colClasses = c("character", "character", "character", "character", "character",
                                     "integer", "integer", "character", "integer", "integer",
                                     "Date", "integer", "integer"),
                      col.names = c("id", "last_name", "first_name", "position", "team", "weight",
                                    "draft_year", "draft_team", "draft_round", "draft_pick", "birthdate",
                                    "age", "exp"),
                      sep = ",", skip = 0, data.table = FALSE, showProgress = FALSE)
  player_table <- as_tibble(player_table)
  environment(player_table) <- asNamespace("ffanalytics")
  assignInNamespace("player_table", player_table, ns = "ffanalytics")
  options(dplyr.summarise.inform = FALSE)
}
