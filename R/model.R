model = function(dt_train, dt_valid, modelType = "xgboost"){
  
  source("R/utils.R")
  require(Metrics)
  require(data.table)
  
  ls_model = list()
  
  # xgboost -----------------------------------------------------------------
  
  if(modelType %in% "xgboost"){
    print("- xgboost ...")
    require(xgboost)
    
    # data
    print("  - transform data ...")
    mx_train = xgb.DMatrix(data.matrix(dt_train[, !c("Patient_ID", "Target"), with = F])
                           , label = dt_train$Target)
    mx_valid = xgb.DMatrix(data.matrix(dt_valid[, !c("Patient_ID", "Target"), with = F])
                           , label = dt_valid$Target)
    # params
    params = list(
      booster = "gbtree"
      , eta = .015
      , max_depth = 6
      , min_child_weight = 3
      , subsample = .8
      , colsample_bytree = .8
      , colsample_bylevel = .8
      
      , objective = "binary:logistic"
      , eval_metric = "auc"
    )
    
    # watchlist
    watchlist = list(train = mx_train, valid = mx_valid)
    
    # model
    print("  - modelling ...")
    set.seed(888)
    model_xgb = xgb.train(params = params
                          , data = mx_train
                          , nrounds = 1000
                          , nthread = 16
                          , watchlist = watchlist
                          , early_stopping_rounds = 10
                          , print_every_n = 50)

    # scoreTracker
    print("  - scoreTracker ...")
    featureNames = names(dt_valid)
    score = auc(dt_valid$Target, predict(model_xgb, mx_valid))
    scoreTracker(modelType, score, featureNames)
    
    ls_model[[modelType]] = model_xgb
  }
  
    
  return(ls_model)
}



