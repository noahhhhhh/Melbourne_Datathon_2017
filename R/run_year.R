source("R/load.R", keep.source = T)
print(paste0("[", Sys.time(), "]: ", "Load ..."))


source("R/split.R")
source("R/featureEngineer.R")
source("R/preprocess.R")
source("R/model.R")

# config ------------------------------------------------------------------


config = list()
config$trainEndDate = "2016-01-01"
config$testEndDate = "2017-05-01"
config$splitRatio = c(.8, .2)
config$Target = "General"
config$no_of_year = NA


# split -------------------------------------------------------------------

year = "2016-01-01"

ls_dt = splitData_year_2016(dt_txn, Target = config$Target, dt_ilness, splitRatio = config$splitRatio, no_of_year = config$no_of_year)
# ls_dt = splitData_year(dt_txn, Target = config$Target, dt_ilness, splitRatio = config$splitRatio, years = year, no_of_year = config$no_of_year)


if(!is.na(config$no_of_year)){
  
  path_rds = paste0("../data/MelbDatathon2017/rds/", config$Target, "/", year(as.Date(year)), "/", config$no_of_year, "/")
  
}else{
  
  path_rds = paste0("../data/MelbDatathon2017/rds/", config$Target, "/", year(as.Date(year)), "/")
  
}

# feature engineering -----------------------------------------------------

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


# merge -------------------------------------------------------------------

years_ = seq(2013, 2016)
# years_ = 2016

dt_train_eng_all = data.table()
dt_valid_eng_all = data.table()

# year_ = 2016
for(year_ in years_){
  
  if(!is.na(config$no_of_year)){
    
    path_rds = paste0("../data/MelbDatathon2017/rds/", config$Target, "/", year_, "/", config$no_of_year, "/")
    
  }else{
    
    path_rds = paste0("../data/MelbDatathon2017/rds/", config$Target, "/", year_, "/")
    
  }
  
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
  dt_valid_eng_all = rbind(dt_valid_eng_all, dt_valid_eng)
  
  print(year_)
}


rm(dt_train_eng_atc, dt_train_eng_date, dt_train_eng_txns, dt_train_eng_illness, dt_train_eng_drug, dt_train_eng_patient, dt_train_eng)
rm(dt_valid_eng_atc, dt_valid_eng_date, dt_valid_eng_txns, dt_valid_eng_illness, dt_valid_eng_drug, dt_valid_eng_patient, dt_valid_eng)
gc()


# preprocess --------------------------------------------------------------

ls_preprocess = preprocess(dt_train_eng = dt_train_eng_all, dt_valid_eng = dt_valid_eng_all
                           , impute_to_0 = T, normalisation = F, targetMean = T)


gc()


# model -------------------------------------------------------------------

print(paste0("[", Sys.time(), "]: ", "Single Xgb ..."))
model_xgb = model(ls_preprocess$dt_train_eng, ls_preprocess$dt_valid_eng
                  , modelTarget = config$Target, modelType = "xgboost", randomSearch = F)
print(paste0("[", Sys.time(), "]: ", "Single Xgb Done ..."))


# importance
importance = xgb.importance(setdiff(names(ls_preprocess$dt_valid_eng), c("Patient_ID", "Target")), model_xgb$xgboost)
xgb.plot.importance(importance[1:50])
