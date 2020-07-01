plot_nwis_timeseries <- function(fileout, site_data_styled, width = 12, height = 7, units = 'in'){
  site_data_df <- readRDS(site_data_styled)
  ggplot(data = site_data_df, aes(x = dateTime, y = water_temperature, color = station_name)) +
    geom_line() + theme_bw()
  ggsave(fileout, width = width, height = height, units = units)
}