WITH study_durations AS (
    SELECT
        "Study Status",
        "NCT Number",
        "Study Title",
        "Start Date",
        "Completion Date",
        -- Calcular la duración del estudio en días
        CASE 
            WHEN "Start Date" IS NOT NULL AND "Completion Date" IS NOT NULL THEN
                ("Completion Date"::date - "Start Date"::date)
            ELSE NULL
        END AS study_duration_days
    FROM 
        "clinical_trials"."public"."clinical_trials_data"
)

-- Agregación de los datos en función del estado del estudio
SELECT
    "Study Status",
    COUNT(*) AS total_studies,
    AVG(study_duration_days) AS avg_study_duration_days,
    MIN(study_duration_days) AS min_study_duration_days,
    MAX(study_duration_days) AS max_study_duration_days
FROM 
    study_durations
GROUP BY 
    "Study Status"
ORDER BY
    total_studies DESC