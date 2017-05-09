source("R/load.R", keep.source = T)
print(paste0("[", Sys.time(), "]: ", "Load ..."))


source("R/split.R")
source("R/featureEngineer.R")


# config ------------------------------------------------------------------


config = list()
config$trainEndDate = "2015-01-01"
config$testEndDate = "2016-01-01"
config$splitRatio = c(.4, .1, .5)



# split -------------------------------------------------------------------


ls_dt = splitData_TimeBased(dt_txn
                            , trainEndDate = config$trainEndDate
                            , testEndDate = config$testEndDate
                            , splitRatio = config$splitRatio)



# feature engineering -----------------------------------------------------


dt_valid_eng = featureEngineer(ls_dt$dt_valid
                               , trainEndDate = config$trainEndDate)
