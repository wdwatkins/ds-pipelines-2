plot_nwis_timeseries <- function(filepath, site_data_styled){
  
  ggplot(data = site_data_styled, aes(x = dateTime, y = water_temperature, color = station_name)) +
    geom_line() + theme_bw()
  ggsave(filepath)
}