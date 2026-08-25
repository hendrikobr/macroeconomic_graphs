
#.hh_ger_gva_sectors <- function(caption,
 #                       label_ger = "Deutschland",
 #                       label_hh = "Hamburg",
 #                       y_axis = "Bruttowertschöpfung",
 #                       decimal_mark = ",",
 #                       big_mark = "."
 #                     ) {
  source("src/bootstrap.R")

  ger_raw <- with_cache(paste0("genesis_82111-0002_", DATA_START_YEAR),
                        genesis_fetch("82111-0002"))
  
  hh_raw <- with_cache(paste0("genesis_82111-0011_", DATA_START_YEAR),
                        genesis_fetch("82111-0011"))
  
  ger_dat <- ger_raw %>%
    dplyr::filter(time == max(time)) %>%
    dplyr::filter(value != "...") %>%
    dplyr::filter(!is.na(`2_variable_attribute_code`)) %>%
    dplyr::select(5,9,12,13,14) %>%
    rename(
      date = 1,
      series = 2,
      sector = 3
    )
  
  hh_dat <- hh_raw %>%
    dplyr::filter(time == max(time)) %>%
    dplyr::filter(`1_variable_attribute_code` == "02") %>%
    dplyr::filter(value != "...") %>%
    dplyr::filter(!is.na(`2_variable_attribute_code`)) %>%
    dplyr::select(5,9,12,13,14) %>%
    rename(
      date = 1,
      series = 2,
      sector = 3
    )
  
  dat <- dplyr::bind_rows(hh_dat, ger_dat) %>%
    mutate(date = as.Date(paste0(date, "-12-31"), format = "%Y-%m-%d"))

  plot_bar(
    dat,
    caption = "Datenquelle",
    labels = NULL,
    y_axis = "",
    decimal_mark = ",",
    colors = c(alpha(hwwi_blue, 0.9), alpha(hwwi_rubin, 0.9)),
    y_limits = NULL,
    position = "dodge"
  )



}
