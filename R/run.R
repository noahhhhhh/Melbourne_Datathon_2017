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



# split -------------------------------------------------------------------


ls_dt = splitData_TimeBased(dt_txn
                            , trainEndDate = config$trainEndDate
                            , testEndDate = config$testEndDate
                            , splitRatio = config$splitRatio)



# feature engineering -----------------------------------------------------


dt_train_eng = featureEngineer(ls_dt$dt_train, trainEndDate = config$trainEndDate, dt_drug, dt_atc)

dt_valid_eng = featureEngineer(ls_dt$dt_valid, trainEndDate = config$trainEndDate, dt_drug, dt_atc)

# dt_test_eng = featureEngineer(ls_dt$dt_test, trainEndDate = config$trainEndDate)



# preprocess --------------------------------------------------------------


dt_train_eng_prep = preprocess(dt_train_eng, impute_to_0 = T, normalisation = T, crossEntropy = T)
dt_valid_eng_prep = preprocess(dt_valid_eng, impute_to_0 = T, normalisation = T, crossEntropy = T)
# dt_test_eng_prep = preprocess(dt_test_eng, impute_to_0 = T, normalisation = T, crossEntropy = T)



# model -------------------------------------------------------------------

model_xgb = model(dt_train_eng_prep, dt_valid_eng_prep, modelType = "xgboost")
# [73]	train-auc:0.971862	valid-auc:0.969310