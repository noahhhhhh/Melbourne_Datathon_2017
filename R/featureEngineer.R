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
  
  # ATCLevel5Code_Raw
  print(paste0("[", Sys.time(), "]: ", "      - ATCLevel5Code_Raw ..."))
  for(a5 in unique(dt_atc_level$ATCLevel5Code)){
    
    dt_no_txns_a5_raw = dt[ATCLevel5Code == a5, (No_Txns_ATC5_Raw = .N), by = Patient_ID]
    dt_tenure_a5_raw = dt[ATCLevel5Code == a5, .(Tenure_ATC5_Raw = (as.numeric(max(Dispense_Week) - min(Dispense_Week)) / 7)), by = Patient_ID]
    dt_no_drugs_a5_raw = dt[ATCLevel5Code == a5, .N, by = .(Patient_ID, Drug_ID)][, .(No_Drugs_ATC5_Raw = .N), by = Patient_ID]
    dt_no_illnesses_a5_raw = dt[ATCLevel5Code == a5, .N, by = .(Patient_ID, ChronicIllness)][, .(No_Illnesses_ATC5_Raw = .N), by = Patient_ID]
    
    
    dt_raw = merge(dt_raw, dt_no_txns_a5_raw, by = "Patient_ID", all.x = T)
    setnames(dt_raw, names(dt_raw), c(names(dt_raw)[1:(ncol(dt_raw) - 1)], paste0("No_Txns_ATC5_Raw_", gsub(" |-", "_", a5))))
    dt_raw = merge(dt_raw, dt_tenure_a5_raw, by = "Patient_ID", all.x = T)
    setnames(dt_raw, names(dt_raw), c(names(dt_raw)[1:(ncol(dt_raw) - 1)], paste0("Tenure_ATC5_Raw_", gsub(" |-", "_", a5))))
    dt_raw = merge(dt_raw, dt_no_drugs_a5_raw, by = "Patient_ID", all.x = T)
    setnames(dt_raw, names(dt_raw), c(names(dt_raw)[1:(ncol(dt_raw) - 1)], paste0("No_Drugs_ATC5_Raw_", gsub(" |-", "_", a5))))
    dt_raw = merge(dt_raw, dt_no_illnesses_a5_raw, by = "Patient_ID", all.x = T)
    setnames(dt_raw, names(dt_raw), c(names(dt_raw)[1:(ncol(dt_raw) - 1)], paste0("No_Illnesses_ATC5_Raw_", gsub(" |-", "_", a5))))
    
  }
  
  # ATCLevel4Code_Raw
  print(paste0("[", Sys.time(), "]: ", "      - ATCLevel4Code_Raw ..."))
  for(a4 in unique(dt_atc_level$ATCLevel4Code)){
    
    dt_no_txns_a4_raw = dt[ATCLevel4Code == a4, (No_Txns_ATC4_Raw = .N), by = Patient_ID]
    dt_tenure_a4_raw = dt[ATCLevel4Code == a4, .(Tenure_ATC4_Raw = (as.numeric(max(Dispense_Week) - min(Dispense_Week)) / 7)), by = Patient_ID]
    dt_no_drugs_a4_raw = dt[ATCLevel4Code == a4, .N, by = .(Patient_ID, Drug_ID)][, .(No_Drugs_ATC4_Raw = .N), by = Patient_ID]
    dt_no_illnesses_a4_raw = dt[ATCLevel4Code == a4, .N, by = .(Patient_ID, ChronicIllness)][, .(No_Illnesses_ATC4_Raw = .N), by = Patient_ID]
    
    
    dt_raw = merge(dt_raw, dt_no_txns_a4_raw, by = "Patient_ID", all.x = T)
    setnames(dt_raw, names(dt_raw), c(names(dt_raw)[1:(ncol(dt_raw) - 1)], paste0("No_Txns_ATC4_Raw_", gsub(" |-", "_", a4))))
    dt_raw = merge(dt_raw, dt_tenure_a4_raw, by = "Patient_ID", all.x = T)
    setnames(dt_raw, names(dt_raw), c(names(dt_raw)[1:(ncol(dt_raw) - 1)], paste0("Tenure_ATC4_Raw_", gsub(" |-", "_", a4))))
    dt_raw = merge(dt_raw, dt_no_drugs_a4_raw, by = "Patient_ID", all.x = T)
    setnames(dt_raw, names(dt_raw), c(names(dt_raw)[1:(ncol(dt_raw) - 1)], paste0("No_Drugs_ATC4_Raw_", gsub(" |-", "_", a4))))
    dt_raw = merge(dt_raw, dt_no_illnesses_a4_raw, by = "Patient_ID", all.x = T)
    setnames(dt_raw, names(dt_raw), c(names(dt_raw)[1:(ncol(dt_raw) - 1)], paste0("No_Illnesses_ATC4_Raw_", gsub(" |-", "_", a4))))
    
  }
  
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
  
  return(dt_raw)
  
}

## Ratio_Reclaim_Amount_Illness ##
featureEngineer_ratio_reclaim_amount_illness = function(dt, dt_raw, illnesses){
  
  for(ill in illnesses){
    
    dt_ratio_reclaim_amount_illness = dt[ChronicIllness == ill, .(Ratio_Reclaim_Amount_Illness = mean(GovernmentReclaim_Amt / (PatientPrice_Amt + WholeSalePrice_Amt))), by = Patient_ID]
    dt_raw = merge(dt_raw, dt_ratio_reclaim_amount_illness, by = "Patient_ID", all.x = T)
    setnames(dt_raw, names(dt_raw), c(names(dt_raw)[1:(ncol(dt_raw) - 1)], paste0("Ratio_Reclaim_Amount_Illness_", gsub(" |-", "_", ill))))
    
  }
  
  return(dt_raw)
  return(dt_raw)
  
}

## Days_till_End_Illness ##
featureEngineer_days_till_end_illness = function(dt, dt_raw, illnesses, trainEndDate){
  
  for(ill in illnesses){
    
    dt_days_till_end__illness = dt[ChronicIllness == ill, .(Max_Dispense_Week_Illness = as.numeric(as.Date(trainEndDate) - max(Dispense_Week)) / 7), by = Patient_ID]
    dt_raw = merge(dt_raw, dt_days_till_end__illness, by = "Patient_ID", all.x = T)
    setnames(dt_raw, names(dt_raw), c(names(dt_raw)[1:(ncol(dt_raw) - 1)], paste0("Days_till_End_Illness_", gsub(" |-", "_", ill))))
    
  }
  
  return(dt_raw)
  
}

## Avg_Days_between_Prescription_Dispense_Illness
featureEngineer_adbpd_illness = function(dt, dt_raw, illnesses){
  
  for(ill in illnesses){
    
    dt_avg_days_between_prescription_dispense_illness = dt[ChronicIllness == ill, .(dbpd_illness = min(as.numeric(Dispense_Week - Prescription_Week) / 7)), by = .(Patient_ID, Prescription_ID)][, .(a_dbpd_illness = mean(dbpd_illness)), by = Patient_ID]
    dt_raw = merge(dt_raw, dt_avg_days_between_prescription_dispense_illness, by = "Patient_ID", all.x = T)
    setnames(dt_raw, names(dt_raw), c(names(dt_raw)[1:(ncol(dt_raw) - 1)], paste0("a_dbpd_Illness_", gsub(" |-", "_", ill))))
    
  }
  
  return(dt_raw)
  
  
}

## Tenure_Illnes ##
featureEngineer_tenure_illness = function(dt, dt_raw, illnesses){
  
  for(ill in illnesses){
    
    dt_tenure_illness = dt[ChronicIllness == ill, .(Tenure_Illness = (as.numeric(max(Dispense_Week) - min(Dispense_Week)) / 7)), by = Patient_ID]
    dt_raw = merge(dt_raw, dt_tenure_illness, by = "Patient_ID", all.x = T)
    setnames(dt_raw, names(dt_raw), c(names(dt_raw)[1:(ncol(dt_raw) - 1)], paste0("Tenure_Illness_", gsub(" |-", "_", ill))))
    
  }
  
  return(dt_raw)
  
}


## Shopping_Density_Illness ##
featureEngineer_shopping_density_illness = function(dt, dt_raw, illnesses){
  
  for(ill in illnesses){
    
    dt_shopping_density_illness = dt[ChronicIllness == ill, .(Shopping_Density_Illness = .N / (as.numeric(max(Dispense_Week) - min(Dispense_Week)) / 7)), by = Patient_ID]
    dt_raw = merge(dt_raw, dt_shopping_density_illness, by = c("Patient_ID"), all.x = T)
    setnames(dt_raw, names(dt_raw), c(names(dt_raw)[1:(ncol(dt_raw) - 1)], paste0("Shopping_Density_", gsub(" |-", "_", ill))))
    
  }
  
  return(dt_raw)
  
}


featureEngineer = function(dt, trainEndDate = "2015-01-01", dt_drug, dt_atc){
  print(paste0("[", Sys.time(), "]: ", "Feature Engineering ..."))
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
  
  # No_ATC
  print(paste0("[", Sys.time(), "]: ", "    - No_ATC ..."))
  print(paste0("[", Sys.time(), "]: ", "      - No_ATC_Sub_5 ..."))
  dt_no_a5_sub = dt[, .N, by = .(Patient_ID, ATCLevel5Code_Sub)][, .(No_ATC5_Sub = .N), by = Patient_ID]
  dt_raw = merge(dt_raw, dt_no_a5_sub, by = "Patient_ID", all.x = T)
  print(dim(dt_raw))
  
  print(paste0("[", Sys.time(), "]: ", "      - No_ATC_Sub_4 ..."))
  dt_no_a4_sub = dt[, .N, by = .(Patient_ID, ATCLevel4Code_Sub)][, .(No_ATC4_Sub = .N), by = Patient_ID]
  dt_raw = merge(dt_raw, dt_no_a4_sub, by = "Patient_ID", all.x = T)
  print(dim(dt_raw))
  
  print(paste0("[", Sys.time(), "]: ", "      - No_ATC_Sub_3 ..."))
  dt_no_a3_sub = dt[, .N, by = .(Patient_ID, ATCLevel3Code_Sub)][, .(No_ATC3_Sub = .N), by = Patient_ID]
  dt_raw = merge(dt_raw, dt_no_a3_sub, by = "Patient_ID", all.x = T)
  print(dim(dt_raw))
  
  print(paste0("[", Sys.time(), "]: ", "      - No_ATC_Sub_2 ..."))
  dt_no_a2_sub = dt[, .N, by = .(Patient_ID, ATCLevel2Code_Sub)][, .(No_ATC2_Sub = .N), by = Patient_ID]
  dt_raw = merge(dt_raw, dt_no_a2_sub, by = "Patient_ID", all.x = T)
  print(dim(dt_raw))
  
  print(paste0("[", Sys.time(), "]: ", "      - No_ATC_Raw_5 ..."))
  dt_no_a5_raw = dt[, .N, by = .(Patient_ID, ATCLevel5Code)][, .(No_ATC5_Raw = .N), by = Patient_ID]
  dt_raw = merge(dt_raw, dt_no_a5_raw, by = "Patient_ID", all.x = T)
  print(dim(dt_raw))
  
  print(paste0("[", Sys.time(), "]: ", "      - No_ATC_Raw_4 ..."))
  dt_no_a4_raw = dt[, .N, by = .(Patient_ID, ATCLevel4Code)][, .(No_ATC4_Raw = .N), by = Patient_ID]
  dt_raw = merge(dt_raw, dt_no_a4_raw, by = "Patient_ID", all.x = T)
  print(dim(dt_raw))
  
  print(paste0("[", Sys.time(), "]: ", "      - No_ATC_Raw_3 ..."))
  dt_no_a3_raw = dt[, .N, by = .(Patient_ID, ATCLevel3Code)][, .(No_ATC3_Raw = .N), by = Patient_ID]
  dt_raw = merge(dt_raw, dt_no_a3_raw, by = "Patient_ID", all.x = T)
  print(dim(dt_raw))
  
  print(paste0("[", Sys.time(), "]: ", "      - No_ATC_Raw_2 ..."))
  dt_no_a2_raw = dt[, .N, by = .(Patient_ID, ATCLevel2Code)][, .(No_ATC2_Raw = .N), by = Patient_ID]
  dt_raw = merge(dt_raw, dt_no_a2_raw, by = "Patient_ID", all.x = T)
  print(dim(dt_raw))
  
  print(paste0("[", Sys.time(), "]: ", "      - No_ATC_1 ..."))
  dt_no_a1 = dt[, .N, by = .(Patient_ID, ATCLevel1Code)][, .(No_ATC1_Raw = .N), by = Patient_ID]
  dt_raw = merge(dt_raw, dt_no_a1, by = "Patient_ID", all.x = T)
  print(dim(dt_raw))
  
  
  # Max_No_ATC
  print(paste0("[", Sys.time(), "]: ", "    - Max_ATC ..."))
  print(paste0("[", Sys.time(), "]: ", "      - Max_ATC_Sub_5 ..."))
  dt_max_txns_a5_sub = dt[, .N, by = .(Patient_ID, ATCLevel5Code_Sub)]
  dt_max_txns_a5_sub[, rank := frankv(-N, ties.method = "first"), by = Patient_ID]
  dt_max_txns_a5_sub = dt_max_txns_a5_sub[rank == 1, !c("rank", "N"), with = F]
  dt_raw = merge(dt_raw, dt_max_txns_a5_sub, by = "Patient_ID", all.x = T)
  print(dim(dt_raw))
  
  print(paste0("[", Sys.time(), "]: ", "      - Max_ATC_Sub_4 ..."))
  dt_max_txns_a4_sub = dt[, .N, by = .(Patient_ID, ATCLevel4Code_Sub)]
  dt_max_txns_a4_sub[, rank := frankv(-N, ties.method = "first"), by = Patient_ID]
  dt_max_txns_a4_sub = dt_max_txns_a4_sub[rank == 1, !c("rank", "N"), with = F]
  dt_raw = merge(dt_raw, dt_max_txns_a4_sub, by = "Patient_ID", all.x = T)
  print(dim(dt_raw))
  
  print(paste0("[", Sys.time(), "]: ", "      - Max_ATC_Sub_3 ..."))
  dt_max_txns_a3_sub = dt[, .N, by = .(Patient_ID, ATCLevel3Code_Sub)]
  dt_max_txns_a3_sub[, rank := frankv(-N, ties.method = "first"), by = Patient_ID]
  dt_max_txns_a3_sub = dt_max_txns_a3_sub[rank == 1, !c("rank", "N"), with = F]
  dt_raw = merge(dt_raw, dt_max_txns_a3_sub, by = "Patient_ID", all.x = T)
  print(dim(dt_raw))
  
  print(paste0("[", Sys.time(), "]: ", "      - Max_ATC_Sub_2 ..."))
  dt_max_txns_a2_sub = dt[, .N, by = .(Patient_ID, ATCLevel2Code_Sub)]
  dt_max_txns_a2_sub[, rank := frankv(-N, ties.method = "first"), by = Patient_ID]
  dt_max_txns_a2_sub = dt_max_txns_a2_sub[rank == 1, !c("rank", "N"), with = F]
  dt_raw = merge(dt_raw, dt_max_txns_a2_sub, by = "Patient_ID", all.x = T)
  print(dim(dt_raw))
  
  print(paste0("[", Sys.time(), "]: ", "      - Max_ATC_Raw_5 ..."))
  dt_max_txns_a5_raw = dt[, .N, by = .(Patient_ID, ATCLevel5Code)]
  dt_max_txns_a5_raw[, rank := frankv(-N, ties.method = "first"), by = Patient_ID]
  dt_max_txns_a5_raw = dt_max_txns_a5_raw[rank == 1, !c("rank", "N"), with = F]
  dt_raw = merge(dt_raw, dt_max_txns_a5_raw, by = "Patient_ID", all.x = T)
  print(dim(dt_raw))
  
  print(paste0("[", Sys.time(), "]: ", "      - Max_ATC_Raw_4 ..."))
  dt_max_txns_a4_raw = dt[, .N, by = .(Patient_ID, ATCLevel4Code)]
  dt_max_txns_a4_raw[, rank := frankv(-N, ties.method = "first"), by = Patient_ID]
  dt_max_txns_a4_raw = dt_max_txns_a4_raw[rank == 1, !c("rank", "N"), with = F]
  dt_raw = merge(dt_raw, dt_max_txns_a4_raw, by = "Patient_ID", all.x = T)
  print(dim(dt_raw))
  
  print(paste0("[", Sys.time(), "]: ", "      - Max_ATC_Raw_3 ..."))
  dt_max_txns_a3_raw = dt[, .N, by = .(Patient_ID, ATCLevel3Code)]
  dt_max_txns_a3_raw[, rank := frankv(-N, ties.method = "first"), by = Patient_ID]
  dt_max_txns_a3_raw = dt_max_txns_a3_raw[rank == 1, !c("rank", "N"), with = F]
  dt_raw = merge(dt_raw, dt_max_txns_a3_raw, by = "Patient_ID", all.x = T)
  print(dim(dt_raw))
  
  print(paste0("[", Sys.time(), "]: ", "      - Max_ATC_Raw_2 ..."))
  dt_max_txns_a2_raw = dt[, .N, by = .(Patient_ID, ATCLevel2Code)]
  dt_max_txns_a2_raw[, rank := frankv(-N, ties.method = "first"), by = Patient_ID]
  dt_max_txns_a2_raw = dt_max_txns_a2_raw[rank == 1, !c("rank", "N"), with = F]
  dt_raw = merge(dt_raw, dt_max_txns_a2_raw, by = "Patient_ID", all.x = T)
  print(dim(dt_raw))
  
  print(paste0("[", Sys.time(), "]: ", "      - Max_ATC_1 ..."))
  dt_max_txns_a1_raw = dt[, .N, by = .(Patient_ID, ATCLevel1Code)]
  dt_max_txns_a1_raw[, rank := frankv(-N, ties.method = "first"), by = Patient_ID]
  dt_max_txns_a1_raw = dt_max_txns_a1_raw[rank == 1, !c("rank", "N"), with = F]
  dt_raw = merge(dt_raw, dt_max_txns_a1_raw, by = "Patient_ID", all.x = T)
  print(dim(dt_raw))
  
  # No...ATC
  print(paste0("[", Sys.time(), "]: ", "    - No...ATC ..."))
  dt_raw = featureEngineer_atc(dt, dt_raw, dt_atc_level)
  print(dim(dt_raw))
  
  
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
  print(dim(dt_raw))
  
  
  # Tenure_Chronic
  print(paste0("[", Sys.time(), "]: ", "    - Tenure_Chronic ..."))
  dt_tenure_chronic = dt[ChronicIllness != "Non-Chronic", .(Tenure_Chronic = as.numeric(max(Dispense_Week) - min(Dispense_Week)) / 7) , by = Patient_ID]
  dt_raw = merge(dt_raw, dt_tenure_chronic, by = "Patient_ID", all.x = T)
  print(dim(dt_raw))
  
  
  # Tenure_NonChronic
  print(paste0("[", Sys.time(), "]: ", "    - Tenure_NonChronic ..."))
  dt_tenure_nonchronic = dt[ChronicIllness == "Non-Chronic", .(Tenure_NonChronic = as.numeric(max(Dispense_Week) - min(Dispense_Week)) / 7) , by = Patient_ID]
  dt_raw = merge(dt_raw, dt_tenure_nonchronic, by = "Patient_ID", all.x = T)
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
  print(dim(dt_raw))
  
  
  # Tenure_per_Drug
  print(paste0("[", Sys.time(), "]: ", "    - Tenure_per_Drug ..."))
  dt_tenure_per_drug = dt[, .(Tenure_per_Drug = as.numeric(max(Dispense_Week) - min(Dispense_Week)) / 7), by = .(Patient_ID, Drug_ID)][, .(Avg_Tenure_per_Drug = mean(Tenure_per_Drug)
                                                                                                                                                          , Max_Tenure_per_Drug = max(Tenure_per_Drug)), by = Patient_ID]
  dt_raw = merge(dt_raw, dt_tenure_per_drug, by = "Patient_ID", all.x = T)
  print(dim(dt_raw))
  
  
  # Shopping_Density
  print(paste0("[", Sys.time(), "]: ", "    - Shopping_Density ..."))
  dt_shopping_density = dt[, .(Shopping_Density = .N / (as.numeric(max(Dispense_Week) - min(Dispense_Week)) / 7)), by = Patient_ID]
  dt_raw = merge(dt_raw, dt_shopping_density, by = "Patient_ID", all.x = T)
  print(dim(dt_raw))
  
  
  # Shopping_Density_Illness
  print(paste0("[", Sys.time(), "]: ", "    - Shopping_Density_Illness ..."))
  dt_raw = featureEngineer_shopping_density_illness(dt, dt_raw, illnesses)
  print(dim(dt_raw))
  

  # Avg_Days_between_Prescription_Dispense
  print(paste0("[", Sys.time(), "]: ", "    - Avg_Days_between_Prescription_Dispense ..."))
  dt_avg_days_between_prescription_dispense = dt[, .(dbpd = min(as.numeric(Dispense_Week - Prescription_Week) / 7)), by = .(Patient_ID, Prescription_ID)][, .(a_dbpd = mean(dbpd)), by = Patient_ID]
  dt_raw = merge(dt_raw, dt_avg_days_between_prescription_dispense, by = "Patient_ID", all.x = T)
  print(dim(dt_raw))
  
  
  # Avg_Days_between_Prescription_Dispense_Illness
  print(paste0("[", Sys.time(), "]: ", "    - Avg_Days_between_Prescription_Dispense_Illness ..."))
  dt_raw = featureEngineer_adbpd_illness(dt, dt_raw, illnesses)
  print(dim(dt_raw))
  
  
  # Days_till_End
  print(paste0("[", Sys.time(), "]: ", "    - Days_till_End ..."))
  dt_days_till_end = dt[, .(Max_Dispense_Week = as.numeric(as.Date(trainEndDate) - max(Dispense_Week)) / 7), by = Patient_ID]
  dt_raw = merge(dt_raw, dt_days_till_end, by = "Patient_ID", all.x = T)
  print(dim(dt_raw))
  
  
  # Days_till_End_Illness
  print(paste0("[", Sys.time(), "]: ", "    - Days_till_End_Illness ..."))
  dt_raw = featureEngineer_days_till_end_illness(dt, dt_raw, illnesses, trainEndDate)
  print(dim(dt_raw))
  
  
  
  # basic txn ---------------------------------------------------------------
  
  print(paste0("[", Sys.time(), "]: ", "  - Basic Txn Features ..."))
  
  # No_Txns
  print(paste0("[", Sys.time(), "]: ", "    - No_Txns ..."))
  dt_no_txns = dt[, .(No_Txns = .N), by = Patient_ID]
  dt_raw = merge(dt_raw, dt_no_txns, by = "Patient_ID", all.x = T)
  print(dim(dt_raw))
  
  
  # No_Drugs
  print(paste0("[", Sys.time(), "]: ", "    - No_Drugs ..."))
  dt_no_drugs = dt[, .N, by = .(Patient_ID, Drug_ID)][, .(No_Drugs = .N), by = Patient_ID]
  dt_raw = merge(dt_raw, dt_no_drugs, by = "Patient_ID", all.x = T)
  print(dim(dt_raw))
  
  
  # No_Illnesses
  print(paste0("[", Sys.time(), "]: ", "    - No_Illnesses ..."))
  dt_no_illnesses = dt[, .N, by = .(Patient_ID, ChronicIllness)][, .(No_Illnesseses = .N), by = Patient_ID]
  dt_raw = merge(dt_raw, dt_no_illnesses, by = "Patient_ID", all.x = T)
  print(dim(dt_raw))
  
  
  # No_Prescriptions
  print(paste0("[", Sys.time(), "]: ", "    - No_Prescriptions ..."))
  dt_no_prescriptions = dt[, .N, by = .(Patient_ID, Prescription_ID)][, .(No_Prescriptions = .N), by = Patient_ID]
  dt_raw = merge(dt_raw, dt_no_prescriptions, by = "Patient_ID", all.x = T)
  print(dim(dt_raw))
  
  # No_Prescribers
  print(paste0("[", Sys.time(), "]: ", "    - No_Prescribers ..."))
  dt_no_prescribers = dt[, .N, by = .(Patient_ID, Prescriber_ID)][, .(No_Prescribers = .N), by = Patient_ID]
  dt_raw = merge(dt_raw, dt_no_prescribers, by = "Patient_ID", all.x = T)
  print(dim(dt_raw))
  
  # No_Stores
  print(paste0("[", Sys.time(), "]: ", "    - No_Stores ..."))
  dt_no_stores = dt[, .N, by = .(Patient_ID, Store_ID)][, .(No_Stores = .N), by = Patient_ID]
  dt_raw = merge(dt_raw, dt_no_stores, by = "Patient_ID", all.x = T)
  print(dim(dt_raw))
  
  # No_DeferredScript
  print(paste0("[", Sys.time(), "]: ", "    - No_DeferredScript ..."))
  dt_no_deferredScript = dt[, .(No_DeferredScript = sum(IsDeferredScript)), by = Patient_ID]
  dt_raw = merge(dt_raw, dt_no_deferredScript, by = "Patient_ID", all.x = T)
  print(dim(dt_raw))
  
  # No_Repeats
  print(paste0("[", Sys.time(), "]: ", "    - No_Repeats ..."))
  dt_no_repeats = dt[, .(No_Repeats = max(RepeatsTotal_Qty)), by = .(Patient_ID, Prescription_ID)][, .(No_Repeats = sum(No_Repeats)), by = Patient_ID]
  dt_raw = merge(dt_raw, dt_no_repeats, by = "Patient_ID", all.x = T)
  print(dim(dt_raw))
  
  # Ratio_Reclaim_Amount
  print(paste0("[", Sys.time(), "]: ", "    - Ratio_Reclaim_Amount ..."))
  dt_ratio_reclaim_amount = dt[, .(Ratio_Reclaim_Amount = mean(GovernmentReclaim_Amt / (PatientPrice_Amt + WholeSalePrice_Amt))), by = Patient_ID]
  dt_raw = merge(dt_raw, dt_ratio_reclaim_amount, by = "Patient_ID", all.x = T)
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
  print(dim(dt_raw))
  
  # No_Drugs_per_Precription
  print(paste0("[", Sys.time(), "]: ", "    - No_Drugs_per_Precription ..."))
  dt_no_drugs_per_prescription = dt[, .N, by = .(Patient_ID, Prescription_ID, Drug_ID)][, .(No_Drugs = .N), by = .(Patient_ID, Prescription_ID)][, .(Avg_No_Drugs = mean(No_Drugs)
                                                                                                                                                     , Max_No_Drugs = max(No_Drugs)), by = Patient_ID]
  dt_raw = merge(dt_raw, dt_no_drugs_per_prescription, by = "Patient_ID", all.x = T)
  print(dim(dt_raw))
  

  
  return(dt_raw)
}










