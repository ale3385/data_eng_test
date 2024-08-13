-- models/simple_model.sql

select
    "NCT Number",
    "Study Title",
    "Study Status",
    "Start Date",
    "Completion Date"
from {{ source('clinical_trials', 'clinical_trials_data') }}
where "Study Status" = 'COMPLETED'
