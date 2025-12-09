{{ config(materialized="view") }}

WITH source AS (
    SELECT *
    FROM {{ source('tdf_source', 'stage_information') }}
),

clean AS (
    SELECT
        TRIM(
            REGEXP_REPLACE(
                REGEXP_REPLACE(
                    REGEXP_REPLACE(
                        stagetitle,
                        r'^\d{4}', ''
                    ),
                    r'»', ''
                ),
                r'(\d{2,3})(Tour)', r'\1 Tour'
            )
        ) AS stage_title,

        SAFE_CAST(year AS INT64) AS year,
        SAFE_CAST(stage AS INT64) AS stage_number,

        PARSE_DATE('%d %B %Y', date) AS stage_date,

        SAFE_CAST(REGEXP_EXTRACT(avg__speed_winner, r'([0-9.]+)') AS FLOAT64)
            AS avg_speed_kmh,

        SAFE_CAST(REGEXP_EXTRACT(distance, r'([0-9.]+)') AS FLOAT64)
            AS distance_km,

        SAFE_CAST(gradient_final_km AS FLOAT64) AS final_km_gradient,
        SAFE_CAST(profilescore AS FLOAT64) AS profile_score,
        SAFE_CAST(vertical_meters AS FLOAT64) AS vertical_meters,

        departure AS departure_city,
        arrival AS arrival_city,

        SAFE_CAST(REGEXP_EXTRACT(race_ranking, r'^([0-9]+)') AS INT64)
            AS race_ranking,

        SAFE_CAST(startlist_quality_score AS INT64)
            AS startlist_quality_score,

        won_how AS win_type

    FROM source

    WHERE SAFE_CAST(year AS INT64) BETWEEN 2015 AND 2025
)

SELECT *
FROM clean
