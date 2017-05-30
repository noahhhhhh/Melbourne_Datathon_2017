
# 2016 whole --------------------------------------------------------------

# config

require(data.table)

config = list()
config$splitRatio = c(.8, .2)
config$Target = "General"
config$no_of_year = NA

# read


years_ = 2016

dt_train_eng_all = data.table()
dt_test_eng_all = data.table()

for(year_ in years_){
  
  if(!is.na(config$no_of_year)){
    
    path_rds = paste0("../data/MelbDatathon2017/rds/", config$Target, "/", year_, "/", config$no_of_year, "/")
    
  }else{
    
    path_rds = paste0("../data/MelbDatathon2017/rds/", config$Target, "/", year_, "/")
    
  }
  
  # train
  dt_train_eng_atc = readRDS(paste0(path_rds, "dt_train_eng_atc.rds"))
  dt_train_eng_date = readRDS(paste0(path_rds, "dt_train_eng_date.rds"))
  dt_train_eng_txns = readRDS(paste0(path_rds, "dt_train_eng_txns.rds"))
  dt_train_eng_illness = readRDS(paste0(path_rds, "dt_train_eng_illness.rds"))
  dt_train_eng_drug = readRDS(paste0(path_rds, "dt_train_eng_drug.rds"))
  dt_train_eng_patient = readRDS(paste0(path_rds, "dt_train_eng_patient.rds"))
  dt_train_eng_extra = readRDS(paste0(path_rds, "dt_train_eng_extra.rds"))
  dt_train_eng_targetMean = readRDS(paste0(path_rds, "dt_train_eng_targetMean.rds"))
  
  dt_train_eng = merge(dt_train_eng_atc, dt_train_eng_date, by = c("Patient_ID", "Target"))
  dt_train_eng = merge(dt_train_eng, dt_train_eng_txns, by = c("Patient_ID", "Target"))
  dt_train_eng = merge(dt_train_eng, dt_train_eng_illness, by = c("Patient_ID", "Target"))
  dt_train_eng = merge(dt_train_eng, dt_train_eng_drug, by = c("Patient_ID", "Target"))
  dt_train_eng = merge(dt_train_eng, dt_train_eng_patient, by = c("Patient_ID", "Target"))
  dt_train_eng = merge(dt_train_eng, dt_train_eng_extra, by = c("Patient_ID", "Target"))
  dt_train_eng = merge(dt_train_eng, dt_train_eng_targetMean, by = c("Patient_ID", "Target"))
  
  
  dt_train_eng_all = rbind(dt_train_eng_all, dt_train_eng)
  
  print(year_)
}

rm(dt_train_eng_date, dt_train_eng_txns, dt_train_eng_illness, dt_train_eng_drug, dt_train_eng_patient, dt_train_eng_extra, dt_train_eng)

gc()

source("R/preprocess.R")
preprocess(dt_train = dt_train_eng_all, featureEngine = T, impute = T, normalisation = T, targetMean = T)

x = sapply(dt_train_eng_all, is.character)
length(x[x == F])
dt_train_eng_all[, names(x[x == F]), with = F]

saveRDS(dt_train_eng_all[, names(x[x == F]), with = F], "../data/MelbDatathon2017/rds/dt_train_eng_all.rds")
# write.csv(dt_train_eng_all[, names(x[x == F]), with = F], "../data/MelbDatathon2017/csv/dt_train_eng_all.csv", row.names = F)

rm(dt_train_eng_all)
gc()

# test --------------------------------------------------------------------


for(year_ in years_){
  
  if(!is.na(config$no_of_year)){
    
    path_rds = paste0("../data/MelbDatathon2017/rds/", config$Target, "/", year_, "/", config$no_of_year, "/")
    
  }else{
    
    path_rds = paste0("../data/MelbDatathon2017/rds/", config$Target, "/", year_, "/")
    
  }
  
  
  # test
  dt_test_eng_atc = readRDS(paste0(path_rds, "dt_test_eng_atc.rds"))
  dt_test_eng_date = readRDS(paste0(path_rds, "dt_test_eng_date.rds"))
  dt_test_eng_txns = readRDS(paste0(path_rds, "dt_test_eng_txns.rds"))
  dt_test_eng_illness = readRDS(paste0(path_rds, "dt_test_eng_illness.rds"))
  dt_test_eng_drug = readRDS(paste0(path_rds, "dt_test_eng_drug.rds"))
  dt_test_eng_patient = readRDS(paste0(path_rds, "dt_test_eng_patient.rds"))
  dt_test_eng_extra = readRDS(paste0(path_rds, "dt_test_eng_extra.rds"))
  dt_test_eng_targetMean = readRDS(paste0(path_rds, "dt_test_eng_targetMean.rds"))
  
  dt_test_eng = merge(dt_test_eng_atc, dt_test_eng_date, by = c("Patient_ID", "Target"))
  dt_test_eng = merge(dt_test_eng, dt_test_eng_txns, by = c("Patient_ID", "Target"))
  dt_test_eng = merge(dt_test_eng, dt_test_eng_illness, by = c("Patient_ID", "Target"))
  dt_test_eng = merge(dt_test_eng, dt_test_eng_drug, by = c("Patient_ID", "Target"))
  dt_test_eng = merge(dt_test_eng, dt_test_eng_patient, by = c("Patient_ID", "Target"))
  dt_test_eng = merge(dt_test_eng, dt_test_eng_extra, by = c("Patient_ID", "Target"))
  dt_test_eng = merge(dt_test_eng, dt_test_eng_targetMean, by = c("Patient_ID", "Target"))
  
  dt_test_eng_all = rbind(dt_test_eng_all, dt_test_eng)
  
  print(year_)
}

rm(dt_test_eng_date, dt_test_eng_txns, dt_test_eng_illness, dt_test_eng_drug, dt_test_eng_patient, dt_test_eng_extra, dt_test_eng)
gc()

source("R/preprocess.R")
preprocess(dt_train = dt_test_eng_all, featureEngine = T, impute = T, normalisation = T, targetMean = T)

x = sapply(dt_test_eng_all, is.character)
length(x[x == F])
dt_test_eng_all[, names(x[x == F]), with = F]

saveRDS(dt_test_eng_all[, names(x[x == F]), with = F], "../data/MelbDatathon2017/rds/dt_test_eng_all")
# write.csv(dt_test_eng_all[, names(x[x == F]), with = F], "../data/MelbDatathon2017/csv/dt_test_eng_all.csv", row.names = F)

rm(dt_test_eng_all)
gc()