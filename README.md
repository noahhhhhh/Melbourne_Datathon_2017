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
  - What ingredient would lead to diabetes
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
    - Tenure_Total_Dispense [Done]
    - Tenure_Total_Prescription [Done]
    - Tenure_Chronic (continuous tenure treating chronic illnesses) [Done]
    - Tenure_NonChronic (continuous tenure treating non-chronic illnesses) [Done]
    - Tenure_Illness_Diabetes, COPD, Hyper Tension, etc. (continuous tenure treating an illness) [Done]
    - Tenure_per_Prescription [Done]
      - Avg [Done]
      - Max [Done]
    - Tenure_per_Drug [Done]
      - Avg [Done]
      - Max [Done]
  - Shopping_Density (most of txns in a short period, or txns are well dristributed over time?) [Done]
    - Shopping_Density_Illness_Diabetes, COPD, Hyper Tension, etc.
  - Avg_Days_between_Prescription_Dispense [Done]
    - Avg_Days_between_Prescription_Dispense_Illness
  - Days_till_End [Done]
    - Days_till_End_Illness [Done]
  - IPI [Done]
    - IPI_Prescription [Done]
    - IPI_Txns [Done]
    - IPI_Illness [Done]
      - mean [Done]
      - sd [Done]
      - median [Done]
      - max [Done]
      - min [Done]
- Basic Txn [Done]
  - Bought_Diabetes
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
  - Spend/Price/Save_Txn [Done]
    - sum [Done]
    - mean [Done]
    - sd [Done]
    - median [Done]
    - max [Done]
    - min [Done]
  - Spend/Price/Save_Prescription [Done]
    - mean [Done]
    - sd [Done]
    - median [Done]
    - max [Done]
    - min [Done]
  - Spend/Price/Save_Illness [Done]
    - sum [Done]
    - mean [Done]
    - sd [Done]
    - median [Done]
    - max [Done]
    - min [Done]

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
  - ATC_CrossEntropy [Done]
    - Refactor level [Done]
    - Raw level [Done]
- Illness [Done]
  - Most_Common_Illness [Done]
  - Last_Illness [Done]
  - First_Illness [Done]
  - Illness_CrossEntropy [Done]
- Drug
  - Most_Common_Drug [Done]
  - Last_Drug [Done]
  - First_Drug [Done]
  - Drug_CrossEntropy [Done]
  - PBS
    - Percent_PBS_vs_Non_PBS
  - Ingredient [Done]
    - Most_Common_Ingredient [Done]
    - Last_Ingredient [Done]
    - First_Ingredient [Done]
    - Ingredient_CrossEntropy [Done]
  - Brand
- Patient [Done]
  - Dist_Postcode [Done]
    - mean [Done]
    - sd [Done]
    - median [Done]
    - max [Done]
    - min [Done]
  - Age [Done]
  - Gender [Done]

- Event
  - Last_Year
    - Illness
    - Drug
    - Date
    - Basic Txns
    - ATC
   - Last_3_Months
    - Illness
    - Drug
    - Date
    - Basic Txns
    - ATC
   
# Preprocess
  - Impute NAs and Infs
  - Normalisation
  - Target mean between Categorical Features and Target (remember to avoid overfit)
  
# Models
  - Non-Diabetes Patients --> Diabetes Model
  - Existing Diabetes Patient --> Non-Diabetes Model
  - Patients Lapsing Model
  
# Cross-Validation
  - Time-based
    - previous years predict this year
    - or last year predicts this year
    - then CV or hold out all patients
  - Standard CV
    - Train on all patients pre 2016
    - Validate on Patient_ID 1 - 279200
    
