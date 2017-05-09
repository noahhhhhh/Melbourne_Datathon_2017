
splitData_TimeBased = function(dt_txn, trainEndDate = "2015-01-01", testEndDate = NULL, splitRatio = c(.4, .1, .5)){
  print(paste0("[", Sys.time(), "]: ", "splitData_TimeBased ..."))
  require(caret)
  
  if(is.null(testEndDate)) testEndDate = as.character(max(dt_txn$Dispense_Week) + 1)
  
  # merge illness -----------------------------------------------------------
  
  
  dt_txn = merge(dt_txn, dt_ilness[, .(MasterProductID, ChronicIllness)], by.x = "Drug_ID", by.y = "MasterProductID", all.x = T)
  dt_txn[is.na(ChronicIllness), ChronicIllness := "Non-Chronic"]
  
  
  # pre and post 2014 -------------------------------------------------------
  
  
  dt_txn_pre = dt_txn[Dispense_Week < as.Date(trainEndDate)]
  dt_txn_pos = dt_txn[Dispense_Week >= as.Date(trainEndDate) & Dispense_Week < as.Date(testEndDate)]

  
  # label targets -----------------------------------------------------------
  
  
  dt_label = dt_txn_pos[, .(Target = any(ChronicIllness == "Diabetes")), by = .(Patient_ID)]
  dt_label[, Target := ifelse(Target == T, 1, 0)]
  dt_txn_pre = merge(dt_txn_pre, dt_label, by = "Patient_ID", all.x = T)
  dt_txn_pre[is.na(Target), Target := 0]
  dt_label_pre = dt_txn_pre[, .(Target = max(Target)), by = Patient_ID]
  
  
  # stratified sampling train, valid, and test ------------------------------
  
  if(sum(splitRatio) != 1) stop("Sum of spliRatio must equal 1")
  y_all = dt_label_pre$Target
  dt_txn_pre[, Target := NULL]
  
  if(length(splitRatio) == 2){
    
    splitRatio_train = splitRatio[1]
    splitRatio_test = splitRatio[2]
    
    # createDataPartition
    ind_test = createDataPartition(y_all, p = splitRatio_test, list = F)
    dt_test_label = dt_label_pre[ind_test]
    dt_train_label = dt_label_pre[-ind_test]
    dt_valid_label = data.table()
    
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
  dt_test = merge(dt_txn_pre, dt_test_label, by = "Patient_ID")
  if(length(dt_valid_label) != 0){
    dt_valid = merge(dt_txn_pre, dt_valid_label, by = "Patient_ID")
  }else{
    dt_valid = data.table()
  }
  
  print(paste("dt_train:", dim(dt_train)))
  print(paste("dt_valid:", dim(dt_valid)))
  print(paste("dt_test:", dim(dt_test)))
  
  return(list(dt_train = dt_train
              , dt_valid = dt_valid
              , dt_test = dt_test))
}


