preprocess = function(dt_train_eng, dt_valid_eng, impute_to_0 = T, normalisation = T, crossEntropy = T){
  
  require(data.table)

  if(!is.null(dt_valid_eng)){
    
    dt_train_eng[, TrainValidTest := "Train"]
    dt_valid_eng[, TrainValidTest := "Valid"]
    dt = rbind(dt_train_eng, dt_valid_eng)
    
  }else{
    
    dt_train_eng[, TrainValidTest := "Train"]
    dt = dt_train_eng
    
  }
  
  # impute ------------------------------------------------------------------
  
  if(impute_to_0){
    
    # days_till
    cols = names(dt)[grepl("Days_till", names(dt))]
    for(j in cols){
      
      set(dt, which(is.na(dt[[j]])), j, 52 * 4)
      
    }
    
    # others
    cols = names(dt)[!grepl("Days_till", names(dt))]
    for (j in cols)
      
      set(dt, which(is.na(dt[[j]])), j, 0)
      set(dt, which(is.infinite(dt[[j]])), j, 0)
    
  }
  

  # normalisation -----------------------------------------------------------

  if(normalisation == T){
    
    range01 = function(x){(x-min(x))/(max(x)-min(x))}
    
    cols = unique(names(dt)[sapply(dt, is.numeric)], names(dt)[sapply(dt, is.integer)])
    cols = cols[!cols %in% c("Patient_ID", "Target")]
    
    for(c in cols){
      
      dt[[c]] = range01(dt[[c]])
      
    }
    
  }
  
  # targetMean -------------------------------------------------------------
  
  
  return(list(dt_train_eng = dt[TrainValidTest == "Train", !c("TrainValidTest"), with = F]
              , dt_valid_eng = dt[TrainValidTest == "Valid", !c("TrainValidTest"), with = F]))
  
}





