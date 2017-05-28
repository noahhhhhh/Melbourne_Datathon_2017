source("R/split.R")
source("R/featureEngineer.R")
source("R/preprocess.R")
source("R/model.R")

# year 1 --------------------------------------------------------------

# config

require(data.table)

config = list()
config$splitRatio = c(.8, .2)
config$Target = "General"
config$no_of_year = 1

# read

dt_train_eng_all = data.table()



years_ = c(2016, 2015, 2014, 2013, 2012)

for(year_ in years_){

if(!is.na(config$no_of_year)){
  
  path_rds = paste0("../data/MelbDatathon2017/rds/", config$Target, "/", year_, "/", config$no_of_year, "/")
  
}else{
  
  path_rds = paste0("../data/MelbDatathon2017/rds/", config$Target, "/", year_, "/")
  
}

# train
# dt_train_eng_atc = readRDS(paste0(path_rds, "dt_train_eng_atc.rds"))
# print(dim(dt_train_eng_atc))
dt_train_eng_date = readRDS(paste0(path_rds, "dt_train_eng_date.rds"))
print(dim(dt_train_eng_date))
dt_train_eng_txns = readRDS(paste0(path_rds, "dt_train_eng_txns.rds"))
print(dim(dt_train_eng_txns))
dt_train_eng_illness = readRDS(paste0(path_rds, "dt_train_eng_illness.rds"))
print(dim(dt_train_eng_illness))
dt_train_eng_drug = readRDS(paste0(path_rds, "dt_train_eng_drug.rds"))
print(dim(dt_train_eng_drug))
dt_train_eng_patient = readRDS(paste0(path_rds, "dt_train_eng_patient.rds"))
print(dim(dt_train_eng_patient))
dt_train_eng_extra = readRDS(paste0(path_rds, "dt_train_eng_extra.rds"))
print(dim(dt_train_eng_extra))
dt_train_eng_targetMean = readRDS(paste0(path_rds, "dt_train_eng_targetMean.rds"))
print(dim(dt_train_eng_targetMean))

dt_train_eng = merge(dt_train_eng_txns, dt_train_eng_date, by = c("Patient_ID", "Target"))
# print(dim(dt_train_eng))
# dt_train_eng = merge(dt_train_eng, dt_train_eng_txns, by = c("Patient_ID", "Target"))
print(dim(dt_train_eng))
dt_train_eng = merge(dt_train_eng, dt_train_eng_illness, by = c("Patient_ID", "Target"))
print(dim(dt_train_eng))
dt_train_eng = merge(dt_train_eng, dt_train_eng_drug, by = c("Patient_ID", "Target"))
print(dim(dt_train_eng))
dt_train_eng = merge(dt_train_eng, dt_train_eng_patient, by = c("Patient_ID", "Target"))
print(dim(dt_train_eng))
dt_train_eng = merge(dt_train_eng, dt_train_eng_extra, by = c("Patient_ID", "Target"))
print(dim(dt_train_eng))
dt_train_eng = merge(dt_train_eng, dt_train_eng_targetMean, by = c("Patient_ID", "Target"))
print(dim(dt_train_eng))


dt_train_eng_all = rbind(dt_train_eng_all, dt_train_eng)

print(year_)
print(dim(dt_train_eng_all))
}

rm(dt_train_eng_date, dt_train_eng_txns, dt_train_eng_illness, dt_train_eng_drug, dt_train_eng_patient, dt_train_eng_extra, dt_train_eng_targetMean, dt_train_eng)

gc()

# save
path_rds = paste0("../data/MelbDatathon2017/rds/", config$Target, "/", config$no_of_year, "_year/")
saveRDS(dt_train_eng_all, paste0(path_rds, "dt_train_eng_all.rds"))

# read
path_rds = paste0("../data/MelbDatathon2017/rds/", config$Target, "/", config$no_of_year, "_year/")
dt_train_eng_all = readRDS(paste0(path_rds, "dt_train_eng_all.rds"))
dim(dt_train_eng_all)


# preprocessing
source("R/preprocess.R")
# preprocess(dt_train = dt_train_eng_all, featureEngine = T, impute = T, normalisation = T, targetMean = T)



# split
require(caret)

k = 5
set.seed(1)
ind_folds = createFolds(dt_train_eng_all$Target, k = k, list = F)

dt_train_preds = data.table()
ls_model = list()

i = 5
  
print(i)
dt_fold_valid = dt_train_eng_all[ind_folds == i]
dt_fold_train = dt_train_eng_all[ind_folds != i]

ls_model = model(dt_fold_train, dt_fold_valid
                      , modelTarget = config$Target, modelType = "xgboost", randomSearch = F, stackedParams = T)

mx_fold_valid = xgb.DMatrix(data.matrix(dt_fold_valid[, !c("Patient_ID", "Target"), with = F])
                            , label = dt_fold_valid$Target)

pred_fold_valid = predict(ls_model$xgboost, mx_fold_valid)

dt_train_preds = rbind(dt_train_preds, data.table(Patient_ID = dt_fold_valid$Patient_ID
                                                  , Diabetes_1 = pred_fold_valid))
  
saveRDS(ls_model, paste0(path_rds, "ls_model_5.rds"))

saveRDS(dt_train_preds, paste0(path_rds, "dt_train_preds.rds"))


# ind_train = createDataPartition(dt_train_eng_all$Target, p = .8, list = F)
# dt_train = dt_train_eng_all[ind_train]
# dt_valid = dt_train_eng_all[-ind_train]
# 
# # modelling
# ls_model = model(dt_train, dt_valid
#                , modelTarget = config$Target, modelType = "xgboost", randomSearch = F)
# [213]	valid-auc:0.964151

saveRDS(ls_model, paste0(path_rds, "ls_model.rds"))


# importance
importance = xgb.importance(setdiff(names(dt_valid), c("Patient_ID", "Target")), ls_model$xgboost)
xgb.plot.importance(importance[1:50])

# preds
## valid
# mx_valid = xgb.DMatrix(data.matrix(dt_valid[, !c("Patient_ID", "Target"), with = F])
#                      , label = dt_valid$Target)
# 
# pred_valid = predict(ls_model$xgboost, mx_valid)
# 
# 
# rm(dt_train_eng_all, dt_train, mx_valid, dt_valid)
# gc()

########################################## test

years_ = 2016
year_ = 2016
dt_test_eng_all = data.table()
for(year_ in years_){
  
  if(!is.na(config$no_of_year)){
    
    path_rds = paste0("../data/MelbDatathon2017/rds/", config$Target, "/", year_, "/", config$no_of_year, "/")
    
  }else{
    
    path_rds = paste0("../data/MelbDatathon2017/rds/", config$Target, "/", year_, "/")
    
  }
  
  
  # test
  # dt_test_eng_atc = readRDS(paste0(path_rds, "dt_test_eng_atc.rds"))
  dt_test_eng_date = readRDS(paste0(path_rds, "dt_test_eng_date.rds"))
  dim(dt_test_eng_date)
  dt_test_eng_txns = readRDS(paste0(path_rds, "dt_test_eng_txns.rds"))
  dt_test_eng_illness = readRDS(paste0(path_rds, "dt_test_eng_illness.rds"))
  dt_test_eng_drug = readRDS(paste0(path_rds, "dt_test_eng_drug.rds"))
  dt_test_eng_patient = readRDS(paste0(path_rds, "dt_test_eng_patient.rds"))
  dt_test_eng_extra = readRDS(paste0(path_rds, "dt_test_eng_extra.rds"))
  dt_test_eng_targetMean = readRDS(paste0(path_rds, "dt_test_eng_targetMean.rds"))
  
  dt_test_eng = merge(dt_test_eng_txns, dt_test_eng_date, by = c("Patient_ID", "Target"))
  # dt_test_eng = merge(dt_test_eng, dt_test_eng_txns, by = c("Patient_ID", "Target"))
  dt_test_eng = merge(dt_test_eng, dt_test_eng_illness, by = c("Patient_ID", "Target"))
  dt_test_eng = merge(dt_test_eng, dt_test_eng_drug, by = c("Patient_ID", "Target"))
  dt_test_eng = merge(dt_test_eng, dt_test_eng_patient, by = c("Patient_ID", "Target"))
  dt_test_eng = merge(dt_test_eng, dt_test_eng_extra, by = c("Patient_ID", "Target"))
  dt_test_eng = merge(dt_test_eng, dt_test_eng_targetMean, by = c("Patient_ID", "Target"))
  
  dt_test_eng_all = rbind(dt_test_eng_all, dt_test_eng)
  
  print(year_)
}

rm(dt_test_eng_date, dt_test_eng_txns, dt_test_eng_illness, dt_test_eng_drug, dt_test_eng_patient, dt_test_eng_extra, dt_test_eng_targetMean, dt_test_eng)
gc()

# preprocessing
# preprocess(dt_train = dt_test_eng_all, featureEngine = T, impute = T, normalisation = T, targetMean = T)

path_rds = paste0("../data/MelbDatathon2017/rds/", config$Target, "/", config$no_of_year, "_year/")
ls_model = readRDS(paste0(path_rds, "ls_model.rds"))

# preds
mx_test = xgb.DMatrix(data.matrix(dt_test_eng_all[, !c("Patient_ID", "Target"), with = F]))

pred_test = c()
for(i in 1:length(ls_model)){
  
  pred_test = predict(ls_model$xgboost, mx_test)
  
}


# submit
dt_submit = data.table(Patient_ID = dt_test_eng_all$Patient_ID
                     , Diabetes = pred_test)
path_rds = paste0("../data/MelbDatathon2017/rds/", config$Target, "/", config$no_of_year, "_year/")
saveRDS(dt_submit, paste0(path_rds, "dt_submti.rds"))
# write.csv(dt_submit, "../data/MelbDatathon2017/submission/04_2016_all_noProprocess_singleModel_noTuning_TargetMeanWithNoise.csv", row.names = F)




