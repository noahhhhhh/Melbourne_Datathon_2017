# Melbourne_Datathon_2017
This is the predictive part of the 2017 Melbourne Datathon.

The task is to predict the probability that a patient will be dispensed a drug related to Diabetes post 2015. This is quite important research as it will be an early warning system for doctors so intervention can potentially be made before it is too late.

# External Data
- PBS API
- Census

# Features
## Key Features
- Overall Transition to Diabetes
  - What drugs would lead to diabetes
  - What illnesses would lead to diabetes
- I_Diabetes_Before
  - Whether a patient had diabetes drug before 2016
- Drug Association
  - Sequential Association
- Illness Association
  - Sequential Association
- Prescriber
  - Some doctors might be diabetes specialist
- I_Qualified_PBSFree
  - Whether a patient was qualified for PBS free
- Other Chronic Illness
  - Number of transactions associated with an illness [Done]
  - Number of prescription associated with an illness [Done]
  - Number of distinct drugs associated with an illness [Done]
  - Time-weighted value for an illness
    - More recent illness txn has bigger value
- Ratio of Reclaim Amount [Done]
  - GovernmentReclaim_Amt / (PatientPrice_Amt + WholeSalePrice_Amt) [Done]
  - by Illness [Done]
 
## Non-key Features
- Date
  - Tenure_Total [Done]
    - Tenure_Total_Dispense
    - Tenure_Total_Prescription
    - Tenure_Chronic (continuous tenure treating chronic illnesses)
    - Tenure_NonChronic (continuous tenure treating non-chronic illnesses)
    - Tenure_Illness_Diabetes, COPD, Hyper Tension, etc. (continuous tenure treating an illness)
    - Tenure_per_Prescription
      - Avg
      - Max
    - Tenure_per_Drug
      - Avg
      - Max
  - Shopping_Density (most of txns in a short period, or txns are well dristributed over time?) [Done]
    - Shopping_Density_Illness_Diabetes, COPD, Hyper Tension, etc.
  - Avg_Days_between_Prescription_Dispense [Done]
    - Avg_Days_between_Prescription_Dispense_Illness
  - Days_till_End [Done]
    - Days_till_End_Illness
  - IPI
    - IPI_Prescription
    - IPI_Drug
    - IPI_Illness
      - mean
      - sd
      - median
      - max
      - min
- Basic Txn [Done]
  - No_Txns [Done]
  - No_Drugs [Done]
  - No_Illnesses [Done]
  - No_Prescriptions [Done]
  - No_Prescribers [Done]
  - No_Stores [Done]
  - No_DeferredScript [Done]
  - No_Repeats [Done]
  - No_Txns_for_Illness_Diabetes, COPD, Hyper Tension, etc. [Done]
  - No_Drugs_for_Illness_Diabetes, COPD, Hyper Tension, etc. [Done]
  - No_Prescriptions_for_Illness_Diabetes, COPD, Hyper Tension, etc. [Done]
  - No_Prescribers_for_Illness_Diabetes, COPD, Hyper Tension, etc. [Done]
  - No_Stores_for_Illness_Diabetes, COPD, Hyper Tension, etc. [Done]
  - No_DeferredScript_Illness_Diabetes, COPD, Hyper Tension, etc. [Done]
  - No_Repeats_for_Illness_Diabetes, COPD, Hyper Tension, etc. [Done]
  - No_Repeats_per_Prescription [Done]
    - Avg [Done]
    - Max [Done]
  - No_Drugs_per_Precription [Done]
    - Avg [Done]
    - Max [Done]
- ATC
  - Refactor (substring) [Done]
  - No_ATC_1, 2, ..., 5 [Done]
    - Refactor level [Done]
    - Raw level [Done]
  - Max_ATC_1, 2, ..., 5 [Done]
    - Refactor level [Done]
    - Raw level [Done]
  - Tenure_ATC_1, 2, ..., 5 [Done]
    - Refactor level [Done]
    - Max_ATC_1, 2, ..., 5 [Done]
  - No_Txns_ATC_1, 2, ..., 5 [Done]
    - Refactor level [Done]
    - Max_ATC_1, 2, ..., 5 [Done]
  - No_Drugs_ATC_1, 2, ..., 5 [Done]
    - Refactor level [Done]
    - Max_ATC_1, 2, ..., 5 [Done]
  - No_Illnesses_ATC_1, 2, ..., 5 [Done]
    - Refactor level [Done]
    - Max_ATC_1, 2, ..., 5 [Done]
  - ATC_CrossEntropy
    - Refactor level
    - Raw level
- Illness
  - Most_Common_Illness
  - Illness_CrossEntropy
- Drug
  - Drug_CrossEntropy
  - PBS
- Patient
  - Dist_postcode
    - mean
    - sd
- Store
  - BannerGroup
    - 

# Preprocess
  - Impute NAs and Infs
  - Normalisation
  - Target mean between Categorical Features and Target (remember to avoid overfit)
  
# Models
  - Non-Diabetes Patients turning Diabetes Model
  - Existing Diabetes Patient Lapsing Model
  
# Cross-Validation
  - Time-based
    - previous years predict this year
    - or last year predicts this year
    - then CV or hold out all patients
  - Standard CV
    - Train on all patients pre 2016
    - Validate on Patient_ID 1 - 279200
    
