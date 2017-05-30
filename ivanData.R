require(data.table)

load("../data/MelbDatathon2017/ivan/feat_simplified_20170529.RData")
load("../data/MelbDatathon2017/ivan/final_features_simp.RData")
load("../data/MelbDatathon2017/ivan/tmp_outcomes2016.RData")


fnl.dat[, Target := ifelse(Patient_ID %in% tmp_outcomes2016, 1, 0)]

dt_train = fnl.dat[Patient_ID < 279201]
dt_test = fnl.dat[Patient_ID >= 279201 & Patient_ID <= 558352]

write.csv(dt_train, "../data/MelbDatathon2017/pythonData/trainData_ivan.csv", row.names = F)
write.csv(dt_test, "../data/MelbDatathon2017/pythonData/testData_ivan.csv")
