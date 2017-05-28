# dt_ivan = fread("../data/MelbDatathon2017/submission/ivan/01_2016_all_noProprocess_singleModel_noTuning2.csv")
dt_noah = fread("../data/MelbDatathon2017/submission/04_2016_all_noProprocess_singleModel_noTuning_TargetMeanWithNoise.csv")
# dt_noah = fread("../data/MelbDatathon2017/submission/08_2016_all_1_2_3_stacking_overTuned.csv")
# dt_1_year = readRDS("../data/MelbDatathon2017/rds/General/1_year/dt_submti.rds")
# dt_2_year = readRDS("../data/MelbDatathon2017/rds/General/2_year/dt_submti.rds")
# dt_3_year = readRDS("../data/MelbDatathon2017/rds/General/3_year/dt_submti.rds")


hist(dt_noah$Diabetes)
hist(dt_1_year$Diabetes)
hist(dt_2_year$Diabetes)
hist(dt_3_year$Diabetes)

# range
range01 = function(x){(x-min(x))/(max(x)-min(x))}

plot(range01(dt_ivan$Diabetes), range01(dt_noah$Diabetes))
plot(range01(pred_test), range01(dt_noah$Diabetes))

dt_noah$Diabetes = range01(dt_noah$Diabetes)
dt_1_year$Diabetes = range01(dt_1_year$Diabetes)
dt_2_year$Diabetes = range01(dt_2_year$Diabetes)
dt_3_year$Diabetes = range01(dt_3_year$Diabetes)

# impute
dt_3_year = rbind(dt_3_year
                  , data.table(Patient_ID = setdiff(dt_noah$Patient_ID, dt_3_year$Patient_ID)
                               , Diabetes = dt_noah[Patient_ID %in% setdiff(dt_noah$Patient_ID, dt_3_year$Patient_ID)]$Diabetes))
dt_3_year = dt_3_year[order(Patient_ID)]

dt_2_year = rbind(dt_2_year
                  , data.table(Patient_ID = setdiff(dt_3_year$Patient_ID, dt_2_year$Patient_ID)
                               , Diabetes = dt_3_year[Patient_ID %in% setdiff(dt_3_year$Patient_ID, dt_2_year$Patient_ID)]$Diabetes))
dt_2_year = dt_2_year[order(Patient_ID)]


dt_1_year = rbind(dt_1_year
                  , data.table(Patient_ID = setdiff(dt_2_year$Patient_ID, dt_1_year$Patient_ID)
                               , Diabetes = dt_2_year[Patient_ID %in% setdiff(dt_2_year$Patient_ID, dt_1_year$Patient_ID)]$Diabetes))
dt_1_year = dt_1_year[order(Patient_ID)]






par(mfrow = c(1, 3))
plot(range01(dt_1_year$Diabetes), range01(dt_noah$Diabetes))
plot(range01(dt_2_year$Diabetes), range01(dt_noah$Diabetes))
plot(range01(dt_3_year$Diabetes), range01(dt_noah$Diabetes))
par(mfrow = c(1, 1))

dt_submit = data.table(Patient_ID = dt_noah$Patient_ID
                       , Diabetes = range01(dt_noah$Diabetes) * .6 + 
                         range01(dt_3_year$Diabetes) * .2 +
                         range01(dt_2_year$Diabetes) * .15 +
                         range01(dt_1_year$Diabetes) * .05)

plot(dt_submit$Diabetes, dt_noah$Diabetes)

# write.csv(dt_submit, "../data/MelbDatathon2017/submission/03_2016_all_noProprocess_singleModel_noTuning_noTargetMean_luck.csv", row.names = F)
# write.csv(dt_submit, "../data/MelbDatathon2017/submission/05_2016_all_noProprocess_singleModel_noTuning_TargetMeanWithNoise_luck.csv", row.names = F)
write.csv(dt_submit, "../data/MelbDatathon2017/submission/07_2016_all_1_2_3_noATC_blending_noPreprocess_noTuning_luck.csv", row.names = F)
# 0.96898




