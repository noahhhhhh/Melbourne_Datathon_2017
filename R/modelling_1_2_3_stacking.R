
# 1 year ------------------------------------------------------------------

# config

require(data.table)

config = list()
config$splitRatio = c(.8, .2)
config$Target = "General"
config$no_of_year = 1

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
  # dt_train_eng_atc = readRDS(paste0(path_rds, "dt_train_eng_atc.rds"))
  dt_train_eng_date = readRDS(paste0(path_rds, "dt_train_eng_date.rds"))
  dt_train_eng_txns = readRDS(paste0(path_rds, "dt_train_eng_txns.rds"))
  dt_train_eng_illness = readRDS(paste0(path_rds, "dt_train_eng_illness.rds"))
  dt_train_eng_drug = readRDS(paste0(path_rds, "dt_train_eng_drug.rds"))
  dt_train_eng_patient = readRDS(paste0(path_rds, "dt_train_eng_patient.rds"))
  dt_train_eng_extra = readRDS(paste0(path_rds, "dt_train_eng_extra.rds"))
  dt_train_eng_targetMean = readRDS(paste0(path_rds, "dt_train_eng_targetMean.rds"))
  
  dt_train_eng = merge(dt_train_eng_txns, dt_train_eng_date, by = c("Patient_ID", "Target"))
  # dt_train_eng = merge(dt_train_eng, dt_train_eng_txns, by = c("Patient_ID", "Target"))
  dt_train_eng = merge(dt_train_eng, dt_train_eng_illness, by = c("Patient_ID", "Target"))
  dt_train_eng = merge(dt_train_eng, dt_train_eng_drug, by = c("Patient_ID", "Target"))
  dt_train_eng = merge(dt_train_eng, dt_train_eng_patient, by = c("Patient_ID", "Target"))
  dt_train_eng = merge(dt_train_eng, dt_train_eng_extra, by = c("Patient_ID", "Target"))
  dt_train_eng = merge(dt_train_eng, dt_train_eng_targetMean, by = c("Patient_ID", "Target"))
  
  
  dt_train_eng_all = rbind(dt_train_eng_all, dt_train_eng)
  
  print(year_)
}

model_1_year = readRDS("../data/MelbDatathon2017/rds/General/1_year/ls_model.rds")
mx_1_year = xgb.DMatrix(data.matrix(dt_train_eng_all[, !c("Patient_ID", "Target"), with = F])
                        , label = dt_train_eng_all$Target)

dt_1_year = data.table(Patient_ID = dt_train_eng_all$Patient_ID
                       , Diabetes = predict(model_1_year$xgboost, mx_1_year))


saveRDS(dt_1_year, "../data/MelbDatathon2017/rds/General/1_year/dt_train_preds.rds")

# 2 year ------------------------------------------------------------------

# config

require(data.table)

config = list()
config$splitRatio = c(.8, .2)
config$Target = "General"
config$no_of_year = 2

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
  # dt_train_eng_atc = readRDS(paste0(path_rds, "dt_train_eng_atc.rds"))
  dt_train_eng_date = readRDS(paste0(path_rds, "dt_train_eng_date.rds"))
  dt_train_eng_txns = readRDS(paste0(path_rds, "dt_train_eng_txns.rds"))
  dt_train_eng_illness = readRDS(paste0(path_rds, "dt_train_eng_illness.rds"))
  dt_train_eng_drug = readRDS(paste0(path_rds, "dt_train_eng_drug.rds"))
  dt_train_eng_patient = readRDS(paste0(path_rds, "dt_train_eng_patient.rds"))
  dt_train_eng_extra = readRDS(paste0(path_rds, "dt_train_eng_extra.rds"))
  dt_train_eng_targetMean = readRDS(paste0(path_rds, "dt_train_eng_targetMean.rds"))
  
  dt_train_eng = merge(dt_train_eng_txns, dt_train_eng_date, by = c("Patient_ID", "Target"))
  # dt_train_eng = merge(dt_train_eng, dt_train_eng_txns, by = c("Patient_ID", "Target"))
  dt_train_eng = merge(dt_train_eng, dt_train_eng_illness, by = c("Patient_ID", "Target"))
  dt_train_eng = merge(dt_train_eng, dt_train_eng_drug, by = c("Patient_ID", "Target"))
  dt_train_eng = merge(dt_train_eng, dt_train_eng_patient, by = c("Patient_ID", "Target"))
  dt_train_eng = merge(dt_train_eng, dt_train_eng_extra, by = c("Patient_ID", "Target"))
  dt_train_eng = merge(dt_train_eng, dt_train_eng_targetMean, by = c("Patient_ID", "Target"))
  
  
  dt_train_eng_all = rbind(dt_train_eng_all, dt_train_eng)
  
  print(year_)
}

model_2_year = readRDS("../data/MelbDatathon2017/rds/General/2_year/ls_model.rds")
mx_2_year = xgb.DMatrix(data.matrix(dt_train_eng_all[, !c("Patient_ID", "Target"), with = F])
                        , label = dt_train_eng_all$Target)

dt_2_year = data.table(Patient_ID = dt_train_eng_all$Patient_ID
                       , Diabetes = predict(model_2_year$xgboost, mx_2_year))

saveRDS(dt_2_year, "../data/MelbDatathon2017/rds/General/2_year/dt_train_preds.rds")

# 3 year ------------------------------------------------------------------

# config

require(data.table)

config = list()
config$splitRatio = c(.8, .2)
config$Target = "General"
config$no_of_year = 3

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
  # dt_train_eng_atc = readRDS(paste0(path_rds, "dt_train_eng_atc.rds"))
  dt_train_eng_date = readRDS(paste0(path_rds, "dt_train_eng_date.rds"))
  dt_train_eng_txns = readRDS(paste0(path_rds, "dt_train_eng_txns.rds"))
  dt_train_eng_illness = readRDS(paste0(path_rds, "dt_train_eng_illness.rds"))
  dt_train_eng_drug = readRDS(paste0(path_rds, "dt_train_eng_drug.rds"))
  dt_train_eng_patient = readRDS(paste0(path_rds, "dt_train_eng_patient.rds"))
  dt_train_eng_extra = readRDS(paste0(path_rds, "dt_train_eng_extra.rds"))
  dt_train_eng_targetMean = readRDS(paste0(path_rds, "dt_train_eng_targetMean.rds"))
  
  dt_train_eng = merge(dt_train_eng_txns, dt_train_eng_date, by = c("Patient_ID", "Target"))
  # dt_train_eng = merge(dt_train_eng, dt_train_eng_txns, by = c("Patient_ID", "Target"))
  dt_train_eng = merge(dt_train_eng, dt_train_eng_illness, by = c("Patient_ID", "Target"))
  dt_train_eng = merge(dt_train_eng, dt_train_eng_drug, by = c("Patient_ID", "Target"))
  dt_train_eng = merge(dt_train_eng, dt_train_eng_patient, by = c("Patient_ID", "Target"))
  dt_train_eng = merge(dt_train_eng, dt_train_eng_extra, by = c("Patient_ID", "Target"))
  dt_train_eng = merge(dt_train_eng, dt_train_eng_targetMean, by = c("Patient_ID", "Target"))
  
  
  dt_train_eng_all = rbind(dt_train_eng_all, dt_train_eng)
  
  print(year_)
}

model_3_year = readRDS("../data/MelbDatathon2017/rds/General/3_year/ls_model.rds")
mx_3_year = xgb.DMatrix(data.matrix(dt_train_eng_all[, !c("Patient_ID", "Target"), with = F])
                        , label = dt_train_eng_all$Target)

dt_3_year = data.table(Patient_ID = dt_train_eng_all$Patient_ID
                       , Diabetes = predict(model_3_year$xgboost, mx_3_year))

saveRDS(dt_3_year, "../data/MelbDatathon2017/rds/General/3_year/dt_train_preds.rds")
