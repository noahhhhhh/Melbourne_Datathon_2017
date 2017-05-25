featureEngineer2 = function(dt, phase = 1){
  
  if(phase == 1){
    
    # RowSum_NAs
    dt[, RowSUm_NAs := apply(dt, 1, function(x)sum(is.na(x)))]
    dt[, RowSUm_Infs := apply(dt, 1, function(x)sum(is.infinite(x)))]
    
    
  }else{
    
    # Sum_I_Bought_Illness
    cols = names(dt)[grepl("Bought", names(dt), ignore.case = T)]
    dt[, Sum_I_Bought_Illness := rowSums(dt[, cols, with = F])]
    
    # RowSum_NAs
    ## Days_till
    dt[, RowSum_NAs_Days_till := apply(dt[, names(dt)[grepl("Days_till", names(dt))], with = F], 1, function(x)sum(x == 208))]
    
    ## Tenure
    dt[, RowSum_NAs_Tenure := apply(dt[, names(dt)[grepl("Tenure", names(dt), ignore.case = T)], with = F], 1, function(x)sum(x == -1))]
    
    ## Shopping_Density
    dt[, RowSum_NAs_Shopping_Density_Zero := apply(dt[, names(dt)[grepl("Shopping_Density", names(dt), ignore.case = T)], with = F], 1, function(x)sum(x == 0))]
    dt[, RowSum_NAs_Shopping_Density_One := apply(dt[, names(dt)[grepl("Shopping_Density", names(dt), ignore.case = T)], with = F], 1, function(x)sum(x == 1))]
    
    ## IPI
    dt[, RowSum_NAs_IPI := apply(dt[, names(dt)[grepl("IPI", names(dt), ignore.case = F)], with = F], 1, function(x)sum(x == -1))]
    
    ## Ratio_Reclaim_Amount
    dt[, RowSum_NAs_Ratio_Reclaim_Amount_minusOne := apply(dt[, names(dt)[grepl("Ratio_Reclaim_Amount", names(dt), ignore.case = T)], with = F], 1, function(x)sum(x == -1))]
    dt[, RowSum_NAs_Ratio_Reclaim_Amount_One := apply(dt[, names(dt)[grepl("Ratio_Reclaim_Amount", names(dt), ignore.case = T)], with = F], 1, function(x)sum(x == 1))]
    
    # Exp_Days_till_End_IPI_Txns
    dt[, Exp_Days_till_End_IPI_Txns := pexp(Max_Dispense_Week, 1 / IPI_Txns_Mean)]
    dt[, Ratio_Days_till_End_IPI_Txns := Max_Dispense_Week / IPI_Txns_Mean]
    dt[, Exp_Days_till_End_IPI_Txns_Hypertension := pexp(Days_till_End_Illness_Hypertension, 1 / IPI_Illness_Mean_Hypertension)]
    dt[, Ratio_Days_till_End_IPI_Txns_Hypertension := Days_till_End_Illness_Hypertension / IPI_Illness_Mean_Hypertension]
    dt[, Exp_Days_till_End_IPI_Txns_Depression := pexp(Days_till_End_Illness_Depression, 1 / IPI_Illness_Mean_Depression)]
    dt[, Ratio_Days_till_End_IPI_Txns_Depression := Days_till_End_Illness_Depression / IPI_Illness_Mean_Depression]
    dt[, Exp_Days_till_End_IPI_Txns_COPD := pexp(Days_till_End_Illness_COPD, 1 / IPI_Illness_Mean_COPD)]
    dt[, Ratio_Days_till_End_IPI_Txns_COPD := Days_till_End_Illness_COPD / IPI_Illness_Mean_COPD]
    dt[, Exp_Days_till_End_IPI_Txns_Lipids := pexp(Days_till_End_Illness_Lipids, 1 / IPI_Illness_Mean_Lipids)]
    dt[, Ratio_Days_till_End_IPI_Txns_Lipids := Days_till_End_Illness_Lipids / IPI_Illness_Mean_Lipids]
    dt[, Exp_Days_till_End_IPI_Txns_Heart_Failure := pexp(Days_till_End_Illness_Heart_Failure, 1 / IPI_Illness_Mean_Heart_Failure)]
    dt[, Ratio_Days_till_End_IPI_Txns_Heart_Failure := Days_till_End_Illness_Heart_Failure / IPI_Illness_Mean_Heart_Failure]
    dt[, Exp_Days_till_End_IPI_Txns_Immunology := pexp(Days_till_End_Illness_Immunology, 1 / IPI_Illness_Mean_Immunology)]
    dt[, Ratio_Days_till_End_IPI_Txns_Immunology := Days_till_End_Illness_Immunology / IPI_Illness_Mean_Immunology]
    dt[, Exp_Days_till_End_IPI_Txns_Urology := pexp(Days_till_End_Illness_Urology, 1 / IPI_Illness_Mean_Urology)]
    dt[, Ratio_Days_till_End_IPI_Txns_Urology := Days_till_End_Illness_Urology / IPI_Illness_Mean_Urology]
    dt[, Exp_Days_till_End_IPI_Txns_Diabetes := pexp(Days_till_End_Illness_Diabetes, 1 / IPI_Illness_Mean_Diabetes)]
    dt[, Ratio_Days_till_End_IPI_Txns_Diabetes := Days_till_End_Illness_Diabetes / IPI_Illness_Mean_Diabetes]
    dt[, Exp_Days_till_End_IPI_Txns_Anti_Coagulant := pexp(Days_till_End_Illness_Anti_Coagulant, 1 / IPI_Illness_Mean_Anti_Coagulant)]
    dt[, Ratio_Days_till_End_IPI_Txns_Anti_Coagulant := Days_till_End_Illness_Anti_Coagulant / IPI_Illness_Mean_Anti_Coagulant]
    dt[, Exp_Days_till_End_IPI_Txns_Osteoporosis := pexp(Days_till_End_Illness_Osteoporosis, 1 / IPI_Illness_Mean_Osteoporosis)]
    dt[, Ratio_Days_till_End_IPI_Txns_Osteoporosis := Days_till_End_Illness_Osteoporosis / IPI_Illness_Mean_Osteoporosis]
    
    # others
    cols = names(dt)[grepl("Exp_Days_till|Ratio_Days_till", names(dt))]
    for (j in cols){
      
      set(dt, which(is.na(dt[[j]])), j, 0)
      set(dt, which(is.infinite(dt[[j]])), j, 0)
      
    }
    
    
  }
  
  
  
  return(dt)
  
  
}