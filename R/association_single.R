dt_txn = merge(dt_txn, dt_ilness, by.x = "Drug_ID", by.y = "MasterProductID", all.x = T)


############
### drug ###
############

dt_transactions = dt_txn[, .(Patient_ID, Prescription_Week, Drug_ID, ChronicIllness)]
setorderv(dt_transactions, c("Patient_ID", "Prescription_Week", "Drug_ID"))

# pre diabetes ------------------------------------------------------------


dt_diabetes_week = dt_transactions[ChronicIllness == "Diabetes", .(Prescription_Week_Diabetes = min(Prescription_Week)), by = Patient_ID]
dt_transactions = merge(dt_transactions, dt_diabetes_week, by = "Patient_ID")

dt_before_diabetes = dt_transactions[Prescription_Week < Prescription_Week_Diabetes]

dt_drug_association_single = dt_before_diabetes[, .N, by = .(Patient_ID, Prescription_Week, Drug_ID)][, .N, by = .(Drug_ID)]

dt_drug_pre_diabetes = dt_drug_association_single[, support := N / sum(N)]


# non diabetes ------------------------------------------------------------


dt_transactions = dt_txn[, .(Patient_ID, Prescription_Week, Drug_ID, ChronicIllness)]

dt_transactions[, Diabetes := any(ChronicIllness == "Diabetes"), by = Patient_ID]
dt_non_diabetes = dt_transactions[is.na(Diabetes)]

dt_drug_association_single = dt_non_diabetes[, .N, by = .(Patient_ID, Prescription_Week, Drug_ID)][, .N, by = .(Drug_ID)]

dt_drug_non_diabetes = dt_drug_association_single[, support := N / sum(N)]


# minus -------------------------------------------------------------------


setnames(dt_drug_pre_diabetes, names(dt_drug_pre_diabetes), c("Drug_ID", "N_Pre_Diabetes", "support_Pre_Diabetes"))
setnames(dt_drug_non_diabetes, names(dt_drug_non_diabetes), c("Drug_ID", "N_Non_Diabetes", "support_Non_Diabetes"))

dt_merge_pre_non_diabetes = merge(dt_drug_pre_diabetes[, .(Drug_ID, support_Pre_Diabetes)], dt_drug_non_diabetes[, .(Drug_ID, support_Non_Diabetes)]
                                  , by = "Drug_ID", all.x = T)

dt_pre_diabetes_only = dt_merge_pre_non_diabetes[is.na(support_Non_Diabetes)]
saveRDS(dt_pre_diabetes_only, "../data/MelbDatathon2017/rds/association/single/dt_pre_diabetes_only.rds")


dt_merge_pre_non_diabetes[is.na(support_Non_Diabetes), support_Non_Diabetes := 0]
dt_merge_pre_non_diabetes[, support := support_Pre_Diabetes - support_Non_Diabetes]
saveRDS(dt_merge_pre_non_diabetes, "../data/MelbDatathon2017/rds/association/single/dt_merge_pre_non_diabetes.rds")


##################
### ingredient ###
##################
dt_txn = merge(dt_txn, dt_drug[, .(MasterProductID, GenericIngredientName)], by.x = "Drug_ID", by.y = "MasterProductID", all.x = T)

dt_transactions = dt_txn[, .(Patient_ID, Prescription_Week, GenericIngredientName, ChronicIllness)]


# pre diabetes ------------------------------------------------------------


dt_diabetes_week = dt_transactions[ChronicIllness == "Diabetes", .(Prescription_Week_Diabetes = min(Prescription_Week)), by = Patient_ID]
dt_transactions = merge(dt_transactions, dt_diabetes_week, by = "Patient_ID")

dt_before_diabetes = dt_transactions[Prescription_Week < Prescription_Week_Diabetes]

dt_drug_association_single = dt_before_diabetes[, .N, by = .(Patient_ID, Prescription_Week, GenericIngredientName)][, .N, by = .(GenericIngredientName)]

dt_ingredient_pre_diabetes = dt_drug_association_single[, support_ingredient := N / sum(N)]


# non diabetes ------------------------------------------------------------


dt_transactions = dt_txn[, .(Patient_ID, Prescription_Week, GenericIngredientName, ChronicIllness)]

dt_transactions[, Diabetes := any(ChronicIllness == "Diabetes"), by = Patient_ID]
dt_non_diabetes = dt_transactions[is.na(Diabetes)]

dt_drug_association_single = dt_non_diabetes[, .N, by = .(Patient_ID, Prescription_Week, GenericIngredientName)][, .N, by = .(GenericIngredientName)]

dt_ingredient_non_diabetes = dt_drug_association_single[, support_ingredient := N / sum(N)]


# minus -------------------------------------------------------------------


setnames(dt_ingredient_pre_diabetes, names(dt_ingredient_pre_diabetes), c("GenericIngredientName", "N_Pre_Diabetes", "support_Pre_Diabetes"))
setnames(dt_ingredient_non_diabetes, names(dt_ingredient_non_diabetes), c("GenericIngredientName", "N_Non_Diabetes", "support_Non_Diabetes"))

dt_merge_pre_non_diabetes = merge(dt_ingredient_pre_diabetes[, .(GenericIngredientName, support_Pre_Diabetes)]
                                  , dt_ingredient_non_diabetes[, .(GenericIngredientName, support_Non_Diabetes)]
                                  , by = "GenericIngredientName", all.x = T)

dt_pre_diabetes_only_ingredient = dt_merge_pre_non_diabetes[is.na(support_Non_Diabetes)]
saveRDS(dt_pre_diabetes_only_ingredient, "../data/MelbDatathon2017/rds/association/single/dt_pre_diabetes_only_ingredient.rds")


dt_merge_pre_non_diabetes[is.na(support_Non_Diabetes), support_Non_Diabetes := 0]
dt_merge_pre_non_diabetes[, support := support_Pre_Diabetes - support_Non_Diabetes]
saveRDS(dt_merge_pre_non_diabetes, "../data/MelbDatathon2017/rds/association/single/dt_merge_pre_non_diabetes_ingredient.rds")
