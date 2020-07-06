process_data <- function(file_out, all_site_files, site_info) {
  all_site_files_df <- readRDS(all_site_files)
  nwis_data <- do.call(bind_rows, lapply(all_site_files_df$filepath, read_csv))
  nwis_data_processed <- rename(nwis_data, water_temperature = X_00010_00000) %>% 
    select(-agency_cd, -X_00010_00000_cd, -tz_cd) %>% 
    left_join(site_info, by = "site_no") %>% 
    select(station_name = station_nm, site_no, dateTime, water_temperature, 
           latitude = dec_lat_va, longitude = dec_long_va) %>% 
    mutate(station_name = as.factor(station_name))
  saveRDS(nwis_data_processed, file = file_out)
}
