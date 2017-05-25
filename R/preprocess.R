preprocess = function(dt_train, dt_test = NULL, featureEngine = T, impute = T, normalisation = T, targetMean = T){
  
  source("R/featureEngineer2.R")
  require(data.table)

  if(!is.null(dt_test)){
    
    dt_train[, TrainValidTest := "Train"]
    dt_test[, TrainValidTest := "Test"]
    dt = rbind(dt_train, dt_test)
    
  }else{
    
    dt_train[, TrainValidTest := "Train"]
    dt = dt_train
    
  }
  
  # featureEngine -----------------------------------------------------------
  
  if(featureEngine == T){
    
    print("featEngine1 ...")
    
    dt = featureEngineer2(dt, 1)
    
  }
  
  
  
  # impute ------------------------------------------------------------------
  
  if(impute){
    print("impute ...")
    
    # Days_till
    cols_days_till = names(dt)[grepl("Days_till", names(dt))]
    for(j in cols_days_till){
      
      set(dt, which(is.na(dt[[j]])), j, 52 * 4)
      
    }
    
    # Tenure
    cols_tenure = names(dt)[grepl("Tenure", names(dt), ignore.case = T)]
    for(j in cols_tenure){
      
      set(dt, which(is.na(dt[[j]])), j, -1)
      
    }
    
    # Shopping_Density
    cols_shopping_density = names(dt)[grepl("Shopping_Density", names(dt), ignore.case = T)]
    for(j in cols_shopping_density){
      
      set(dt, which(is.na(dt[[j]])), j, 0)
      set(dt, which(is.infinite(dt[[j]])), j, 1)
      
    }
    
    # IPI
    cols_ipi = names(dt)[grepl("IPI", names(dt), ignore.case = F)]
    for(j in cols_ipi){
      
      set(dt, which(is.na(dt[[j]])), j, -1)
      
    }
    
    # Ratio_Reclaim_Amount
    cols_ratio_reclaim_amount = names(dt)[grepl("Ratio_Reclaim_Amount", names(dt), ignore.case = T)]
    for(j in cols_ratio_reclaim_amount){
      
      set(dt, which(is.na(dt[[j]])), j, -1)
      set(dt, which(is.infinite(dt[[j]])), j, 1)
      
    }
    
    # others
    cols = names(dt)[!names(dt) %in% c(cols_days_till, cols_tenure, cols_shopping_density, cols_ipi, cols_ratio_reclaim_amount)]
    for (j in cols){
      
      set(dt, which(is.na(dt[[j]])), j, 0)
      set(dt, which(is.infinite(dt[[j]])), j, 0)
      
    }
      
      
    
  }
  
  # featureEngine -----------------------------------------------------------
  
  if(featureEngine == T){
    print("featEngine2 ...")
    
    dt = featureEngineer2(dt, 2)
    
  }
  

  # normalisation -----------------------------------------------------------

  if(normalisation == T){
    
    print("normalisation ...")
    range01 = function(x){(x-min(x))/(max(x)-min(x))}
    
    cols = unique(names(dt)[sapply(dt, is.numeric)], names(dt)[sapply(dt, is.integer)])
    cols = cols[!cols %in% c("Patient_ID", "Target")]
    
    for(c in cols){
      
      dt[[c]] = range01(dt[[c]])
      
    }
    
  }
  
  # targetMean -------------------------------------------------------------
  
  
  
  
  return(list(dt_train = dt[TrainValidTest == "Train", !c("TrainValidTest"), with = F]
              , dt_test = dt[TrainValidTest == "Test", !c("TrainValidTest"), with = F]))
  
}





