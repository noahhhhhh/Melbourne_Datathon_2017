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
  - Number of transactions associated with an illness
  - Number of prescription associated with an illness
  - NUmber of distinct drugs associated with an illness
  - Time-weighted value for an illness
    - More recent illness txn has bigger value
- Ratio of Reclaim Amount
  - GovernmentReclaim_Amt / (PatientPrice_Amt + WholeSalePrice_Amt)
 
## Non-key Features
- Date
  - Tenure_Total (need normalisation)
  - Tenure_Chronic (continuous tenure treating chronic illnesses, need normalisation)
  - Tenure_NonChronic (continuous tenure treating non-chronic illnesses, need normalisation)
  - Tenure_Illness_Diabetes, COPD, Hyper Tension, etc. (continuous tenure treating am illness, need normalisation)
  - Shopping_Density (most of txns in a short period, or txns are well dristributed over time?)
  - Avg_Days_between_Prescription_Dispense
- Basic Txn
  - No_Txns (need normalisation)
  - No_Drugs (need normalisation)
  - No_Illnesses (need normalisation)
  - No_Drugs_for_Illness_Diabetes, COPD, Hyper Tension, etc. (need normalisation)
  - No_Txns_for_Illness_Diabetes, COPD, Hyper Tension, etc. (need normalisation)
  - No_Repeats (need normalisation)
  - No_Repeats_for_Illness_Diabetes, COPD, Hyper Tension, etc. (need normalisation)
  - No_Prescription (need normalisation)
  - No_Prescription_for_Illness_Diabetes, COPD, Hyper Tension, etc. (need normalisation)
  - Avg_No_Drugs_per_Precription (need normalisation)
  
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
    
