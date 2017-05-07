# Melbourne_Datathon_2017
This is the predictive part of the 2017 Melbourne Datathon.

The task is to predict the probability that a patient will be dispensed a drug related to Diabetes post 2015. This is quite important research as it will be an early warning system for doctors so intervention can potentially be made before it is too late.

# External Data
- PBS API
- Census

# Features
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
  
  # Models
  - Non-Diabetes Patients turning Diabetes Model
  - Existing Diabetes Patient Lapsing Model
  
  # Cross-Validation
  - Time-based
    - previous years predict this year
    - last year predicts this year
    
