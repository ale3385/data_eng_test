
  create view "clinical_trials"."public"."simple_model__dbt_tmp"
    
    
  as (
    -- models/simple_model.sql

select
    "NCT Number",
    "Study Title",
    "Study Status",
    "Start Date",
    "Completion Date"
from "clinical_trials"."public"."clinical_trials_data"
where "Study Status" = 'COMPLETED'
  );