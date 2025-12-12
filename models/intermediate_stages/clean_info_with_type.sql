WITH source AS (

    SELECT *
    FROM {{ source('tdf_source', 'all_stage_information_with_type') }}

),

renamed AS (

    SELECT
        StageTitle AS stage_title,
        CAST(Year AS INT64) AS year,
        CAST(Stage AS INT64) AS stage,

        Date AS stage_date,
        Start_time AS start_time,

        SAFE_CAST(Avg__speed_winner AS FLOAT64) AS avg_speed_winner,
        Classification AS classification,
        Race_category AS race_category,
        SAFE_CAST(Distance AS FLOAT64) AS distance_km,
        Points_scale AS points_scale,
        UCI_scale AS uci_scale,

        -- ✅ FIX ICI
        TRIM(CAST(Parcours_type AS STRING)) AS parcours_type,

        SAFE_CAST(Gradient_final_km AS FLOAT64) AS gradient_final_km,
        SAFE_CAST(ProfileScore AS FLOAT64) AS profile_score,
        SAFE_CAST(Vertical_meters AS INT64) AS vertical_meters,

        TRIM(Departure) AS departure_city,
        TRIM(Arrival) AS arrival_city,

        Race_ranking AS race_ranking,
        SAFE_CAST(Startlist_quality_score AS FLOAT64) AS startlist_quality_score,
        TRIM(Won_how) AS won_how,
        SAFE_CAST(Avg__temperature AS FLOAT64) AS avg_temperature,
        Timelimit AS time_limit

    FROM source
)

SELECT *
FROM renamed