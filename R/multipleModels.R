years_ = 2016

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
  
  dt_valid_eng_atc = readRDS(paste0(path_rds, "dt_valid_eng_atc.rds"))
  dt_valid_eng_date = readRDS(paste0(path_rds, "dt_valid_eng_date.rds"))
  dt_valid_eng_txns = readRDS(paste0(path_rds, "dt_valid_eng_txns.rds"))
  dt_valid_eng_illness = readRDS(paste0(path_rds, "dt_valid_eng_illness.rds"))
  dt_valid_eng_drug = readRDS(paste0(path_rds, "dt_valid_eng_drug.rds"))
  dt_valid_eng_patient = readRDS(paste0(path_rds, "dt_valid_eng_patient.rds"))
  
  
  dt_train_eng = merge(dt_train_eng_atc, dt_train_eng_date, by = c("Patient_ID", "Target"))
  dt_train_eng = merge(dt_train_eng, dt_train_eng_txns, by = c("Patient_ID", "Target"))
  dt_train_eng = merge(dt_train_eng, dt_train_eng_illness, by = c("Patient_ID", "Target"))
  dt_train_eng = merge(dt_train_eng, dt_train_eng_drug, by = c("Patient_ID", "Target"))
  dt_train_eng = merge(dt_train_eng, dt_train_eng_patient, by = c("Patient_ID", "Target"))
  
  dt_valid_eng = merge(dt_valid_eng_atc, dt_valid_eng_date, by = c("Patient_ID", "Target"))
  dt_valid_eng = merge(dt_valid_eng, dt_valid_eng_txns, by = c("Patient_ID", "Target"))
  dt_valid_eng = merge(dt_valid_eng, dt_valid_eng_illness, by = c("Patient_ID", "Target"))
  dt_valid_eng = merge(dt_valid_eng, dt_valid_eng_drug, by = c("Patient_ID", "Target"))
  dt_valid_eng = merge(dt_valid_eng, dt_valid_eng_patient, by = c("Patient_ID", "Target"))
  
  
  dt_train_eng_all = rbind(dt_train_eng_all, dt_train_eng)
  dt_valid_eng_all = rbind(dt_valid_eng_all, dt_valid_eng)
  
  print(year_)
}


rm(dt_train_eng_atc, dt_train_eng_date, dt_train_eng_txns, dt_train_eng_illness, dt_train_eng_drug, dt_train_eng_patient, dt_train_eng)
rm(dt_valid_eng_atc, dt_valid_eng_date, dt_valid_eng_txns, dt_valid_eng_illness, dt_valid_eng_drug, dt_valid_eng_patient, dt_valid_eng)
gc()

############## all ##############

ls_preprocess = preprocess(dt_train_eng = dt_train_eng_all, dt_valid_eng = dt_valid_eng_all
                           , impute_to_0 = T, normalisation = T, targetMean = T)


model_xgb_all = model(ls_preprocess$dt_train_eng, ls_preprocess$dt_valid_eng
                  , modelTarget = config$Target, modelType = "xgboost", randomSearch = T)

mx_valid_all = xgb.DMatrix(data.matrix(ls_preprocess$dt_valid_eng[, !c("Patient_ID", "Target"), with = F])
                       , label = ls_preprocess$dt_valid_eng$Target)

############## no ATC ##############

ls_preprocess = preprocess(dt_train_eng = dt_train_eng_all[, names(dt_train_eng_all)[!grepl("ATC", names(dt_train_eng_all))], with = F]
                           , dt_valid_eng = dt_valid_eng_all[, names(dt_valid_eng_all)[!grepl("ATC", names(dt_valid_eng_all))], with = F]
                           , impute_to_0 = T, normalisation = T, targetMean = T)

model_xgb_noATC = model(ls_preprocess$dt_train_eng, ls_preprocess$dt_valid_eng
                      , modelTarget = config$Target, modelType = "xgboost", randomSearch = T)

mx_valid_noATC = xgb.DMatrix(data.matrix(ls_preprocess$dt_valid_eng[, !c("Patient_ID", "Target"), with = F])
                           , label = ls_preprocess$dt_valid_eng$Target)

############## no diabetes ##############

ls_preprocess = preprocess(dt_train_eng = dt_train_eng_all[, names(dt_train_eng_all)[!grepl("Diabetes", names(dt_train_eng_all))], with = F]
                           , dt_valid_eng = dt_valid_eng_all[, names(dt_valid_eng_all)[!grepl("Diabetes", names(dt_valid_eng_all))], with = F]
                           , impute_to_0 = T, normalisation = T, targetMean = T)

model_xgb_noDiabetes = model(ls_preprocess$dt_train_eng, ls_preprocess$dt_valid_eng
                      , modelTarget = config$Target, modelType = "xgboost", randomSearch = T)

mx_valid_noDiabetes = xgb.DMatrix(data.matrix(ls_preprocess$dt_valid_eng[, !c("Patient_ID", "Target"), with = F])
                             , label = ls_preprocess$dt_valid_eng$Target)

############## no diabetes no ATC ##############

ls_preprocess = preprocess(dt_train_eng = dt_train_eng_all[, names(dt_train_eng_all)[!grepl("ATC|Diabetes", names(dt_train_eng_all))], with = F]
                           , dt_valid_eng = dt_valid_eng_all[, names(dt_valid_eng_all)[!grepl("ATC|Diabetes", names(dt_valid_eng_all))], with = F]
                           , impute_to_0 = T, normalisation = T, targetMean = T)

model_xgb_noATC_noDiabetes = model(ls_preprocess$dt_train_eng, ls_preprocess$dt_valid_eng
                                   , modelTarget = config$Target, modelType = "xgboost", randomSearch = T)


mx_valid_noATC_noDiabetes = xgb.DMatrix(data.matrix(ls_preprocess$dt_valid_eng[, !c("Patient_ID", "Target"), with = F])
                             , label = ls_preprocess$dt_valid_eng$Target)

# blend -------------------------------------------------------------------

pred_valid_all = predict(model_xgb_all$xgboost, mx_valid_all)
auc(dt_valid_eng_all$Target, pred_valid_all)

pred_valid_noATC = predict(model_xgb_noATC$xgboost, mx_valid_noATC)
auc(dt_valid_eng_all$Target, pred_valid_noATC)

pred_valid_noDiabetes = predict(model_xgb_noDiabetes$xgboost, mx_valid_noDiabetes)
auc(dt_valid_eng_all$Target, pred_valid_noDiabetes)

pred_valid_noATC_noDiabetes = predict(model_xgb_noATC_noDiabetes$xgboost, mx_valid_noATC_noDiabetes)
auc(dt_valid_eng_all$Target, pred_valid_noATC_noDiabetes)


dt_blend = data.table(Target = dt_valid_eng_all$Target
                      , all = pred_valid_all
                      , noATC = pred_valid_noATC
                      , noDiabetes = pred_valid_noDiabetes
                      , noATC_noDiabetes = pred_valid_noATC_noDiabetes)
auc(dt_blend$Target, rowMeans(dt_blend[, !c("Target"), with = F]))

md_blend_lm = lm(Target ~ ., data = dt_blend)
pred_blend_lm = predict(md_blend_lm, dt_blend)

auc(dt_blend$Target, pred_blend_lm)


