preprocess = function(dt, impute_to_0 = T, normalisation = T, crossEntropy = T){
  
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

  
  # crossEntropy ------------------------------------------------------------
  
  
  return(dt)
  
}





