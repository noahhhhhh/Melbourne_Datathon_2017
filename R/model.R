model = function(dt_train, dt_valid, modelTarget, modelType = "xgboost", randomSearch = F){
  
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
    
    if(randomSearch == F){
      # params
      params = list(
        booster = "gbtree"
        , eta = 0.000425338450889103
        , max_depth = 14
        , min_child_weight = 1
        , subsample = 0.570443930663168
        , colsample_bytree = 0.676142484601587
        , colsample_bylevel = 0.838651546183974
        , gamma = 0.560226952889934
        , scale_pos_weight = ifelse(modelTarget == "Lapsing", length(dt_train$Target == 0) / length(dt_train$Target == 1), 1)
        , objective = "binary:logistic"
        , eval_metric = "auc"
      )
      
      # watchlist
      watchlist = list(valid = mx_valid)
      
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
      scoreTracker(modelTarget, modelType, score, featureNames)
      
      ls_model[[modelType]] = model_xgb
      
    }else{
      
      seq_eta = c(.0001, .01)
      seq_max_depth = seq(5, 15)
      seq_min_child_weight = seq(1, 8)
      seq_subsample = c(.5, .9)
      seq_colsample_bytree = c(.5, .9)
      seq_colsample_bylevel = c(.5, .9)
      seq_gamma = seq(0, 2)
      
      ls_score = list()
      
      for(i in 1:2){
        
        # params
        set.seed(888)
        params = list(
          booster = "gbtree"
          , eta = runif(1, seq_eta[1], seq_eta[2])
          , max_depth = sample(seq_max_depth, 1)
          , min_child_weight = sample(seq_min_child_weight, 1)
          , subsample = runif(1, seq_subsample[1], seq_subsample[2])
          , colsample_bytree = runif(1, seq_colsample_bytree[1], seq_colsample_bytree[2])
          , colsample_bylevel = runif(1, seq_colsample_bylevel[1], seq_colsample_bylevel[2])
          , gamma = runif(1, seq_gamma[1], seq_gamma[2])
          , scale_pos_weight = ifelse(modelTarget == "Lapsing", length(dt_train$Target == 0) / length(dt_train$Target == 1), 1)
          , objective = "binary:logistic"
          , eval_metric = "auc"
        )
        
        # watchlist
        watchlist = list(valid = mx_valid)
        
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
        score = auc(dt_valid$Target, predict(model_xgb, mx_valid))
        
        print(unlist(params))
        print(score)
        ls_score[[i]] =  list(params = params, score = score)
        
      }
      
      # params
      params = ls_score[[which.max(lapply(ls_score, function(x)x$score))]][["params"]]
      
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
      
      ls_model[[modelType]] = model_xgb
      
    }
      
    
  }
  
    
  return(ls_model)
}



