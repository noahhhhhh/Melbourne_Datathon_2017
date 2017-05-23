
splitData_TimeBased = function(dt_txn, Target = "General", dt_ilness, trainEndDate = "2015-01-01", testEndDate = NULL, splitRatio = NULL){
  
  print(paste0("[", Sys.time(), "]: ", "splitData_TimeBased ..."))
  require(caret)
  require(data.table)
  
  if(is.null(testEndDate)) testEndDate = as.character(max(dt_txn$Dispense_Week) + 1)
  
  # merge illness -----------------------------------------------------------
  
  
  dt_txn = merge(dt_txn, dt_ilness[, .(MasterProductID, ChronicIllness)], by.x = "Drug_ID", by.y = "MasterProductID", all.x = T)
  dt_txn[is.na(ChronicIllness), ChronicIllness := "Non-Chronic"]
  
  
  # pre and post 2014 -------------------------------------------------------
  
  
  dt_txn_pre = dt_txn[Dispense_Week < as.Date(trainEndDate)]
  dt_txn_pos = dt_txn[Dispense_Week >= as.Date(trainEndDate) & Dispense_Week < as.Date(testEndDate)]

  
  # label targets -----------------------------------------------------------
  
  if(Target == "General"){
    
    dt_label = dt_txn_pos[, .(Target = any(ChronicIllness == "Diabetes")), by = .(Patient_ID)]
    dt_label[, Target := ifelse(Target == T, 1, 0)]
    dt_txn_pre = merge(dt_txn_pre, dt_label, by = "Patient_ID", all.x = T)
    dt_txn_pre[is.na(Target), Target := 0]
    dt_label_pre = dt_txn_pre[, .(Target = max(Target)), by = Patient_ID]
    
  }else if(Target == "Lapsing"){
    
    dt_label = data.table(Patient_ID = setdiff(unique(dt_txn_pre$Patient_ID)
                                               , unique(dt_txn_pos$Patient_ID)))
    dt_label[, Target := 1]
    dt_txn_pre = merge(dt_txn_pre, dt_label, by = "Patient_ID", all.x = T)
    dt_txn_pre[is.na(Target), Target := 0]
    dt_label_pre = dt_txn_pre[, .(Target = max(Target)), by = Patient_ID]
    
  }
  
  
  # stratified sampling train, valid, and test ------------------------------
  
  if(sum(splitRatio) != 1) stop("Sum of spliRatio must equal 1")
  y_all = dt_label_pre$Target
  dt_txn_pre[, Target := NULL]
  if(length(splitRatio) == 2){
    
    splitRatio_train = splitRatio[1]
    splitRatio_valid = splitRatio[2]
    
    # createDataPartition
    ind_valid = createDataPartition(y_all, p = splitRatio_valid, list = F)
    dt_valid_label = dt_label_pre[ind_valid]
    dt_train_label = dt_label_pre[-ind_valid]
    dt_test_label = data.table()
    
  }else{
    
    splitRatio_train = splitRatio[1] / (splitRatio[1] + splitRatio[2])
    splitRatio_test = splitRatio[3]
    
    # createDataPartition
    ind_test = createDataPartition(y_all, p = splitRatio_test, list = F)
    dt_test_label = dt_label_pre[ind_test]
    dt_train_valid = dt_label_pre[-ind_test]
    ind_train = createDataPartition(dt_train_valid$Target, p = splitRatio_train, list = F)
    dt_train_label = dt_train_valid[ind_train]
    dt_valid_label = dt_train_valid[-ind_train]
    
  }
  
  dt_train = merge(dt_txn_pre, dt_train_label, by = "Patient_ID")
  dt_valid = merge(dt_txn_pre, dt_valid_label, by = "Patient_ID")
  if(length(dt_test_label) != 0){
    dt_test = merge(dt_txn_pre, dt_test_label, by = "Patient_ID")
  }else{
    dt_test = data.table()
  }
  
  print(paste("dt_train:", dim(dt_train)))
  print(paste("dt_valid:", dim(dt_valid)))
  print(paste("dt_test:", dim(dt_test)))
  
  return(list(dt_train = dt_train
              , dt_valid = dt_valid
              , dt_test = dt_test))
}


splitData_TestSetBased = function(dt_txn, dt_ilness, splitRatio = NULL){
  
  print(paste0("[", Sys.time(), "]: ", "splitDate_TestSetBased ..."))
  require(caret)
  require(data.table)
  
  trainEndDate = "2016-01-01"
  
  # merge illness -----------------------------------------------------------
  
  
  dt_txn = merge(dt_txn, dt_ilness[, .(MasterProductID, ChronicIllness)], by.x = "Drug_ID", by.y = "MasterProductID", all.x = T)
  dt_txn[is.na(ChronicIllness), ChronicIllness := "Non-Chronic"]
  
  
  # pre and post 2014 -------------------------------------------------------
  
  
  dt_txn_pre = dt_txn[Dispense_Week < as.Date(trainEndDate)]
  dt_txn_pos = dt_txn[Dispense_Week >= as.Date(trainEndDate)]
  
  
  # label targets -----------------------------------------------------------
  
  
  dt_label = dt_txn_pos[, .(Target = any(ChronicIllness == "Diabetes")), by = .(Patient_ID)]
  dt_label[, Target := ifelse(Target == T, 1, 0)]
  dt_txn_pre = merge(dt_txn_pre, dt_label, by = "Patient_ID", all.x = T)
  dt_txn_pre[is.na(Target), Target := 0]
  dt_label_pre = dt_txn_pre[, .(Target = max(Target)), by = Patient_ID]
  
  
  # test set ----------------------------------------------------------------
  
  
  dt_test = dt_txn_pre[Patient_ID >= 279201]
  
  
  # stratified sampling train, valid, and test ------------------------------
  
  if(sum(splitRatio) != 1) stop("Sum of spliRatio must equal 1")
  y_all = dt_label_pre[Patient_ID < 279201]$Target
  
  dt_txn_pre[, Target := NULL]

  splitRatio_train = splitRatio[1]
  splitRatio_valid = splitRatio[2]
  
  # createDataPartition
  ind_valid = createDataPartition(y_all, p = splitRatio_valid, list = F)
  dt_valid_label = dt_label_pre[Patient_ID < 279201][ind_valid]
  dt_train_label = dt_label_pre[Patient_ID < 279201][-ind_valid]
    
  dt_train = merge(dt_txn_pre, dt_train_label, by = "Patient_ID")
  dt_valid = merge(dt_txn_pre, dt_valid_label, by = "Patient_ID")
  
  print(paste("dt_train:", dim(dt_train)))
  print(paste("dt_valid:", dim(dt_valid)))
  print(paste("dt_test:", dim(dt_test)))
  
  return(list(dt_train = dt_train
              , dt_valid = dt_valid
              , dt_test = dt_test))
  
}


splitData_year_2016 = function(dt_txn, Target = "General", dt_ilness, splitRatio = NULL, no_of_year = NA){
  
  print(paste0("[", Sys.time(), "]: ", "splitData_year_2016 ..."))
  require(caret)
  require(data.table)
  require(lubridate)
  
  # merge illness -----------------------------------------------------------
  
  
  dt_txn = merge(dt_txn, dt_ilness[, .(MasterProductID, ChronicIllness)], by.x = "Drug_ID", by.y = "MasterProductID", all.x = T)
  dt_txn[is.na(ChronicIllness), ChronicIllness := "Non-Chronic"]
  
  # post 2016 ---------------------------------------------------------------
  
  dt_pos = dt_txn[Dispense_Week >= as.Date("2016-01-01")]
  
  if(!is.na(no_of_year)){
    dt_pre = dt_txn[Dispense_Week >= (as.Date("2016-01-01") - years(no_of_year)) & Dispense_Week < as.Date("2016-01-01")]
  }else{
    dt_pre = dt_txn[Dispense_Week < as.Date("2016-01-01")]
  }
  
  
  # label--------------------------------------------------------------------
  
  dt_pre_label = dt_pos[, .(Target = any(ChronicIllness == "Diabetes")), by = Patient_ID]
  dt_pre_label[, Target := ifelse(Target == T, 1, 0)]
  dt_pre = merge(dt_pre, dt_pre_label, by = "Patient_ID", all.x = T)
  dt_pre[is.na(Target), Target := 0]
  
  # split -------------------------------------------------------------------
  
  dt_test = dt_pre[Patient_ID >= 279201 & Patient_ID <= 558352]
  dt_train = dt_pre[Patient_ID < 279201]
  
  print(paste("dt_train:", dim(dt_train)))
  print(paste("dt_test:", dim(dt_test)))
  
  return(list(dt_train = dt_train
              , dt_test = dt_test))
  
}


splitData_year = function(dt_txn, Target = "General", dt_ilness, splitRatio = NULL, years = NULL, no_of_year = NA){
  
  print(paste0("[", Sys.time(), "]: ", "splitData_year ...", no_of_year))
  require(caret)
  require(data.table)
  require(lubridate)
  
  
  # merge illness -----------------------------------------------------------
  
  
  dt_txn = merge(dt_txn, dt_ilness[, .(MasterProductID, ChronicIllness)], by.x = "Drug_ID", by.y = "MasterProductID", all.x = T)
  dt_txn[is.na(ChronicIllness), ChronicIllness := "Non-Chronic"]
  
  # pre and pos -------------------------------------------------------------
  
  if(is.null(years)){
    
    years = c("2013-01-01", "2014-01-01", "2015-01-01")
    
  }
  dt_trains = data.table()
  dt_valids = data.table()
  
  for(year in years){
    
    dt_pos = dt_txn[Dispense_Week >= as.Date(year) & Dispense_Week < (as.Date(year) + years(1) + months(4))]
    
    if(!is.na(no_of_year)){
      dt_pre = dt_txn[Dispense_Week >= (as.Date(year) - years(no_of_year)) & Dispense_Week < as.Date(year)]
    }else{
      dt_pre = dt_txn[Dispense_Week < as.Date(year)]
    }
    
    
    # label--------------------------------------------------------------------
    
    dt_pre_label = dt_pos[, .(Target = any(ChronicIllness == "Diabetes")), by = Patient_ID]
    dt_pre_label[, Target := ifelse(Target == T, 1, 0)]
    dt_pre = merge(dt_pre, dt_pre_label, by = "Patient_ID", all.x = T)
    dt_pre[is.na(Target), Target := 0]

  }
  
  return(list(dt_train = dt_pre))
  
}

