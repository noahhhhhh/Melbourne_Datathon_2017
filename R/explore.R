dt_txn[Patient_ID >= 279201 & Patient_ID <= 558352, range(Dispense_Week)]
# [1] "2010-05-09" "2015-12-27"



# bigger patient_id == newer patient? -------------------------------------


dt_sample = dt_txn[Patient_ID %in% sample(unique(dt_txn$Patient_ID), 10000)]

dt_sample[, .(min(Dispense_Week)), by = Patient_ID][order(Patient_ID)]
# no


# are the targeted patients different? ------------------------------------

# txn
x = dt_txn[Dispense_Week < as.Date("2016-01-01"), .N, by = Patient_ID]
hist(x$N, breaks = 100)
summary(x$N)
quantile(x$N, seq(0, 1, .1))

y = dt_txn[Patient_ID >= 279201 & Patient_ID <= 558352 & Dispense_Week < as.Date("2016-01-01"), .N, by = Patient_ID]
hist(y$N, breaks = 100)
summary(y$N)
quantile(y$N, seq(0, 1, .1))

# drug
x = dt_txn[Dispense_Week < as.Date("2016-01-01"), .N, by = .(Patient_ID, Drug_ID)][, .N, Patient_ID]
hist(x$N, breaks = 100)
summary(x$N)
quantile(x$N, seq(0, 1, .1))

y = dt_txn[Patient_ID >= 279201 & Patient_ID <= 558352 & Dispense_Week < as.Date("2016-01-01"), .N, by = .(Patient_ID, Drug_ID)][, .N, Patient_ID]
hist(y$N, breaks = 100)
summary(y$N)
quantile(y$N, seq(0, 1, .1))

# no

