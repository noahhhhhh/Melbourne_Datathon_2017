
getTrainDt_TimeBased = function(dt_txn, trainEndDate = "2015-01-01", testEndDate = NULL, splitRatio = c(.4, .1, .5)){
  
  require(caret)
  
  if(is.null(testEndDate)) testEndDate = as.character(max(dt_txn$Dispense_Week) + 1)
  
  # merge illness -----------------------------------------------------------
  
  
  dt_txn = merge(dt_txn, dt_ilness, by.x = "Drug_ID", by.y = "MasterProductID", all.x = T)
  dt_txn[is.na(ChronicIllness), ChronicIllness := "Non-Chronic"]
  
  
  # pre and post 2014 -------------------------------------------------------
  
  
  dt_txn_pre2015 = dt_txn[Dispense_Week < as.Date(trainEndDate)]
  dt_txn_2015 = dt_txn[Dispense_Week >= as.Date(trainEndDate) & Dispense_Week < as.Date(testEndDate)]

  
  # label targets -----------------------------------------------------------
  
  
  dt_label = dt_txn_2015[, .(Target = any(ChronicIllness == "Diabetes")), by = .(Patient_ID)]
  dt_txn_pre2015 = merge(dt_txn_pre2015, dt_label, by = "Patient_ID")
  dt_txn_pre2015[is.na(Target), Target := F]
  dt_txn_pre2015[, Target := ifelse(Target == T, 1, 0)]
  
  
  # stratified sampling train, valid, and test ------------------------------
  
  if(sum(splitRatio) != 1) stop("Sum of spliRatio must equal 1")
  y_all = dt_txn_pre2015$Target
  
  if(length(splitRatio) == 2){
    
    splitRatio_train = splitRatio[1]
    splitRatio_test = splitRatio[2]
    
    # createDataPartition
    ind_test = createDataPartition(y_all, p = splitRatio_test, list = F)
    dt_test = dt_txn_pre2015[ind_test]
    dt_train = dt_txn_pre2015[-ind_test]
    dt_valid = data.table()
    
  }else{
    
    splitRatio_train = splitRatio[1] / (splitRatio[1] + splitRatio[2])
    splitRatio_test = splitRatio[3]
    
    # createDataPartition
    ind_test = createDataPartition(y_all, p = splitRatio_test, list = F)
    dt_test = dt_txn_pre2015[ind_test]
    dt_train_valid = dt_txn_pre2015[-ind_test]
    ind_train = createDataPartition(dt_train_valid$Target, p = splitRatio_train, list = F)
    dt_train = dt_train_valid[ind_train]
    dt_valid = dt_train_valid[-ind_train]
    
  }
  
  
  return(list(dt_train = dt_train
              , dt_valid = dt_valid
              , dt_test = dt_test))
}


