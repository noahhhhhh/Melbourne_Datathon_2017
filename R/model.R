model = function(dt_train, dt_valid, modelTarget, modelType = "xgboost", gridSearch = F){
  
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
    
    if(gridSearch == F){
      # params
      params = list(
        booster = "gbtree"
        , eta = .015
        , max_depth = 6
        , min_child_weight = 3
        , subsample = .8
        , colsample_bytree = .8
        , colsample_bylevel = .8
        , gamma = 0
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
      
      seq_eta = seq(.001, .1, .01)
      seq_max_depth = seq(5, 15, 1)
      seq_min_child_weight = seq(1, 8, 1)
      seq_subsample = seq(.5, .9, .1)
      seq_colsample_bytree = seq(.5, .9, .1)
      seq_colsample_bylevel = seq(.5, .9, .1)
      seq_gamma = seq(0, 2, .5)
      
      ls_score = list()
      
      for(eta in seq_eta){
        
        for(max_depth in seq_max_depth){
          
          for(min_child_weight in seq_min_child_weight){
            
            for(subsample in seq_subsample){
              
              for(colsample_bytree in seq_colsample_bytree){
                
                for(colsample_bylevel in seq_colsample_bylevel){
                  
                  for(gamma in seq_gamma){
                    
                    # params
                    params = list(
                      booster = "gbtree"
                      , eta = eta
                      , max_depth = max_depth
                      , min_child_weight = min_child_weight
                      , subsample = subsample
                      , colsample_bytree = colsample_bytree
                      , colsample_bylevel = colsample_bylevel
                      , gamma = gamma
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
                    score = auc(dt_valid$Target, predict(model_xgb, mx_valid))
                    
                    print(params)
                    print(score)
                    ls_score[[length(ls_score) + 1]] =  list(params = params, score = score)
                    
                  }
                  
                }
                
                
              }
              
            }
            
          }
          
        }
        
      }
      
      
      return(ls_score)
    }
    
  }
  
    
  return(ls_model)
}



