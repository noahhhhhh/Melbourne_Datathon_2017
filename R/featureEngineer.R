## Days_till_End_Illness ##
featureEngineer_days_till_end_illness = function(dt, dt_raw, illnesses, trainEndDate){
  
  for(ill in illnesses){
    
    dt_days_till_end__illness = dt[ChronicIllness == ill, .(Max_Dispense_Week = as.numeric(as.Date(trainEndDate) - max(Dispense_Week)) / 7), by = Patient_ID]
    dt_raw = merge(dt_raw, dt_days_till_end__illness, by = "Patient_ID", all.x = T)
    setnames(dt_raw, names(dt_raw), c(names(dt_raw)[1:(ncol(dt_raw) - 1)], paste0("Days_till_End_Illness_", gsub(" |-", "_", ill))))
    
  }
  
  return(dt_raw)
  
}

## Avg_Days_between_Prescription_Dispense_Illness
featureEngineer_adbpd_illness = function(dt, dt_raw, illnesses){
  
  for(ill in illnesses){
    
    dt_avg_days_between_prescription_dispense_illness = dt[ChronicIllness == ill, .(dbpd = min(as.numeric(Dispense_Week - Prescription_Week) / 7)), by = .(Patient_ID, Prescription_ID)][, .(a_dbpd = mean(dbpd)), by = Patient_ID]
    dt_raw = merge(dt_raw, dt_avg_days_between_prescription_dispense_illness, by = "Patient_ID", all.x = T)
    setnames(dt_raw, names(dt_raw), c(names(dt_raw)[1:(ncol(dt_raw) - 1)], paste0("a_dbpd_Illness_", gsub(" |-", "_", ill))))
    
  }
  
  return(dt_raw)
  
  
}

## Tenure_Illnes ##
featureEngineer_tenure_illness = function(dt, dt_raw, illnesses){
  
  for(ill in illnesses){
    
    dt_tenure_illness = dt[ChronicIllness == ill, .(Tenure = (as.numeric(max(Dispense_Week) - min(Dispense_Week)) / 7)), by = Patient_ID]
    dt_raw = merge(dt_raw, dt_tenure_illness, by = "Patient_ID", all.x = T)
    setnames(dt_raw, names(dt_raw), c(names(dt_raw)[1:(ncol(dt_raw) - 1)], paste0("Tenure_Illness_", gsub(" |-", "_", ill))))
    
  }
  
  return(dt_raw)
  
}


## Shopping_Density_Illness ##
featureEngineer_shopping_density_illness = function(dt, dt_raw, illnesses){
  
  for(ill in illnesses){
    
    dt_shopping_density_illness = dt[ChronicIllness == ill, .(Shopping_Density = .N / (as.numeric(max(Dispense_Week) - min(Dispense_Week)) / 7)), by = Patient_ID]
    dt_raw = merge(dt_raw, dt_shopping_density_illness, by = "Patient_ID", all.x = T)
    setnames(dt_raw, names(dt_raw), c(names(dt_raw)[1:(ncol(dt_raw) - 1)], paste0("Shopping_Density_", gsub(" |-", "_", ill))))
    
  }
  
  return(dt_raw)
  
}


featureEngineer = function(dt, trainEndDate = "2015-01-01"){
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
                                                                                                                                                          , Max_TTenure_per_Drug = max(Tenure_per_Drug)), by = Patient_ID]
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
  
  
  
  return(dt_raw)
}







