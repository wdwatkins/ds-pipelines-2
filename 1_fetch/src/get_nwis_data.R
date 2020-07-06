nwis_site_info <- function(fileout, site_hash_table){
  site_no <- readRDS(site_hash_table) %>%
    pull(filepath) %>% basename() %>% 
    stringr::str_extract(pattern = "(?:[0-9]+)")
  site_info <- dataRetrieval::readNWISsite(site_no)
  return(site_info)
}


download_nwis_site_data <- function(filepath, parameterCd = '00010', startDate="2014-05-01", endDate="2015-05-01"){
  
  # filepaths look something like directory/nwis_01432160_data.csv,
  # remove the directory with basename() and extract the 01432160 with the regular expression match
  site_num <- basename(filepath) %>% 
    stringr::str_extract(pattern = "(?:[0-9]+)")
  
  # readNWISdata is from the dataRetrieval package
  data_out <- readNWISdata(sites=site_num, 
                           service="iv", 
                           parameterCd = parameterCd, startDate = startDate, endDate = endDate)
  #-- simulating a failure-prone web-sevice here, do not edit --
  if (sample(c(T,F,F,F), 1)){
    stop(site_num, ' has failed due to connection timeout. Try scmake() again')
  }
  #-- end of do-not-edit block
  
  write_csv(data_out, path = filepath)
  return(filepath)
}

