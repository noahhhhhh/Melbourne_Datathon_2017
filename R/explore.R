dt_txn[Patient_ID >= 279201 & Patient_ID <= 558352, range(Dispense_Week)]
# [1] "2010-05-09" "2015-12-27"



# bigger patient_id == newer patient? -------------------------------------


dt_sample = dt_txn[Patient_ID %in% sample(unique(dt_txn$Patient_ID), 10000)]

dt_sample[, .(min(Dispense_Week)), by = Patient_ID][order(Patient_ID)]
# no

