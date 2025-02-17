
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

if (!require("pacman")) install.packages("pacman")
pacman::p_load(tidyverse, ggplot2, dplyr, lubridate, stringr, readxl, data.table, gdata, scales)


# Read data and set workspace for knitr -------------------------------


# Create objects for markdown ---------------------------------------------

plan.type.table <- enroll.info %>% group_by(plan_type) %>% count() %>% arrange(-n)
tot.obs <- as.numeric(count(enroll.info %>% ungroup()))
plan.type.year1 <- enroll.info %>% group_by(plan_type) %>% count() %>% arrange(-n) %>% filter(plan_type!="NA")

final.plans <- enroll.info %>%
  filter(snp == "No" & eghp == "No" &
           (planid < 800 | planid >= 900))
plan.type.year2 <- final.plans %>% group_by(plan_type) %>% count() %>% arrange(-n)

plan.type.enroll <- final.plans %>% group_by(plan_type) %>% summarize(n=n(), enollment=mean(enrollment, na.rm=TRUE)) %>% arrange(-n)



rm(list=c("full.ma.data", "contract.service.area","final.data"))
save.image("submission1/Hwk1_workspace.Rdata")
