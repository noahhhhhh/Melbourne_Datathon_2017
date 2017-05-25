source("R/split.R")
source("R/featureEngineer.R")
source("R/preprocess.R")
source("R/model.R")

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
  
  dt_train_eng_all = rbind(dt_train_eng_all, dt_train_eng)
  dt_test_eng_all = rbind(dt_test_eng_all, dt_test_eng)
  
  print(year_)
}

rm(dt_train_eng_atc, dt_train_eng_date, dt_train_eng_txns, dt_train_eng_illness, dt_train_eng_drug, dt_train_eng_patient, dt_train_eng_extra, dt_train_eng_targetMean, dt_train_eng)
rm(dt_test_eng_atc, dt_test_eng_date, dt_test_eng_txns, dt_test_eng_illness, dt_test_eng_drug, dt_test_eng_patient, dt_test_eng_extra, dt_test_eng_targetMean, dt_test_eng)
gc()

# preprocessing
source("R/preprocess.R")
ls_preprocess = preprocess(dt_train = dt_train_eng_all, featureEngine = T, impute = T, normalisation = T, targetMean = T)
ls_preprocess = preprocess(dt_train = dt_test_eng_all, featureEngine = T, impute = T, normalisation = T, targetMean = T)


# split
require(caret)
ind_train = createDataPartition(dt_train_eng_all$Target, p = .8, list = F)
dt_train = dt_train_eng_all[ind_train]
dt_valid = dt_train_eng_all[-ind_train]

# modelling
ls_model = model(dt_train, dt_valid
                 , modelTarget = config$Target, modelType = "xgboost", randomSearch = F)

# importance
importance = xgb.importance(setdiff(names(dt_valid), c("Patient_ID", "Target")), ls_model$xgboost)
xgb.plot.importance(importance[1:50])

# preds
## valid
mx_valid = xgb.DMatrix(data.matrix(dt_valid[, !c("Patient_ID", "Target"), with = F])
                       , label = dt_valid$Target)

pred_valid = predict(ls_model$xgboost, mx_valid)

## test
mx_test = xgb.DMatrix(data.matrix(dt_test_eng_all[, !c("Patient_ID", "Target"), with = F]))
pred_test = predict(ls_model$xgboost, mx_test)
dt_submit = data.table(Patient_ID = dt_test_eng_all$Patient_ID
                       , Diabetes = pred_test)
# write.csv(dt_submit, "../data/MelbDatathon2017/submission/01_2016_all_noProprocess_singleModel_noTuning.csv", row.names = F)




