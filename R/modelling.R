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

  
  dt_train_eng_all = rbind(dt_train_eng_all, dt_train_eng)
  
  print(year_)
}

rm(dt_train_eng_date, dt_train_eng_txns, dt_train_eng_illness, dt_train_eng_drug, dt_train_eng_patient, dt_train_eng_extra, dt_train_eng_targetMean, dt_train_eng)

gc()


# # stacking 1, 2, 3
# require(xgboost)
# mx_train_eng_all_noATC = xgb.DMatrix(data.matrix(dt_train_eng_all[, !c("Patient_ID", "Target", names(dt_train_eng_atc)), with = F])
#                                , label = dt_train_eng_all$Target)
# 
# rm(dt_train_eng_atc)
# gc()
# 
# # 1 year
# pred_stack_1 = rep(0, nrow(dt_train_eng_all))
# for(i in 1:5){
#   
#   model_year_1 = readRDS(paste0("../data/MelbDatathon2017/rds/General/1_year/ls_model_", i, ".rds"))
#   preds = predict(model_year_1$xgboost, mx_train_eng_all_noATC)
#   print(range(preds))
#   pred_stack_1 = pred_stack_1 + preds
#   print(range(pred_stack_1))
# }
# dt_1_year = data.table(Patient_ID = dt_train_eng_all$Patient_ID
#                        , Diabetes_1 = pred_stack_1 / 5)
# 
# # 2 year
# pred_stack_2 = rep(0, nrow(dt_train_eng_all))
# for(i in 1:5){
#   
#   model_year_2 = readRDS(paste0("../data/MelbDatathon2017/rds/General/2_year/ls_model_", i, ".rds"))
#   preds = predict(model_year_2$xgboost, mx_train_eng_all_noATC)
#   print(range(preds))
#   pred_stack_2 = pred_stack_2 + preds
#   print(range(pred_stack_2))
# }
# dt_2_year = data.table(Patient_ID = dt_train_eng_all$Patient_ID
#                        , Diabetes_2 = pred_stack_2 / 5)
# 
# # 3 year
# pred_stack_3 = rep(0, nrow(dt_train_eng_all))
# for(i in 1:5){
#   
#   model_year_3 = readRDS(paste0("../data/MelbDatathon2017/rds/General/3_year/ls_model_", i, ".rds"))
#   preds = predict(model_year_3$xgboost, mx_train_eng_all_noATC)
#   print(range(preds))
#   pred_stack_3 = pred_stack_3 + preds
#   print(range(pred_stack_2))
# }
# dt_3_year = data.table(Patient_ID = dt_train_eng_all$Patient_ID
#                        , Diabetes_3 = pred_stack_3 / 5)
# 
# dt_train_eng_all = merge(dt_train_eng_all, dt_1_year, by = "Patient_ID", all.x = T)
# dt_train_eng_all = merge(dt_train_eng_all, dt_2_year, by = "Patient_ID", all.x = T)
# dt_train_eng_all = merge(dt_train_eng_all, dt_3_year, by = "Patient_ID", all.x = T)

# preprocessing
source("R/preprocess.R")
# preprocess(dt_train = dt_train_eng_all, featureEngine = T, impute = T, normalisation = T, targetMean = T)



# split
require(caret)
ind_train = createDataPartition(dt_train_eng_all$Target, p = .8, list = F)
dt_train = dt_train_eng_all[ind_train]
dt_valid = dt_train_eng_all[-ind_train]

# modelling
set.seed(888)
ls_model = model(dt_train, dt_valid
                 , modelTarget = config$Target, modelType = "xgboost", randomSearch = F)
# [35]	valid-auc:0.976293 (with TargetMean) - 0.96679
# [18]	valid-auc:0.968359 (without TargetMean) - 0.96726
# [49]	valid-auc:0.971872 (with noise in targetMean) - 0.96933
# [8]	valid-auc:0.972736 (with 1, 2, 3 year stacking)
# [17]	valid-auc:0.975068 (with 1, 2, 3 oof stacking, overtuned) - 0.96805
# [25]	valid-auc:0.973108 (with 1, 2, 3 oof stacking) - 0.96805
# [7]	valid-auc:0.971978 (no 1, 2, 3 oof staking, no preprocessing) - 
# 
# set.seed(888)
# ls_model_gblinear = model(dt_train, dt_valid
#                           , modelTarget = config$Target, modelType = "xgboost", randomSearch = F, gblinear = T)

# importance
importance = xgb.importance(setdiff(names(dt_valid), c("Patient_ID", "Target")), ls_model$xgboost)
xgb.plot.importance(importance[1:50])

# preds
## valid
# mx_valid = xgb.DMatrix(data.matrix(dt_valid[, !c("Patient_ID", "Target"), with = F])
#                        , label = dt_valid$Target)
# 
# pred_valid = predict(ls_model$xgboost, mx_valid)
# 
rm(dt_train_eng_all, dt_train, mx_valid, dt_valid)
gc()

########################################## test

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

rm(dt_test_eng_date, dt_test_eng_txns, dt_test_eng_illness, dt_test_eng_drug, dt_test_eng_patient, dt_test_eng_extra, dt_test_eng_targetMean, dt_test_eng)
gc()

# # stacking 1, 2, 3
# mx_test_eng_all_noATC = xgb.DMatrix(data.matrix(dt_test_eng_all[, !c("Patient_ID", "Target", names(dt_test_eng_atc)), with = F])
#                                      , label = dt_test_eng_all$Target)
# 
# rm(dt_test_eng_atc)
# gc()
# 
# # 1 year
# pred_stack_1 = rep(0, nrow(dt_test_eng_all))
# for(i in 1:5){
#   
#   model_year_1 = readRDS(paste0("../data/MelbDatathon2017/rds/General/1_year/ls_model_", i, ".rds"))
#   preds = predict(model_year_1$xgboost, mx_test_eng_all_noATC)
#   print(range(preds))
#   pred_stack_1 = pred_stack_1 + preds
#   print(range(pred_stack_1))
# }
# dt_1_year = data.table(Patient_ID = dt_test_eng_all$Patient_ID
#                        , Diabetes_1 = pred_stack_1 / 5)
# 
# # 2 year
# pred_stack_2 = rep(0, nrow(dt_test_eng_all))
# for(i in 1:5){
#   
#   model_year_2 = readRDS(paste0("../data/MelbDatathon2017/rds/General/2_year/ls_model_", i, ".rds"))
#   preds = predict(model_year_2$xgboost, mx_test_eng_all_noATC)
#   print(range(preds))
#   pred_stack_2 = pred_stack_2 + preds
#   print(range(pred_stack_2))
# }
# dt_2_year = data.table(Patient_ID = dt_test_eng_all$Patient_ID
#                        , Diabetes_2 = pred_stack_2 / 5)
# 
# # 3 year
# pred_stack_3 = rep(0, nrow(dt_test_eng_all))
# for(i in 1:5){
#   
#   model_year_3 = readRDS(paste0("../data/MelbDatathon2017/rds/General/3_year/ls_model_", i, ".rds"))
#   preds = predict(model_year_3$xgboost, mx_test_eng_all_noATC)
#   print(range(preds))
#   pred_stack_3 = pred_stack_3 + preds
#   print(range(pred_stack_2))
# }
# dt_3_year = data.table(Patient_ID = dt_test_eng_all$Patient_ID
#                        , Diabetes_3 = pred_stack_3 / 5)
# 
# dt_test_eng_all = merge(dt_test_eng_all, dt_1_year, by = "Patient_ID", all.x = T)
# dt_test_eng_all = merge(dt_test_eng_all, dt_2_year, by = "Patient_ID", all.x = T)
# dt_test_eng_all = merge(dt_test_eng_all, dt_3_year, by = "Patient_ID", all.x = T)

# preprocessing
# preprocess(dt_train = dt_test_eng_all, featureEngine = T, impute = T, normalisation = T, targetMean = T)

# preds
mx_test = xgb.DMatrix(data.matrix(dt_test_eng_all[, !c("Patient_ID", "Target"), with = F]))
pred_test = predict(ls_model$xgboost, mx_test)

# submit
dt_submit = data.table(Patient_ID = dt_test_eng_all$Patient_ID
                       , Diabetes = pred_test)
write.csv(dt_submit, "../data/MelbDatathon2017/submission/10_2016_all_no_stacking_noPrprocessing.csv", row.names = F)




