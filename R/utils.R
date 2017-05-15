scoreTracker = function(modelTarget, modelType, score, featureNames){

  path_scoreTracker = "../data/MelbDatathon2017/rds/scoreTracker.rds"
  
  curTime = as.character(Sys.time())
  
  if(file.exists(path_scoreTracker)){
    
    ls_scoreTracker = readRDS(path_scoreTracker)
    ls_scoreTracker[[curTime]][["features"]] = featureNames
    ls_scoreTracker[[curTime]][["modelType"]] = modelType
    ls_scoreTracker[[curTime]][["modelTarget"]] = modelTarget
    ls_scoreTracker[[curTime]][["score"]] = score
    
    
  }else{
    
    ls_scoreTracker = list()
    ls_scoreTracker[[curTime]][["features"]] = featureNames
    ls_scoreTracker[[curTime]][["modelType"]] = modelType
    ls_scoreTracker[[curTime]][["modelTarget"]] = modelTarget
    ls_scoreTracker[[curTime]][["score"]] = score
    
    
  }
  
  saveRDS(ls_scoreTracker, path_scoreTracker)
  
  print("Done")
}