
#Preliminaries
if(!require("pacman"))install.packages("pacman")
pacman::p_load(tidyverse, ggplot2, dplyr, lubridate, stringr, readxl, data.table, gdata)

 #Import data
  enroll.info=read_csv("data/input/CPSC_Enrollment_Info_2015_01.csv",
                       skip=1,
                       col_names = c("contractid","planid","ssa","fips","state","county","enrollment"),
                       col_types = cols(
                       contractid = col_character(),
                       planid = col_double(),
                       ssa = col_double(),
                       fips = col_double(),
                       state = col_character(),
                       county = col_character(),
                       enrollment = col_double()
                       ),na="*")


service_area.info=read_csv("data/input/MA_Cnty_SA_2015_01.csv",
                          skip=1,
                          col_names=c("contractid","org_name","org_type","plan_type","partial","eghp",
                                      "ssa","fips","county","state","notes"),
                          col_types = cols(
                            contractid = col_character(),
                            org_name = col_character(),
                            org_type = col_character(),
                            plan_type = col_character(),
                            partial = col_logical(),
                            eghp = col_character(),
                            ssa = col_double(),
                            fips = col_double(),
                            county = col_character(),
                            notes = col_character()
                            ),na='*')

merged_data=merge(enroll.info, service_area.info, by = c("contractid", "ssa", "fips", "county", "state"), all = FALSE)

