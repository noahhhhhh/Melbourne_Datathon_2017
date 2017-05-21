require(arules)
require(arulesSequences)

dt_txn = merge(dt_txn, dt_ilness, by.x = "Drug_ID", by.y = "MasterProductID", all.x = T)

dt_transactions = dt_txn[, .(Patient_ID, Prescription_Week, Drug_ID, ChronicIllness)]
setorderv(dt_transactions, c("Patient_ID", "Prescription_Week", "Drug_ID"))

dt_transactions[, Diabetes := any(ChronicIllness == "Diabetes"), by = Patient_ID]
dt_transactions = dt_transactions[is.na(Diabetes)]

# dt_diabetes_week = dt_transactions[ChronicIllness == "Diabetes", .(Prescription_Week_Diabetes = min(Prescription_Week)), by = Patient_ID]
# dt_transactions = merge(dt_transactions, dt_diabetes_week, by = "Patient_ID")
# 
# dt_before_diabetes = dt_transactions[Prescription_Week < Prescription_Week_Diabetes]
dt_before_diabetes = copy(dt_transactions)

dt_before_diabetes = dt_before_diabetes[!duplicated(dt_before_diabetes)]

dt_before_diabetes = dt_before_diabetes[, Patient_ID_Rank := frank(Patient_ID, ties.method = "dense")]
dt_before_diabetes = dt_before_diabetes[, Prescription_Week_Rank := frank(Prescription_Week, ties.method = "dense"), by = .(Patient_ID)]

dt_before_diabetes = dt_before_diabetes[, .(Patient_ID_Rank, Prescription_Week_Rank, Drug_ID)]


# stack -------------------------------------------------------------------

require(splitstackshape)

dt_dcast = dcast.data.table(getanID(dt_before_diabetes, c("Patient_ID_Rank", "Prescription_Week_Rank"))
                            , Patient_ID_Rank + Prescription_Week_Rank ~ .id, value.var = "Drug_ID", fill = "")

setnames(dt_dcast, names(dt_dcast), c("sequenceID", "eventID", names(dt_dcast)[3:ncol(dt_dcast)]))

write.table(dt_dcast, "../data/MelbDatathon2017/txt/associationNonDiabetes.txt", na = "", row.names = F, col.names = F)



# sequential rule ---------------------------------------------------------

x = read_baskets(con = "../data/MelbDatathon2017/txt/association.txt"
                 , info = c("sequenceID","eventID"))

sequentialRule = cspade(x
                        , parameter = list(support = .05
                                           , maxsize = 5
                                           , maxlen = 10)
                        , control = list(memsize = 10000, verbose = T))

dt_sequantialRule = as.data.table(as(sequentialRule, "data.frame"))
setorder(dt_sequantialRule, -support)
dt_sequantialRule

# saveRDS(dt_sequantialRule, "../data/MelbDatathon2017/rds/association/beforeDiabetes.rds")
saveRDS(dt_sequantialRule, "../data/MelbDatathon2017/rds/association/nonDiabetes.rds")
