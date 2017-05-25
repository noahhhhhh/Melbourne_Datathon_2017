source("R/load.R", keep.source = T)
print(paste0("[", Sys.time(), "]: ", "Load ..."))


source("R/split.R")
source("R/featureEngineer.R")
source("R/preprocess.R")
source("R/model.R")

# 2016, 3 -----------------------------------------------------------------

# config


config = list()
config$trainEndDate = "2016-01-01"
config$testEndDate = "2017-05-01"
config$splitRatio = c(.8, .2)
config$Target = "General"
config$no_of_year = 3


# split

year = "2016-01-01"

ls_dt = splitData_year_2016(dt_txn, Target = config$Target, dt_ilness, splitRatio = config$splitRatio, no_of_year = config$no_of_year)
# ls_dt = splitData_year(dt_txn, Target = config$Target, dt_ilness, splitRatio = config$splitRatio, years = year, no_of_year = config$no_of_year)


if(!is.na(config$no_of_year)){
  
  path_rds = paste0("../data/MelbDatathon2017/rds/", config$Target, "/", year(as.Date(year)), "/", config$no_of_year, "/")
  
}else{
  
  path_rds = paste0("../data/MelbDatathon2017/rds/", config$Target, "/", year(as.Date(year)), "/")
  
}

# feature engineering

## train
print("##### Train - TargetMean Features #####")
dt_train_eng_targetMean = featureEngineer_TargetMean(ls_dt$dt_train, dt_drug)
saveRDS(dt_train_eng_targetMean, paste0(path_rds, "dt_train_eng_targetMean.rds"))
rm(dt_train_eng_targetMean)
gc()

print("##### Train - Extra Features #####")
dt_train_eng_extra = featureEngineer_Extra(ls_dt$dt_train, dt_drug)
saveRDS(dt_train_eng_extra, paste0(path_rds, "dt_train_eng_extra.rds"))
rm(dt_train_eng_extra)
gc()

print("##### Train - ATC Features #####")
dt_train_eng_atc = featureEngineer_ATC(ls_dt$dt_train, trainEndDate = year, dt_drug, dt_atc)
saveRDS(dt_train_eng_atc, paste0(path_rds, "dt_train_eng_atc.rds"))
rm(dt_train_eng_atc)
gc()

print("##### Train - Date Features #####")
dt_train_eng_date = featureEngineer_Date(ls_dt$dt_train, trainEndDate = year, dt_drug, dt_atc)
saveRDS(dt_train_eng_date, paste0(path_rds, "dt_train_eng_date.rds"))
rm(dt_train_eng_date)
gc()

print("##### Train - Txns Features #####")
dt_train_eng_txns = featureEngineer_Txns(ls_dt$dt_train, trainEndDate = year, dt_drug, dt_atc)
saveRDS(dt_train_eng_txns, paste0(path_rds, "dt_train_eng_txns.rds"))
rm(dt_train_eng_txns)
gc()

print("##### Train - Illness Features #####")
dt_train_eng_illness = featureEngineer_Illness(ls_dt$dt_train, trainEndDate = year, dt_drug, dt_atc)
saveRDS(dt_train_eng_illness, paste0(path_rds, "dt_train_eng_illness.rds"))
rm(dt_train_eng_illness)
gc()

print("##### Train - Drug Features #####")
dt_train_eng_drug = featureEngineer_Drug(ls_dt$dt_train, trainEndDate = year, dt_drug, dt_atc)
saveRDS(dt_train_eng_drug, paste0(path_rds, "dt_train_eng_drug.rds"))
rm(dt_train_eng_drug)
gc()

print("##### Train - Patient Features #####")
dt_train_eng_patient = featureEngineer_Patient(ls_dt$dt_train, trainEndDate = year, dt_drug, dt_atc, dt_patient, dt_store)
saveRDS(dt_train_eng_patient, paste0(path_rds, "dt_train_eng_patient.rds"))
rm(dt_train_eng_patient)
gc()


## test
print("##### test - TargetMean Features #####")
dt_test_eng_targetMean = featureEngineer_TargetMean_test(ls_dt$dt_train, ls_dt$dt_test, dt_drug)
saveRDS(dt_test_eng_targetMean, paste0(path_rds, "dt_test_eng_targetMean.rds"))
rm(dt_test_eng_targetMean)
gc()

print("##### test - Extra Features #####")
dt_test_eng_extra = featureEngineer_Extra(ls_dt$dt_test, dt_drug)
saveRDS(dt_test_eng_extra, paste0(path_rds, "dt_test_eng_extra.rds"))
rm(dt_test_eng_extra)
gc()

print("##### test - ATC Features #####")
dt_test_eng_atc = featureEngineer_ATC(ls_dt$dt_test, trainEndDate = year, dt_drug, dt_atc)
saveRDS(dt_test_eng_atc, paste0(path_rds, "dt_test_eng_atc.rds"))
rm(dt_test_eng_atc)
gc()

print("##### test - Date Features #####")
dt_test_eng_date = featureEngineer_Date(ls_dt$dt_test, trainEndDate = year, dt_drug, dt_atc)
saveRDS(dt_test_eng_date, paste0(path_rds, "dt_test_eng_date.rds"))
rm(dt_test_eng_date)
gc()

print("##### test - Txns Features #####")
dt_test_eng_txns = featureEngineer_Txns(ls_dt$dt_test, trainEndDate = year, dt_drug, dt_atc)
saveRDS(dt_test_eng_txns, paste0(path_rds, "dt_test_eng_txns.rds"))
rm(dt_test_eng_txns)
gc()

print("##### test - Illness Features #####")
dt_test_eng_illness = featureEngineer_Illness(ls_dt$dt_test, trainEndDate = year, dt_drug, dt_atc)
saveRDS(dt_test_eng_illness, paste0(path_rds, "dt_test_eng_illness.rds"))
rm(dt_test_eng_illness)
gc()

print("##### test - Drug Features #####")
dt_test_eng_drug = featureEngineer_Drug(ls_dt$dt_test, trainEndDate = year, dt_drug, dt_atc)
saveRDS(dt_test_eng_drug, paste0(path_rds, "dt_test_eng_drug.rds"))
rm(dt_test_eng_drug)
gc()

print("##### test - Patient Features #####")
dt_test_eng_patient = featureEngineer_Patient(ls_dt$dt_test, trainEndDate = year, dt_drug, dt_atc, dt_patient, dt_store)
saveRDS(dt_test_eng_patient, paste0(path_rds, "dt_test_eng_patient.rds"))
rm(dt_test_eng_patient)
gc()



rm(ls_dt)
gc()








# 2016, 2 -----------------------------------------------------------------

# config


config = list()
config$trainEndDate = "2016-01-01"
config$testEndDate = "2017-05-01"
config$splitRatio = c(.8, .2)
config$Target = "General"
config$no_of_year = 2


# split

year = "2016-01-01"

ls_dt = splitData_year_2016(dt_txn, Target = config$Target, dt_ilness, splitRatio = config$splitRatio, no_of_year = config$no_of_year)
# ls_dt = splitData_year(dt_txn, Target = config$Target, dt_ilness, splitRatio = config$splitRatio, years = year, no_of_year = config$no_of_year)


if(!is.na(config$no_of_year)){
  
  path_rds = paste0("../data/MelbDatathon2017/rds/", config$Target, "/", year(as.Date(year)), "/", config$no_of_year, "/")
  
}else{
  
  path_rds = paste0("../data/MelbDatathon2017/rds/", config$Target, "/", year(as.Date(year)), "/")
  
}

# feature engineering

## train
print("##### Train - TargetMean Features #####")
dt_train_eng_targetMean = featureEngineer_TargetMean(ls_dt$dt_train, dt_drug)
saveRDS(dt_train_eng_targetMean, paste0(path_rds, "dt_train_eng_targetMean.rds"))
rm(dt_train_eng_targetMean)
gc()

print("##### Train - Extra Features #####")
dt_train_eng_extra = featureEngineer_Extra(ls_dt$dt_train, dt_drug)
saveRDS(dt_train_eng_extra, paste0(path_rds, "dt_train_eng_extra.rds"))
rm(dt_train_eng_extra)
gc()

print("##### Train - ATC Features #####")
dt_train_eng_atc = featureEngineer_ATC(ls_dt$dt_train, trainEndDate = year, dt_drug, dt_atc)
saveRDS(dt_train_eng_atc, paste0(path_rds, "dt_train_eng_atc.rds"))
rm(dt_train_eng_atc)
gc()

print("##### Train - Date Features #####")
dt_train_eng_date = featureEngineer_Date(ls_dt$dt_train, trainEndDate = year, dt_drug, dt_atc)
saveRDS(dt_train_eng_date, paste0(path_rds, "dt_train_eng_date.rds"))
rm(dt_train_eng_date)
gc()

print("##### Train - Txns Features #####")
dt_train_eng_txns = featureEngineer_Txns(ls_dt$dt_train, trainEndDate = year, dt_drug, dt_atc)
saveRDS(dt_train_eng_txns, paste0(path_rds, "dt_train_eng_txns.rds"))
rm(dt_train_eng_txns)
gc()

print("##### Train - Illness Features #####")
dt_train_eng_illness = featureEngineer_Illness(ls_dt$dt_train, trainEndDate = year, dt_drug, dt_atc)
saveRDS(dt_train_eng_illness, paste0(path_rds, "dt_train_eng_illness.rds"))
rm(dt_train_eng_illness)
gc()

print("##### Train - Drug Features #####")
dt_train_eng_drug = featureEngineer_Drug(ls_dt$dt_train, trainEndDate = year, dt_drug, dt_atc)
saveRDS(dt_train_eng_drug, paste0(path_rds, "dt_train_eng_drug.rds"))
rm(dt_train_eng_drug)
gc()

print("##### Train - Patient Features #####")
dt_train_eng_patient = featureEngineer_Patient(ls_dt$dt_train, trainEndDate = year, dt_drug, dt_atc, dt_patient, dt_store)
saveRDS(dt_train_eng_patient, paste0(path_rds, "dt_train_eng_patient.rds"))
rm(dt_train_eng_patient)
gc()


## test
print("##### test - TargetMean Features #####")
dt_test_eng_targetMean = featureEngineer_TargetMean_test(ls_dt$dt_train, ls_dt$dt_test, dt_drug)
saveRDS(dt_test_eng_targetMean, paste0(path_rds, "dt_test_eng_targetMean.rds"))
rm(dt_test_eng_targetMean)
gc()

print("##### test - Extra Features #####")
dt_test_eng_extra = featureEngineer_Extra(ls_dt$dt_test, dt_drug)
saveRDS(dt_test_eng_extra, paste0(path_rds, "dt_test_eng_extra.rds"))
rm(dt_test_eng_extra)
gc()

print("##### test - ATC Features #####")
dt_test_eng_atc = featureEngineer_ATC(ls_dt$dt_test, trainEndDate = year, dt_drug, dt_atc)
saveRDS(dt_test_eng_atc, paste0(path_rds, "dt_test_eng_atc.rds"))
rm(dt_test_eng_atc)
gc()

print("##### test - Date Features #####")
dt_test_eng_date = featureEngineer_Date(ls_dt$dt_test, trainEndDate = year, dt_drug, dt_atc)
saveRDS(dt_test_eng_date, paste0(path_rds, "dt_test_eng_date.rds"))
rm(dt_test_eng_date)
gc()

print("##### test - Txns Features #####")
dt_test_eng_txns = featureEngineer_Txns(ls_dt$dt_test, trainEndDate = year, dt_drug, dt_atc)
saveRDS(dt_test_eng_txns, paste0(path_rds, "dt_test_eng_txns.rds"))
rm(dt_test_eng_txns)
gc()

print("##### test - Illness Features #####")
dt_test_eng_illness = featureEngineer_Illness(ls_dt$dt_test, trainEndDate = year, dt_drug, dt_atc)
saveRDS(dt_test_eng_illness, paste0(path_rds, "dt_test_eng_illness.rds"))
rm(dt_test_eng_illness)
gc()

print("##### test - Drug Features #####")
dt_test_eng_drug = featureEngineer_Drug(ls_dt$dt_test, trainEndDate = year, dt_drug, dt_atc)
saveRDS(dt_test_eng_drug, paste0(path_rds, "dt_test_eng_drug.rds"))
rm(dt_test_eng_drug)
gc()

print("##### test - Patient Features #####")
dt_test_eng_patient = featureEngineer_Patient(ls_dt$dt_test, trainEndDate = year, dt_drug, dt_atc, dt_patient, dt_store)
saveRDS(dt_test_eng_patient, paste0(path_rds, "dt_test_eng_patient.rds"))
rm(dt_test_eng_patient)
gc()



rm(ls_dt)
gc()


# 2016, 1 -----------------------------------------------------------------

# config


config = list()
config$trainEndDate = "2016-01-01"
config$testEndDate = "2017-05-01"
config$splitRatio = c(.8, .2)
config$Target = "General"
config$no_of_year = 1


# split

year = "2016-01-01"

ls_dt = splitData_year_2016(dt_txn, Target = config$Target, dt_ilness, splitRatio = config$splitRatio, no_of_year = config$no_of_year)
# ls_dt = splitData_year(dt_txn, Target = config$Target, dt_ilness, splitRatio = config$splitRatio, years = year, no_of_year = config$no_of_year)


if(!is.na(config$no_of_year)){
  
  path_rds = paste0("../data/MelbDatathon2017/rds/", config$Target, "/", year(as.Date(year)), "/", config$no_of_year, "/")
  
}else{
  
  path_rds = paste0("../data/MelbDatathon2017/rds/", config$Target, "/", year(as.Date(year)), "/")
  
}

# feature engineering

## train
print("##### Train - TargetMean Features #####")
dt_train_eng_targetMean = featureEngineer_TargetMean(ls_dt$dt_train, dt_drug)
saveRDS(dt_train_eng_targetMean, paste0(path_rds, "dt_train_eng_targetMean.rds"))
rm(dt_train_eng_targetMean)
gc()

print("##### Train - Extra Features #####")
dt_train_eng_extra = featureEngineer_Extra(ls_dt$dt_train, dt_drug)
saveRDS(dt_train_eng_extra, paste0(path_rds, "dt_train_eng_extra.rds"))
rm(dt_train_eng_extra)
gc()

print("##### Train - ATC Features #####")
dt_train_eng_atc = featureEngineer_ATC(ls_dt$dt_train, trainEndDate = year, dt_drug, dt_atc)
saveRDS(dt_train_eng_atc, paste0(path_rds, "dt_train_eng_atc.rds"))
rm(dt_train_eng_atc)
gc()

print("##### Train - Date Features #####")
dt_train_eng_date = featureEngineer_Date(ls_dt$dt_train, trainEndDate = year, dt_drug, dt_atc)
saveRDS(dt_train_eng_date, paste0(path_rds, "dt_train_eng_date.rds"))
rm(dt_train_eng_date)
gc()

print("##### Train - Txns Features #####")
dt_train_eng_txns = featureEngineer_Txns(ls_dt$dt_train, trainEndDate = year, dt_drug, dt_atc)
saveRDS(dt_train_eng_txns, paste0(path_rds, "dt_train_eng_txns.rds"))
rm(dt_train_eng_txns)
gc()

print("##### Train - Illness Features #####")
dt_train_eng_illness = featureEngineer_Illness(ls_dt$dt_train, trainEndDate = year, dt_drug, dt_atc)
saveRDS(dt_train_eng_illness, paste0(path_rds, "dt_train_eng_illness.rds"))
rm(dt_train_eng_illness)
gc()

print("##### Train - Drug Features #####")
dt_train_eng_drug = featureEngineer_Drug(ls_dt$dt_train, trainEndDate = year, dt_drug, dt_atc)
saveRDS(dt_train_eng_drug, paste0(path_rds, "dt_train_eng_drug.rds"))
rm(dt_train_eng_drug)
gc()

print("##### Train - Patient Features #####")
dt_train_eng_patient = featureEngineer_Patient(ls_dt$dt_train, trainEndDate = year, dt_drug, dt_atc, dt_patient, dt_store)
saveRDS(dt_train_eng_patient, paste0(path_rds, "dt_train_eng_patient.rds"))
rm(dt_train_eng_patient)
gc()


## test
print("##### test - TargetMean Features #####")
dt_test_eng_targetMean = featureEngineer_TargetMean_test(ls_dt$dt_train, ls_dt$dt_test, dt_drug)
saveRDS(dt_test_eng_targetMean, paste0(path_rds, "dt_test_eng_targetMean.rds"))
rm(dt_test_eng_targetMean)
gc()

print("##### test - Extra Features #####")
dt_test_eng_extra = featureEngineer_Extra(ls_dt$dt_test, dt_drug)
saveRDS(dt_test_eng_extra, paste0(path_rds, "dt_test_eng_extra.rds"))
rm(dt_test_eng_extra)
gc()

print("##### test - ATC Features #####")
dt_test_eng_atc = featureEngineer_ATC(ls_dt$dt_test, trainEndDate = year, dt_drug, dt_atc)
saveRDS(dt_test_eng_atc, paste0(path_rds, "dt_test_eng_atc.rds"))
rm(dt_test_eng_atc)
gc()

print("##### test - Date Features #####")
dt_test_eng_date = featureEngineer_Date(ls_dt$dt_test, trainEndDate = year, dt_drug, dt_atc)
saveRDS(dt_test_eng_date, paste0(path_rds, "dt_test_eng_date.rds"))
rm(dt_test_eng_date)
gc()

print("##### test - Txns Features #####")
dt_test_eng_txns = featureEngineer_Txns(ls_dt$dt_test, trainEndDate = year, dt_drug, dt_atc)
saveRDS(dt_test_eng_txns, paste0(path_rds, "dt_test_eng_txns.rds"))
rm(dt_test_eng_txns)
gc()

print("##### test - Illness Features #####")
dt_test_eng_illness = featureEngineer_Illness(ls_dt$dt_test, trainEndDate = year, dt_drug, dt_atc)
saveRDS(dt_test_eng_illness, paste0(path_rds, "dt_test_eng_illness.rds"))
rm(dt_test_eng_illness)
gc()

print("##### test - Drug Features #####")
dt_test_eng_drug = featureEngineer_Drug(ls_dt$dt_test, trainEndDate = year, dt_drug, dt_atc)
saveRDS(dt_test_eng_drug, paste0(path_rds, "dt_test_eng_drug.rds"))
rm(dt_test_eng_drug)
gc()

print("##### test - Patient Features #####")
dt_test_eng_patient = featureEngineer_Patient(ls_dt$dt_test, trainEndDate = year, dt_drug, dt_atc, dt_patient, dt_store)
saveRDS(dt_test_eng_patient, paste0(path_rds, "dt_test_eng_patient.rds"))
rm(dt_test_eng_patient)
gc()



rm(ls_dt)
gc()


# 2015, 3 -----------------------------------------------------------------

# config


config = list()
config$trainEndDate = "2016-01-01"
config$testEndDate = "2017-05-01"
config$splitRatio = c(.8, .2)
config$Target = "General"
config$no_of_year = 3


# split

year = "2015-01-01"

# ls_dt = splitData_year_2016(dt_txn, Target = config$Target, dt_ilness, splitRatio = config$splitRatio, no_of_year = config$no_of_year)
ls_dt = splitData_year(dt_txn, Target = config$Target, dt_ilness, splitRatio = config$splitRatio, years = year, no_of_year = config$no_of_year)


if(!is.na(config$no_of_year)){
  
  path_rds = paste0("../data/MelbDatathon2017/rds/", config$Target, "/", year(as.Date(year)), "/", config$no_of_year, "/")
  
}else{
  
  path_rds = paste0("../data/MelbDatathon2017/rds/", config$Target, "/", year(as.Date(year)), "/")
  
}

# feature engineering

## train
print("##### Train - TargetMean Features #####")
dt_train_eng_targetMean = featureEngineer_TargetMean(ls_dt$dt_train, dt_drug)
saveRDS(dt_train_eng_targetMean, paste0(path_rds, "dt_train_eng_targetMean.rds"))
rm(dt_train_eng_targetMean)
gc()

print("##### Train - Extra Features #####")
dt_train_eng_extra = featureEngineer_Extra(ls_dt$dt_train, dt_drug)
saveRDS(dt_train_eng_extra, paste0(path_rds, "dt_train_eng_extra.rds"))
rm(dt_train_eng_extra)
gc()

print("##### Train - ATC Features #####")
dt_train_eng_atc1 = featureEngineer_ATC(ls_dt$dt_train[Patient_ID >= 279201], trainEndDate = year, dt_drug, dt_atc)
dt_train_eng_atc2 = featureEngineer_ATC(ls_dt$dt_train[Patient_ID < 279201], trainEndDate = year, dt_drug, dt_atc)
dt_train_eng_atc = rbind(dt_train_eng_atc1, dt_train_eng_atc2)
saveRDS(dt_train_eng_atc, paste0(path_rds, "dt_train_eng_atc.rds"))
rm(dt_train_eng_atc1, dt_train_eng_atc2, dt_train_eng_atc)
gc()

print("##### Train - Date Features #####")
dt_train_eng_date = featureEngineer_Date(ls_dt$dt_train, trainEndDate = year, dt_drug, dt_atc)
saveRDS(dt_train_eng_date, paste0(path_rds, "dt_train_eng_date.rds"))
rm(dt_train_eng_date)
gc()

print("##### Train - Txns Features #####")
dt_train_eng_txns = featureEngineer_Txns(ls_dt$dt_train, trainEndDate = year, dt_drug, dt_atc)
saveRDS(dt_train_eng_txns, paste0(path_rds, "dt_train_eng_txns.rds"))
rm(dt_train_eng_txns)
gc()

print("##### Train - Illness Features #####")
dt_train_eng_illness = featureEngineer_Illness(ls_dt$dt_train, trainEndDate = year, dt_drug, dt_atc)
saveRDS(dt_train_eng_illness, paste0(path_rds, "dt_train_eng_illness.rds"))
rm(dt_train_eng_illness)
gc()

print("##### Train - Drug Features #####")
dt_train_eng_drug = featureEngineer_Drug(ls_dt$dt_train, trainEndDate = year, dt_drug, dt_atc)
saveRDS(dt_train_eng_drug, paste0(path_rds, "dt_train_eng_drug.rds"))
rm(dt_train_eng_drug)
gc()

print("##### Train - Patient Features #####")
dt_train_eng_patient = featureEngineer_Patient(ls_dt$dt_train, trainEndDate = year, dt_drug, dt_atc, dt_patient, dt_store)
saveRDS(dt_train_eng_patient, paste0(path_rds, "dt_train_eng_patient.rds"))
rm(dt_train_eng_patient)
gc()


rm(ls_dt)
gc()


# 2015, 2 -----------------------------------------------------------------

# config


config = list()
config$trainEndDate = "2016-01-01"
config$testEndDate = "2017-05-01"
config$splitRatio = c(.8, .2)
config$Target = "General"
config$no_of_year = 2


# split

year = "2015-01-01"

# ls_dt = splitData_year_2016(dt_txn, Target = config$Target, dt_ilness, splitRatio = config$splitRatio, no_of_year = config$no_of_year)
ls_dt = splitData_year(dt_txn, Target = config$Target, dt_ilness, splitRatio = config$splitRatio, years = year, no_of_year = config$no_of_year)


if(!is.na(config$no_of_year)){
  
  path_rds = paste0("../data/MelbDatathon2017/rds/", config$Target, "/", year(as.Date(year)), "/", config$no_of_year, "/")
  
}else{
  
  path_rds = paste0("../data/MelbDatathon2017/rds/", config$Target, "/", year(as.Date(year)), "/")
  
}

# feature engineering

## train
print("##### Train - TargetMean Features #####")
dt_train_eng_targetMean = featureEngineer_TargetMean(ls_dt$dt_train, dt_drug)
saveRDS(dt_train_eng_targetMean, paste0(path_rds, "dt_train_eng_targetMean.rds"))
rm(dt_train_eng_targetMean)
gc()

print("##### Train - Extra Features #####")
dt_train_eng_extra = featureEngineer_Extra(ls_dt$dt_train, dt_drug)
saveRDS(dt_train_eng_extra, paste0(path_rds, "dt_train_eng_extra.rds"))
rm(dt_train_eng_extra)
gc()

print("##### Train - ATC Features #####")
dt_train_eng_atc = featureEngineer_ATC(ls_dt$dt_train, trainEndDate = year, dt_drug, dt_atc)
saveRDS(dt_train_eng_atc, paste0(path_rds, "dt_train_eng_atc.rds"))
rm(dt_train_eng_atc)
gc()

print("##### Train - Date Features #####")
dt_train_eng_date = featureEngineer_Date(ls_dt$dt_train, trainEndDate = year, dt_drug, dt_atc)
saveRDS(dt_train_eng_date, paste0(path_rds, "dt_train_eng_date.rds"))
rm(dt_train_eng_date)
gc()

print("##### Train - Txns Features #####")
dt_train_eng_txns = featureEngineer_Txns(ls_dt$dt_train, trainEndDate = year, dt_drug, dt_atc)
saveRDS(dt_train_eng_txns, paste0(path_rds, "dt_train_eng_txns.rds"))
rm(dt_train_eng_txns)
gc()

print("##### Train - Illness Features #####")
dt_train_eng_illness = featureEngineer_Illness(ls_dt$dt_train, trainEndDate = year, dt_drug, dt_atc)
saveRDS(dt_train_eng_illness, paste0(path_rds, "dt_train_eng_illness.rds"))
rm(dt_train_eng_illness)
gc()

print("##### Train - Drug Features #####")
dt_train_eng_drug = featureEngineer_Drug(ls_dt$dt_train, trainEndDate = year, dt_drug, dt_atc)
saveRDS(dt_train_eng_drug, paste0(path_rds, "dt_train_eng_drug.rds"))
rm(dt_train_eng_drug)
gc()

print("##### Train - Patient Features #####")
dt_train_eng_patient = featureEngineer_Patient(ls_dt$dt_train, trainEndDate = year, dt_drug, dt_atc, dt_patient, dt_store)
saveRDS(dt_train_eng_patient, paste0(path_rds, "dt_train_eng_patient.rds"))
rm(dt_train_eng_patient)
gc()


rm(ls_dt)
gc()


# 2015, 1 -----------------------------------------------------------------

# config


config = list()
config$trainEndDate = "2016-01-01"
config$testEndDate = "2017-05-01"
config$splitRatio = c(.8, .2)
config$Target = "General"
config$no_of_year = 1


# split

year = "2015-01-01"

# ls_dt = splitData_year_2016(dt_txn, Target = config$Target, dt_ilness, splitRatio = config$splitRatio, no_of_year = config$no_of_year)
ls_dt = splitData_year(dt_txn, Target = config$Target, dt_ilness, splitRatio = config$splitRatio, years = year, no_of_year = config$no_of_year)


if(!is.na(config$no_of_year)){
  
  path_rds = paste0("../data/MelbDatathon2017/rds/", config$Target, "/", year(as.Date(year)), "/", config$no_of_year, "/")
  
}else{
  
  path_rds = paste0("../data/MelbDatathon2017/rds/", config$Target, "/", year(as.Date(year)), "/")
  
}

# feature engineering

## train
print("##### Train - TargetMean Features #####")
dt_train_eng_targetMean = featureEngineer_TargetMean(ls_dt$dt_train, dt_drug)
saveRDS(dt_train_eng_targetMean, paste0(path_rds, "dt_train_eng_targetMean.rds"))
rm(dt_train_eng_targetMean)
gc()

print("##### Train - Extra Features #####")
dt_train_eng_extra = featureEngineer_Extra(ls_dt$dt_train, dt_drug)
saveRDS(dt_train_eng_extra, paste0(path_rds, "dt_train_eng_extra.rds"))
rm(dt_train_eng_extra)
gc()

print("##### Train - ATC Features #####")
dt_train_eng_atc = featureEngineer_ATC(ls_dt$dt_train, trainEndDate = year, dt_drug, dt_atc)
saveRDS(dt_train_eng_atc, paste0(path_rds, "dt_train_eng_atc.rds"))
rm(dt_train_eng_atc)
gc()

print("##### Train - Date Features #####")
dt_train_eng_date = featureEngineer_Date(ls_dt$dt_train, trainEndDate = year, dt_drug, dt_atc)
saveRDS(dt_train_eng_date, paste0(path_rds, "dt_train_eng_date.rds"))
rm(dt_train_eng_date)
gc()

print("##### Train - Txns Features #####")
dt_train_eng_txns = featureEngineer_Txns(ls_dt$dt_train, trainEndDate = year, dt_drug, dt_atc)
saveRDS(dt_train_eng_txns, paste0(path_rds, "dt_train_eng_txns.rds"))
rm(dt_train_eng_txns)
gc()

print("##### Train - Illness Features #####")
dt_train_eng_illness = featureEngineer_Illness(ls_dt$dt_train, trainEndDate = year, dt_drug, dt_atc)
saveRDS(dt_train_eng_illness, paste0(path_rds, "dt_train_eng_illness.rds"))
rm(dt_train_eng_illness)
gc()

print("##### Train - Drug Features #####")
dt_train_eng_drug = featureEngineer_Drug(ls_dt$dt_train, trainEndDate = year, dt_drug, dt_atc)
saveRDS(dt_train_eng_drug, paste0(path_rds, "dt_train_eng_drug.rds"))
rm(dt_train_eng_drug)
gc()

print("##### Train - Patient Features #####")
dt_train_eng_patient = featureEngineer_Patient(ls_dt$dt_train, trainEndDate = year, dt_drug, dt_atc, dt_patient, dt_store)
saveRDS(dt_train_eng_patient, paste0(path_rds, "dt_train_eng_patient.rds"))
rm(dt_train_eng_patient)
gc()


rm(ls_dt)
gc()


# 2014, 3 -----------------------------------------------------------------

# config


config = list()
config$trainEndDate = "2016-01-01"
config$testEndDate = "2017-05-01"
config$splitRatio = c(.8, .2)
config$Target = "General"
config$no_of_year = 3


# split

year = "2014-01-01"

# ls_dt = splitData_year_2016(dt_txn, Target = config$Target, dt_ilness, splitRatio = config$splitRatio, no_of_year = config$no_of_year)
ls_dt = splitData_year(dt_txn, Target = config$Target, dt_ilness, splitRatio = config$splitRatio, years = year, no_of_year = config$no_of_year)


if(!is.na(config$no_of_year)){
  
  path_rds = paste0("../data/MelbDatathon2017/rds/", config$Target, "/", year(as.Date(year)), "/", config$no_of_year, "/")
  
}else{
  
  path_rds = paste0("../data/MelbDatathon2017/rds/", config$Target, "/", year(as.Date(year)), "/")
  
}

# feature engineering

## train
print("##### Train - TargetMean Features #####")
dt_train_eng_targetMean = featureEngineer_TargetMean(ls_dt$dt_train, dt_drug)
saveRDS(dt_train_eng_targetMean, paste0(path_rds, "dt_train_eng_targetMean.rds"))
rm(dt_train_eng_targetMean)
gc()

print("##### Train - Extra Features #####")
dt_train_eng_extra = featureEngineer_Extra(ls_dt$dt_train, dt_drug)
saveRDS(dt_train_eng_extra, paste0(path_rds, "dt_train_eng_extra.rds"))
rm(dt_train_eng_extra)
gc()

print("##### Train - ATC Features #####")
dt_train_eng_atc = featureEngineer_ATC(ls_dt$dt_train, trainEndDate = year, dt_drug, dt_atc)
saveRDS(dt_train_eng_atc, paste0(path_rds, "dt_train_eng_atc.rds"))
rm(dt_train_eng_atc)
gc()

print("##### Train - Date Features #####")
dt_train_eng_date = featureEngineer_Date(ls_dt$dt_train, trainEndDate = year, dt_drug, dt_atc)
saveRDS(dt_train_eng_date, paste0(path_rds, "dt_train_eng_date.rds"))
rm(dt_train_eng_date)
gc()

print("##### Train - Txns Features #####")
dt_train_eng_txns = featureEngineer_Txns(ls_dt$dt_train, trainEndDate = year, dt_drug, dt_atc)
saveRDS(dt_train_eng_txns, paste0(path_rds, "dt_train_eng_txns.rds"))
rm(dt_train_eng_txns)
gc()

print("##### Train - Illness Features #####")
dt_train_eng_illness = featureEngineer_Illness(ls_dt$dt_train, trainEndDate = year, dt_drug, dt_atc)
saveRDS(dt_train_eng_illness, paste0(path_rds, "dt_train_eng_illness.rds"))
rm(dt_train_eng_illness)
gc()

print("##### Train - Drug Features #####")
dt_train_eng_drug = featureEngineer_Drug(ls_dt$dt_train, trainEndDate = year, dt_drug, dt_atc)
saveRDS(dt_train_eng_drug, paste0(path_rds, "dt_train_eng_drug.rds"))
rm(dt_train_eng_drug)
gc()

print("##### Train - Patient Features #####")
dt_train_eng_patient = featureEngineer_Patient(ls_dt$dt_train, trainEndDate = year, dt_drug, dt_atc, dt_patient, dt_store)
saveRDS(dt_train_eng_patient, paste0(path_rds, "dt_train_eng_patient.rds"))
rm(dt_train_eng_patient)
gc()


rm(ls_dt)
gc()


# 2014, 2 -----------------------------------------------------------------

# config


config = list()
config$trainEndDate = "2016-01-01"
config$testEndDate = "2017-05-01"
config$splitRatio = c(.8, .2)
config$Target = "General"
config$no_of_year = 2


# split

year = "2014-01-01"

# ls_dt = splitData_year_2016(dt_txn, Target = config$Target, dt_ilness, splitRatio = config$splitRatio, no_of_year = config$no_of_year)
ls_dt = splitData_year(dt_txn, Target = config$Target, dt_ilness, splitRatio = config$splitRatio, years = year, no_of_year = config$no_of_year)


if(!is.na(config$no_of_year)){
  
  path_rds = paste0("../data/MelbDatathon2017/rds/", config$Target, "/", year(as.Date(year)), "/", config$no_of_year, "/")
  
}else{
  
  path_rds = paste0("../data/MelbDatathon2017/rds/", config$Target, "/", year(as.Date(year)), "/")
  
}

# feature engineering

## train
print("##### Train - TargetMean Features #####")
dt_train_eng_targetMean = featureEngineer_TargetMean(ls_dt$dt_train, dt_drug)
saveRDS(dt_train_eng_targetMean, paste0(path_rds, "dt_train_eng_targetMean.rds"))
rm(dt_train_eng_targetMean)
gc()

print("##### Train - Extra Features #####")
dt_train_eng_extra = featureEngineer_Extra(ls_dt$dt_train, dt_drug)
saveRDS(dt_train_eng_extra, paste0(path_rds, "dt_train_eng_extra.rds"))
rm(dt_train_eng_extra)
gc()

print("##### Train - ATC Features #####")
dt_train_eng_atc = featureEngineer_ATC(ls_dt$dt_train, trainEndDate = year, dt_drug, dt_atc)
saveRDS(dt_train_eng_atc, paste0(path_rds, "dt_train_eng_atc.rds"))
rm(dt_train_eng_atc)
gc()

print("##### Train - Date Features #####")
dt_train_eng_date = featureEngineer_Date(ls_dt$dt_train, trainEndDate = year, dt_drug, dt_atc)
saveRDS(dt_train_eng_date, paste0(path_rds, "dt_train_eng_date.rds"))
rm(dt_train_eng_date)
gc()

print("##### Train - Txns Features #####")
dt_train_eng_txns = featureEngineer_Txns(ls_dt$dt_train, trainEndDate = year, dt_drug, dt_atc)
saveRDS(dt_train_eng_txns, paste0(path_rds, "dt_train_eng_txns.rds"))
rm(dt_train_eng_txns)
gc()

print("##### Train - Illness Features #####")
dt_train_eng_illness = featureEngineer_Illness(ls_dt$dt_train, trainEndDate = year, dt_drug, dt_atc)
saveRDS(dt_train_eng_illness, paste0(path_rds, "dt_train_eng_illness.rds"))
rm(dt_train_eng_illness)
gc()

print("##### Train - Drug Features #####")
dt_train_eng_drug = featureEngineer_Drug(ls_dt$dt_train, trainEndDate = year, dt_drug, dt_atc)
saveRDS(dt_train_eng_drug, paste0(path_rds, "dt_train_eng_drug.rds"))
rm(dt_train_eng_drug)
gc()

print("##### Train - Patient Features #####")
dt_train_eng_patient = featureEngineer_Patient(ls_dt$dt_train, trainEndDate = year, dt_drug, dt_atc, dt_patient, dt_store)
saveRDS(dt_train_eng_patient, paste0(path_rds, "dt_train_eng_patient.rds"))
rm(dt_train_eng_patient)
gc()


rm(ls_dt)
gc()


# 2014, 1 -----------------------------------------------------------------

# config


config = list()
config$trainEndDate = "2016-01-01"
config$testEndDate = "2017-05-01"
config$splitRatio = c(.8, .2)
config$Target = "General"
config$no_of_year = 1


# split

year = "2014-01-01"

# ls_dt = splitData_year_2016(dt_txn, Target = config$Target, dt_ilness, splitRatio = config$splitRatio, no_of_year = config$no_of_year)
ls_dt = splitData_year(dt_txn, Target = config$Target, dt_ilness, splitRatio = config$splitRatio, years = year, no_of_year = config$no_of_year)


if(!is.na(config$no_of_year)){
  
  path_rds = paste0("../data/MelbDatathon2017/rds/", config$Target, "/", year(as.Date(year)), "/", config$no_of_year, "/")
  
}else{
  
  path_rds = paste0("../data/MelbDatathon2017/rds/", config$Target, "/", year(as.Date(year)), "/")
  
}

# feature engineering

## train
print("##### Train - TargetMean Features #####")
dt_train_eng_targetMean = featureEngineer_TargetMean(ls_dt$dt_train, dt_drug)
saveRDS(dt_train_eng_targetMean, paste0(path_rds, "dt_train_eng_targetMean.rds"))
rm(dt_train_eng_targetMean)
gc()

print("##### Train - Extra Features #####")
dt_train_eng_extra = featureEngineer_Extra(ls_dt$dt_train, dt_drug)
saveRDS(dt_train_eng_extra, paste0(path_rds, "dt_train_eng_extra.rds"))
rm(dt_train_eng_extra)
gc()

print("##### Train - ATC Features #####")
dt_train_eng_atc = featureEngineer_ATC(ls_dt$dt_train, trainEndDate = year, dt_drug, dt_atc)
saveRDS(dt_train_eng_atc, paste0(path_rds, "dt_train_eng_atc.rds"))
rm(dt_train_eng_atc)
gc()

print("##### Train - Date Features #####")
dt_train_eng_date = featureEngineer_Date(ls_dt$dt_train, trainEndDate = year, dt_drug, dt_atc)
saveRDS(dt_train_eng_date, paste0(path_rds, "dt_train_eng_date.rds"))
rm(dt_train_eng_date)
gc()

print("##### Train - Txns Features #####")
dt_train_eng_txns = featureEngineer_Txns(ls_dt$dt_train, trainEndDate = year, dt_drug, dt_atc)
saveRDS(dt_train_eng_txns, paste0(path_rds, "dt_train_eng_txns.rds"))
rm(dt_train_eng_txns)
gc()

print("##### Train - Illness Features #####")
dt_train_eng_illness = featureEngineer_Illness(ls_dt$dt_train, trainEndDate = year, dt_drug, dt_atc)
saveRDS(dt_train_eng_illness, paste0(path_rds, "dt_train_eng_illness.rds"))
rm(dt_train_eng_illness)
gc()

print("##### Train - Drug Features #####")
dt_train_eng_drug = featureEngineer_Drug(ls_dt$dt_train, trainEndDate = year, dt_drug, dt_atc)
saveRDS(dt_train_eng_drug, paste0(path_rds, "dt_train_eng_drug.rds"))
rm(dt_train_eng_drug)
gc()

print("##### Train - Patient Features #####")
dt_train_eng_patient = featureEngineer_Patient(ls_dt$dt_train, trainEndDate = year, dt_drug, dt_atc, dt_patient, dt_store)
saveRDS(dt_train_eng_patient, paste0(path_rds, "dt_train_eng_patient.rds"))
rm(dt_train_eng_patient)
gc()


rm(ls_dt)
gc()


# 2013, 2 -----------------------------------------------------------------

# config


config = list()
config$trainEndDate = "2016-01-01"
config$testEndDate = "2017-05-01"
config$splitRatio = c(.8, .2)
config$Target = "General"
config$no_of_year = 2


# split

year = "2013-01-01"

# ls_dt = splitData_year_2016(dt_txn, Target = config$Target, dt_ilness, splitRatio = config$splitRatio, no_of_year = config$no_of_year)
ls_dt = splitData_year(dt_txn, Target = config$Target, dt_ilness, splitRatio = config$splitRatio, years = year, no_of_year = config$no_of_year)


if(!is.na(config$no_of_year)){
  
  path_rds = paste0("../data/MelbDatathon2017/rds/", config$Target, "/", year(as.Date(year)), "/", config$no_of_year, "/")
  
}else{
  
  path_rds = paste0("../data/MelbDatathon2017/rds/", config$Target, "/", year(as.Date(year)), "/")
  
}

# feature engineering

## train
print("##### Train - TargetMean Features #####")
dt_train_eng_targetMean = featureEngineer_TargetMean(ls_dt$dt_train, dt_drug)
saveRDS(dt_train_eng_targetMean, paste0(path_rds, "dt_train_eng_targetMean.rds"))
rm(dt_train_eng_targetMean)
gc()

print("##### Train - Extra Features #####")
dt_train_eng_extra = featureEngineer_Extra(ls_dt$dt_train, dt_drug)
saveRDS(dt_train_eng_extra, paste0(path_rds, "dt_train_eng_extra.rds"))
rm(dt_train_eng_extra)
gc()

print("##### Train - ATC Features #####")
dt_train_eng_atc = featureEngineer_ATC(ls_dt$dt_train, trainEndDate = year, dt_drug, dt_atc)
saveRDS(dt_train_eng_atc, paste0(path_rds, "dt_train_eng_atc.rds"))
rm(dt_train_eng_atc)
gc()

print("##### Train - Date Features #####")
dt_train_eng_date = featureEngineer_Date(ls_dt$dt_train, trainEndDate = year, dt_drug, dt_atc)
saveRDS(dt_train_eng_date, paste0(path_rds, "dt_train_eng_date.rds"))
rm(dt_train_eng_date)
gc()

print("##### Train - Txns Features #####")
dt_train_eng_txns = featureEngineer_Txns(ls_dt$dt_train, trainEndDate = year, dt_drug, dt_atc)
saveRDS(dt_train_eng_txns, paste0(path_rds, "dt_train_eng_txns.rds"))
rm(dt_train_eng_txns)
gc()

print("##### Train - Illness Features #####")
dt_train_eng_illness = featureEngineer_Illness(ls_dt$dt_train, trainEndDate = year, dt_drug, dt_atc)
saveRDS(dt_train_eng_illness, paste0(path_rds, "dt_train_eng_illness.rds"))
rm(dt_train_eng_illness)
gc()

print("##### Train - Drug Features #####")
dt_train_eng_drug = featureEngineer_Drug(ls_dt$dt_train, trainEndDate = year, dt_drug, dt_atc)
saveRDS(dt_train_eng_drug, paste0(path_rds, "dt_train_eng_drug.rds"))
rm(dt_train_eng_drug)
gc()

print("##### Train - Patient Features #####")
dt_train_eng_patient = featureEngineer_Patient(ls_dt$dt_train, trainEndDate = year, dt_drug, dt_atc, dt_patient, dt_store)
saveRDS(dt_train_eng_patient, paste0(path_rds, "dt_train_eng_patient.rds"))
rm(dt_train_eng_patient)
gc()


rm(ls_dt)
gc()


# 2013, 1 -----------------------------------------------------------------

# config


config = list()
config$trainEndDate = "2016-01-01"
config$testEndDate = "2017-05-01"
config$splitRatio = c(.8, .2)
config$Target = "General"
config$no_of_year = 1


# split

year = "2013-01-01"

# ls_dt = splitData_year_2016(dt_txn, Target = config$Target, dt_ilness, splitRatio = config$splitRatio, no_of_year = config$no_of_year)
ls_dt = splitData_year(dt_txn, Target = config$Target, dt_ilness, splitRatio = config$splitRatio, years = year, no_of_year = config$no_of_year)


if(!is.na(config$no_of_year)){
  
  path_rds = paste0("../data/MelbDatathon2017/rds/", config$Target, "/", year(as.Date(year)), "/", config$no_of_year, "/")
  
}else{
  
  path_rds = paste0("../data/MelbDatathon2017/rds/", config$Target, "/", year(as.Date(year)), "/")
  
}

# feature engineering

## train
print("##### Train - TargetMean Features #####")
dt_train_eng_targetMean = featureEngineer_TargetMean(ls_dt$dt_train, dt_drug)
saveRDS(dt_train_eng_targetMean, paste0(path_rds, "dt_train_eng_targetMean.rds"))
rm(dt_train_eng_targetMean)
gc()

print("##### Train - Extra Features #####")
dt_train_eng_extra = featureEngineer_Extra(ls_dt$dt_train, dt_drug)
saveRDS(dt_train_eng_extra, paste0(path_rds, "dt_train_eng_extra.rds"))
rm(dt_train_eng_extra)
gc()

print("##### Train - ATC Features #####")
dt_train_eng_atc = featureEngineer_ATC(ls_dt$dt_train, trainEndDate = year, dt_drug, dt_atc)
saveRDS(dt_train_eng_atc, paste0(path_rds, "dt_train_eng_atc.rds"))
rm(dt_train_eng_atc)
gc()

print("##### Train - Date Features #####")
dt_train_eng_date = featureEngineer_Date(ls_dt$dt_train, trainEndDate = year, dt_drug, dt_atc)
saveRDS(dt_train_eng_date, paste0(path_rds, "dt_train_eng_date.rds"))
rm(dt_train_eng_date)
gc()

print("##### Train - Txns Features #####")
dt_train_eng_txns = featureEngineer_Txns(ls_dt$dt_train, trainEndDate = year, dt_drug, dt_atc)
saveRDS(dt_train_eng_txns, paste0(path_rds, "dt_train_eng_txns.rds"))
rm(dt_train_eng_txns)
gc()

print("##### Train - Illness Features #####")
dt_train_eng_illness = featureEngineer_Illness(ls_dt$dt_train, trainEndDate = year, dt_drug, dt_atc)
saveRDS(dt_train_eng_illness, paste0(path_rds, "dt_train_eng_illness.rds"))
rm(dt_train_eng_illness)
gc()

print("##### Train - Drug Features #####")
dt_train_eng_drug = featureEngineer_Drug(ls_dt$dt_train, trainEndDate = year, dt_drug, dt_atc)
saveRDS(dt_train_eng_drug, paste0(path_rds, "dt_train_eng_drug.rds"))
rm(dt_train_eng_drug)
gc()

print("##### Train - Patient Features #####")
dt_train_eng_patient = featureEngineer_Patient(ls_dt$dt_train, trainEndDate = year, dt_drug, dt_atc, dt_patient, dt_store)
saveRDS(dt_train_eng_patient, paste0(path_rds, "dt_train_eng_patient.rds"))
rm(dt_train_eng_patient)
gc()


rm(ls_dt)
gc()



# 2012, 1 -----------------------------------------------------------------

# config


config = list()
config$trainEndDate = "2016-01-01"
config$testEndDate = "2017-05-01"
config$splitRatio = c(.8, .2)
config$Target = "General"
config$no_of_year = 1


# split

year = "2012-01-01"

# ls_dt = splitData_year_2016(dt_txn, Target = config$Target, dt_ilness, splitRatio = config$splitRatio, no_of_year = config$no_of_year)
ls_dt = splitData_year(dt_txn, Target = config$Target, dt_ilness, splitRatio = config$splitRatio, years = year, no_of_year = config$no_of_year)


if(!is.na(config$no_of_year)){
  
  path_rds = paste0("../data/MelbDatathon2017/rds/", config$Target, "/", year(as.Date(year)), "/", config$no_of_year, "/")
  
}else{
  
  path_rds = paste0("../data/MelbDatathon2017/rds/", config$Target, "/", year(as.Date(year)), "/")
  
}

# feature engineering

## train
print("##### Train - TargetMean Features #####")
dt_train_eng_targetMean = featureEngineer_TargetMean(ls_dt$dt_train, dt_drug)
saveRDS(dt_train_eng_targetMean, paste0(path_rds, "dt_train_eng_targetMean.rds"))
rm(dt_train_eng_targetMean)
gc()

print("##### Train - Extra Features #####")
dt_train_eng_extra = featureEngineer_Extra(ls_dt$dt_train, dt_drug)
saveRDS(dt_train_eng_extra, paste0(path_rds, "dt_train_eng_extra.rds"))
rm(dt_train_eng_extra)
gc()

print("##### Train - ATC Features #####")
dt_train_eng_atc = featureEngineer_ATC(ls_dt$dt_train, trainEndDate = year, dt_drug, dt_atc)
saveRDS(dt_train_eng_atc, paste0(path_rds, "dt_train_eng_atc.rds"))
rm(dt_train_eng_atc)
gc()

print("##### Train - Date Features #####")
dt_train_eng_date = featureEngineer_Date(ls_dt$dt_train, trainEndDate = year, dt_drug, dt_atc)
saveRDS(dt_train_eng_date, paste0(path_rds, "dt_train_eng_date.rds"))
rm(dt_train_eng_date)
gc()

print("##### Train - Txns Features #####")
dt_train_eng_txns = featureEngineer_Txns(ls_dt$dt_train, trainEndDate = year, dt_drug, dt_atc)
saveRDS(dt_train_eng_txns, paste0(path_rds, "dt_train_eng_txns.rds"))
rm(dt_train_eng_txns)
gc()

print("##### Train - Illness Features #####")
dt_train_eng_illness = featureEngineer_Illness(ls_dt$dt_train, trainEndDate = year, dt_drug, dt_atc)
saveRDS(dt_train_eng_illness, paste0(path_rds, "dt_train_eng_illness.rds"))
rm(dt_train_eng_illness)
gc()

print("##### Train - Drug Features #####")
dt_train_eng_drug = featureEngineer_Drug(ls_dt$dt_train, trainEndDate = year, dt_drug, dt_atc)
saveRDS(dt_train_eng_drug, paste0(path_rds, "dt_train_eng_drug.rds"))
rm(dt_train_eng_drug)
gc()

print("##### Train - Patient Features #####")
dt_train_eng_patient = featureEngineer_Patient(ls_dt$dt_train, trainEndDate = year, dt_drug, dt_atc, dt_patient, dt_store)
saveRDS(dt_train_eng_patient, paste0(path_rds, "dt_train_eng_patient.rds"))
rm(dt_train_eng_patient)
gc()


rm(ls_dt)
gc()