source("R/load.R", keep.source = T)
print(paste0("[", Sys.time(), "]: ", "Load ..."))


source("R/split.R")
source("R/featureEngineer.R")
source("R/preprocess.R")
source("R/model.R")

# config ------------------------------------------------------------------


config = list()
config$trainEndDate = "2015-01-01"
config$testEndDate = "2016-01-01"
config$splitRatio = c(.8, .2)
config$Target = "General"
config$no_of_year = NA


# split -------------------------------------------------------------------

ls_dt = splitData_year_2016(dt_txn, Target = config$Target, dt_ilness, splitRatio = config$splitRatio, no_of_year = config$no_of_year)

# years = c("2013-01-01", "2014-01-01", "2015-01-01")

year = "2016-01-01"

if(!is.na(config$no_of_year)){
  
  path_rds = paste0("../data/MelbDatathon2017/rds/", config$Target, "/", year(as.Date(year)), "/", config$no_of_year, "/")
  
}else{
  
  path_rds = paste0("../data/MelbDatathon2017/rds/", config$Target, "/", year(as.Date(year)), "/")
  
}

# ls_dt = splitData_year(dt_txn, Target = config$Target, dt_ilness, splitRatio = config$splitRatio, years = year, no_of_year = config$no_of_year)

# rm(dt_txn)
gc()

# feature engineering -----------------------------------------------------

## train
print("##### Train - ATC Features #####")
dt_train_eng_atc = featureEngineer_ATC(ls_dt$dt_train, trainEndDate = config$trainEndDate, dt_drug, dt_atc)
saveRDS(dt_train_eng_atc, paste0(path_rds, "dt_train_eng_atc.rds"))
rm(dt_train_eng_atc)
gc()

print("##### Train - Date Features #####")
dt_train_eng_date = featureEngineer_Date(ls_dt$dt_train, trainEndDate = config$trainEndDate, dt_drug, dt_atc)
saveRDS(dt_train_eng_date, paste0(path_rds, "dt_train_eng_date.rds"))
rm(dt_train_eng_date)
gc()

print("##### Train - Txns Features #####")
dt_train_eng_txns = featureEngineer_Txns(ls_dt$dt_train, trainEndDate = config$trainEndDate, dt_drug, dt_atc)
saveRDS(dt_train_eng_txns, paste0(path_rds, "dt_train_eng_txns.rds"))
rm(dt_train_eng_txns)
gc()

print("##### Train - Illness Features #####")
dt_train_eng_illness = featureEngineer_Illness(ls_dt$dt_train, trainEndDate = config$trainEndDate, dt_drug, dt_atc)
saveRDS(dt_train_eng_illness, paste0(path_rds, "dt_train_eng_illness.rds"))
rm(dt_train_eng_illness)
gc()

print("##### Train - Drug Features #####")
dt_train_eng_drug = featureEngineer_Drug(ls_dt$dt_train, trainEndDate = config$trainEndDate, dt_drug, dt_atc)
saveRDS(dt_train_eng_drug, paste0(path_rds, "dt_train_eng_drug.rds"))
rm(dt_train_eng_drug)
gc()

print("##### Train - Patient Features #####")
dt_train_eng_patient = featureEngineer_Patient(ls_dt$dt_train, trainEndDate = config$trainEndDate, dt_drug, dt_atc, dt_patient, dt_store)
saveRDS(dt_train_eng_patient, paste0(path_rds, "dt_train_eng_patient.rds"))
rm(dt_train_eng_patient)
gc()

## valid
print("##### Valid - ATC Features #####")
dt_valid_eng_atc = featureEngineer_ATC(ls_dt$dt_valid, trainEndDate = config$trainEndDate, dt_drug, dt_atc)
saveRDS(dt_valid_eng_atc, paste0(path_rds, "dt_valid_eng_atc.rds"))
rm(dt_valid_eng_atc)
gc()

print("##### Valid - Date Features #####")
dt_valid_eng_date = featureEngineer_Date(ls_dt$dt_valid, trainEndDate = config$trainEndDate, dt_drug, dt_atc)
saveRDS(dt_valid_eng_date, paste0(path_rds, "dt_valid_eng_date.rds"))
rm(dt_valid_eng_date)
gc()

print("##### Valid - Txns Features #####")
dt_valid_eng_txns = featureEngineer_Txns(ls_dt$dt_valid, trainEndDate = config$trainEndDate, dt_drug, dt_atc)
saveRDS(dt_valid_eng_txns, paste0(path_rds, "dt_valid_eng_txns.rds"))
rm(dt_valid_eng_txns)
gc()

print("##### Valid - Illness Features #####")
dt_valid_eng_illness = featureEngineer_Illness(ls_dt$dt_valid, trainEndDate = config$trainEndDate, dt_drug, dt_atc)
saveRDS(dt_valid_eng_illness, paste0(path_rds, "dt_valid_eng_illness.rds"))
rm(dt_valid_eng_illness)
gc()

print("##### Valid - Drug Features #####")
dt_valid_eng_drug = featureEngineer_Drug(ls_dt$dt_valid, trainEndDate = config$trainEndDate, dt_drug, dt_atc)
saveRDS(dt_valid_eng_drug, paste0(path_rds, "dt_valid_eng_drug.rds"))
rm(dt_valid_eng_drug)
gc()

print("##### Valid - Patient Features #####")
dt_valid_eng_patient = featureEngineer_Patient(ls_dt$dt_valid, trainEndDate = config$trainEndDate, dt_drug, dt_atc, dt_patient, dt_store)
saveRDS(dt_valid_eng_patient, paste0(path_rds, "dt_valid_eng_patient.rds"))
rm(dt_valid_eng_patient)
gc()

## test
print("##### test - ATC Features #####")
dt_test_eng_atc = featureEngineer_ATC(ls_dt$dt_test, trainEndDate = config$trainEndDate, dt_drug, dt_atc)
saveRDS(dt_test_eng_atc, paste0(path_rds, "dt_test_eng_atc.rds"))
rm(dt_test_eng_atc)
gc()

print("##### test - Date Features #####")
dt_test_eng_date = featureEngineer_Date(ls_dt$dt_test, trainEndDate = config$trainEndDate, dt_drug, dt_atc)
saveRDS(dt_test_eng_date, paste0(path_rds, "dt_test_eng_date.rds"))
rm(dt_test_eng_date)
gc()

print("##### test - Txns Features #####")
dt_test_eng_txns = featureEngineer_Txns(ls_dt$dt_test, trainEndDate = config$trainEndDate, dt_drug, dt_atc)
saveRDS(dt_test_eng_txns, paste0(path_rds, "dt_test_eng_txns.rds"))
rm(dt_test_eng_txns)
gc()

print("##### test - Illness Features #####")
dt_test_eng_illness = featureEngineer_Illness(ls_dt$dt_test, trainEndDate = config$trainEndDate, dt_drug, dt_atc)
saveRDS(dt_test_eng_illness, paste0(path_rds, "dt_test_eng_illness.rds"))
rm(dt_test_eng_illness)
gc()

print("##### test - Drug Features #####")
dt_test_eng_drug = featureEngineer_Drug(ls_dt$dt_test, trainEndDate = config$trainEndDate, dt_drug, dt_atc)
saveRDS(dt_test_eng_drug, paste0(path_rds, "dt_test_eng_drug.rds"))
rm(dt_test_eng_drug)
gc()

print("##### test - Patient Features #####")
dt_test_eng_patient = featureEngineer_Patient(ls_dt$dt_test, trainEndDate = config$trainEndDate, dt_drug, dt_atc, dt_patient, dt_store)
saveRDS(dt_test_eng_patient, paste0(path_rds, "dt_test_eng_patient.rds"))
rm(dt_test_eng_patient)
gc()


rm(ls_dt)
gc()


# merge -------------------------------------------------------------------

years_ = seq(2013, 2016)
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



# featureSelection --------------------------------------------------------

# require(doParallel)
# registerDoParallel(7)
# getDoParWorkers()
# 
# ga_ctrl = gafsControl(functions = rfGA, # Assess fitness with RF
#                       method = "cv",    # 10 fold cross validation
#                       number = 2,
#                       genParallel = TRUE, # Use parallel programming
#                       allowParallel = TRUE)
# 
# rf_ga3 = gafs(x = dt_train_eng, y = dt_train_eng$Target,
#               iters = 100, # 100 generations of algorithm
#               popSize = 200, # population size for each generation
#               gafsControl = ga_ctrl)


# preprocess --------------------------------------------------------------


dt_train_eng_all = dt_train_eng_all[, names(dt_train_eng_all)[!grepl("ATC", names(dt_train_eng_all))], with = F]
dt_valid_eng_all = dt_valid_eng_all[, names(dt_valid_eng_all)[!grepl("ATC", names(dt_valid_eng_all))], with = F]
ls_preprocess = preprocess(dt_train_eng = dt_train_eng_all, dt_valid_eng = dt_valid_eng_all
                           , impute_to_0 = T, normalisation = F, targetMean = T)
# dt_valid_eng_prep = preprocess(dt_valid_eng, impute_to_0 = T, normalisation = T, crossEntropy = T)
# dt_test_eng_prep = preprocess(dt_test_eng, impute_to_0 = T, normalisation = T, crossEntropy = T)

rm(dt_train_eng_all, dt_valid_eng_all)
gc()


# model -------------------------------------------------------------------

print(paste0("[", Sys.time(), "]: ", "Single Xgb ..."))
model_xgb = model(ls_preprocess$dt_train_eng, ls_preprocess$dt_valid_eng
                  , modelTarget = config$Target, modelType = "xgboost", gridSearch = T)
print(paste0("[", Sys.time(), "]: ", "Single Xgb Done ..."))
# [73]	train-auc:0.971862	valid-auc:0.969310  (without ATC)
# [112]	train-auc:0.971568	valid-auc:0.972089  (with ATC)
# [35]	train-auc:0.971014	valid-auc:0.971300  (with ATC and crossEntropy)
# [14]	train-auc:0.970227	valid-auc:0.973048  (with IPI, Illness, Drug without PBS, Ingredient, Brand)
# [25]	train-auc:0.970937	valid-auc:0.972005  (with IPI, Illness, Drug without PBS, Brand)
# [18]	train-auc:0.970159	valid-auc:0.972132  (with IPI, Illness, Drug without PBS, Brand with patient)

auc = function(actual, predicted) 
{
  r <- rank(predicted)
  n_pos <- as.double(sum(actual == 1))
  n_neg <- as.double(length(actual) - n_pos)
  auc <- (sum(r[actual == 1]) - n_pos * (n_pos + 1)/2)/(n_pos * 
                                                          n_neg)
  auc
}

# mx_valid = xgb.DMatrix(data.matrix(ls_preprocess$dt_valid_eng[, !c("Patient_ID", "Target"), with = F])
#                        , label = ls_preprocess$dt_valid_eng$Target)
# 
# pred_valid = predict(model_xgb$xgboost, mx_valid)
# pred_valid_threshold = ifelse(pred_valid > .5, 1, 0)
# cm = confusionMatrix(pred_valid_threshold, ls_preprocess$dt_valid_eng$Target)


importance = xgb.importance(setdiff(names(ls_preprocess$dt_valid_eng), c("Patient_ID", "Target")), model_xgb$xgboost)
xgb.plot.importance(importance[1:50])
