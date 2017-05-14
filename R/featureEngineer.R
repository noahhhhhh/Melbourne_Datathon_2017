## Save_Illness ##
featureEngineer_Save_illness = function(dt, dt_raw, illnesses){
  
  for(ill in illnesses){
    
    dt_save_illness = dt[ChronicIllness == ill, .(Save_Txn_Sum = sum(GovernmentReclaim_Amt, na.rm = T)
                                                  , Save_Txn_Mean = mean(GovernmentReclaim_Amt, na.rm = T)
                                                  , Save_Txn_sd = sd(GovernmentReclaim_Amt, na.rm = T)
                                                  , Save_Txn_median = median(GovernmentReclaim_Amt, na.rm = T)
                                                  , Save_Txn_max = max(GovernmentReclaim_Amt, na.rm = T)
                                                  , Save_Txn_min = min(GovernmentReclaim_Amt, na.rm = T)), by = Patient_ID]
    dt_raw = merge(dt_raw, dt_save_illness, by = "Patient_ID", all.x = T)
    setnames(dt_raw, names(dt_raw), c(names(dt_raw)[1:(ncol(dt_raw) - 6)]
                                      , paste0("Save_Illness_Sum_", gsub(" |-", "_", ill))
                                      , paste0("Save_Illness_Mean_", gsub(" |-", "_", ill))
                                      , paste0("Save_Illness_sd_", gsub(" |-", "_", ill))
                                      , paste0("Save_Illness_median_", gsub(" |-", "_", ill))
                                      , paste0("Save_Illness_max_", gsub(" |-", "_", ill))
                                      , paste0("Save_Illness_min_", gsub(" |-", "_", ill))))
    
  }
  gc()
  return(dt_raw)
  
}

## Price_Illness ##
featureEngineer_Price_illness = function(dt, dt_raw, illnesses){
  
  for(ill in illnesses){
    
    dt_price_illness = dt[ChronicIllness == ill, .(Price_Txn_Sum = sum(WholeSalePrice_Amt, na.rm = T)
                                                   , Price_Txn_Mean = mean(WholeSalePrice_Amt, na.rm = T)
                                                   , Price_Txn_sd = sd(WholeSalePrice_Amt, na.rm = T)
                                                   , Price_Txn_median = median(WholeSalePrice_Amt, na.rm = T)
                                                   , Price_Txn_max = max(WholeSalePrice_Amt, na.rm = T)
                                                   , Price_Txn_min = min(WholeSalePrice_Amt, na.rm = T)), by = Patient_ID]
    dt_raw = merge(dt_raw, dt_price_illness, by = "Patient_ID", all.x = T)
    setnames(dt_raw, names(dt_raw), c(names(dt_raw)[1:(ncol(dt_raw) - 6)]
                                      , paste0("Price_Illness_Sum_", gsub(" |-", "_", ill))
                                      , paste0("Price_Illness_Mean_", gsub(" |-", "_", ill))
                                      , paste0("Price_Illness_sd_", gsub(" |-", "_", ill))
                                      , paste0("Price_Illness_median_", gsub(" |-", "_", ill))
                                      , paste0("Price_Illness_max_", gsub(" |-", "_", ill))
                                      , paste0("Price_Illness_min_", gsub(" |-", "_", ill))))
    
  }
  gc()
  return(dt_raw)
  
}

## Spend_Illness ##
featureEngineer_Spend_illness = function(dt, dt_raw, illnesses){
  
  for(ill in illnesses){
  
    dt_spend_illness = dt[ChronicIllness == ill, .(Spend_Txn_Sum = sum(PatientPrice_Amt, na.rm = T)
                                                   , Spend_Txn_Mean = mean(PatientPrice_Amt, na.rm = T)
                                                   , Spend_Txn_sd = sd(PatientPrice_Amt, na.rm = T)
                                                   , Spend_Txn_median = median(PatientPrice_Amt, na.rm = T)
                                                   , Spend_Txn_max = max(PatientPrice_Amt, na.rm = T)
                                                   , Spend_Txn_min = min(PatientPrice_Amt, na.rm = T)), by = Patient_ID]
    dt_raw = merge(dt_raw, dt_spend_illness, by = "Patient_ID", all.x = T)
    setnames(dt_raw, names(dt_raw), c(names(dt_raw)[1:(ncol(dt_raw) - 6)]
                                      , paste0("Spend_Illness_Sum_", gsub(" |-", "_", ill))
                                      , paste0("Spend_Illness_Mean_", gsub(" |-", "_", ill))
                                      , paste0("Spend_Illness_sd_", gsub(" |-", "_", ill))
                                      , paste0("Spend_Illness_median_", gsub(" |-", "_", ill))
                                      , paste0("Spend_Illness_max_", gsub(" |-", "_", ill))
                                      , paste0("Spend_Illness_min_", gsub(" |-", "_", ill))))
    
  }
  gc()
  return(dt_raw)
  
}

## IPI_Illness ##
featureEngineer_IPI_Illness = function(dt, dt_raw, illnesses){
  
  dt_txns_week = dt[, .(Patient_ID, Dispense_Week, ChronicIllness)]
  setorderv(dt_txns_week, c("Patient_ID", "Dispense_Week"))
  
  for(ill in illnesses){
    
    dt_illness_week = dt_txns_week[ChronicIllness == ill, .(IPI_Illness = as.numeric(shift(Dispense_Week, type = "lead") - Dispense_Week) / 7), by = Patient_ID]
    dt_illness_week = dt_illness_week[, .(IPI_Illness_Mean = mean(IPI_Illness, na.rm = T)
                                          , IPI_Illness_sd = sd(IPI_Illness, na.rm = T)
                                          , IPI_Illness_median = median(IPI_Illness, na.rm = T)
                                          , IIPI_Illnesss_max = max(IPI_Illness, na.rm = T)
                                          , IPI_Illness_min = min(IPI_Illness, na.rm = T)), by = Patient_ID]
    dt_raw = merge(dt_raw, dt_illness_week, by = "Patient_ID", all.x = T)
    setnames(dt_raw, names(dt_raw), c(names(dt_raw)[1:(ncol(dt_raw) - 5)]
                                      , paste0("IPI_Illness_Mean_", gsub(" |-", "_", ill))
                                      , paste0("IPI_Illness_sd_", gsub(" |-", "_", ill))
                                      , paste0("IPI_Illness_median_", gsub(" |-", "_", ill))
                                      , paste0("IPI_Illness_max_", gsub(" |-", "_", ill))
                                      , paste0("IPI_Illness_min_", gsub(" |-", "_", ill))))
    
  }
  
  gc()
  return(dt_raw)
  
}

## crossEntropy ##
featureEngineer_crossEntropy = function(dt, dt_raw, col){
  
  dt_N = dt[, .(N = .N), by = Patient_ID]
  dt_N_col = dt[, .(N_col = .N), by = c("Patient_ID", col)]
  dt_N_merge = merge(dt_N, dt_N_col, by = "Patient_ID")
  dt_N_merge[, freq := N_col / N]
  dt_N_merge[, crossEntropy := -freq*log(freq)]
  dt_N_final = dt_N_merge[, .(crossEntropy_col = sum(crossEntropy)), by = Patient_ID]
  
  dt_raw = merge(dt_raw, dt_N_final, by = "Patient_ID", all.x = T)
  setnames(dt_raw, names(dt_raw), c(names(dt_raw)[1:(ncol(dt_raw) - 1)], paste0("CrossEntropy_", gsub(" |-", "_", col))))
  rm(dt_N, dt_N_col, dt_N_merge, dt_N_final)
  gc()
  
  return(dt_raw)
}

## featureEngineer_atc ##
featureEngineer_atc = function(dt, dt_raw, dt_atc_level){
  
  # ATCLevel5Code_Sub
  print(paste0("[", Sys.time(), "]: ", "      - ATCLevel5Code_Sub ..."))
  for(a5_sub in unique(dt_atc_level$ATCLevel5Code_Sub)){
    
    dt_no_txns_a5_sub = dt[ATCLevel5Code_Sub == a5_sub, (No_ATC5_Sub = .N), by = Patient_ID]
    dt_tenure_a5_sub = dt[ATCLevel5Code_Sub == a5_sub, .(Tenure_ATC5_Sub = (as.numeric(max(Dispense_Week) - min(Dispense_Week)) / 7)), by = Patient_ID]
    dt_no_drugs_a5_sub = dt[ATCLevel5Code_Sub == a5_sub, .N, by = .(Patient_ID, Drug_ID)][, .(No_Drugs_ATC5_Sub = .N), by = Patient_ID]
    dt_no_illnesses_a5_sub = dt[ATCLevel5Code_Sub == a5_sub, .N, by = .(Patient_ID, ChronicIllness)][, .(No_Illnesses_ATC5_Sub = .N), by = Patient_ID]
    
    
    dt_raw = merge(dt_raw, dt_no_txns_a5_sub, by = "Patient_ID", all.x = T)
    setnames(dt_raw, names(dt_raw), c(names(dt_raw)[1:(ncol(dt_raw) - 1)], paste0("No_Txns_ATC5_Sub_", gsub(" |-", "_", a5_sub))))
    dt_raw = merge(dt_raw, dt_tenure_a5_sub, by = "Patient_ID", all.x = T)
    setnames(dt_raw, names(dt_raw), c(names(dt_raw)[1:(ncol(dt_raw) - 1)], paste0("Tenure_ATC5_Sub_", gsub(" |-", "_", a5_sub))))
    dt_raw = merge(dt_raw, dt_no_drugs_a5_sub, by = "Patient_ID", all.x = T)
    setnames(dt_raw, names(dt_raw), c(names(dt_raw)[1:(ncol(dt_raw) - 1)], paste0("No_Drugs_ATC5_Sub_", gsub(" |-", "_", a5_sub))))
    dt_raw = merge(dt_raw, dt_no_illnesses_a5_sub, by = "Patient_ID", all.x = T)
    setnames(dt_raw, names(dt_raw), c(names(dt_raw)[1:(ncol(dt_raw) - 1)], paste0("No_Illnesses_ATC5_Sub_", gsub(" |-", "_", a5_sub))))
    
  }
  rm(dt_no_txns_a5_sub, dt_tenure_a5_sub, dt_no_drugs_a5_sub, dt_no_illnesses_a5_sub)
  gc()
  
  # ATCLevel4Code_Sub
  print(paste0("[", Sys.time(), "]: ", "      - ATCLevel4Code_Sub ..."))
  for(a4_sub in unique(dt_atc_level$ATCLevel4Code_Sub)){
    
    dt_no_txns_a4_sub = dt[ATCLevel4Code_Sub == a4_sub, (No_ATC4_Sub = .N), by = Patient_ID]
    dt_tenure_a4_sub = dt[ATCLevel4Code_Sub == a4_sub, .(Tenure_ATC4_Sub = (as.numeric(max(Dispense_Week) - min(Dispense_Week)) / 7)), by = Patient_ID]
    dt_no_drugs_a4_sub = dt[ATCLevel4Code_Sub == a4_sub, .N, by = .(Patient_ID, Drug_ID)][, .(No_Drugs_ATC4_Sub = .N), by = Patient_ID]
    dt_no_illnesses_a4_sub = dt[ATCLevel4Code_Sub == a4_sub, .N, by = .(Patient_ID, ChronicIllness)][, .(No_Illnesses_ATC4_Sub = .N), by = Patient_ID]
    
    
    dt_raw = merge(dt_raw, dt_no_txns_a4_sub, by = "Patient_ID", all.x = T)
    setnames(dt_raw, names(dt_raw), c(names(dt_raw)[1:(ncol(dt_raw) - 1)], paste0("No_Txns_ATC4_Sub_", gsub(" |-", "_", a4_sub))))
    dt_raw = merge(dt_raw, dt_tenure_a4_sub, by = "Patient_ID", all.x = T)
    setnames(dt_raw, names(dt_raw), c(names(dt_raw)[1:(ncol(dt_raw) - 1)], paste0("Tenure_ATC4_Sub_", gsub(" |-", "_", a4_sub))))
    dt_raw = merge(dt_raw, dt_no_drugs_a4_sub, by = "Patient_ID", all.x = T)
    setnames(dt_raw, names(dt_raw), c(names(dt_raw)[1:(ncol(dt_raw) - 1)], paste0("No_Drugs_ATC4_Sub_", gsub(" |-", "_", a4_sub))))
    dt_raw = merge(dt_raw, dt_no_illnesses_a4_sub, by = "Patient_ID", all.x = T)
    setnames(dt_raw, names(dt_raw), c(names(dt_raw)[1:(ncol(dt_raw) - 1)], paste0("No_Illnesses_ATC4_Sub_", gsub(" |-", "_", a4_sub))))
    
  }
  rm(dt_no_txns_a4_sub, dt_tenure_a4_sub, dt_no_drugs_a4_sub, dt_no_illnesses_a4_sub)
  gc()
  
  # ATCLevel3Code_Sub
  print(paste0("[", Sys.time(), "]: ", "      - ATCLevel3Code_Sub ..."))
  for(a3_sub in unique(dt_atc_level$ATCLevel3Code_Sub)){
    
    dt_no_txns_a3_sub = dt[ATCLevel3Code_Sub == a3_sub, (No_ATC3_Sub = .N), by = Patient_ID]
    dt_tenure_a3_sub = dt[ATCLevel3Code_Sub == a3_sub, .(Tenure_ATC3_Sub = (as.numeric(max(Dispense_Week) - min(Dispense_Week)) / 7)), by = Patient_ID]
    dt_no_drugs_a3_sub = dt[ATCLevel3Code_Sub == a3_sub, .N, by = .(Patient_ID, Drug_ID)][, .(No_Drugs_ATC3_Sub = .N), by = Patient_ID]
    dt_no_illnesses_a3_sub = dt[ATCLevel3Code_Sub == a3_sub, .N, by = .(Patient_ID, ChronicIllness)][, .(No_Illnesses_ATC3_Sub = .N), by = Patient_ID]
    
    
    dt_raw = merge(dt_raw, dt_no_txns_a3_sub, by = "Patient_ID", all.x = T)
    setnames(dt_raw, names(dt_raw), c(names(dt_raw)[1:(ncol(dt_raw) - 1)], paste0("No_Txns_ATC3_Sub_", gsub(" |-", "_", a3_sub))))
    dt_raw = merge(dt_raw, dt_tenure_a3_sub, by = "Patient_ID", all.x = T)
    setnames(dt_raw, names(dt_raw), c(names(dt_raw)[1:(ncol(dt_raw) - 1)], paste0("Tenure_ATC3_Sub_", gsub(" |-", "_", a3_sub))))
    dt_raw = merge(dt_raw, dt_no_drugs_a3_sub, by = "Patient_ID", all.x = T)
    setnames(dt_raw, names(dt_raw), c(names(dt_raw)[1:(ncol(dt_raw) - 1)], paste0("No_Drugs_ATC3_Sub_", gsub(" |-", "_", a3_sub))))
    dt_raw = merge(dt_raw, dt_no_illnesses_a3_sub, by = "Patient_ID", all.x = T)
    setnames(dt_raw, names(dt_raw), c(names(dt_raw)[1:(ncol(dt_raw) - 1)], paste0("No_Illnesses_ATC3_Sub_", gsub(" |-", "_", a3_sub))))
    
  }
  rm(dt_no_txns_a3_sub, dt_tenure_a3_sub, dt_no_drugs_a3_sub, dt_no_illnesses_a3_sub)
  gc()
  
  # ATCLevel2Code_Sub
  print(paste0("[", Sys.time(), "]: ", "      - ATCLevel2Code_Sub ..."))
  for(a2_sub in unique(dt_atc_level$ATCLevel2Code_Sub)){
    
    dt_no_txns_a2_sub = dt[ATCLevel2Code_Sub == a2_sub, (No_ATC2_Sub = .N), by = Patient_ID]
    dt_tenure_a2_sub = dt[ATCLevel2Code_Sub == a2_sub, .(Tenure_ATC2_Sub = (as.numeric(max(Dispense_Week) - min(Dispense_Week)) / 7)), by = Patient_ID]
    dt_no_drugs_a2_sub = dt[ATCLevel2Code_Sub == a2_sub, .N, by = .(Patient_ID, Drug_ID)][, .(No_Drugs_ATC2_Sub = .N), by = Patient_ID]
    dt_no_illnesses_a2_sub = dt[ATCLevel2Code_Sub == a2_sub, .N, by = .(Patient_ID, ChronicIllness)][, .(No_Illnesses_ATC2_Sub = .N), by = Patient_ID]
    
    
    dt_raw = merge(dt_raw, dt_no_txns_a2_sub, by = "Patient_ID", all.x = T)
    setnames(dt_raw, names(dt_raw), c(names(dt_raw)[1:(ncol(dt_raw) - 1)], paste0("No_Txns_ATC2_Sub_", gsub(" |-", "_", a2_sub))))
    dt_raw = merge(dt_raw, dt_tenure_a2_sub, by = "Patient_ID", all.x = T)
    setnames(dt_raw, names(dt_raw), c(names(dt_raw)[1:(ncol(dt_raw) - 1)], paste0("Tenure_ATC2_Sub_", gsub(" |-", "_", a2_sub))))
    dt_raw = merge(dt_raw, dt_no_drugs_a2_sub, by = "Patient_ID", all.x = T)
    setnames(dt_raw, names(dt_raw), c(names(dt_raw)[1:(ncol(dt_raw) - 1)], paste0("No_Drugs_ATC2_Sub_", gsub(" |-", "_", a2_sub))))
    dt_raw = merge(dt_raw, dt_no_illnesses_a2_sub, by = "Patient_ID", all.x = T)
    setnames(dt_raw, names(dt_raw), c(names(dt_raw)[1:(ncol(dt_raw) - 1)], paste0("No_Illnesses_ATC2_Sub_", gsub(" |-", "_", a2_sub))))
    
  }
  rm(dt_no_txns_a2_sub, dt_tenure_a2_sub, dt_no_drugs_a2_sub, dt_no_illnesses_a2_sub)
  gc()
  
  # # ATCLevel5Code_Raw
  # print(paste0("[", Sys.time(), "]: ", "      - ATCLevel5Code_Raw ..."))
  # for(a5 in unique(dt_atc_level$ATCLevel5Code)){
  #   
  #   dt_no_txns_a5_raw = dt[ATCLevel5Code == a5, (No_Txns_ATC5_Raw = .N), by = Patient_ID]
  #   dt_tenure_a5_raw = dt[ATCLevel5Code == a5, .(Tenure_ATC5_Raw = (as.numeric(max(Dispense_Week) - min(Dispense_Week)) / 7)), by = Patient_ID]
  #   dt_no_drugs_a5_raw = dt[ATCLevel5Code == a5, .N, by = .(Patient_ID, Drug_ID)][, .(No_Drugs_ATC5_Raw = .N), by = Patient_ID]
  #   dt_no_illnesses_a5_raw = dt[ATCLevel5Code == a5, .N, by = .(Patient_ID, ChronicIllness)][, .(No_Illnesses_ATC5_Raw = .N), by = Patient_ID]
  #   
  #   
  #   dt_raw = merge(dt_raw, dt_no_txns_a5_raw, by = "Patient_ID", all.x = T)
  #   setnames(dt_raw, names(dt_raw), c(names(dt_raw)[1:(ncol(dt_raw) - 1)], paste0("No_Txns_ATC5_Raw_", gsub(" |-", "_", a5))))
  #   dt_raw = merge(dt_raw, dt_tenure_a5_raw, by = "Patient_ID", all.x = T)
  #   setnames(dt_raw, names(dt_raw), c(names(dt_raw)[1:(ncol(dt_raw) - 1)], paste0("Tenure_ATC5_Raw_", gsub(" |-", "_", a5))))
  #   dt_raw = merge(dt_raw, dt_no_drugs_a5_raw, by = "Patient_ID", all.x = T)
  #   setnames(dt_raw, names(dt_raw), c(names(dt_raw)[1:(ncol(dt_raw) - 1)], paste0("No_Drugs_ATC5_Raw_", gsub(" |-", "_", a5))))
  #   dt_raw = merge(dt_raw, dt_no_illnesses_a5_raw, by = "Patient_ID", all.x = T)
  #   setnames(dt_raw, names(dt_raw), c(names(dt_raw)[1:(ncol(dt_raw) - 1)], paste0("No_Illnesses_ATC5_Raw_", gsub(" |-", "_", a5))))
  #   
  # }
  # 
  # # ATCLevel4Code_Raw
  # print(paste0("[", Sys.time(), "]: ", "      - ATCLevel4Code_Raw ..."))
  # for(a4 in unique(dt_atc_level$ATCLevel4Code)){
  #   
  #   dt_no_txns_a4_raw = dt[ATCLevel4Code == a4, (No_Txns_ATC4_Raw = .N), by = Patient_ID]
  #   dt_tenure_a4_raw = dt[ATCLevel4Code == a4, .(Tenure_ATC4_Raw = (as.numeric(max(Dispense_Week) - min(Dispense_Week)) / 7)), by = Patient_ID]
  #   dt_no_drugs_a4_raw = dt[ATCLevel4Code == a4, .N, by = .(Patient_ID, Drug_ID)][, .(No_Drugs_ATC4_Raw = .N), by = Patient_ID]
  #   dt_no_illnesses_a4_raw = dt[ATCLevel4Code == a4, .N, by = .(Patient_ID, ChronicIllness)][, .(No_Illnesses_ATC4_Raw = .N), by = Patient_ID]
  #   
  #   
  #   dt_raw = merge(dt_raw, dt_no_txns_a4_raw, by = "Patient_ID", all.x = T)
  #   setnames(dt_raw, names(dt_raw), c(names(dt_raw)[1:(ncol(dt_raw) - 1)], paste0("No_Txns_ATC4_Raw_", gsub(" |-", "_", a4))))
  #   dt_raw = merge(dt_raw, dt_tenure_a4_raw, by = "Patient_ID", all.x = T)
  #   setnames(dt_raw, names(dt_raw), c(names(dt_raw)[1:(ncol(dt_raw) - 1)], paste0("Tenure_ATC4_Raw_", gsub(" |-", "_", a4))))
  #   dt_raw = merge(dt_raw, dt_no_drugs_a4_raw, by = "Patient_ID", all.x = T)
  #   setnames(dt_raw, names(dt_raw), c(names(dt_raw)[1:(ncol(dt_raw) - 1)], paste0("No_Drugs_ATC4_Raw_", gsub(" |-", "_", a4))))
  #   dt_raw = merge(dt_raw, dt_no_illnesses_a4_raw, by = "Patient_ID", all.x = T)
  #   setnames(dt_raw, names(dt_raw), c(names(dt_raw)[1:(ncol(dt_raw) - 1)], paste0("No_Illnesses_ATC4_Raw_", gsub(" |-", "_", a4))))
  #   
  # }
  
  # ATCLevel3Code_Raw
  print(paste0("[", Sys.time(), "]: ", "      - ATCLevel3Code_Raw ..."))
  for(a3 in unique(dt_atc_level$ATCLevel3Code)){
    
    dt_no_txns_a3_raw = dt[ATCLevel3Code == a3, (No_Txns_ATC3_Raw = .N), by = Patient_ID]
    dt_tenure_a3_raw = dt[ATCLevel3Code == a3, .(Tenure_ATC3_Raw = (as.numeric(max(Dispense_Week) - min(Dispense_Week)) / 7)), by = Patient_ID]
    dt_no_drugs_a3_raw = dt[ATCLevel3Code == a3, .N, by = .(Patient_ID, Drug_ID)][, .(No_Drugs_ATC3_Raw = .N), by = Patient_ID]
    dt_no_illnesses_a3_raw = dt[ATCLevel3Code == a3, .N, by = .(Patient_ID, ChronicIllness)][, .(No_Illnesses_ATC3_Raw = .N), by = Patient_ID]
    
    
    dt_raw = merge(dt_raw, dt_no_txns_a3_raw, by = "Patient_ID", all.x = T)
    setnames(dt_raw, names(dt_raw), c(names(dt_raw)[1:(ncol(dt_raw) - 1)], paste0("No_Txns_ATC3_Raw_", gsub(" |-", "_", a3))))
    dt_raw = merge(dt_raw, dt_tenure_a3_raw, by = "Patient_ID", all.x = T)
    setnames(dt_raw, names(dt_raw), c(names(dt_raw)[1:(ncol(dt_raw) - 1)], paste0("Tenure_ATC3_Raw_", gsub(" |-", "_", a3))))
    dt_raw = merge(dt_raw, dt_no_drugs_a3_raw, by = "Patient_ID", all.x = T)
    setnames(dt_raw, names(dt_raw), c(names(dt_raw)[1:(ncol(dt_raw) - 1)], paste0("No_Drugs_ATC3_Raw_", gsub(" |-", "_", a3))))
    dt_raw = merge(dt_raw, dt_no_illnesses_a3_raw, by = "Patient_ID", all.x = T)
    setnames(dt_raw, names(dt_raw), c(names(dt_raw)[1:(ncol(dt_raw) - 1)], paste0("No_Illnesses_ATC3_Raw_", gsub(" |-", "_", a3))))
    
  }
  rm(dt_no_txns_a3_raw, dt_tenure_a3_raw, dt_no_drugs_a3_raw, dt_no_illnesses_a3_raw)
  gc()
  
  # ATCLevel2Code_Raw
  print(paste0("[", Sys.time(), "]: ", "      - ATCLevel2Code_Raw ..."))
  for(a2 in unique(dt_atc_level$ATCLevel2Code)){
    
    dt_no_txns_a2_raw = dt[ATCLevel2Code == a2, (No_Txns_ATC2_Raw = .N), by = Patient_ID]
    dt_tenure_a2_raw = dt[ATCLevel2Code == a2, .(Tenure_ATC2_Raw = (as.numeric(max(Dispense_Week) - min(Dispense_Week)) / 7)), by = Patient_ID]
    dt_no_drugs_a2_raw = dt[ATCLevel2Code == a2, .N, by = .(Patient_ID, Drug_ID)][, .(No_Drugs_ATC2_Raw = .N), by = Patient_ID]
    dt_no_illnesses_a2_raw = dt[ATCLevel2Code == a2, .N, by = .(Patient_ID, ChronicIllness)][, .(No_Illnesses_ATC2_Raw = .N), by = Patient_ID]
    
    
    dt_raw = merge(dt_raw, dt_no_txns_a2_raw, by = "Patient_ID", all.x = T)
    setnames(dt_raw, names(dt_raw), c(names(dt_raw)[1:(ncol(dt_raw) - 1)], paste0("No_Txns_ATC2_Raw_", gsub(" |-", "_", a2))))
    dt_raw = merge(dt_raw, dt_tenure_a2_raw, by = "Patient_ID", all.x = T)
    setnames(dt_raw, names(dt_raw), c(names(dt_raw)[1:(ncol(dt_raw) - 1)], paste0("Tenure_ATC2_Raw_", gsub(" |-", "_", a2))))
    dt_raw = merge(dt_raw, dt_no_drugs_a2_raw, by = "Patient_ID", all.x = T)
    setnames(dt_raw, names(dt_raw), c(names(dt_raw)[1:(ncol(dt_raw) - 1)], paste0("No_Drugs_ATC2_Raw_", gsub(" |-", "_", a2))))
    dt_raw = merge(dt_raw, dt_no_illnesses_a2_raw, by = "Patient_ID", all.x = T)
    setnames(dt_raw, names(dt_raw), c(names(dt_raw)[1:(ncol(dt_raw) - 1)], paste0("No_Illnesses_ATC2_Raw_", gsub(" |-", "_", a2))))
    
  }
  rm(dt_no_txns_a2_raw, dt_tenure_a2_raw, dt_no_drugs_a2_raw, dt_no_illnesses_a2_raw)
  gc()
  
  # ATCLevel1Code_Raw
  print(paste0("[", Sys.time(), "]: ", "      - ATCLevel1Code_Raw ..."))
  for(a1 in unique(dt_atc_level$ATCLevel1Code)){
    
    dt_no_txns_a1_raw = dt[ATCLevel1Code == a1, (No_Txns_ATC1_Raw = .N), by = Patient_ID]
    dt_tenure_a1_raw = dt[ATCLevel1Code == a1, .(Tenure_ATC1_Raw = (as.numeric(max(Dispense_Week) - min(Dispense_Week)) / 7)), by = Patient_ID]
    dt_no_drugs_a1_raw = dt[ATCLevel1Code == a1, .N, by = .(Patient_ID, Drug_ID)][, .(No_Drugs_ATC1_Raw = .N), by = Patient_ID]
    dt_no_illnesses_a1_raw = dt[ATCLevel1Code == a1, .N, by = .(Patient_ID, ChronicIllness)][, .(No_Illnesses_ATC1_Raw = .N), by = Patient_ID]
    
    
    dt_raw = merge(dt_raw, dt_no_txns_a1_raw, by = "Patient_ID", all.x = T)
    setnames(dt_raw, names(dt_raw), c(names(dt_raw)[1:(ncol(dt_raw) - 1)], paste0("No_Txns_ATC1_Raw_", gsub(" |-", "_", a1))))
    dt_raw = merge(dt_raw, dt_tenure_a1_raw, by = "Patient_ID", all.x = T)
    setnames(dt_raw, names(dt_raw), c(names(dt_raw)[1:(ncol(dt_raw) - 1)], paste0("Tenure_ATC1_Raw_", gsub(" |-", "_", a1))))
    dt_raw = merge(dt_raw, dt_no_drugs_a1_raw, by = "Patient_ID", all.x = T)
    setnames(dt_raw, names(dt_raw), c(names(dt_raw)[1:(ncol(dt_raw) - 1)], paste0("No_Drugs_ATC1_Raw_", gsub(" |-", "_", a1))))
    dt_raw = merge(dt_raw, dt_no_illnesses_a1_raw, by = "Patient_ID", all.x = T)
    setnames(dt_raw, names(dt_raw), c(names(dt_raw)[1:(ncol(dt_raw) - 1)], paste0("No_Illnesses_ATC1_Raw_", gsub(" |-", "_", a1))))
    
  }
  rm(dt_no_txns_a1_raw, dt_tenure_a1_raw, dt_no_drugs_a1_raw, dt_no_illnesses_a1_raw)
  gc()
  
  return(dt_raw)
  
}

## No_Txns_for_Illness ##
featureEngineer_basic_txn_illness = function(dt, dt_raw, illnesses){
  
  for(ill in illnesses){
    
    dt_no_txns = dt[ChronicIllness == ill, .(No_Txns_Illness = .N), by = Patient_ID]
    dt_no_drugs = dt[ChronicIllness == ill, .N, by = .(Patient_ID, Drug_ID)][, .(No_Drugs_Illness = .N), by = Patient_ID]
    dt_no_prescriptions = dt[ChronicIllness == ill, .N, by = .(Patient_ID, Prescription_ID)][, .(No_Prescriptions_Illness = .N), by = Patient_ID]
    dt_no_prescribers = dt[ChronicIllness == ill, .N, by = .(Patient_ID, Prescriber_ID)][, .(No_Prescribers_Illness = .N), by = Patient_ID]
    dt_no_stores = dt[ChronicIllness == ill, .N, by = .(Patient_ID, Store_ID)][, .(No_Stores_Illness = .N), by = Patient_ID]
    dt_no_deferredScript = dt[ChronicIllness == ill, .(No_DeferredScript_Illness = sum(IsDeferredScript)), by = Patient_ID]
    dt_no_repeats = dt[ChronicIllness == ill, .(No_Repeats = max(RepeatsTotal_Qty)), by = .(Patient_ID, Prescription_ID)][, .(No_Repeats_Illness = sum(No_Repeats)), by = Patient_ID]
    
    dt_raw = merge(dt_raw, dt_no_txns, by = "Patient_ID", all.x = T)
    setnames(dt_raw, names(dt_raw), c(names(dt_raw)[1:(ncol(dt_raw) - 1)], paste0("No_Txns_Illness_", gsub(" |-", "_", ill))))
    dt_raw = merge(dt_raw, dt_no_drugs, by = "Patient_ID", all.x = T)
    setnames(dt_raw, names(dt_raw), c(names(dt_raw)[1:(ncol(dt_raw) - 1)], paste0("No_Drugs_Illness_", gsub(" |-", "_", ill))))
    dt_raw = merge(dt_raw, dt_no_prescriptions, by = "Patient_ID", all.x = T)
    setnames(dt_raw, names(dt_raw), c(names(dt_raw)[1:(ncol(dt_raw) - 1)], paste0("No_Prescriptions_Illness_", gsub(" |-", "_", ill))))
    dt_raw = merge(dt_raw, dt_no_prescribers, by = "Patient_ID", all.x = T)
    setnames(dt_raw, names(dt_raw), c(names(dt_raw)[1:(ncol(dt_raw) - 1)], paste0("No_Prescribers_Illness_", gsub(" |-", "_", ill))))
    dt_raw = merge(dt_raw, dt_no_stores, by = "Patient_ID", all.x = T)
    setnames(dt_raw, names(dt_raw), c(names(dt_raw)[1:(ncol(dt_raw) - 1)], paste0("No_Stores_Illness_", gsub(" |-", "_", ill))))
    dt_raw = merge(dt_raw, dt_no_deferredScript, by = "Patient_ID", all.x = T)
    setnames(dt_raw, names(dt_raw), c(names(dt_raw)[1:(ncol(dt_raw) - 1)], paste0("No_DeferredScript_Illness_", gsub(" |-", "_", ill))))
    dt_raw = merge(dt_raw, dt_no_repeats, by = "Patient_ID", all.x = T)
    setnames(dt_raw, names(dt_raw), c(names(dt_raw)[1:(ncol(dt_raw) - 1)], paste0("No_Repeats_Illness_", gsub(" |-", "_", ill))))
    
  }
  gc()
  
  return(dt_raw)
  
}

## Ratio_Reclaim_Amount_Illness ##
featureEngineer_ratio_reclaim_amount_illness = function(dt, dt_raw, illnesses){
  
  for(ill in illnesses){
    
    dt_ratio_reclaim_amount_illness = dt[ChronicIllness == ill, .(Ratio_Reclaim_Amount_Illness = mean(GovernmentReclaim_Amt / (PatientPrice_Amt + WholeSalePrice_Amt))), by = Patient_ID]
    dt_raw = merge(dt_raw, dt_ratio_reclaim_amount_illness, by = "Patient_ID", all.x = T)
    setnames(dt_raw, names(dt_raw), c(names(dt_raw)[1:(ncol(dt_raw) - 1)], paste0("Ratio_Reclaim_Amount_Illness_", gsub(" |-", "_", ill))))
    
  }
  
  gc()
  return(dt_raw)
  
}

## Days_till_End_Illness ##
featureEngineer_days_till_end_illness = function(dt, dt_raw, illnesses, trainEndDate){
  
  for(ill in illnesses){
    
    dt_days_till_end__illness = dt[ChronicIllness == ill, .(Max_Dispense_Week_Illness = as.numeric(as.Date(trainEndDate) - max(Dispense_Week)) / 7), by = Patient_ID]
    dt_raw = merge(dt_raw, dt_days_till_end__illness, by = "Patient_ID", all.x = T)
    setnames(dt_raw, names(dt_raw), c(names(dt_raw)[1:(ncol(dt_raw) - 1)], paste0("Days_till_End_Illness_", gsub(" |-", "_", ill))))
    
  }
  
  gc()
  return(dt_raw)
  
}

## Avg_Days_between_Prescription_Dispense_Illness ##
featureEngineer_adbpd_illness = function(dt, dt_raw, illnesses){
  
  for(ill in illnesses){
    
    dt_avg_days_between_prescription_dispense_illness = dt[ChronicIllness == ill, .(dbpd_illness = min(as.numeric(Dispense_Week - Prescription_Week) / 7)), by = .(Patient_ID, Prescription_ID)][, .(a_dbpd_illness = mean(dbpd_illness)), by = Patient_ID]
    dt_raw = merge(dt_raw, dt_avg_days_between_prescription_dispense_illness, by = "Patient_ID", all.x = T)
    setnames(dt_raw, names(dt_raw), c(names(dt_raw)[1:(ncol(dt_raw) - 1)], paste0("a_dbpd_Illness_", gsub(" |-", "_", ill))))
    
  }
  
  gc()
  return(dt_raw)
  
  
}

## Tenure_Illnes ##
featureEngineer_tenure_illness = function(dt, dt_raw, illnesses){
  
  for(ill in illnesses){
    
    dt_tenure_illness = dt[ChronicIllness == ill, .(Tenure_Illness = (as.numeric(max(Dispense_Week) - min(Dispense_Week)) / 7)), by = Patient_ID]
    dt_raw = merge(dt_raw, dt_tenure_illness, by = "Patient_ID", all.x = T)
    setnames(dt_raw, names(dt_raw), c(names(dt_raw)[1:(ncol(dt_raw) - 1)], paste0("Tenure_Illness_", gsub(" |-", "_", ill))))
    
  }
  
  gc()
  return(dt_raw)
  
}

## Shopping_Density_Illness ##
featureEngineer_shopping_density_illness = function(dt, dt_raw, illnesses){
  
  for(ill in illnesses){
    
    dt_shopping_density_illness = dt[ChronicIllness == ill, .(Shopping_Density_Illness = .N / (as.numeric(max(Dispense_Week) - min(Dispense_Week)) / 7)), by = Patient_ID]
    dt_raw = merge(dt_raw, dt_shopping_density_illness, by = c("Patient_ID"), all.x = T)
    setnames(dt_raw, names(dt_raw), c(names(dt_raw)[1:(ncol(dt_raw) - 1)], paste0("Shopping_Density_", gsub(" |-", "_", ill))))
    
  }
  
  gc()
  return(dt_raw)
  
}

# ATC Feature Engineering -------------------------------------------------


featureEngineer_ATC = function(dt, trainEndDate = "2015-01-01", dt_drug, dt_atc){
  print(paste0("[", Sys.time(), "]: ", "ATC Feature Engineering ..."))
  print(dim(dt))
  
  # Preparation -------------------------------------------------------------
  
  print(paste0("[", Sys.time(), "]: ", "  - Preparation ..."))
  print(paste0("[", Sys.time(), "]: ", "    - COPD ..."))
  dt[ChronicIllness == "Chronic Obstructive Pulmonary Disease (COPD)", ChronicIllness := "COPD"]
  
  print(paste0("[", Sys.time(), "]: ", "    - Prescription_ID ..."))
  dt[, Prescription_ID := paste0(Prescriber_ID, "_", as.character(Prescription_Week), "_", Patient_ID)]
  
  print(paste0("[", Sys.time(), "]: ", "    - dt_raw ..."))
  dt_raw = dt[, .(Patient_ID, Target)]
  dt_raw = dt_raw[!duplicated(dt_raw)]
  
  print(paste0("[", Sys.time(), "]: ", "    - illnesses ..."))
  illnesses = c("Hypertension", "Depression", "COPD", "Lipids", "Heart Failure", "Immunology", "Urology"
                , "Epilepsy", "Diabetes", "Anti-Coagulant", "Osteoporosis")
  
  # atc ---------------------------------------------------------------------
  
  print(paste0("[", Sys.time(), "]: ", "  - ATC Features ..."))
  # txn level
  dt = merge(dt, dt_drug[, .(MasterProductID, ATCLevel1Code, ATCLevel2Code, ATCLevel3Code, ATCLevel4Code, ATCLevel5Code)]
             , by.x = "Drug_ID", by.y = "MasterProductID")
  
  
  dt[, ATCLevel5Code_Sub := ifelse(nchar(ATCLevel4Code) == nchar(ATCLevel3Code), ATCLevel3Code
                                   , ifelse(nchar(ATCLevel4Code) == nchar(ATCLevel5Code), ATCLevel4Code
                                            , substr(ATCLevel5Code, 6, 7)))]
  dt[, ATCLevel4Code_Sub := ifelse(nchar(ATCLevel4Code) == nchar(ATCLevel3Code), ATCLevel3Code, substr(ATCLevel4Code, 5, 5))]
  dt[, ATCLevel3Code_Sub := substr(ATCLevel3Code, 4, 4)]
  dt[, ATCLevel2Code_Sub := substr(ATCLevel2Code, 2, 3)]
  
  # atc level
  dt_atc_level = dt_atc[, .(ATCLevel1Code, ATCLevel2Code, ATCLevel3Code, ATCLevel4Code, ATCLevel5Code)]
  dt_atc_level[, ATCLevel5Code_Sub := ifelse(nchar(ATCLevel4Code) == nchar(ATCLevel3Code), ATCLevel3Code
                                             , ifelse(nchar(ATCLevel4Code) == nchar(ATCLevel5Code), ATCLevel4Code
                                                      , substr(ATCLevel5Code, 6, 7)))]
  dt_atc_level[, ATCLevel4Code_Sub := ifelse(nchar(ATCLevel4Code) == nchar(ATCLevel3Code), ATCLevel3Code, substr(ATCLevel4Code, 5, 5))]
  dt_atc_level[, ATCLevel3Code_Sub := substr(ATCLevel3Code, 4, 4)]
  dt_atc_level[, ATCLevel2Code_Sub := substr(ATCLevel2Code, 2, 3)]
  
  # CrossEntropy
  print(paste0("[", Sys.time(), "]: ", "    - CrossEntropy ..."))
  print(paste0("[", Sys.time(), "]: ", "      - CrossEntropy_ATC_Sub_5 ..."))
  dt_raw = featureEngineer_crossEntropy(dt, dt_raw, "ATCLevel5Code_Sub")
  print(dim(dt_raw))
  
  print(paste0("[", Sys.time(), "]: ", "      - CrossEntropy_ATC_Sub_4 ..."))
  dt_raw = featureEngineer_crossEntropy(dt, dt_raw, "ATCLevel4Code_Sub")
  print(dim(dt_raw))
  
  print(paste0("[", Sys.time(), "]: ", "      - CrossEntropy_ATC_Sub_3 ..."))
  dt_raw = featureEngineer_crossEntropy(dt, dt_raw, "ATCLevel3Code_Sub")
  print(dim(dt_raw))
  
  print(paste0("[", Sys.time(), "]: ", "      - CrossEntropy_ATC_Sub_2 ..."))
  dt_raw = featureEngineer_crossEntropy(dt, dt_raw, "ATCLevel2Code_Sub")
  print(dim(dt_raw))
  
  print(paste0("[", Sys.time(), "]: ", "      - CrossEntropy_ATC_Raw_5 ..."))
  dt_raw = featureEngineer_crossEntropy(dt, dt_raw, "ATCLevel5Code")
  print(dim(dt_raw))
  
  print(paste0("[", Sys.time(), "]: ", "      - CrossEntropy_ATC_Raw_4 ..."))
  dt_raw = featureEngineer_crossEntropy(dt, dt_raw, "ATCLevel4Code")
  print(dim(dt_raw))
  
  print(paste0("[", Sys.time(), "]: ", "      - CrossEntropy_ATC_Raw_3 ..."))
  dt_raw = featureEngineer_crossEntropy(dt, dt_raw, "ATCLevel3Code")
  print(dim(dt_raw))
  
  print(paste0("[", Sys.time(), "]: ", "      - CrossEntropy_ATC_Raw_2 ..."))
  dt_raw = featureEngineer_crossEntropy(dt, dt_raw, "ATCLevel2Code")
  print(dim(dt_raw))
  
  print(paste0("[", Sys.time(), "]: ", "      - CrossEntropy_ATC_Raw_1 ..."))
  dt_raw = featureEngineer_crossEntropy(dt, dt_raw, "ATCLevel1Code")
  print(dim(dt_raw))
  
  # No_ATC
  print(paste0("[", Sys.time(), "]: ", "    - No_ATC ..."))
  print(paste0("[", Sys.time(), "]: ", "      - No_ATC_Sub_5 ..."))
  dt_no_a5_sub = dt[, .N, by = .(Patient_ID, ATCLevel5Code_Sub)][, .(No_ATC5_Sub = .N), by = Patient_ID]
  dt_raw = merge(dt_raw, dt_no_a5_sub, by = "Patient_ID", all.x = T)
  rm("dt_no_a5_sub")
  gc()
  print(dim(dt_raw))
  
  print(paste0("[", Sys.time(), "]: ", "      - No_ATC_Sub_4 ..."))
  dt_no_a4_sub = dt[, .N, by = .(Patient_ID, ATCLevel4Code_Sub)][, .(No_ATC4_Sub = .N), by = Patient_ID]
  dt_raw = merge(dt_raw, dt_no_a4_sub, by = "Patient_ID", all.x = T)
  rm("dt_no_a4_sub")
  gc()
  print(dim(dt_raw))
  
  print(paste0("[", Sys.time(), "]: ", "      - No_ATC_Sub_3 ..."))
  dt_no_a3_sub = dt[, .N, by = .(Patient_ID, ATCLevel3Code_Sub)][, .(No_ATC3_Sub = .N), by = Patient_ID]
  dt_raw = merge(dt_raw, dt_no_a3_sub, by = "Patient_ID", all.x = T)
  rm("dt_no_a3_sub")
  gc()
  print(dim(dt_raw))
  
  print(paste0("[", Sys.time(), "]: ", "      - No_ATC_Sub_2 ..."))
  dt_no_a2_sub = dt[, .N, by = .(Patient_ID, ATCLevel2Code_Sub)][, .(No_ATC2_Sub = .N), by = Patient_ID]
  dt_raw = merge(dt_raw, dt_no_a2_sub, by = "Patient_ID", all.x = T)
  rm("dt_no_a2_sub")
  gc()
  print(dim(dt_raw))
  
  print(paste0("[", Sys.time(), "]: ", "      - No_ATC_Raw_5 ..."))
  dt_no_a5_raw = dt[, .N, by = .(Patient_ID, ATCLevel5Code)][, .(No_ATC5_Raw = .N), by = Patient_ID]
  dt_raw = merge(dt_raw, dt_no_a5_raw, by = "Patient_ID", all.x = T)
  rm("dt_no_a5_raw")
  gc()
  print(dim(dt_raw))
  
  print(paste0("[", Sys.time(), "]: ", "      - No_ATC_Raw_4 ..."))
  dt_no_a4_raw = dt[, .N, by = .(Patient_ID, ATCLevel4Code)][, .(No_ATC4_Raw = .N), by = Patient_ID]
  dt_raw = merge(dt_raw, dt_no_a4_raw, by = "Patient_ID", all.x = T)
  rm("dt_no_a4_raw")
  gc()
  print(dim(dt_raw))
  
  print(paste0("[", Sys.time(), "]: ", "      - No_ATC_Raw_3 ..."))
  dt_no_a3_raw = dt[, .N, by = .(Patient_ID, ATCLevel3Code)][, .(No_ATC3_Raw = .N), by = Patient_ID]
  dt_raw = merge(dt_raw, dt_no_a3_raw, by = "Patient_ID", all.x = T)
  rm("dt_no_a3_raw")
  gc()
  print(dim(dt_raw))
  
  print(paste0("[", Sys.time(), "]: ", "      - No_ATC_Raw_2 ..."))
  dt_no_a2_raw = dt[, .N, by = .(Patient_ID, ATCLevel2Code)][, .(No_ATC2_Raw = .N), by = Patient_ID]
  dt_raw = merge(dt_raw, dt_no_a2_raw, by = "Patient_ID", all.x = T)
  rm("dt_no_a2_raw")
  gc()
  print(dim(dt_raw))
  
  print(paste0("[", Sys.time(), "]: ", "      - No_ATC_1 ..."))
  dt_no_a1 = dt[, .N, by = .(Patient_ID, ATCLevel1Code)][, .(No_ATC1_Raw = .N), by = Patient_ID]
  dt_raw = merge(dt_raw, dt_no_a1, by = "Patient_ID", all.x = T)
  rm("dt_no_a1")
  gc()
  print(dim(dt_raw))
  
  
  # Most_Common_ATC
  print(paste0("[", Sys.time(), "]: ", "    - Most_Common_ATC ..."))
  print(paste0("[", Sys.time(), "]: ", "      - Most_Common_ATC_Sub_5 ..."))
  dt_max_txns_a5_sub = dt[, .N, by = .(Patient_ID, ATCLevel5Code_Sub, Prescription_ID)]
  dt_max_txns_a5_sub = dt_max_txns_a5_sub[, .N, by = .(Patient_ID, ATCLevel5Code_Sub)]
  dt_max_txns_a5_sub[, rank := frankv(-N, ties.method = "first"), by = Patient_ID]
  dt_max_txns_a5_sub = dt_max_txns_a5_sub[rank == 1, !c("rank", "N"), with = F]
  dt_raw = merge(dt_raw, dt_max_txns_a5_sub, by = "Patient_ID", all.x = T)
  setnames(dt_raw, names(dt_raw), c(names(dt_raw)[1:(ncol(dt_raw) - 1)], paste0("Most_Common_ATC_Sub_5")))
  rm("dt_max_txns_a5_sub")
  gc()
  print(dim(dt_raw))
  
  print(paste0("[", Sys.time(), "]: ", "      - Most_Common_ATC_Sub_4 ..."))
  dt_max_txns_a4_sub = dt[, .N, by = .(Patient_ID, ATCLevel4Code_Sub, Prescription_ID)]
  dt_max_txns_a4_sub = dt_max_txns_a4_sub[, .N, by = .(Patient_ID, ATCLevel4Code_Sub)]
  dt_max_txns_a4_sub[, rank := frankv(-N, ties.method = "first"), by = Patient_ID]
  dt_max_txns_a4_sub = dt_max_txns_a4_sub[rank == 1, !c("rank", "N"), with = F]
  dt_raw = merge(dt_raw, dt_max_txns_a4_sub, by = "Patient_ID", all.x = T)
  setnames(dt_raw, names(dt_raw), c(names(dt_raw)[1:(ncol(dt_raw) - 1)], paste0("Most_Common_ATC_Sub_4")))
  rm("dt_max_txns_a4_sub")
  gc()
  print(dim(dt_raw))
  
  print(paste0("[", Sys.time(), "]: ", "      - Most_Common_ATC_Sub_3 ..."))
  dt_max_txns_a3_sub = dt[, .N, by = .(Patient_ID, ATCLevel3Code_Sub, Prescription_ID)]
  dt_max_txns_a3_sub = dt_max_txns_a3_sub[, .N, by = .(Patient_ID, ATCLevel3Code_Sub)]
  dt_max_txns_a3_sub[, rank := frankv(-N, ties.method = "first"), by = Patient_ID]
  dt_max_txns_a3_sub = dt_max_txns_a3_sub[rank == 1, !c("rank", "N"), with = F]
  dt_raw = merge(dt_raw, dt_max_txns_a3_sub, by = "Patient_ID", all.x = T)
  setnames(dt_raw, names(dt_raw), c(names(dt_raw)[1:(ncol(dt_raw) - 1)], paste0("Most_Common_ATC_Sub_3")))
  rm("dt_max_txns_a3_sub")
  gc()
  print(dim(dt_raw))
  
  print(paste0("[", Sys.time(), "]: ", "      - Most_Common_ATC_Sub_2 ..."))
  dt_max_txns_a2_sub = dt[, .N, by = .(Patient_ID, ATCLevel2Code_Sub, Prescription_ID)]
  dt_max_txns_a2_sub = dt_max_txns_a2_sub[, .N, by = .(Patient_ID, ATCLevel2Code_Sub)]
  dt_max_txns_a2_sub[, rank := frankv(-N, ties.method = "first"), by = Patient_ID]
  dt_max_txns_a2_sub = dt_max_txns_a2_sub[rank == 1, !c("rank", "N"), with = F]
  dt_raw = merge(dt_raw, dt_max_txns_a2_sub, by = "Patient_ID", all.x = T)
  setnames(dt_raw, names(dt_raw), c(names(dt_raw)[1:(ncol(dt_raw) - 1)], paste0("Most_Common_ATC_Sub_2")))
  rm("dt_max_txns_a2_sub")
  gc()
  print(dim(dt_raw))
  
  print(paste0("[", Sys.time(), "]: ", "      - Most_Common_ATC_Raw_5 ..."))
  dt_max_txns_a5_raw = dt[, .N, by = .(Patient_ID, ATCLevel5Code, Prescription_ID)]
  dt_max_txns_a5_raw = dt_max_txns_a5_raw[, .N, by = .(Patient_ID, ATCLevel5Code)]
  dt_max_txns_a5_raw[, rank := frankv(-N, ties.method = "first"), by = Patient_ID]
  dt_max_txns_a5_raw = dt_max_txns_a5_raw[rank == 1, !c("rank", "N"), with = F]
  dt_raw = merge(dt_raw, dt_max_txns_a5_raw, by = "Patient_ID", all.x = T)
  setnames(dt_raw, names(dt_raw), c(names(dt_raw)[1:(ncol(dt_raw) - 1)], paste0("Most_Common_ATC_Raw_5")))
  rm("dt_max_txns_a5_raw")
  gc()
  print(dim(dt_raw))
  
  print(paste0("[", Sys.time(), "]: ", "      - Most_Common_ATC_Raw_4 ..."))
  dt_max_txns_a4_raw = dt[, .N, by = .(Patient_ID, ATCLevel4Code, Prescription_ID)]
  dt_max_txns_a4_raw = dt_max_txns_a4_raw[, .N, by = .(Patient_ID, ATCLevel4Code)]
  dt_max_txns_a4_raw[, rank := frankv(-N, ties.method = "first"), by = Patient_ID]
  dt_max_txns_a4_raw = dt_max_txns_a4_raw[rank == 1, !c("rank", "N"), with = F]
  dt_raw = merge(dt_raw, dt_max_txns_a4_raw, by = "Patient_ID", all.x = T)
  setnames(dt_raw, names(dt_raw), c(names(dt_raw)[1:(ncol(dt_raw) - 1)], paste0("Most_Common_ATC_Raw_4")))
  rm("dt_max_txns_a4_raw")
  gc()
  print(dim(dt_raw))
  
  print(paste0("[", Sys.time(), "]: ", "      - Max_ATC_Raw_3 ..."))
  dt_max_txns_a3_raw = dt[, .N, by = .(Patient_ID, ATCLevel3Code, Prescription_ID)]
  dt_max_txns_a3_raw = dt_max_txns_a3_raw[, .N, by = .(Patient_ID, ATCLevel3Code)]
  dt_max_txns_a3_raw[, rank := frankv(-N, ties.method = "first"), by = Patient_ID]
  dt_max_txns_a3_raw = dt_max_txns_a3_raw[rank == 1, !c("rank", "N"), with = F]
  dt_raw = merge(dt_raw, dt_max_txns_a3_raw, by = "Patient_ID", all.x = T)
  setnames(dt_raw, names(dt_raw), c(names(dt_raw)[1:(ncol(dt_raw) - 1)], paste0("Most_Common_ATC_Raw_3")))
  rm("dt_max_txns_a3_raw")
  gc()
  print(dim(dt_raw))
  
  print(paste0("[", Sys.time(), "]: ", "      - Most_Common_ATC_Raw_2 ..."))
  dt_max_txns_a2_raw = dt[, .N, by = .(Patient_ID, ATCLevel2Code, Prescription_ID)]
  dt_max_txns_a2_raw = dt_max_txns_a2_raw[, .N, by = .(Patient_ID, ATCLevel2Code)]
  dt_max_txns_a2_raw[, rank := frankv(-N, ties.method = "first"), by = Patient_ID]
  dt_max_txns_a2_raw = dt_max_txns_a2_raw[rank == 1, !c("rank", "N"), with = F]
  dt_raw = merge(dt_raw, dt_max_txns_a2_raw, by = "Patient_ID", all.x = T)
  setnames(dt_raw, names(dt_raw), c(names(dt_raw)[1:(ncol(dt_raw) - 1)], paste0("Most_Common_ATC_Raw_2")))
  rm("dt_max_txns_a2_raw")
  gc()
  print(dim(dt_raw))
  
  print(paste0("[", Sys.time(), "]: ", "      - Most_Common_ATC_1 ..."))
  dt_max_txns_a1_raw = dt[, .N, by = .(Patient_ID, ATCLevel1Code, Prescription_ID)]
  dt_max_txns_a1_raw = dt_max_txns_a1_raw[, .N, by = .(Patient_ID, ATCLevel1Code)]
  dt_max_txns_a1_raw[, rank := frankv(-N, ties.method = "first"), by = Patient_ID]
  dt_max_txns_a1_raw = dt_max_txns_a1_raw[rank == 1, !c("rank", "N"), with = F]
  dt_raw = merge(dt_raw, dt_max_txns_a1_raw, by = "Patient_ID", all.x = T)
  setnames(dt_raw, names(dt_raw), c(names(dt_raw)[1:(ncol(dt_raw) - 1)], paste0("Most_Common_ATC_1")))
  rm("dt_max_txns_a1_raw")
  gc()
  print(dim(dt_raw))
  
  # No...ATC
  print(paste0("[", Sys.time(), "]: ", "    - No...ATC ..."))
  dt_raw = featureEngineer_atc(dt, dt_raw, dt_atc_level)
  print(dim(dt_raw))
  
  return(dt_raw)
}


# Basic Txns Feature Engineering ------------------------------------------


featureEngineer_Txns = function(dt, trainEndDate = "2015-01-01", dt_drug, dt_atc){
  
  print(paste0("[", Sys.time(), "]: ", "Txns Feature Engineering ..."))
  print(dim(dt))
  
  # Preparation -------------------------------------------------------------
  
  print(paste0("[", Sys.time(), "]: ", "  - Preparation ..."))
  print(paste0("[", Sys.time(), "]: ", "    - COPD ..."))
  dt[ChronicIllness == "Chronic Obstructive Pulmonary Disease (COPD)", ChronicIllness := "COPD"]
  
  print(paste0("[", Sys.time(), "]: ", "    - Prescription_ID ..."))
  dt[, Prescription_ID := paste0(Prescriber_ID, "_", as.character(Prescription_Week), "_", Patient_ID)]
  
  print(paste0("[", Sys.time(), "]: ", "    - dt_raw ..."))
  dt_raw = dt[, .(Patient_ID, Target)]
  dt_raw = dt_raw[!duplicated(dt_raw)]
  
  print(paste0("[", Sys.time(), "]: ", "    - illnesses ..."))
  illnesses = c("Hypertension", "Depression", "COPD", "Lipids", "Heart Failure", "Immunology", "Urology"
                , "Epilepsy", "Diabetes", "Anti-Coagulant", "Osteoporosis")
  
  # basic txn ---------------------------------------------------------------
  
  print(paste0("[", Sys.time(), "]: ", "  - Basic Txn Features ..."))
  
  # No_Txns
  print(paste0("[", Sys.time(), "]: ", "    - No_Txns ..."))
  dt_no_txns = dt[, .(No_Txns = .N), by = Patient_ID]
  dt_raw = merge(dt_raw, dt_no_txns, by = "Patient_ID", all.x = T)
  rm("dt_no_txns")
  gc()
  print(dim(dt_raw))
  
  
  # No_Drugs
  print(paste0("[", Sys.time(), "]: ", "    - No_Drugs ..."))
  dt_no_drugs = dt[, .N, by = .(Patient_ID, Drug_ID)][, .(No_Drugs = .N), by = Patient_ID]
  dt_raw = merge(dt_raw, dt_no_drugs, by = "Patient_ID", all.x = T)
  rm("dt_no_drugs")
  gc()
  print(dim(dt_raw))
  
  
  # No_Illnesses
  print(paste0("[", Sys.time(), "]: ", "    - No_Illnesses ..."))
  dt_no_illnesses = dt[, .N, by = .(Patient_ID, ChronicIllness)][, .(No_Illnesseses = .N), by = Patient_ID]
  dt_raw = merge(dt_raw, dt_no_illnesses, by = "Patient_ID", all.x = T)
  rm("dt_no_illnesses")
  gc()
  print(dim(dt_raw))
  
  
  # No_Prescriptions
  print(paste0("[", Sys.time(), "]: ", "    - No_Prescriptions ..."))
  dt_no_prescriptions = dt[, .N, by = .(Patient_ID, Prescription_ID)][, .(No_Prescriptions = .N), by = Patient_ID]
  dt_raw = merge(dt_raw, dt_no_prescriptions, by = "Patient_ID", all.x = T)
  rm("dt_no_prescriptions")
  gc()
  print(dim(dt_raw))
  
  # No_Prescribers
  print(paste0("[", Sys.time(), "]: ", "    - No_Prescribers ..."))
  dt_no_prescribers = dt[, .N, by = .(Patient_ID, Prescriber_ID)][, .(No_Prescribers = .N), by = Patient_ID]
  dt_raw = merge(dt_raw, dt_no_prescribers, by = "Patient_ID", all.x = T)
  rm("dt_no_prescribers")
  gc()
  print(dim(dt_raw))
  
  # No_Stores
  print(paste0("[", Sys.time(), "]: ", "    - No_Stores ..."))
  dt_no_stores = dt[, .N, by = .(Patient_ID, Store_ID)][, .(No_Stores = .N), by = Patient_ID]
  dt_raw = merge(dt_raw, dt_no_stores, by = "Patient_ID", all.x = T)
  rm("dt_no_stores")
  gc()
  print(dim(dt_raw))
  
  # No_DeferredScript
  print(paste0("[", Sys.time(), "]: ", "    - No_DeferredScript ..."))
  dt_no_deferredScript = dt[, .(No_DeferredScript = sum(IsDeferredScript)), by = Patient_ID]
  dt_raw = merge(dt_raw, dt_no_deferredScript, by = "Patient_ID", all.x = T)
  rm("dt_no_deferredScript")
  gc()
  print(dim(dt_raw))
  
  # No_Repeats
  print(paste0("[", Sys.time(), "]: ", "    - No_Repeats ..."))
  dt_no_repeats = dt[, .(No_Repeats = max(RepeatsTotal_Qty)), by = .(Patient_ID, Prescription_ID)][, .(No_Repeats = sum(No_Repeats)), by = Patient_ID]
  dt_raw = merge(dt_raw, dt_no_repeats, by = "Patient_ID", all.x = T)
  rm("dt_no_repeats")
  gc()
  print(dim(dt_raw))
  
  # Ratio_Reclaim_Amount
  print(paste0("[", Sys.time(), "]: ", "    - Ratio_Reclaim_Amount ..."))
  dt_ratio_reclaim_amount = dt[, .(Ratio_Reclaim_Amount = mean(GovernmentReclaim_Amt / (PatientPrice_Amt + WholeSalePrice_Amt))), by = Patient_ID]
  dt_raw = merge(dt_raw, dt_ratio_reclaim_amount, by = "Patient_ID", all.x = T)
  rm("dt_ratio_reclaim_amount")
  gc()
  print(dim(dt_raw))
  
  # Ratio_Reclaim_Amount_Illness
  print(paste0("[", Sys.time(), "]: ", "    - Ratio_Reclaim_Amount_Illness ..."))
  dt_raw = featureEngineer_ratio_reclaim_amount_illness(dt, dt_raw, illnesses)
  print(dim(dt_raw))
  
  # No_Basic_Txns_Illness
  print(paste0("[", Sys.time(), "]: ", "    - No_Basic_Txns_Illness ..."))
  dt_raw = featureEngineer_basic_txn_illness(dt, dt_raw, illnesses)
  print(dim(dt_raw))
  
  # No_Repeats_per_Prescription
  print(paste0("[", Sys.time(), "]: ", "    - No_Repeats_per_Prescription ..."))
  dt_no_repeats_per_prescription = dt[, .(No_Repeats = max(RepeatsTotal_Qty)), by = .(Patient_ID, Prescription_ID)][, .(Avg_No_Repeats = mean(No_Repeats)
                                                                                                                        , Max_No_Repeats = max(No_Repeats)), by = Patient_ID]
  dt_raw = merge(dt_raw, dt_no_repeats_per_prescription, by = "Patient_ID", all.x = T)
  rm("dt_no_repeats_per_prescription")
  gc()
  print(dim(dt_raw))
  
  # No_Drugs_per_Precription
  print(paste0("[", Sys.time(), "]: ", "    - No_Drugs_per_Precription ..."))
  dt_no_drugs_per_prescription = dt[, .N, by = .(Patient_ID, Prescription_ID, Drug_ID)][, .(No_Drugs = .N), by = .(Patient_ID, Prescription_ID)][, .(Avg_No_Drugs = mean(No_Drugs)
                                                                                                                                                     , Max_No_Drugs = max(No_Drugs)), by = Patient_ID]
  dt_raw = merge(dt_raw, dt_no_drugs_per_prescription, by = "Patient_ID", all.x = T)
  rm("dt_no_drugs_per_prescription")
  gc()
  print(dim(dt_raw))
  
  # # Spend_Txn
  # print(paste0("[", Sys.time(), "]: ", "    - Spend_Txn ..."))
  # dt_spend_txn = dt[, .(Spend_Txn_Sum = sum(PatientPrice_Amt, na.rm = T)
  #                       , Spend_Txn_Mean = mean(PatientPrice_Amt, na.rm = T)
  #                       , Spend_Txn_sd = sd(PatientPrice_Amt, na.rm = T)
  #                       , Spend_Txn_median = median(PatientPrice_Amt, na.rm = T)
  #                       , Spend_Txn_max = max(PatientPrice_Amt, na.rm = T)
  #                       , Spend_Txn_min = min(PatientPrice_Amt, na.rm = T)), by = Patient_ID]
  # dt_raw = merge(dt_raw, dt_spend_txn, by = "Patient_ID", all.x = T)
  # rm("dt_spend_txn")
  # gc()
  # print(dim(dt_raw))
  # 
  # # Spend_Prescription
  # print(paste0("[", Sys.time(), "]: ", "    - Spend_Prescription ..."))
  # dt_spend_prescription = dt[, .(PatientPrice_Amt = sum(PatientPrice_Amt, na.rm = T)), by = .(Patient_ID, Prescription_ID)][, .(Spend_Prescription_Sum = sum(PatientPrice_Amt, na.rm = T)
  #                                                                                                                               , Spend_Prescription_Mean = mean(PatientPrice_Amt, na.rm = T)
  #                                                                                                                               , Spend_Prescription_sd = sd(PatientPrice_Amt, na.rm = T)
  #                                                                                                                               , Spend_Prescription_median = median(PatientPrice_Amt, na.rm = T)
  #                                                                                                                               , Spend_Prescription_max = max(PatientPrice_Amt, na.rm = T)
  #                                                                                                                               , Spend_Prescription_min = min(PatientPrice_Amt, na.rm = T)), by = Patient_ID]
  # dt_raw = merge(dt_raw, dt_spend_prescription, by = "Patient_ID", all.x = T)
  # rm("dt_spend_prescription")
  # gc()
  # print(dim(dt_raw))
  # 
  # # Spend_Illness
  # print(paste0("[", Sys.time(), "]: ", "    - Spend_Illness ..."))
  # dt_raw = featureEngineer_Spend_illness(dt, dt_raw, illnesses)
  # print(dim(dt_raw))
  # 
  # 
  # # Price_Txn
  # print(paste0("[", Sys.time(), "]: ", "    - Price_Txn ..."))
  # dt_price_txn = dt[, .(Price_Txn_Sum = sum(WholeSalePrice_Amt, na.rm = T)
  #                       , Price_Txn_Mean = mean(WholeSalePrice_Amt, na.rm = T)
  #                       , Price_Txn_sd = sd(WholeSalePrice_Amt, na.rm = T)
  #                       , Price_Txn_median = median(WholeSalePrice_Amt, na.rm = T)
  #                       , Price_Txn_max = max(WholeSalePrice_Amt, na.rm = T)
  #                       , Price_Txn_min = min(WholeSalePrice_Amt, na.rm = T)), by = Patient_ID]
  # dt_raw = merge(dt_raw, dt_price_txn, by = "Patient_ID", all.x = T)
  # rm("dt_price_txn")
  # gc()
  # print(dim(dt_raw))
  # 
  # # Price_Prescription
  # print(paste0("[", Sys.time(), "]: ", "    - Price_Prescription ..."))
  # dt_price_prescription = dt[, .(WholeSalePrice_Amt = sum(WholeSalePrice_Amt, na.rm = T)), by = .(Patient_ID, Prescription_ID)][, .(Price_Prescription_Sum = sum(WholeSalePrice_Amt, na.rm = T)
  #                                                                                                                               , Price_Prescription_Mean = mean(WholeSalePrice_Amt, na.rm = T)
  #                                                                                                                               , Price_Prescription_sd = sd(WholeSalePrice_Amt, na.rm = T)
  #                                                                                                                               , Price_Prescription_median = median(WholeSalePrice_Amt, na.rm = T)
  #                                                                                                                               , Price_Prescription_max = max(WholeSalePrice_Amt, na.rm = T)
  #                                                                                                                               , Price_Prescription_min = min(WholeSalePrice_Amt, na.rm = T)), by = Patient_ID]
  # dt_raw = merge(dt_raw, dt_price_prescription, by = "Patient_ID", all.x = T)
  # rm("dt_price_prescription")
  # gc()
  # print(dim(dt_raw))
  # 
  # # Price_Illness
  # print(paste0("[", Sys.time(), "]: ", "    - Price_Illness ..."))
  # dt_raw = featureEngineer_Price_illness(dt, dt_raw, illnesses)
  # print(dim(dt_raw))
  # 
  # # Save_Txn
  # print(paste0("[", Sys.time(), "]: ", "    - Save_Txn ..."))
  # dt_save_txn = dt[, .(Save_Txn_Sum = sum(GovernmentReclaim_Amt, na.rm = T)
  #                      , Save_Txn_Mean = mean(GovernmentReclaim_Amt, na.rm = T)
  #                      , Save_Txn_sd = sd(GovernmentReclaim_Amt, na.rm = T)
  #                      , Save_Txn_median = median(GovernmentReclaim_Amt, na.rm = T)
  #                      , Save_Txn_max = max(GovernmentReclaim_Amt, na.rm = T)
  #                      , Save_Txn_min = min(GovernmentReclaim_Amt, na.rm = T)), by = Patient_ID]
  # dt_raw = merge(dt_raw, dt_save_txn, by = "Patient_ID", all.x = T)
  # rm("dt_save_txn")
  # gc()
  # print(dim(dt_raw))
  # 
  # # Save_Prescription
  # print(paste0("[", Sys.time(), "]: ", "    - Save_Prescription ..."))
  # dt_save_prescription = dt[, .(GovernmentReclaim_Amt = sum(GovernmentReclaim_Amt, na.rm = T)), by = .(Patient_ID, Prescription_ID)][, .(Save_Prescription_Sum = sum(GovernmentReclaim_Amt, na.rm = T)
  #                                                                                                                            , Save_Prescription_Mean = mean(GovernmentReclaim_Amt, na.rm = T)
  #                                                                                                                            , Save_Prescription_sd = sd(GovernmentReclaim_Amt, na.rm = T)
  #                                                                                                                            , Save_Prescription_median = median(GovernmentReclaim_Amt, na.rm = T)
  #                                                                                                                            , Save_Prescription_max = max(GovernmentReclaim_Amt, na.rm = T)
  #                                                                                                                            , Save_Prescription_min = min(GovernmentReclaim_Amt, na.rm = T)), by = Patient_ID]
  # dt_raw = merge(dt_raw, dt_save_prescription, by = "Patient_ID", all.x = T)
  # rm("dt_save_prescription")
  # gc()
  # print(dim(dt_raw))
  # 
  # # Save_Illness
  # print(paste0("[", Sys.time(), "]: ", "    - Save_Illness ..."))
  # dt_raw = featureEngineer_Save_illness(dt, dt_raw, illnesses)
  # print(dim(dt_raw))
  
  return(dt_raw)
  
}


# Date Feature Engineering ------------------------------------------------


featureEngineer_Date = function(dt, trainEndDate = "2015-01-01", dt_drug, dt_atc){
  
  print(paste0("[", Sys.time(), "]: ", "Date Feature Engineering ..."))
  print(dim(dt))
  
  # Preparation -------------------------------------------------------------
  
  print(paste0("[", Sys.time(), "]: ", "  - Preparation ..."))
  print(paste0("[", Sys.time(), "]: ", "    - COPD ..."))
  dt[ChronicIllness == "Chronic Obstructive Pulmonary Disease (COPD)", ChronicIllness := "COPD"]
  
  print(paste0("[", Sys.time(), "]: ", "    - Prescription_ID ..."))
  dt[, Prescription_ID := paste0(Prescriber_ID, "_", as.character(Prescription_Week), "_", Patient_ID)]
  
  print(paste0("[", Sys.time(), "]: ", "    - dt_raw ..."))
  dt_raw = dt[, .(Patient_ID, Target)]
  dt_raw = dt_raw[!duplicated(dt_raw)]
  
  print(paste0("[", Sys.time(), "]: ", "    - illnesses ..."))
  illnesses = c("Hypertension", "Depression", "COPD", "Lipids", "Heart Failure", "Immunology", "Urology"
                , "Epilepsy", "Diabetes", "Anti-Coagulant", "Osteoporosis")
  
  # date --------------------------------------------------------------------
  
  print(paste0("[", Sys.time(), "]: ", "  - Date Features ..."))
  print(dim(dt_raw))
  
  # Tenure_Total
  print(paste0("[", Sys.time(), "]: ", "    - Tenure_Total_Dispense ..."))
  dt_tenure_total_dispense = dt[, .(Tenure_Total_Dispense = as.numeric(max(Dispense_Week) - min(Dispense_Week)) / 7), by = Patient_ID]
  dt_raw = merge(dt_raw, dt_tenure_total_dispense, by = "Patient_ID")
  print(paste0("[", Sys.time(), "]: ", "    - Tenure_Total_Prescription ..."))
  dt_tenure_total_prescription = dt[, .(Tenure_Total_Prescription = as.numeric(max(Prescription_Week) - min(Prescription_Week)) / 7), by = Patient_ID]
  dt_raw = merge(dt_raw, dt_tenure_total_prescription, by = "Patient_ID")
  rm(dt_tenure_total_prescription, dt_tenure_total_dispense)
  gc()
  print(dim(dt_raw))
  
  
  # Tenure_Chronic
  print(paste0("[", Sys.time(), "]: ", "    - Tenure_Chronic ..."))
  dt_tenure_chronic = dt[ChronicIllness != "Non-Chronic", .(Tenure_Chronic = as.numeric(max(Dispense_Week) - min(Dispense_Week)) / 7) , by = Patient_ID]
  dt_raw = merge(dt_raw, dt_tenure_chronic, by = "Patient_ID", all.x = T)
  rm("dt_tenure_chronic")
  gc()
  print(dim(dt_raw))
  
  
  # Tenure_NonChronic
  print(paste0("[", Sys.time(), "]: ", "    - Tenure_NonChronic ..."))
  dt_tenure_nonchronic = dt[ChronicIllness == "Non-Chronic", .(Tenure_NonChronic = as.numeric(max(Dispense_Week) - min(Dispense_Week)) / 7) , by = Patient_ID]
  dt_raw = merge(dt_raw, dt_tenure_nonchronic, by = "Patient_ID", all.x = T)
  rm("dt_tenure_nonchronic")
  gc()
  print(dim(dt_raw))
  
  
  # Tenure_Illness
  print(paste0("[", Sys.time(), "]: ", "    - Tenure_Illness ..."))
  dt_raw = featureEngineer_tenure_illness(dt, dt_raw, illnesses)
  print(dim(dt_raw))
  
  
  # Tenure_per_Prescription
  print(paste0("[", Sys.time(), "]: ", "    - Tenure_per_Prescription ..."))
  dt_tenure_per_prescription = dt[, .(Tenure_per_Prescription = as.numeric(max(Dispense_Week) - min(Dispense_Week)) / 7), by = .(Patient_ID, Prescription_ID)][, .(Avg_Tenure_per_Prescription = mean(Tenure_per_Prescription)
                                                                                                                                                                   , Max_Tenure_per_Prescription = max(Tenure_per_Prescription)), by = Patient_ID]
  dt_raw = merge(dt_raw, dt_tenure_per_prescription, by = "Patient_ID", all.x = T)
  rm("dt_tenure_per_prescription")
  gc()
  print(dim(dt_raw))
  
  
  # Tenure_per_Drug
  print(paste0("[", Sys.time(), "]: ", "    - Tenure_per_Drug ..."))
  dt_tenure_per_drug = dt[, .(Tenure_per_Drug = as.numeric(max(Dispense_Week) - min(Dispense_Week)) / 7), by = .(Patient_ID, Drug_ID)][, .(Avg_Tenure_per_Drug = mean(Tenure_per_Drug)
                                                                                                                                           , Max_Tenure_per_Drug = max(Tenure_per_Drug)), by = Patient_ID]
  dt_raw = merge(dt_raw, dt_tenure_per_drug, by = "Patient_ID", all.x = T)
  rm("dt_tenure_per_drug")
  gc()
  print(dim(dt_raw))
  
  
  # Shopping_Density
  print(paste0("[", Sys.time(), "]: ", "    - Shopping_Density ..."))
  dt_shopping_density = dt[, .(Shopping_Density = .N / (as.numeric(max(Dispense_Week) - min(Dispense_Week)) / 7)), by = Patient_ID]
  dt_raw = merge(dt_raw, dt_shopping_density, by = "Patient_ID", all.x = T)
  rm("dt_shopping_density")
  gc()
  print(dim(dt_raw))
  
  
  # Shopping_Density_Illness
  print(paste0("[", Sys.time(), "]: ", "    - Shopping_Density_Illness ..."))
  dt_raw = featureEngineer_shopping_density_illness(dt, dt_raw, illnesses)
  print(dim(dt_raw))
  
  
  # Avg_Days_between_Prescription_Dispense
  print(paste0("[", Sys.time(), "]: ", "    - Avg_Days_between_Prescription_Dispense ..."))
  dt_avg_days_between_prescription_dispense = dt[, .(dbpd = min(as.numeric(Dispense_Week - Prescription_Week) / 7)), by = .(Patient_ID, Prescription_ID)][, .(a_dbpd = mean(dbpd)), by = Patient_ID]
  dt_raw = merge(dt_raw, dt_avg_days_between_prescription_dispense, by = "Patient_ID", all.x = T)
  rm("dt_avg_days_between_prescription_dispense")
  gc()
  print(dim(dt_raw))
  
  
  # Avg_Days_between_Prescription_Dispense_Illness
  print(paste0("[", Sys.time(), "]: ", "    - Avg_Days_between_Prescription_Dispense_Illness ..."))
  dt_raw = featureEngineer_adbpd_illness(dt, dt_raw, illnesses)
  print(dim(dt_raw))
  
  
  # Days_till_End
  print(paste0("[", Sys.time(), "]: ", "    - Days_till_End ..."))
  dt_days_till_end = dt[, .(Max_Dispense_Week = as.numeric(as.Date(trainEndDate) - max(Dispense_Week)) / 7), by = Patient_ID]
  dt_raw = merge(dt_raw, dt_days_till_end, by = "Patient_ID", all.x = T)
  rm("dt_days_till_end")
  gc()
  print(dim(dt_raw))
  
  
  # Days_till_End_Illness
  print(paste0("[", Sys.time(), "]: ", "    - Days_till_End_Illness ..."))
  dt_raw = featureEngineer_days_till_end_illness(dt, dt_raw, illnesses, trainEndDate)
  print(dim(dt_raw))
  
  # IPI_Prescription
  print(paste0("[", Sys.time(), "]: ", "    - IPI_Prescription ..."))
  dt_prescription_week = dt[, .N, by = .(Patient_ID, Prescription_Week)]
  setorderv(dt_prescription_week, c("Patient_ID", "Prescription_Week"))
  dt_prescription_week = dt_prescription_week[, .(IPI = as.numeric(shift(Prescription_Week, type = "lead") - Prescription_Week) / 7), by = Patient_ID]
  dt_prescription_week = dt_prescription_week[, .(IPI_Prescription_Mean = mean(IPI, na.rm = T)
                                                  , IPI_Prescription_sd = sd(IPI, na.rm = T)
                                                  , IPI_Prescription_median = median(IPI, na.rm = T)
                                                  , IPI_Prescription_max = max(IPI, na.rm = T)
                                                  , IPI_Prescription_min = min(IPI, na.rm = T)), by = Patient_ID]
  dt_raw = merge(dt_raw, dt_prescription_week, by = "Patient_ID", all.x = T)
  rm("dt_prescription_week")
  gc()
  print(dim(dt_raw))
  
  # IPI_Txns
  print(paste0("[", Sys.time(), "]: ", "    - IPI_Txns ..."))
  dt_txns_week = dt[, .(Patient_ID, Dispense_Week)]
  setorderv(dt_txns_week, c("Patient_ID", "Dispense_Week"))
  dt_txns_week = dt_txns_week[, .(IPI = as.numeric(shift(Dispense_Week, type = "lead") - Dispense_Week) / 7), by = Patient_ID]
  dt_txns_week = dt_txns_week[, .(IPI_Txns_Mean = mean(IPI, na.rm = T)
                                  , IPI_Txns_sd = sd(IPI, na.rm = T)
                                  , IPI_Txns_median = median(IPI, na.rm = T)
                                  , IPI_Txns_max = max(IPI, na.rm = T)
                                  , IPI_Txns_min = min(IPI, na.rm = T)), by = Patient_ID]
  dt_raw = merge(dt_raw, dt_txns_week, by = "Patient_ID", all.x = T)
  rm("dt_txns_week")
  gc()
  print(dim(dt_raw))
  
  # IPI_Illness
  print(paste0("[", Sys.time(), "]: ", "    - IPI_Illness ..."))
  dt_raw = featureEngineer_IPI_Illness(dt, dt_raw, illnesses)
  print(dim(dt_raw))
  
  
  return(dt_raw)
  
}


# Illness Feature Engineering ---------------------------------------------


featureEngineer_Illness = function(dt, trainEndDate = "2015-01-01", dt_drug, dt_atc){
  
  print(paste0("[", Sys.time(), "]: ", "Illness Feature Engineering ..."))
  print(dim(dt))
  
  # Preparation -------------------------------------------------------------
  
  print(paste0("[", Sys.time(), "]: ", "  - Preparation ..."))
  print(paste0("[", Sys.time(), "]: ", "    - COPD ..."))
  dt[ChronicIllness == "Chronic Obstructive Pulmonary Disease (COPD)", ChronicIllness := "COPD"]
  
  print(paste0("[", Sys.time(), "]: ", "    - Prescription_ID ..."))
  dt[, Prescription_ID := paste0(Prescriber_ID, "_", as.character(Prescription_Week), "_", Patient_ID)]
  
  print(paste0("[", Sys.time(), "]: ", "    - dt_raw ..."))
  dt_raw = dt[, .(Patient_ID, Target)]
  dt_raw = dt_raw[!duplicated(dt_raw)]
  
  print(paste0("[", Sys.time(), "]: ", "    - illnesses ..."))
  illnesses = c("Hypertension", "Depression", "COPD", "Lipids", "Heart Failure", "Immunology", "Urology"
                , "Epilepsy", "Diabetes", "Anti-Coagulant", "Osteoporosis")
  
  
  # Illness -----------------------------------------------------------------
  
  # Most_Common_Illness
  print(paste0("[", Sys.time(), "]: ", "    - Most_Common_Illness ..."))
  dt_illness = dt[ChronicIllness != "Non-Chronic", .N, by = .(Patient_ID, ChronicIllness, Prescription_ID)]
  dt_illness = dt_illness[, .N, by = .(Patient_ID, ChronicIllness)]
  dt_illness[, rank := frankv(-N, ties.method = "first"), by = Patient_ID]
  dt_illness = dt_illness[rank == 1, !c("rank", "N"), with = F]
  dt_raw = merge(dt_raw, dt_illness, by = "Patient_ID", all.x = T)
  setnames(dt_raw, names(dt_raw), c(names(dt_raw)[1:(ncol(dt_raw) - 1)], paste0("Most_Common_Illness")))
  dt_raw[is.na(Most_Common_Illness), Most_Common_Illness := "Non-Chronic"]
  rm("dt_illness")
  gc()
  print(dim(dt_raw))
  
  # Last_Illness
  print(paste0("[", Sys.time(), "]: ", "    - Last_Illness ..."))
  dt_last_illness = dt[, .(Patient_ID, Dispense_Week, ChronicIllness)]
  setorderv(dt_last_illness, c("Patient_ID", "Dispense_Week"))
  dt_last_illness = dt[ChronicIllness != "Non-Chronic", .(Last_Illness = tail(ChronicIllness, 1)), by = .(Patient_ID)]
  dt_raw = merge(dt_raw, dt_last_illness, by = "Patient_ID", all.x = T)
  dt_raw[is.na(Last_Illness), Last_Illness := "Non-Chronic"]
  rm("dt_last_illness")
  gc()
  print(dim(dt_raw))
  
  # First_Illness
  print(paste0("[", Sys.time(), "]: ", "    - First_Illness ..."))
  dt_first_illness = dt[, .(Patient_ID, Dispense_Week, ChronicIllness)]
  setorderv(dt_first_illness, c("Patient_ID", "Dispense_Week"))
  dt_first_illness = dt[ChronicIllness != "Non-Chronic", .(First_Illness = head(ChronicIllness, 1)), by = .(Patient_ID)]
  dt_raw = merge(dt_raw, dt_first_illness, by = "Patient_ID", all.x = T)
  dt_raw[is.na(First_Illness), First_Illness := "Non-Chronic"]
  rm("dt_first_illness")
  gc()
  print(dim(dt_raw))
  
  # I_First_Last_Illness_Same
  dt_raw[, I_First_Last_Illness_Same := ifelse(First_Illness == Last_Illness, 1, 0)]
  
  # I_Most_Common_Last_Illness_Same
  dt_raw[, I_Most_Common_Last_Illness_Same := ifelse(Most_Common_Illness == Last_Illness, 1, 0)]
  
  # I_Most_Common_First_Illness_Same
  dt_raw[, I_Most_Common_First_Illness_Same := ifelse(Most_Common_Illness == First_Illness, 1, 0)]
  
  # I_Most_Common_First_Last_Illness_Same
  dt_raw[, I_Most_Common_First_Illness_Same := I_First_Last_Illness_Same + I_Most_Common_Last_Illness_Same + I_Most_Common_First_Illness_Same]
  
  # Illness_CrossEntropy
  print(paste0("[", Sys.time(), "]: ", "    - Illness_CrossEntropy ..."))
  dt_raw = featureEngineer_crossEntropy(dt[ChronicIllness != "Non-Chronic"], dt_raw, "ChronicIllness")
  print(dim(dt_raw))
  
  return(dt_raw)
}


# Drug Feature Engineering  -----------------------------------------------

featureEngineer_Drug = function(dt, trainEndDate = "2015-01-01", dt_drug, dt_atc){
  
  print(paste0("[", Sys.time(), "]: ", "Drug Feature Engineering ..."))
  print(dim(dt))
  
  # Preparation -------------------------------------------------------------
  
  print(paste0("[", Sys.time(), "]: ", "  - Preparation ..."))
  print(paste0("[", Sys.time(), "]: ", "    - COPD ..."))
  dt[ChronicIllness == "Chronic Obstructive Pulmonary Disease (COPD)", ChronicIllness := "COPD"]
  
  print(paste0("[", Sys.time(), "]: ", "    - Prescription_ID ..."))
  dt[, Prescription_ID := paste0(Prescriber_ID, "_", as.character(Prescription_Week), "_", Patient_ID)]
  
  print(paste0("[", Sys.time(), "]: ", "    - dt_raw ..."))
  dt_raw = dt[, .(Patient_ID, Target)]
  dt_raw = dt_raw[!duplicated(dt_raw)]
  
  print(paste0("[", Sys.time(), "]: ", "    - illnesses ..."))
  illnesses = c("Hypertension", "Depression", "COPD", "Lipids", "Heart Failure", "Immunology", "Urology"
                , "Epilepsy", "Diabetes", "Anti-Coagulant", "Osteoporosis")
  
  
  
  # Drug ---------------------------------------------------------------------
  
  # Most_Common_Drug
  print(paste0("[", Sys.time(), "]: ", "    - Most_Common_Drug ..."))
  dt_drug = dt[, .N, by = .(Patient_ID, Drug_ID, Prescription_ID)]
  dt_drug = dt_drug[, .N, by = .(Patient_ID, Drug_ID)]
  dt_drug[, rank := frankv(-N, ties.method = "first"), by = Patient_ID]
  dt_drug = dt_drug[rank == 1, !c("rank", "N"), with = F]
  dt_raw = merge(dt_raw, dt_drug, by = "Patient_ID", all.x = T)
  setnames(dt_raw, names(dt_raw), c(names(dt_raw)[1:(ncol(dt_raw) - 1)], paste0("Most_Common_Drug")))
  rm("dt_drug")
  gc()
  print(dim(dt_raw))
  
  # Last_Drug
  print(paste0("[", Sys.time(), "]: ", "    - Last_Drug ..."))
  dt_last_drug = dt[, .(Patient_ID, Dispense_Week, Drug_ID)]
  setorderv(dt_last_drug, c("Patient_ID", "Dispense_Week"))
  dt_last_drug = dt[, .(Last_Drug = tail(Drug_ID, 1)), by = .(Patient_ID)]
  dt_raw = merge(dt_raw, dt_last_drug, by = "Patient_ID", all.x = T)
  rm("dt_last_drug")
  gc()
  print(dim(dt_raw))
  
  # First_Drug
  print(paste0("[", Sys.time(), "]: ", "    - First_Drug ..."))
  dt_first_drug = dt[, .(Patient_ID, Dispense_Week, Drug_ID)]
  setorderv(dt_first_drug, c("Patient_ID", "Dispense_Week"))
  dt_first_drug = dt[, .(First_Drug = head(Drug_ID, 1)), by = .(Patient_ID)]
  dt_raw = merge(dt_raw, dt_first_drug, by = "Patient_ID", all.x = T)
  rm("dt_first_drug")
  gc()
  print(dim(dt_raw))
  
  # I_First_Last_Drug_Same
  dt_raw[, I_First_Last_Drug_Same := ifelse(First_Drug == Last_Drug, 1, 0)]
  
  # I_Most_Common_Last_Drug_Same
  dt_raw[, I_Most_Common_Last_Drug_Same := ifelse(Most_Common_Drug == Last_Drug, 1, 0)]
  
  # I_Most_Common_First_Drug_Same
  dt_raw[, I_Most_Common_First_Drug_Same := ifelse(Most_Common_Drug == First_Drug, 1, 0)]
  
  # I_Most_Common_First_Last_Drug_Same
  dt_raw[, I_Most_Common_First_Drug_Same := I_First_Last_Drug_Same + I_Most_Common_Last_Drug_Same + I_Most_Common_First_Drug_Same]
  
  # Drug_CrossEntropy
  print(paste0("[", Sys.time(), "]: ", "    - Drug_CrossEntropy ..."))
  dt_raw = featureEngineer_crossEntropy(dt[ChronicIllness != "Non-Chronic"], dt_raw, "Drug_ID")
  print(dim(dt_raw))
  
  # Ingredient
  # Most_Common_Ingredient
  print(paste0("[", Sys.time(), "]: ", "    - Most_Common_Ingredient ..."))
  dt = merge(dt, dt_drug[, .(MasterProductID, GenericIngredientName)], by.x = "Drug_ID", by.y = "MasterProductID")
  dt_ingredient = dt[ChronicIllness != "Non-Chronic", .N, by = .(Patient_ID, GenericIngredientName, Prescription_ID)]
  dt_ingredient = dt_ingredient[, .N, by = .(Patient_ID, GenericIngredientName)]
  dt_ingredient[, rank := frankv(-N, ties.method = "first"), by = Patient_ID]
  dt_ingredient = dt_ingredient[rank == 1, !c("rank", "N"), with = F]
  dt_raw = merge(dt_raw, dt_ingredient, by = "Patient_ID", all.x = T)
  setnames(dt_raw, names(dt_raw), c(names(dt_raw)[1:(ncol(dt_raw) - 1)], paste0("Most_Common_Ingredient")))
  dt_raw[is.na(Most_Common_Ingredient), Most_Common_Ingredient := "Non-Chronic"]
  rm("dt_ingredient")
  gc()
  print(dim(dt_raw))
  
  # Last_Ingredient
  print(paste0("[", Sys.time(), "]: ", "    - Last_Ingredient ..."))
  dt_last_ingredient = dt[ChronicIllness != "Non-Chronic", .(Patient_ID, Dispense_Week, GenericIngredientName)]
  setorderv(dt_last_ingredient, c("Patient_ID", "Dispense_Week"))
  dt_last_ingredient = dt[, .(Last_Ingredient = tail(GenericIngredientName, 1)), by = .(Patient_ID)]
  dt_raw = merge(dt_raw, dt_last_ingredient, by = "Patient_ID", all.x = T)
  dt_raw[is.na(Last_Ingredient), Last_Ingredient := "Non-Chronic"]
  rm("dt_last_ingredient")
  gc()
  print(dim(dt_raw))
  
  # First_Ingredient
  print(paste0("[", Sys.time(), "]: ", "    - First_Ingredient ..."))
  dt_first_ingredient = dt[ChronicIllness != "Non-Chronic", .(Patient_ID, Dispense_Week, GenericIngredientName)]
  setorderv(dt_first_ingredient, c("Patient_ID", "Dispense_Week"))
  dt_first_ingredient = dt[, .(First_Ingredient = head(GenericIngredientName, 1)), by = .(Patient_ID)]
  dt_raw = merge(dt_raw, dt_first_ingredient, by = "Patient_ID", all.x = T)
  dt_raw[is.na(First_Ingredient), First_Ingredient := "Non-Chronic"]
  rm("dt_first_ingredient")
  gc()
  print(dim(dt_raw))
  
  # I_First_Last_Ingredient_Same
  dt_raw[, I_First_Last_Ingredient_Same := ifelse(First_Ingredient == Last_Ingredient, 1, 0)]
  
  # I_Most_Common_Last_Ingredient_Same
  dt_raw[, I_Most_Common_Last_Ingredient_Same := ifelse(Most_Common_Ingredient == Last_Ingredient, 1, 0)]
  
  # I_Most_Common_First_Ingredient_Same
  dt_raw[, I_Most_Common_First_Ingredient_Same := ifelse(Most_Common_Ingredient == First_Ingredient, 1, 0)]
  
  # I_Most_Common_First_Last_Ingredient_Same
  dt_raw[, I_Most_Common_First_Ingredient_Same := I_First_Last_Ingredient_Same + I_Most_Common_Last_Ingredient_Same + I_Most_Common_First_Ingredient_Same]
  
  # Ingredient_CrossEntropy
  print(paste0("[", Sys.time(), "]: ", "    - Ingredient_CrossEntropy ..."))
  dt_raw = featureEngineer_crossEntropy(dt[ChronicIllness != "Non-Chronic"], dt_raw, "GenericIngredientName")
  print(dim(dt_raw))
  
  return(dt_raw)
  
}


# Patient Feature Engineering ---------------------------------------------

featureEngineer_Patient = function(dt, trainEndDate = "2015-01-01", dt_drug, dt_atc, dt_patient, dt_store){
  
  print(paste0("[", Sys.time(), "]: ", "Patient Feature Engineering ..."))
  print(dim(dt))
  
  # Preparation -------------------------------------------------------------
  
  print(paste0("[", Sys.time(), "]: ", "  - Preparation ..."))
  print(paste0("[", Sys.time(), "]: ", "    - Merge dt_patient ..."))
  dt = merge(dt, dt_patient, by = "Patient_ID")
  
  print(paste0("[", Sys.time(), "]: ", "    - Merge dt_store ..."))
  dt = merge(dt, dt_store, by = "Store_ID")
  
  print(paste0("[", Sys.time(), "]: ", "    - COPD ..."))
  dt[ChronicIllness == "Chronic Obstructive Pulmonary Disease (COPD)", ChronicIllness := "COPD"]
  
  print(paste0("[", Sys.time(), "]: ", "    - Prescription_ID ..."))
  dt[, Prescription_ID := paste0(Prescriber_ID, "_", as.character(Prescription_Week), "_", Patient_ID)]
  
  print(paste0("[", Sys.time(), "]: ", "    - dt_raw ..."))
  dt_raw = dt[, .(Patient_ID, Target)]
  dt_raw = dt_raw[!duplicated(dt_raw)]
  
  print(paste0("[", Sys.time(), "]: ", "    - illnesses ..."))
  illnesses = c("Hypertension", "Depression", "COPD", "Lipids", "Heart Failure", "Immunology", "Urology"
                , "Epilepsy", "Diabetes", "Anti-Coagulant", "Osteoporosis")
  
  
  # Patient  -----------------------------------------------------------------
  
  # Dist_Postcode
  print(paste0("[", Sys.time(), "]: ", "    - Dist_Postcode ..."))
  dt$postcode_patient = as.numeric(dt$postcode_patient)
  dt$postcode_store = as.numeric(dt$postcode_store)
  dt_dist_postcode = dt[, .(Dist_Postcode_Mean = mean(postcode_patient - postcode_store)
                            , Dist_Postcode_sd = sd(postcode_patient - postcode_store)
                            , Dist_Postcode_Median = median(postcode_patient - postcode_store)
                            , Dist_Postcode_Max = max(postcode_patient - postcode_store)
                            , Dist_Postcode_Min = min(postcode_patient - postcode_store)), by = Patient_ID]
  dt_raw = merge(dt_raw, dt_dist_postcode, by = "Patient_ID", all.x = T)
  rm("dt_dist_postcode")
  gc()
  print(dim(dt_raw))
  
  # gender and age
  dt_raw = merge(dt_raw, dt_patient[, .(Patient_ID, gender, year_of_birth)], by = "Patient_ID", all.x = T)
  dt_raw[, Age := as.numeric(substr(trainEndDate, 1, 4)) - year_of_birth]
  dt_raw[, year_of_birth := NULL]
  
  return(dt_raw)
  
}





